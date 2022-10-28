Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CC5611389
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJ1NtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiJ1Nsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:48:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1A1E0443
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:46:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l32so3252146wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlka1GHz30o8aFh5tsOBDtq0uUt2y6UQRhwfqrBr1vE=;
        b=QYmk5BWs/oI32LYoqi6tLS8sQs5PGD1Qrw15MH8NBomuEMZV10PHqTFlI+RoBIu63A
         O3/7wsg3FeQJ8vpmH241KKQ65NuURSh+kytsn4Er3zqNF+2kZrikQips6ZOXKrKbtlZ2
         t+ChjWuvDTdR8O1yED8kWYgLfTG3bEGRzxsxItS4+3Z+603sVU7GuAYftmbDHAx9PbhO
         x9igrP530WCjTkHlUR07gSVAPV0wbqlU/N7YUS/Zs66d9uG/4YOFXarqhBQqMQZGnXTA
         Y6rKBrErcmc0BcARnZN8SJZ7gHOj9FiEyUNKny59c92ODDwddB7ExNP8QQ3t20w8FXkr
         0AGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vlka1GHz30o8aFh5tsOBDtq0uUt2y6UQRhwfqrBr1vE=;
        b=6sMIPaO0kWrtCaTx6E9GDTaBNB0NBDSURPOYoMlslOqAEqtxhuWwqw7UAUC7LkrOVH
         hnPlJrkKToTWIcSNixjUOqgt5cQptLwzzjNf273KjFbaFxO2jvPhNXParlrbWQxPSfKp
         5LIaGjqRSK/q9INQB2MJu5Q5TY/Z68HKvE18YOfUNgCsWl5KyuoiSEiMFKZEQCSS4WcZ
         8B548QsTAHMVtfQ18OIa6y+uiYL+ripasf5Q/LKAzCPrzLrPLYGZ+BloKu820Cci0OTQ
         nHFn7ALj7S9VPTqV4U/thggpE9utQNp0OIWVb97SxgFS7MpBOnTcnFILFCXgytGG/Ht/
         IA2A==
X-Gm-Message-State: ACrzQf1J2BuqK5qNz4caV4Au+L0PhzgreeRuHZ5OxhwugsCUBVCvpD6Z
        EoMj50gljHpPcTAavDwx6JkXvg==
X-Google-Smtp-Source: AMsMyM6jRcL5aI0pR7qvy593FXtb1XFIcJ1VPvGc+0GGu3R4pUQo7szAhVrmZO9sLmRfQplU7LHFgQ==
X-Received: by 2002:a05:600c:3789:b0:3c6:beed:fecf with SMTP id o9-20020a05600c378900b003c6beedfecfmr9281906wmr.174.1666964817077;
        Fri, 28 Oct 2022 06:46:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:898:f380:9e9c:c6c2:95a3:c182? ([2a01:e0a:898:f380:9e9c:c6c2:95a3:c182])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b003c6c5a5a651sm4267793wmb.28.2022.10.28.06.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:46:56 -0700 (PDT)
Message-ID: <ec753353-a844-2262-bbbf-7b77fc55af19@linaro.org>
Date:   Fri, 28 Oct 2022 15:46:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] clk: meson: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221028134156.64042-1-yuanjilin@cdjrlc.com>
Organization: Linaro Developer Services
In-Reply-To: <20221028134156.64042-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 15:41, Jilin Yuan wrote:
> Delete the redundant word 'of'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>   drivers/clk/meson/clk-regmap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
> index e365312da54e..e08a9fa0cc36 100644
> --- a/drivers/clk/meson/clk-regmap.h
> +++ b/drivers/clk/meson/clk-regmap.h
> @@ -18,7 +18,7 @@
>    * @data:	data specific to the clock type
>    *
>    * Clock which is controlled by regmap backed registers. The actual type of
> - * of the clock is controlled by the clock_ops and data.
> + * the clock is controlled by the clock_ops and data.
>    */
>   struct clk_regmap {
>   	struct clk_hw	hw;


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
