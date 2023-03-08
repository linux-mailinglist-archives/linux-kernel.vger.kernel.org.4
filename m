Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196F76AFB61
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCHAjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCHAjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:39:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BFE9CBE1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678235869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+naXqPK+BNnrnoMbMYJmt5mQqn+jrV3xlv29zF2BaDc=;
        b=c548sGUnYVuSG/ZegRhJp5Rw3fxMzSu1rzGzENZwR5cqZGGEN3T3FpCJ+l99vDMvbvn+8w
        JEYtQB5E7gzi7wkkfdI6LfzjHEKzkwPeBVeIDChQDPWnlaySaM4xI33xDAkUFTvxq81ynv
        VH7IB09du1+ymY7eIW8+oYH645Tdg/Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-IHxFFcYPNxiGgwSh0CszzQ-1; Tue, 07 Mar 2023 19:37:46 -0500
X-MC-Unique: IHxFFcYPNxiGgwSh0CszzQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B45E2A5954D;
        Wed,  8 Mar 2023 00:37:45 +0000 (UTC)
Received: from localhost (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 818D3492C14;
        Wed,  8 Mar 2023 00:37:44 +0000 (UTC)
Date:   Wed, 8 Mar 2023 08:37:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] kexec: Remove unnecessary arch hook
Message-ID: <ZAfY1OxDBzX7cnw4@MiWiFi-R3L-srv>
References: <20230307224416.907040-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307224416.907040-1-helgaas@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/23 at 04:44pm, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> There are no arch-specific things in arch_kexec_kernel_image_load(), so
> remove it and just use the generic version.
> 
> v1 is at:
> https://lore.kernel.org/all/20221215182339.129803-1-helgaas@kernel.org/
> 
> This v2 is trivially rebased to v6.3-rc1 and the commit log expanded
> slightly.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> 
> Bjorn Helgaas (2):
>   x86/kexec: Remove unnecessary arch_kexec_kernel_image_load()
>   kexec: Remove unnecessary arch_kexec_kernel_image_load()
> 
>  arch/x86/include/asm/kexec.h       |  3 ---
>  arch/x86/kernel/machine_kexec_64.c | 11 -----------
>  include/linux/kexec.h              |  8 --------
>  kernel/kexec_file.c                |  6 +++---
>  4 files changed, 3 insertions(+), 25 deletions(-)
> 
> -- 
> 2.25.1
> 

