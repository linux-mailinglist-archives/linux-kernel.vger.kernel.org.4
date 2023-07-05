Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F66748157
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGEJrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjGEJrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:47:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BCAE72
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:47:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9936b3d0286so348882266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688550427; x=1691142427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qZvOCuKtFzTR7vPGrjwngsBt7RydTrhfcDYMvZhiw8=;
        b=eUSy8p0Mg7RhNCBHhmCblXUAWtklwGxj/93vKnJv3r8/jA/k+PrRQHB/n5Y9+pqFWG
         QJ5L36IOr4Edpr+OshV1EEofpxOb9XUsm3e0NTFo00j5lzn/2h3MfPHVpMm6sMQ4s0VO
         6AChbtHcRFLsO08XLTrYDi1ehCZ0HIXucxe6e4fgREiTEN4JwKZXB8xPpMFc+5QdG2M/
         QpINCWSYcL8KnluLbVuIcGECtF/ipK2oQi4HvVAAJG+1ChtRUx4QmSuI/NhADZf53xsV
         PYssiwMzpH93sPPS6BUHOmj8ntbrsTTUNDtD1VQXKAzY/+EMq7vNNcs2Y7fxqmk4Fdtm
         iW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688550427; x=1691142427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qZvOCuKtFzTR7vPGrjwngsBt7RydTrhfcDYMvZhiw8=;
        b=ZvNQWn/xGnekXdNR5m0G64Gf55EOwUt1LK4klQtbllDJGPoXYRJgk7eQe7KGrsyxGn
         GZimWkwprfvX1X4v9iyh6C/ExX4PkpRdCDKccE9OeDQeIhsGgO9XDo2/4pzNkNGC2XFt
         hk/NGo4dVR36eX6Onlx6e64tMC5/1VFY0XgDNIDN0xbBBT524NzbPM85dRJ/tUzxhDM8
         XOAkM2gzj3L5OpWU6NEJDp7/dLCmmTeyHiii/SGiTKPAgZ8PFiP0CUzScsUWR1ipThnV
         ab9sUQXBNioL2ZHy0cf2O7YfZMiTgkQTqRlF1/SaLj4SIPJApU2u3PTmQZoSXkip2rwT
         +HTg==
X-Gm-Message-State: ABy/qLZVzSItkUi6QCVSWypOaayxrB06d4/j7YumfphFseFoczlnYgV0
        RQrqIAASovDVsaju+QnyZqVsLA==
X-Google-Smtp-Source: ACHHUZ7mGwZf3R998XeLI1YA51tEUsLMBv+Cw6Q6BC5GAYD2s2ZUyWeqERykOe3eIHcokghQRKsdvw==
X-Received: by 2002:a17:907:9859:b0:991:e3c4:c129 with SMTP id jj25-20020a170907985900b00991e3c4c129mr11397957ejc.69.1688550427056;
        Wed, 05 Jul 2023 02:47:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id mh9-20020a170906eb8900b00993a37aebc5sm502987ejb.50.2023.07.05.02.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:47:06 -0700 (PDT)
Message-ID: <fe205e01-c065-adbe-33bf-b2acb1058c27@linaro.org>
Date:   Wed, 5 Jul 2023 11:47:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/7] dt-bindings: arm: qcom: Document SM7125 and
 xiaomi,joyeuse board
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230704163848.169853-2-davidwronek@gmail.com>
 <20230704163848.169853-4-davidwronek@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230704163848.169853-4-davidwronek@gmail.com>
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

On 04/07/2023 18:31, David Wronek wrote:
> Document the xiaomi,joyeuse board based on the Qualcomm SM7125 SoC.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

