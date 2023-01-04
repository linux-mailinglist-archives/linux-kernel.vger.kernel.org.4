Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE71465CC1F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 04:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjADDV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 22:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjADDV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 22:21:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A465580
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 19:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672802474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0EYPdegMv2Qzzqky790rw/FkqITGzxXVxGnFBGqkRE=;
        b=ioJSbTVIs4iQjXuBh21F+ZzM8pXLr/9WSR9j3ugZP/mCzgGoEJ3VIR7vLTbkLh3TQe6cpx
        zh1Ze9V2xqnIIvLVWCOgPQEIxixmaK893wLvWuG7DOTr5qzhPXufBz+4dcHfINHo5vTLRD
        j2EqKs94YDc8HViXGWRCNyD1ZkVeVzU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-8xHK1lY2PtyCeW7JVIIdsA-1; Tue, 03 Jan 2023 22:21:08 -0500
X-MC-Unique: 8xHK1lY2PtyCeW7JVIIdsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 017E129ABA17;
        Wed,  4 Jan 2023 03:21:08 +0000 (UTC)
Received: from localhost (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC5B02026D68;
        Wed,  4 Jan 2023 03:21:06 +0000 (UTC)
Date:   Wed, 4 Jan 2023 11:21:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Message-ID: <Y7TwnyixithmnizI@MiWiFi-R3L-srv>
References: <20221215182339.129803-1-helgaas@kernel.org>
 <Y6KiH2Nf/hMiaPmD@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6KiH2Nf/hMiaPmD@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Boris,

On 12/21/22 at 02:05pm, Baoquan He wrote:
> On 12/15/22 at 12:23pm, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > There are no arch-specific things in arch_kexec_kernel_image_load(), so
> > remove it and just use the generic version.
> 
> This patchset looks good to me, thx.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
> Since it cleans up the last arch specific version of
> arch_kexec_kernel_image_load in x86, maybe this patchset can go into x86
> branch?

Could you consider picking this patchset into x86 branch? This is a
clean up on kexec, while the last ARCH using it is x86.

Thanks
Baoquan

