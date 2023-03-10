Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57DC6B4CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjCJQVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjCJQUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:20:41 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2819612B966
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:16:27 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17711f56136so6334500fac.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1678464972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybB2/6fiCPS1q7MSkJgqsG4qB8ZvqgTBA+GacxHV53I=;
        b=FRfBleY8vdY4BY91j53yyYGdhm0gaATN3ND+n8UDf6MEA1vayyxuIl2zQr6OHlpKjb
         RDf7z5+SciODL68u5ZZt1EFahvAvYJMK/R82qRF73uVRmJUJXHjgqx/5Sb97I9geirVz
         befj8hPFJlLCq4lh+/NsttNkXVcq+wePdm+jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678464972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybB2/6fiCPS1q7MSkJgqsG4qB8ZvqgTBA+GacxHV53I=;
        b=uyKEW8JAc2AJnvFIIt2qM0fZ/d+zxciL5Sxg8lP+MdQ4Xk4ej/iBr7zHUl1z4ykuM2
         GPKQDrNoQGKar8IZKddVbEedZHfF+x9iI3g1Z0k6wkJPp4sQyFPDHgA+RTbPXQ1dMEd8
         HDOI7axf/k8xSbOeJVglyzcxF5F/XesEalyFoKqrpFlfDxdCBJlLTL2yb50I3AlPo62k
         2BPmmg1ZYvca1Bg2BSonxCDQDEYlbdwlQsdzFarQsDvmsrW9voUaNUGpo0Zzm7huRXpC
         TvFYqAbRYx5qH+VHfPhW4ogDV7w4k416cmdu0lpv2FpjvGFGiFvzjzEAjHSm6wkMr3NX
         PiWA==
X-Gm-Message-State: AO0yUKUC/926XdGa0aO0pvGq8GJuiZ8OzwirOBsnHQypRq60+m9/Qn75
        sYQL4rQIrDWiPB+v7NcR4txMsw==
X-Google-Smtp-Source: AK7set8zKxezsFGFrVD9ORC855Xu0mIsWnaOFm5gYDpUWJ7BjoD3vqc2zRk3JnSJlNxDFhdoGO+99Q==
X-Received: by 2002:a05:6870:a114:b0:16e:8c0:6ddf with SMTP id m20-20020a056870a11400b0016e08c06ddfmr15613893oae.32.1678464972470;
        Fri, 10 Mar 2023 08:16:12 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id s138-20020a374590000000b007436d0e9408sm8964qka.127.2023.03.10.08.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 08:16:11 -0800 (PST)
Message-ID: <6ed4616d-03e7-f055-cd25-934e69d253df@ieee.org>
Date:   Fri, 10 Mar 2023 10:16:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] staging: greybus: Fix Alignment with parenthesis
Content-Language: en-US
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        outreachy@lists.linux.dev
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 9:51 AM, Menna Mahmoud wrote:
> Fix " CHECK: Alignment should match open parenthesis "
> Reported by checkpath
> 
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>

Is this (and your second patch) the only place(s) where
this issue gets reported?

I think this type of alignment is not a major problem,
and alignment isn't done this way in general in this
driver, it's probably OK to keep it that way.

					-Alex

> ---
>   drivers/staging/greybus/fw-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/fw-core.c b/drivers/staging/greybus/fw-core.c
> index 57bebf24636b..f562cb12d5ad 100644
> --- a/drivers/staging/greybus/fw-core.c
> +++ b/drivers/staging/greybus/fw-core.c
> @@ -89,7 +89,7 @@ static int gb_fw_core_probe(struct gb_bundle *bundle,
>   			}
>   
>   			connection = gb_connection_create(bundle, cport_id,
> -						gb_fw_mgmt_request_handler);
> +							  gb_fw_mgmt_request_handler);
>   			if (IS_ERR(connection)) {
>   				ret = PTR_ERR(connection);
>   				dev_err(&bundle->dev,

