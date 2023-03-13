Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A196B751A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCMLDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCMLDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:03:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121710A83
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:03:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso11259436pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678705391;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhI30tCLkB+amGX90mAxnZUAEcYPmoV4l/2fFogFv3c=;
        b=DQlGurtNgAxicvzYip50ZAarzlDqIviydiT9JqHkR+4ZW9EX3lljrSCSqoZ2YVoCHx
         DalX8V+mnggp3W1f8U5fwdk9LFrC1eyQiWnjF64RK0MJhUcTMIHwCxa3Bafad8K2e9up
         qT8skjc/C5DQxEcimjIrYdcAIr01ib9huh0XBc4lQihVNzyhexe//3llhOyDO2LPpO1m
         Eg4pVDTXbKK7pO4OqNJupTVbokN19vNis5bATFruqZKcSpcFz5GFPfrbTriF5QvrJZoV
         V/UmDYKQJJmN9smpmBvYQpbEhISMeWEFVa/sKkD1StI45zWHyKgav1TfhhpG/ivjjX4v
         Wgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678705391;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhI30tCLkB+amGX90mAxnZUAEcYPmoV4l/2fFogFv3c=;
        b=B+p3gA8+JbrCVWsICEAcEmJ2Xm7RjFUOnBX0FeueW3t4Gl3AnTXA31U9KpDJnP+7vf
         RvMbB5CV3wBpmgcvRm1Lyn9Wr+iLlZShv0TXhwchOrpzM/MA+6w9ajKRQADbL1R+CTXd
         YJzvzSQRVUnZyUJVlMiB8SdDWDNwnR0PlOtAYEVw1h4d298Za2l3vebKyksleV8/Xnjo
         4emoltb3Bg8Vn3TKOMsKpx4gP+ABk8k7s71il8KER+j/XWiYZXwHg3Gj6MU84iB25A00
         A3ISX6DxPrHap8c7PMdsEshAFvUCetDfCtvWufPaS/AyALLtNUb7Hv1+pp0k0vDNWBSd
         1S/Q==
X-Gm-Message-State: AO0yUKUtyWQVvWG2iHNO5DFA7dAJimNtHMa3YHz4j8u+EWXbJ09lxbTU
        PfDcMk78jZ+dm4Jbpdo4dvGu1sAzs+Q2LA==
X-Google-Smtp-Source: AK7set8WaBDj6VowvNO2pLLuv6bBIcvooNQgz61FUlLSLcYoK7V5YUR1vYmO97lXC7ZhOdBSkVEnZQ==
X-Received: by 2002:a05:6a20:a692:b0:c2:fae6:caea with SMTP id ba18-20020a056a20a69200b000c2fae6caeamr33906047pzb.21.1678705391561;
        Mon, 13 Mar 2023 04:03:11 -0700 (PDT)
Received: from [172.30.1.89] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x2-20020aa784c2000000b005d92c9afbd4sm4163676pfn.33.2023.03.13.04.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 04:03:11 -0700 (PDT)
Message-ID: <1da3c396-ffce-0473-aedb-a290d707fb19@gmail.com>
Date:   Mon, 13 Mar 2023 20:03:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/4] extcon: Removed redundant null checking for class
Content-Language: en-US
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
References: <20230302090143.46678-1-bw365.lee@samsung.com>
 <CGME20230302090149epcas1p35d6a66bf8b29ef159ecee93441560c58@epcas1p3.samsung.com>
 <20230302090143.46678-2-bw365.lee@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230302090143.46678-2-bw365.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 2. 18:01, Bumwoo Lee wrote:
> create_extcon_class() is already Null checking.
> 
> Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
> ---
>  drivers/extcon/extcon.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index e1c71359b605..adcf01132f70 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1012,12 +1012,13 @@ ATTRIBUTE_GROUPS(extcon);
>  
>  static int create_extcon_class(void)
>  {
> -	if (!extcon_class) {
> -		extcon_class = class_create(THIS_MODULE, "extcon");
> -		if (IS_ERR(extcon_class))
> -			return PTR_ERR(extcon_class);
> -		extcon_class->dev_groups = extcon_groups;
> -	}
> +	if (extcon_class)
> +		return 0;
> +
> +	extcon_class = class_create(THIS_MODULE, "extcon");
> +	if (IS_ERR(extcon_class))
> +		return PTR_ERR(extcon_class);
> +	extcon_class->dev_groups = extcon_groups;
>  
>  	return 0;
>  }
> @@ -1088,11 +1089,9 @@ int extcon_dev_register(struct extcon_dev *edev)
>  	int ret, index = 0;
>  	static atomic_t edev_no = ATOMIC_INIT(-1);
>  
> -	if (!extcon_class) {
> -		ret = create_extcon_class();
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret = create_extcon_class();
> +	if (ret < 0)
> +		return ret;
>  
>  	if (!edev || !edev->supported_cable)
>  		return -EINVAL;


Applied it with following edited title:
On later, please write the patch title in command form.

extcon: Remove redundant null checking for class

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

