Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464DB5BC601
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiISKF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiISKF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:05:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D079582
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:05:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x29so995525ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1m6rTMKNi34J7sLNFezHq9Zai2Cnn9/zIHw82h382uo=;
        b=jVVkXI7aV1ZfDnFfJ10wIoue4SuXD2taKfvnuvUvj4m49PSFro6C5uU/oi0e7RjzLM
         Y8Lp3oq59a3xY5brIvbWnnigIifUgrwrStd7XNluzEShiDlMRkArim5NNJ6JjiEHCHNE
         WDaJXWO2NVFald5fq1mNVwu6u2MCXHvvUgGm7bb+Kr5QtKUUaMU5/1oGmmzrIedwY+TG
         muvBYD0Ph7gmUDMNSjlcoZaobbEC+wEF0nhRuU+KwYF1A6AUVYz6aQyY6V21AHIZPbV6
         sbggmMeIIbhS2hJmHTtJYdLHTJtXUhssgOX7PZTt7Owho6gVSOAQBn7QulvQVNBJgBeI
         SIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1m6rTMKNi34J7sLNFezHq9Zai2Cnn9/zIHw82h382uo=;
        b=GVy0o8qGYFo9pFz5WtxQ2RiNUVK1wbG7Ha813dH2InYbKFSbfLHttA+II08zfwS4iO
         kAVorWuIA53y0O3XUunVkH+YDlGc0eHMJG0rJUEh/uOseXAXr5aaB4FnUS6czc5ICxTI
         TNvctTMtOlLruw6YkeKwIKA3hlWZ5cHXPn6Uf94oku2pNWsftUm65jaQXMB6jbh/LGow
         Jfjf2kbKsjJH6Rk3CmiBLJht5yr9esNsWuNemaqO72wCt5MzMa+GsWScVq3rHl89XraS
         VvDKgRiNunUQSBJq///XVJykk1hRUSrtog4A6yyffL11k8YJD06fx6Q7maWb8ZxdLGsv
         +lZQ==
X-Gm-Message-State: ACrzQf0QV1m0kvQCx/8h3SCnqcVrRu6luGQ6epPwP5D8n1kF80IxvVIF
        Cr59HYdP9y6BllJzUGNv/qC0Mg==
X-Google-Smtp-Source: AMsMyM73xxCTYNUwa7FeSMykXFeY+X43ry66C5w+e7n3KKOef83rPxP42JDs4oNPg2K8kg2S3nIRFg==
X-Received: by 2002:a2e:a551:0:b0:26c:4e2a:cbe1 with SMTP id e17-20020a2ea551000000b0026c4e2acbe1mr1657025ljn.9.1663581923520;
        Mon, 19 Sep 2022 03:05:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g13-20020a0565123b8d00b0049f53b65790sm1962232lfv.228.2022.09.19.03.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 03:05:23 -0700 (PDT)
Message-ID: <10dc71fe-6ef7-ecfa-2840-7172d693c32b@linaro.org>
Date:   Mon, 19 Sep 2022 12:05:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V3] dt-bindings: clock: add i.MX8M Anatop
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abel.vesa@linaro.org, sboyd@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220919055904.1659124-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919055904.1659124-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 07:59, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8M Family features an anatop module the produces PLL to clock
> control module(CCM) root clock. Add the missing yaml file.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
