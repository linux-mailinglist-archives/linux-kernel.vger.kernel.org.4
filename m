Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885C1622A52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiKILWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiKILV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:21:58 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CEC5FC7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:21:56 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id c25so25254304ljr.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCxYg4WgOjP/bm5a9BsDTG0c45MKZEsJG67lP9MsgSg=;
        b=HO+gw2fSW5E05U6Iq8JqzMRKLuM08uJDLhQRuJlxdr8dPesLMigBWgAyzAeExa/QeM
         nw0R5KrFXl+7T/GNrFhphNcbZaMhwSA3VB9Th1nj3R5wpJ6CcHE8rDHzETkHzHM0Oiwt
         in7VXNBFy/07Kz3EgHs7G0g0nZqONOpmfoGbGYOjZ3kVH55CNNAMH/bbX5ieNbd0Pqi9
         iuupt++I5YcAQlyePI7uickafZLUSSNtSPzpPb09dR/Xi5x3lBPgbm3CYeuBfvBGx6vL
         tkYQboJ0epeJoFCdNGZa3ThE7N8YaUG3rR4meKJAM5CPnNbbNrzqmAhmW0erUsceeqeb
         MRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCxYg4WgOjP/bm5a9BsDTG0c45MKZEsJG67lP9MsgSg=;
        b=rSmFp0NpMojeyCLpEmVqmQci76UuPmzxjKxbT8MEcc199TRjob8RQNeJKghRtEz71k
         GCi3P999IaXPkWMfQ+ErYyj64V0AdxVkL6e01VCDAuxNKh4gNf6+OM/EPVXywR5fXuPP
         6WIgfAqmXwH7P+UKqjLnC1qsxATsVNJOjcIrCBSvi1quHMPiuvQe5gFmg0gfM7Iln7Az
         TuWwDyJ6VQBDRlRapSNC3aL1idk5whNuhfNWHB0tqwmKdn4hvhmzczTFs4P3bBtWNQiX
         BVDX/+7nkdssb1t2PDaLyMeeyyc+fX7VlcBxJiRW0tMrYD1Up9cN4Hf1cxAl7VuAMf5h
         enew==
X-Gm-Message-State: ACrzQf1h3KsQsAZBv8GqRR0Ere4eYT26kR/Kdw9vc7iz6vvv8EAEdL3K
        Jh+TMXFCZoNKz06bvjkHCFW+cA==
X-Google-Smtp-Source: AMsMyM5qV7jVeG2pPQIG8qp/abMPvu2TVr8VijShCi76V0U224nQCkI55e+QRkjLdIj+vRoGV2Cf7g==
X-Received: by 2002:a05:651c:2226:b0:277:4818:a1ca with SMTP id y38-20020a05651c222600b002774818a1camr7905330ljq.361.1667992914945;
        Wed, 09 Nov 2022 03:21:54 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25f66000000b0047f7722b73csm2187030lfc.142.2022.11.09.03.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 03:21:54 -0800 (PST)
Message-ID: <32240212-7460-9d37-8986-e7d3e34cb1b7@linaro.org>
Date:   Wed, 9 Nov 2022 12:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 6/6] arm64: dts: fsd: Add support for error correction
 code for message RAM
Content-Language: en-US
To:     Vivek Yadav <vivek.2311@samsung.com>, rcsekar@samsung.com,
        krzysztof.kozlowski+dt@linaro.org, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com, alim.akhtar@samsung.com,
        linux-fsd@tesla.com, robh+dt@kernel.org
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        aswani.reddy@samsung.com, sriranjani.p@samsung.com
References: <20221109100928.109478-1-vivek.2311@samsung.com>
 <CGME20221109100309epcas5p4bc1ddd62048098d681ba8af8d35e2e73@epcas5p4.samsung.com>
 <20221109100928.109478-7-vivek.2311@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109100928.109478-7-vivek.2311@samsung.com>
Content-Type: text/plain; charset=UTF-8
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

On 09/11/2022 11:09, Vivek Yadav wrote:
> Add mram-ecc-cfg property which indicates the error correction code config
> and enable the same for FSD platform.
> 
> In FSD, error correction code (ECC) is configured via PERIC SYSREG
> registers.
> 
> Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
> Cc: devicetree@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
> ---

For net-folks: although the DTS patches are here as well, but they must
go via ARM SOC tree, so pick only network/can drivers and bindings when
they are ready.

Best regards,
Krzysztof

