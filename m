Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D20D5B3238
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiIIIsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIIIs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:48:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D320C12D1B0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:48:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so3208306wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=qHVswhVACDLOTVZmDz8woSoanr3PlEeTXqdYDzKWiac=;
        b=aMPagJHU+dBvQYKAjci2vGliRESLcJzfv12RrSlAS7weQhJKXuTvKCZ+vVLhhDwBEy
         7mcNQCfsbpzdDJjT7QBASPp/asPlPElmDoRdfo7isuu8oAuH+8WWwItPeWeAlJjoSQbr
         687BhLcGxls6lXdY1K8i8hrMCJXAx9xhcw9f/bEa+Zd0DaypUEorp768is1CzcRnhiJj
         GJCiId5/1Kb6ItpILoFp2frmNbIIlgFJFGLJjxW3YxCPnL0HZ/XWFZZ3AoFBeBAv5bo3
         Ot3zvAoe9hl9TVnGEham1wJwNnMplbpeaZXatumSvQoTX6Ngjet5ORsHKdIwZ892MYd8
         Y26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qHVswhVACDLOTVZmDz8woSoanr3PlEeTXqdYDzKWiac=;
        b=aMZJ280Mcdd8roYpOwJTQFdK2odtMUR+FHgRzorT4zrEDfTnsmBmlEZ58nGkBnRJH7
         JkoEhRoNbBtzmhyaGwreTTg8Fq+KxqGR5I7NjN0up1LZI23vEdxnqMuH2ReiEmdWclMn
         knGTBb7XXxDxnddC74z7qe2wCH8kTcoFyxIGx0qLI4bjABbo/9u6y9saO9N6spq3gDXa
         XMSrR0DPaV5w4AmokmAqJE4Gd/96P64FYvQkJbMxGN0JqDhKtbloo+5BcQ1T+0YA+oii
         Vi9ErOWL460a/apWrKvHSu3R50fPs853lM4w77G171XyeFc+M7ipQ1wcH8zuSs2UopxZ
         WABA==
X-Gm-Message-State: ACgBeo39vc37y48zn2dzFinbNOkI+xxxBnhMfe0jqBq0sU3rnvZ6FNij
        Mm7gpx3Lw06YIow8sAXHSBNO2A==
X-Google-Smtp-Source: AA6agR7k0FqLnxJKlHx+725dk2xWhXPx8/Es727NpYHaX+cqeN/AGjFkoMi4mIs61qP+DouU2xVVJQ==
X-Received: by 2002:a1c:4c03:0:b0:3a5:d65c:c1e7 with SMTP id z3-20020a1c4c03000000b003a5d65cc1e7mr4883562wmf.4.1662713306373;
        Fri, 09 Sep 2022 01:48:26 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id fc10-20020a05600c524a00b003a5de95b105sm5974868wmb.41.2022.09.09.01.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 01:48:25 -0700 (PDT)
Message-ID: <1c83195f-0228-b3c7-3652-8f2c59c7da22@linaro.org>
Date:   Fri, 9 Sep 2022 09:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] nvmem: sunxi_sid: Always use 32-bit MMIO reads
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220814173656.11856-1-samuel@sholland.org>
 <20220814173656.11856-2-samuel@sholland.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220814173656.11856-2-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/08/2022 18:36, Samuel Holland wrote:
> The SID SRAM on at least some SoCs (A64 and D1) returns different values
> when read with bus cycles narrower than 32 bits. This is not immediately
> obvious, because memcpy_fromio() uses word-size accesses as long as
> enough data is being copied.
> 
> The vendor driver always uses 32-bit MMIO reads, so do the same here.
> This is faster than the register-based method, which is currently used
> as a workaround on A64. And it fixes the values returned on D1, where
> the SRAM method was being used.
> 
> The special case for the last word is needed to maintain .word_size == 1
> for sysfs ABI compatibility, as noted previously in commit de2a3eaea552
> ("nvmem: sunxi_sid: Optimize register read-out method").
> 
Missing Cc stable..

--srini
> Fixes: 07ae4fde9efa ("nvmem: sunxi_sid: Add support for D1 variant")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>   drivers/nvmem/sunxi_sid.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index 5750e1f4bcdb..92dfe4cb10e3 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -41,8 +41,21 @@ static int sunxi_sid_read(void *context, unsigned int offset,
>   			  void *val, size_t bytes)
>   {
>   	struct sunxi_sid *sid = context;
> +	u32 word;
> +
> +	/* .stride = 4 so offset is guaranteed to be aligned */
> +	__ioread32_copy(val, sid->base + sid->value_offset + offset, bytes / 4);
>   
> -	memcpy_fromio(val, sid->base + sid->value_offset + offset, bytes);
> +	val += round_down(bytes, 4);
> +	offset += round_down(bytes, 4);
> +	bytes = bytes % 4;
> +
> +	if (!bytes)
> +		return 0;
> +
> +	/* Handle any trailing bytes */
> +	word = readl_relaxed(sid->base + sid->value_offset + offset);
> +	memcpy(val, &word, bytes);
>   
>   	return 0;
>   }
