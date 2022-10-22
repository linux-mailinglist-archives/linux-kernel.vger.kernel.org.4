Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B948608EF9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 20:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJVSVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 14:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJVSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 14:21:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11746129096
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:21:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r14so17211353edc.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4dYS00nmatIUppAOJMsP1CIwXCPkE0shI+FzsyxnF4=;
        b=LmsTgBInlO6kroK4y9Vmss5gmswOC1txnttsCS3kuthbS4jYNShmFMorKezy+HwLp0
         ph+7SuEK1hjWE308mr8ICh9Hiiy4Mrwc3sAyDlLgLiPkeDIsskXq5FhzQgpMmgJnc/Oq
         JhjimpnmcEC8TTuj9Z4+4NZ1jgaFQSLwbC3mrR4O6NiNW89laVMceb1jObc0nYBxE26S
         8UiYMpHTun2oIT4G6X0KPyyo31oxluZmqmyy9chTD900m2vcMTiE4mVIfbe5HrnBQPOT
         IfjdkYol9PXEglTBCDofdye9o3N5KFCNw/Jf8xagYHfGpBBy6aE2iFpDt7vT1Rc55zKn
         hLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4dYS00nmatIUppAOJMsP1CIwXCPkE0shI+FzsyxnF4=;
        b=qzVwiFnWB2IZOMSPKXssKCk/pdlgHleNOSehftbZz5+QPLhc5HVrKEEJK2N/4DqgqM
         yJ+s+jRG14AqFpsUgkCpxjCV8DLLnSW28RS/ia2emwBogyXykBNCBjWsHYtXUqHYcMFs
         8E8lzvfvczYgi9eju5TioYokTygVfr9bvDZ8Efdq8E5uSgPhTfFeM5Xag7+HweYIaYPq
         EhmfatifQj4h6ZxhNqEqbu5oX/E5t4DiAB+cuu6Vv2b31lKZcQcTpbg/7QQbAC1T/TT5
         JLyz5b3AbhQHlzZQsJ1MnDnOsUXTadJuhkFE3JoGUlW1CDfiIxtWvsBAgjaHBS3lV1I9
         qyEA==
X-Gm-Message-State: ACrzQf0+qmkqjxdfSH3nAqJrTLEeKxoZDKdBQVyhTZJ5zyEFg2SM8e1G
        1BRkhYdz8XMsXrzKQyAj3UC/syvFISA=
X-Google-Smtp-Source: AMsMyM5AeL9qecsAzr2PPgmUzAbMNBCFuJt2dcdQq+5/re0WcpjAVUw3m8z+VJgMD04SUV9WD9d7sQ==
X-Received: by 2002:a17:906:cc0b:b0:78d:f3b9:ab15 with SMTP id ml11-20020a170906cc0b00b0078df3b9ab15mr20534634ejb.367.1666462876256;
        Sat, 22 Oct 2022 11:21:16 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id k15-20020a17090632cf00b0078d38cda2b1sm13060242ejk.202.2022.10.22.11.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 11:21:15 -0700 (PDT)
Date:   Sat, 22 Oct 2022 20:21:00 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     t4rmin@zohomail.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Staging: rtl8192e: rtl819x_HTProc: fixed missing
 blank space
Message-ID: <20221022182100.GA16464@nam-dell>
References: <d4898956a848c85fc93c3f7d25cafbfc49a46e60.camel@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4898956a848c85fc93c3f7d25cafbfc49a46e60.camel@zohomail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 10:48:08PM +0700, Aaron Lawrence wrote:
> >From e6635103e3cf2426220767955b99d2e2b62a7329 Mon Sep 17 00:00:00 2001
> Message-Id: <e6635103e3cf2426220767955b99d2e2b62a7329.1666450553.git.t4rmin@zohomail.com>
> In-Reply-To: <cover.1666450553.git.t4rmin@zohomail.com>
> References: <cover.1666450553.git.t4rmin@zohomail.com>
> From: Aaron Lawrence <t4rmin@zohomail.com>
> Date: Sat, 22 Oct 2022 20:46:25 +0700

I think you messed up something here. These are not supposed to be in
the email description. All your patches are sent separatedly, instead of
being in the same thread.

I can recommend follow the instructions in this website:
https://kernelnewbies.org/FirstKernelPatch

> Subject: [PATCH 1/3] Staging: rtl8192e: rtl819x_HTProc: fixed missing blank
>  space
> 
> Added a missing blank space as per the Linux kernel coding-style
> regulations. The issue was flagged by the checkpatch script as a
> warning.
> 
> Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
> ---
>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index ef3dca51cf99..b763cf0ba356 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -70,6 +70,7 @@ static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
>  void HTUpdateDefaultSetting(struct rtllib_device *ieee)
>  {
>  struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
> +
>  pHTInfo->bRegShortGI20MHz = 1;
>  pHTInfo->bRegShortGI40MHz = 1;
> -- 
> 2.38.1
> 
> 
