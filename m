Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC1C5ED571
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiI1Gyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiI1GyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2793481E9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664347973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IlaSZc33GONrE9IArKtEWlpurS3hEknJV/JTkyz5RZ0=;
        b=ei/q7ZTjNwzS5h/Cg9Nik5CkBJ+JayhfLmiGr1/6psnrxS6UxY/E/WVW0YdqRNLORY0FAs
        6hMUxo5Q9BgYaZvgbmDFYG8eR2kXoJyu+S8PiGIg2abwutcewUXZUEj1EULBlqMZ5cgLEj
        ky49N6QqOpc2Nux/aFAALwIq4X48I9Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-7yyPjbgSNVaEGE3qQ-_5FA-1; Wed, 28 Sep 2022 02:52:47 -0400
X-MC-Unique: 7yyPjbgSNVaEGE3qQ-_5FA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C7FD185A79C;
        Wed, 28 Sep 2022 06:52:47 +0000 (UTC)
Received: from localhost (ovpn-13-211.pek2.redhat.com [10.72.13.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 772D5422A9;
        Wed, 28 Sep 2022 06:52:45 +0000 (UTC)
Date:   Wed, 28 Sep 2022 14:52:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chen Lifu <chenlifu@huawei.com>
Cc:     linux@armlinux.org.uk, akpm@linux-foundation.org, pmladek@suse.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ARM: kexec: Make machine_crash_nonpanic_core()
 static
Message-ID: <YzPvOjGWHxdcGUjh@MiWiFi-R3L-srv>
References: <20220816074250.3991633-1-chenlifu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816074250.3991633-1-chenlifu@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/22 at 03:42pm, Chen Lifu wrote:
> This symbol is not used outside of the file, so mark it static.
> 
> Fixes the following warning:
> 
> arch/arm/kernel/machine_kexec.c:76:6: warning: symbol 'machine_crash_nonpanic_core' was not declared. Should it be static?
> 
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  arch/arm/kernel/machine_kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index f567032a09c0..a2e9ac763a9f 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -71,11 +71,11 @@ int machine_kexec_prepare(struct kimage *image)
>  
>  void machine_kexec_cleanup(struct kimage *image)
>  {
>  }
>  
> -void machine_crash_nonpanic_core(void *unused)
> +static void machine_crash_nonpanic_core(void *unused)
>  {
>  	struct pt_regs regs;
>  
>  	crash_setup_regs(&regs, get_irq_regs());
>  	printk(KERN_DEBUG "CPU %u will stop doing anything useful since another CPU has crashed\n",
> -- 
> 2.37.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

