Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D017625E95
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiKKPpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiKKPpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:45:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FDD4D5E3;
        Fri, 11 Nov 2022 07:45:09 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v17so8124009edc.8;
        Fri, 11 Nov 2022 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIEGBYnjtBLkkhF3MQRlWI1UwDpfyFwgWu7aqDXVdLI=;
        b=YN6ZOyaOgRTYvOKxAFMYPmNCwWfFOSUdbeniVLII4vBW+e7oZbHP+1ovegicD/Q93b
         1MqacqdJqB16YWEeJ9jUnhfnhACuqfCJNyvzGMd0EA8ehlGJ0csPUC+Zr19bDsqxzIVo
         QM03B927f6HpIRjcqkNCQ9cOked1uk2oCYLbvTgRK/kjUYvCcgv3fAUgvTqJvrdvYnK/
         0k/H6CWcuuIt+c+MzUDAFhoueD7eccauawkxjAnrmarezlD6Ddz1XzMPVDVUppXcyu5d
         7WevXb1UV+lf6fqmxtRhL68zA3BFRjZqtS4otxXSATmfpzrmwyZWb0mkh7SShtv91tBn
         l8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIEGBYnjtBLkkhF3MQRlWI1UwDpfyFwgWu7aqDXVdLI=;
        b=tX4iwaUC+fXxJIIv9SNeh+SaXxK6SrT8/UEVjlA+whxR5YSoPRGHJMgQW0jP7K4QCW
         0KzmjwQuisMkm2LhI+Q9Js+a7wwDLP9iIpYAFXw/ung2MTbyJTlEAv/1wPskmaIR4hht
         ubiQf5y6FgX2tq1FYqVu1OMNbI8jDvvAJ/x2TzlLr9jKeYW3XOBUMCNNUwHq9vFoUszl
         nERMaKwwSe4EQC4TEnfGkxgliwt5kdKxNDWRBUzFWDtBDen/WZxBq1fiMYm5kLUoV0R1
         cOqr1SqRPbtJrZeQS8cVypNzdZQfxPtwhx9CA2BxJmQiwPc7pDXtTdyuxpsQP/eftnIf
         vI5A==
X-Gm-Message-State: ANoB5plGytJ0AtHV3Fx1EWVYWDyGbg419mrMoAxI8ACDZ7ysSR9+Moea
        OAqS5t9xn7w+EU02P8JSYXY=
X-Google-Smtp-Source: AA0mqf7MsHhRdN7JZ5C8J2CL2kabiKK6v9/ZXFxPy2/4geGcr3vteYcWiBUz3cpkb7RegzADeBKQcw==
X-Received: by 2002:a50:ff04:0:b0:462:709:9f7b with SMTP id a4-20020a50ff04000000b0046207099f7bmr2051431edu.263.1668181508274;
        Fri, 11 Nov 2022 07:45:08 -0800 (PST)
Received: from [10.176.235.173] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b0078df3b4464fsm1027467ejb.19.2022.11.11.07.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 07:45:07 -0800 (PST)
Message-ID: <b3e92294-0aa7-edc1-115b-7552b13f9e7d@gmail.com>
Date:   Fri, 11 Nov 2022 16:45:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/4] ufs: core: Remove redundant desc_size variable
 from hba
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1667399353-10228-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1667399353-10228-3-git-send-email-Arthur.Simchaev@wdc.com>
Content-Language: en-US
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <1667399353-10228-3-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.11.22 3:29 PM, Arthur Simchaev wrote:
> @@ -7446,25 +7428,24 @@ static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
>   static void ufshcd_set_active_icc_lvl(struct ufs_hba *hba)
>   {
>   	int ret;
> -	int buff_len = hba->desc_size[QUERY_DESC_IDN_POWER];
>   	u8 *desc_buf;
>   	u32 icc_level;
>   
> -	desc_buf = kmalloc(buff_len, GFP_KERNEL);
> +	desc_buf = kmalloc(QUERY_DESC_MAX_SIZE, GFP_KERNEL);
>   	if (!desc_buf)


Hi Arthur,

Do you think it is better to use kzalloc or kmalloc here? If item in the

descriptor is not supported by the device, it will be 0x00 and then the

relevant feature will be marked as disabled or not supported on the

device feature checkup logic.


Kind regards,

Bean



