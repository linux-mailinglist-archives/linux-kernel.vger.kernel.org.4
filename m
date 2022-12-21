Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5454652CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiLUGGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiLUGGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118789599
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671602726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qtlhrl2qq3dgmxn4quIc/7aksQ9mUhgFQl5OdwTK7n0=;
        b=G72azOdweST4mpEJamao/wvUNrmJkB98LQOaDcCVAzev7vn6Bt7A/ZlcJTX+mbJPevrje0
        a+j05tYSBNZpnujKhQmLjf2D4agwuJeSV9b2Yyi5W3uhp1HxPDjlv6es6GNZI9wvfK/YoC
        Apu1Ofp/Osv2+oqUneKafKkY1jhEb8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-NfehV5i0MJGFVwXnLhGVkA-1; Wed, 21 Dec 2022 01:05:25 -0500
X-MC-Unique: NfehV5i0MJGFVwXnLhGVkA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D28B801779;
        Wed, 21 Dec 2022 06:05:23 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB1321731B;
        Wed, 21 Dec 2022 06:05:22 +0000 (UTC)
Date:   Wed, 21 Dec 2022 14:05:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Message-ID: <Y6KiH2Nf/hMiaPmD@MiWiFi-R3L-srv>
References: <20221215182339.129803-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215182339.129803-1-helgaas@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 at 12:23pm, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> There are no arch-specific things in arch_kexec_kernel_image_load(), so
> remove it and just use the generic version.

This patchset looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>

Since it cleans up the last arch specific version of
arch_kexec_kernel_image_load in x86, maybe this patchset can go into x86
branch?

Thanks
Baoquan

