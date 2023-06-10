Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D40C72AD61
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjFJQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFJQgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:36:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3193A97
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:36:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977cf86aae5so425534166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686415009; x=1689007009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9TSyf1ASxYuSJlQ+UH4uk/uLAz+06/cWAcBLiOwXQw=;
        b=l4+idekUo2R3qaEXZf31sAuFI5DCWxe4ezpojv3RNHiK971aW/uxN/SkMBYEOFbtvV
         YMuJSmg9Rd9OhaBkBaTa6enedG+RAHAEa/HBELbprqMmtM+VYp2GMuqX2eYNX8cnJ+T1
         W70v5oxLT08J/gkTY/ECjfXZJQ2lHj+9UrkyBevOQFx5HEiA7XBcS2Rx8uvJq4j/Nqov
         devXgD2UABfKjXUkXiuGo0pUeOwlTrTeq1f85MPWIxUmZEPjAcE1XGpvuQpMNSbk9NH1
         UBmi0WpR2PPQZRP3+F5eiNzhbvjFHyY+XuVQQqOJRkdDJ18EoC2ZyKbuQLame1o9M9SX
         zzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686415009; x=1689007009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9TSyf1ASxYuSJlQ+UH4uk/uLAz+06/cWAcBLiOwXQw=;
        b=PtQYnClVnEPTl8TZcR/vBSfPEuGWgQMRJ4HnTTjIdPakNvntJ9wqiFyi3cDc74YGR6
         PZQjXanbGBNAyl3kMmvkJRL0vvk5fbk7EtfCVTT0oZnx0DijvGWg5Neg3b+wlnyVw75U
         S5p8AiHm4Pog7+6n5Q5YkdQkuPV5lFuebC8zbtJFWK8QNlA4tegSmMY1DgauS811vanY
         mb4975FP97akmXBitbswxrFhiRbZAUE3A3J4yLA1K1ODYqf4IMmoDgEdsAadmNRLKi2M
         rAdZ7u3sbBnPhkhyVFdnAuHyQjuzRKzKtKtpoDY7+K6NWR2LLAOozNu+ihsrEL2Y5G3f
         nWTQ==
X-Gm-Message-State: AC+VfDwVYj1M6QhGopAJWX7Rujp4QChBo+ThkT26iHXamVBBu3oTPl7F
        8p6eYl49N+bhLFADuTYdUMuXc2uPfTDFA7ZlM/4=
X-Google-Smtp-Source: ACHHUZ5t65TieFqQtj8koK/mLlS0PIsBePt/tLL8PzN3k07slDI1BUS4YqsKDnXwsw63KijHoadNwQ==
X-Received: by 2002:a17:907:2cc2:b0:96f:8439:6143 with SMTP id hg2-20020a1709072cc200b0096f84396143mr4846949ejc.40.1686415009051;
        Sat, 10 Jun 2023 09:36:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x7-20020a170906298700b00965b2d3968csm2791443eje.84.2023.06.10.09.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 09:36:48 -0700 (PDT)
Message-ID: <4e47443b-5ab9-7af3-6da7-840182768b1d@linaro.org>
Date:   Sat, 10 Jun 2023 18:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: Add Gateworks i.MX8M Mini
 GW7905-0x board
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230609174107.3373182-1-tharvey@gateworks.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609174107.3373182-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 19:41, Tim Harvey wrote:
> Add DT compatible string for a Gateworks GW7905-0x board based on
> the i.MX8M Mini from NXP.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

