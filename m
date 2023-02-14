Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F6695A88
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjBNHWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBNHWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:22:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3E5E057
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:22:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y1so14637587wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+TwnjAXxTTAQQ8LXT0M5l2YQ9gFoLEmULHa8JKTYR4=;
        b=jx0MSCW2gt8kaWQHxlwOyC9fvgmMYQH3jnWJtmqSFUZxwCE96pzCUMxc/FC5NBfq8z
         JlKLCpnm/ciYpV9rvN4EnknEmRhZ0fjcv2sTD8Oho7d7pVcOdEJBvam/LR8x/MKEHU2S
         qN8GheCstJSHRIjJgiIcMaD1Ne6NnzLShaXYVDnXC3wJkaTF0VN07cXqRj5ZVZrMxSMb
         rU1wJfebjaFnUHmYVWukmU1sEUgvk9CrY2nBlYl1h4RJm+QRcCrOvgJVLJO0pkghZnMx
         gygNvk8fVywtJC8DN9LIFEWC088ec/EbtVu/blu561Nz1yXvYtEEF9eptlCdpExccXYM
         X2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+TwnjAXxTTAQQ8LXT0M5l2YQ9gFoLEmULHa8JKTYR4=;
        b=HpoKY404Wy9ymU0RgfIxsiiE2OlcMAt1FMutDOxj/FrWsSaT8EvlygUzixurd9RJNZ
         kOy4U8em849H4eU5hiaYgKwAGc3JKFMnxNolchUy2W/DUwDGdvQkULXv2cbnteuZtHFy
         QXRd52daP0WzXSffW+5PJu3O3MTl+5RgmrOH8ffktOSrElGarqZQzkiSH07JhJrBTGO5
         gToyAmAdeM/VYig1o3hkiF25YOrgGeP9QcxvxybJxZOcqphZz3tA1M20afAQPJPdlUWA
         3ZsGBOtPjU1Z/bY+o5fOfO1GS6BSBh7CD8lKtN1weORlsVOv7aJVXvv+uP+7c/mAiiik
         7nRQ==
X-Gm-Message-State: AO0yUKXprkJpsk4yGFqORIRQf/Ujfusy+kqjNPN7CYJzGmv3/+L81kft
        nf/COPldRyuz+QfFBohX8HOYfVq2Oz6i0pCn
X-Google-Smtp-Source: AK7set/u8IAuSg7A7VxtiJt2hjuOIFjvoIRsVVtaR5dwCCQMZITd3akSq1tUSYkwidR+nKUUkb5bzg==
X-Received: by 2002:adf:f8d2:0:b0:2c5:4ca6:96f6 with SMTP id f18-20020adff8d2000000b002c54ca696f6mr987050wrq.22.1676359323645;
        Mon, 13 Feb 2023 23:22:03 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b002c567e3808bsm481145wrm.40.2023.02.13.23.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:22:03 -0800 (PST)
Message-ID: <59c0ba61-c5d6-b74f-0fbd-844b08d13e5d@linaro.org>
Date:   Tue, 14 Feb 2023 08:22:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] module: fix MIPS module_layout -> module_memory
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Song Liu <song@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
References: <20230214005400.17137-1-rdunlap@infradead.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230214005400.17137-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 14/2/23 01:54, Randy Dunlap wrote:
> Correct the struct's field/member name from mod_mem to mem.
> 
> Fixes this build error:
> ../arch/mips/kernel/vpe.c: In function 'vpe_elfload':
> ../arch/mips/kernel/vpe.c:643:41: error: 'struct module' has no member named 'mod_mem'
>    643 |         v->load_addr = alloc_progmem(mod.mod_mem[MOD_TEXT].size);
> 
> Fixes: 2ece476a2346 ("module: replace module_layout with module_memory")

On which tree is your patch based?

fatal: ambiguous argument '2ece476a2346': unknown revision or path not 
in the working tree.

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Song Liu <song@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> ---
> Has this already been fixed?
> 
>   arch/mips/kernel/vpe.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
> --- a/arch/mips/kernel/vpe.c
> +++ b/arch/mips/kernel/vpe.c
> @@ -640,7 +640,7 @@ static int vpe_elfload(struct vpe *v)
>   		layout_sections(&mod, hdr, sechdrs, secstrings);
>   	}
>   
> -	v->load_addr = alloc_progmem(mod.mod_mem[MOD_TEXT].size);
> +	v->load_addr = alloc_progmem(mod.mem[MOD_TEXT].size);
>   	if (!v->load_addr)
>   		return -ENOMEM;
>   

