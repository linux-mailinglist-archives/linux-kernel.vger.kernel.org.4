Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54C273839C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjFUMVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFUMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:21:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528CA10C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:21:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3111cb3dda1so6709422f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687350094; x=1689942094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiYHd+ez1eBUEBJjfoLrdHwsLSVwCQn16XtUaKUe2VI=;
        b=DhlKQ6dU+tlczMaohMlS+W0k73hDWJ8p5AAh3nHc1Awu9hOczZH5jPmD51Kv/zDiIx
         6XnE7NH++TrIlaI4WvNiUHB37AG5BfT+BNhc7MzUu/CsATwFnFWPPEY6L9PF4rNZy3If
         S1goMFGHntFVJIfj5bHm3ZBS3VxIBpsVqaoneriX1yfOtutIsaQupJNFE/D/Yf5Gx4cB
         CaRaoJqF9453UmrLfhcuLLWVyBSd/S65UdFIcFOT38Ug4IdasHNOvsm89FIyvQOZ70rn
         A4Fd8u1C/Nn5Jno6gRA2MFCYP2SgSdbIDvj1ADYHFmPecGy60wGA6JuR1UYwQyKI84FX
         JqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687350094; x=1689942094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiYHd+ez1eBUEBJjfoLrdHwsLSVwCQn16XtUaKUe2VI=;
        b=CwhQtM/ynff2KqCYFwCcFV9dmuXjj32p2wtMwz0AVz8I/QEbehAlFqPIG+Q2f6nsaO
         uPpWSQ5LYFK7JKbUa8pPEngQ1fvQyKeVImB7c8LS5QLQvpj6UimRYRxpc3cT4HONHeDu
         S7pA/Ju+1G4osvSoA68JWJFj2p1ajeW6SUhTJaJFjRl7RUqu4wyjVQSqaBaHuN2nuQ48
         p9pRknXzPudYGb2lq4CU5vWwBaEniObWp2J+8Y2faExMrnDLP+iIsklkb9xFPE0+E5m/
         o0XXfiFYqKggu9fDVdufJHCJF4DawCEF1ISYTDqKCvFygISxNnV13Zl3jW2dz58ru/iC
         m55g==
X-Gm-Message-State: AC+VfDxUi1K4xkCTm44kRCTUpWRPT8fLMuyYOAUNkUcnxmbOt314UvP9
        ldf5ae/JTDOt5ChQNftWu7uHOA==
X-Google-Smtp-Source: ACHHUZ7YdAD+SC9QActN7pDnaISAagYkfFkfMfIM4lfGQTS4szBq0gc+PMkNmbwHZvwhbsjLdpTVeg==
X-Received: by 2002:a05:6000:104f:b0:311:110d:5573 with SMTP id c15-20020a056000104f00b00311110d5573mr14519588wrx.64.1687350093788;
        Wed, 21 Jun 2023 05:21:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d4-20020a056000114400b0030ae93bd196sm4370845wrx.21.2023.06.21.05.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 05:21:33 -0700 (PDT)
Message-ID: <69ef04db-f7a2-e5bd-1e6c-c922e2fa75e4@linaro.org>
Date:   Wed, 21 Jun 2023 14:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: ili9881c: add compatible string for
 Elida hj080be31ia1
Content-Language: en-US
To:     Dongjin Kim <tobetter@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230621100244.1325638-1-tobetter@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621100244.1325638-1-tobetter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 12:02, Dongjin Kim wrote:
> Elida hj080be31ia1 is a 8" MIPI display panel. It utilizes an ILI9881C
> controller chip, so its compatible string should be added to
> ilitek,ili9881c file.
> 
> Add the compatible string for it.
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

