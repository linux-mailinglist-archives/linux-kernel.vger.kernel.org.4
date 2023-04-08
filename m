Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610726DBBC8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDHPTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjDHPTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:19:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C293483CD;
        Sat,  8 Apr 2023 08:19:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id c3so1459354pjg.1;
        Sat, 08 Apr 2023 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680967150; x=1683559150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KqJ33S2mBxOYayewj0QM1JDs9QEyAwtjuW4woTEAIS4=;
        b=g9nJ8dwilGsODcpCqJ2W4SiGry06PGQ2jMpyeI4I5c3lguHmtJE+VaQwMiFs2r205x
         xghZvqir7f4d4ltwIEY//VvI/uZvA8qoJ9JFBLB995xy1tzVmC6fNiv25ZFFbnGmihV4
         WBXRSMjIU8xQVGx5byOoXqs9fk8+Xkc0XQv2+oydJexZMR9b061isKatHgqB9x5k5VLu
         69AAf8vJEWZIuFd6mlxT42+pCq1LsG55QMu132nQ77Airfr8Hl3JkJ4uG/tizlRNHj70
         BCHxBQGkFVfwAWca1yJ/8tTJEbFYQDmqbobUV6Zlsr0tB3dOPsfsvKiJnI/1mLeMoXnQ
         7b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680967150; x=1683559150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqJ33S2mBxOYayewj0QM1JDs9QEyAwtjuW4woTEAIS4=;
        b=JSBdjCNZStQq22aP6O+TJYudqUbEd/kmMDKFLkmAvnoDJrFV3VuCYsw/gOVVMVs/3N
         0dvKEtnfKYNp1AjRRYW0s3CKnvJcolTbH11l3COfPle6Ic0p364fZgybf71CBUqRLiLJ
         3CHHvwdpii8TufDyjuaX8uq77vr75fInD4L8GF3+GRA/6dF4hJQgxzMkpRlVTjvGGuNf
         o5eBLQVzRp+oh1eZxhZaEVtkBzAcHX88xY5F7QsN3EhTg/0mhMyHFsh5ci4lN1vi9qTd
         7wbZ3DkLTOWt3iflsgdSZy6y91RfAM9NvYIeQ8coxIzXr7G3SiteZ/Owo6hBgAXSuuy5
         VJgg==
X-Gm-Message-State: AAQBX9cE54O7SkXAmiN9L/2NzHaZsrJQ6t4GYUa5Cc4Ub+sh0ImRwpFz
        TirnCXQU+fjH3CGK4ZqWzF0=
X-Google-Smtp-Source: AKy350aYkFGaqdQgKw2HCb4Wb9fQIfTnpQ8zTGapIJ6wltWZhtbrztf5n/2+TpvYTZf0XQ9MMXd1GA==
X-Received: by 2002:a17:90a:6747:b0:237:9cc7:28a6 with SMTP id c7-20020a17090a674700b002379cc728a6mr3168275pjm.26.1680967150251;
        Sat, 08 Apr 2023 08:19:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090a950600b0023f786a64ebsm6373371pjo.57.2023.04.08.08.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 08:19:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ce0fffca-5965-87f1-c827-3e18e40727f2@roeck-us.net>
Date:   Sat, 8 Apr 2023 08:19:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] watchdog: imx2_wdt: set variables imx_wdt*
 storage-class-specifier to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, wim@linux-watchdog.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230408143428.2704141-1-trix@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230408143428.2704141-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/23 07:34, Tom Rix wrote:
> smatch reports
> drivers/watchdog/imx2_wdt.c:442:22: warning: symbol
>    'imx_wdt' was not declared. Should it be static?
> drivers/watchdog/imx2_wdt.c:446:22: warning: symbol
>    'imx_wdt_legacy' was not declared. Should it be static?
> 
> These variables are only used in one file so should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

We already have that at

https://patchwork.kernel.org/project/linux-watchdog/patch/20230228151648.4087637-1-linux@roeck-us.net/

but I don't really care which one Wim picks up, so

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>   drivers/watchdog/imx2_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 19ab7b3d286b..6fcc3596103c 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -439,11 +439,11 @@ static int __maybe_unused imx2_wdt_resume(struct device *dev)
>   static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
>   			 imx2_wdt_resume);
>   
> -struct imx2_wdt_data imx_wdt = {
> +static struct imx2_wdt_data imx_wdt = {
>   	.wdw_supported = true,
>   };
>   
> -struct imx2_wdt_data imx_wdt_legacy = {
> +static struct imx2_wdt_data imx_wdt_legacy = {
>   	.wdw_supported = false,
>   };
>   

