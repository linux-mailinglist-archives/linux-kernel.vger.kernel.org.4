Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A089262949E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiKOJny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbiKOJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:43:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EB562F8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:43:51 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j4so23628910lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wrWpTcqZkvu1mmEitCifcGVxseblveX37zlqDCCpjc=;
        b=it/DGIfpFZ8anGUh2KdXMRwrOXmr/1l+NeEU4BlzB5mGBZkmEixmLYx40GUCVKB87e
         bCrJmUvRNocDMraCwZfAYcF7ECn1W0ZriniqdEo6GMDTXquXhsB7Um4pr3eZ+s2VNGdc
         11q/S+5B/4piz75M2HQhxuPy2uNKsSfDGwfzbYCayE/QnHZMdVQnGBKoqVAHTLBS+TXs
         eel1HZWnAx8UWO9f+jPF8RMug7N7vVAGDysfsJMXcnx8W/fZIsWQNmsrUdKjlVXXmaua
         2Dp17L1VeW/f2vj3AWfhevQHBHEMtbjLBwgdIY8/uwChGshulhPfbzyzPcFm2ji4RcDJ
         sKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wrWpTcqZkvu1mmEitCifcGVxseblveX37zlqDCCpjc=;
        b=UyqNqQqdrgNRIQsU/PSjBHPweYyySdmm1Lm7QHzBPJux2YDkR1MwIM6SjTKQBk9q5V
         F0xaGYlDQV2QJ2UtvlzjMVPRKeOxjU4G8+NdWuTJtHfsXK1MRfC/Ku2mN6o2p8020yJR
         bLTxthUsZy5+rt4co76iLBcy9q0JLDDuLs/EDfbzNkTcrbuL3Xv2WdsLhE0alGzA5XT2
         XyB5Sqz5j8Q7XTOnsQDIM3z/s7xF2XjRdlKCgwB/A7SRSJIaeihfvHyBJ3eHB2V+qjo/
         RbSrlowviiyOJW55xhvfeKPCPzwNMUUPAsbhHwjy7/sJy8jHNUg3ZA7RUCsLJtP8S1ei
         cufQ==
X-Gm-Message-State: ANoB5pnLkJgWAtZo4GOspwl74ERDEIq0N47Zhh6csqIfNBYi50UuJ/1f
        PfEVOBRfzwwg3R7c9qYmhLQLbQ==
X-Google-Smtp-Source: AA0mqf75O/7WU8XDD9IwQKSCfFeGbOFmcHAo5be07CziHS5AMi+B7pemqxe1e76Z9mVvNjLaX4/kIw==
X-Received: by 2002:a19:6449:0:b0:4ae:5dc5:82c5 with SMTP id b9-20020a196449000000b004ae5dc582c5mr5964438lfj.2.1668505429663;
        Tue, 15 Nov 2022 01:43:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b13-20020ac25e8d000000b004b1892aa5c8sm2155057lfq.56.2022.11.15.01.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:43:49 -0800 (PST)
Message-ID: <33c2ffe2-7f23-5292-8eec-aee66fb59cf8@linaro.org>
Date:   Tue, 15 Nov 2022 10:43:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 05/15] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC
 bindings
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
 <20221115025421.59847-6-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115025421.59847-6-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 03:54, Bernhard Rosenkränzer wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

1. Drop second, redundant "bindings" from subject.

2. This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

