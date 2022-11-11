Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967F362608D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiKKRis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiKKRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:38:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011A85BD60
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:38:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so7371300wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtQcHdnXGmdeDNnT4QITUKcKLbC/o+km4OY5CSxdgzs=;
        b=cSDXdAat9tQMJS4E8j6Wnts/+Bwpb9BPztlmM1pJ9qpP1B/BHqtEhKhD3lNep7yuVT
         gnpcbvZWTq09EXle8/gO56+MRYBltykMp+Tn1ympGRglkcnNKGWHGOUAvqMD+2esNJMx
         rfGQTCMPG0Gy9PZJmAr6Z1BW57mZ8IvD2Q0bxmTEERCQgTCpSIplsaXUHSyPEl9SDO3d
         xnStW0YJ6mH33xWvK/6t4tTk1b8IlYAoXMVWG9UGKBLx2gxM5BPYDSJMu2aigGtY5RZG
         hILElqf0DpC2Qpi0JBgDahPqFIA2F47kSR5BgnkU8K9rnMdybE1p+A76Fc6clXMag47d
         zosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtQcHdnXGmdeDNnT4QITUKcKLbC/o+km4OY5CSxdgzs=;
        b=HRmhckKlIO5fcO4Ya1sBnIhgti3+YdlPL6CfkKv18P5nBvTVSWBK+d7aG4hUr5v5C1
         QqqkZ3Q0v6F31dMHKl5xz9fo96bSaqfidOPo4JqahPjqfTbhF2FuzUxpeisK48J0qLD8
         vNwlnzy6AwQzpHDTQu2AovT7W64P+R3VGWSj3Ta7Z8Vpdt2+Mz8Em5G2aHAKUZd6V1EY
         5i7ruw6qjLpSoQCjSkvoH6Urlmycb221TX4Q6FkLQG5we7ZzovyGT+LHLId46lrKrBuE
         VqR7CXU5wqqsJS/2OpmafnMHCl6LQTILAMCyh4C2eAZe/zTOQo57xqU3dqenId/4sZiv
         DSBQ==
X-Gm-Message-State: ANoB5pn6+8VkMO0oTkxg80j9TejgxV9m9UGFmp/vnhrLh9RWWiFsIJvc
        Swfs/bQTwb9s8QXpf/NqIBQbHv/Op2uNdg==
X-Google-Smtp-Source: AA0mqf74NAeCBN5gUlzhsgNa4hZcptbsUFtVAUofQmWbwyHDb7vC8af/fg1rJdiIDGHYknKp+Z9bUw==
X-Received: by 2002:adf:a51d:0:b0:236:6302:2237 with SMTP id i29-20020adfa51d000000b0023663022237mr1937624wrb.519.1668188324529;
        Fri, 11 Nov 2022 09:38:44 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id f20-20020a05600c155400b003c6f3e5ba42sm11225931wmg.46.2022.11.11.09.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:38:43 -0800 (PST)
Message-ID: <b0544b8b-fe49-baa1-85eb-5151fa0c7261@linaro.org>
Date:   Fri, 11 Nov 2022 17:38:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvmem: u-boot-env: fix crc32_data_offset on redundant
 u-boot-env
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     rafal@milecki.pl, gregkh@linuxfoundation.org,
        a.fatoum@pengutronix.de
References: <70a16eae113e08db2390b76e174f4837caa135c3.1667580636.git.chunkeey@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <70a16eae113e08db2390b76e174f4837caa135c3.1667580636.git.chunkeey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/11/2022 16:52, Christian Lamparter wrote:
> The Western Digital MyBook Live (PowerPC 464/APM82181)
> has a set of redundant u-boot-env. Loading up the driver
> the following error:
> 
> | u_boot_env: Invalid calculated CRC32: 0x4f8f2c86 (expected: 0x98b14514)
> | u_boot_env: probe of partition@1e000 failed with error -22
> 
> Looking up the userspace libubootenv utilities source [0],
> it looks like the "mark" or "flag" is not part of the
> crc32 sum... which is unfortunate :(
> 
> |static int libuboot_load(struct uboot_ctx *ctx)
> |{
> |[...]
> |       if (ctx->redundant) {
> |		[...]
> |               offsetdata = offsetof(struct uboot_env_redund, data);
> |		[...]					//-----^^
> |       }
> |       usable_envsize = ctx->size - offsetdata;
> |       buf[0] = malloc(bufsize);
> |[...]
> |	for (i = 0; i < copies; i++) {
> |		data = (uint8_t *)(buf[i] + offsetdata);
> |               uint32_t crc;
> |
> |		ret = devread(ctx, i, buf[i]);
> |		[...]
> |		crc = *(uint32_t *)(buf[i] + offsetcrc);
> |               dev->crc = crc32(0, (uint8_t *)data, usable_envsize);
> |
> 
> [0] https://github.com/sbabic/libubootenv/blob/master/src/uboot_env.c#L951
> Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---

Applied thanks,

--srini
> v1->v2:
> 	- drop endian crc32 check - handled by pending patch
> 	- added u-boot-env: tag to subject + adjusted subject
> ---
>   drivers/nvmem/u-boot-env.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
> index 8e72d1bbd649..4fdbdccebda1 100644
> --- a/drivers/nvmem/u-boot-env.c
> +++ b/drivers/nvmem/u-boot-env.c
> @@ -135,7 +135,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
>   		break;
>   	case U_BOOT_FORMAT_REDUNDANT:
>   		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
> -		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, mark);
> +		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
>   		data_offset = offsetof(struct u_boot_env_image_redundant, data);
>   		break;
>   	}
