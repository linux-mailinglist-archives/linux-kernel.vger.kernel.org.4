Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B28F6E26B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDNPSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjDNPSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:18:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192A69757
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:17:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fy21so3450791ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681485469; x=1684077469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9drcNPSM0KBR/CLrBwPG24/hlufSHekIX2GuAa0mc7s=;
        b=DpYdX+CHD+F/+NFh7Oh0tAd/G7RToDYcGkhwE0Qp9T+/OXvLJkiThET18+0f2JhQR/
         ytNVi+NL44SPs4QSFY3PVpySwPE8J67VT6ToVQyvHjhsbqre9DKC1GI64VmbIKZINwuQ
         TBrs8yC9yasnwi7+34VIkrpYmsalcISpUyMIMxWPxhHm9W2fCutH/uqUiiwSFAM/Epgs
         Z1vis+O0CuGzfD3ka/4FKW33Y7U1MqWS1c2LEqQ9ARD7gQ4stOYs+jI7cehgK/wmEphg
         wt2mU3/FpPLYcZUff4OIPg4J8gaRgJ/VlB5oiirY18bTdXQllJmRfVm9GrR47BMFGojl
         Czqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681485469; x=1684077469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9drcNPSM0KBR/CLrBwPG24/hlufSHekIX2GuAa0mc7s=;
        b=Zn+R8Gos9l+WQRNeR+Ykg6jv3oIzLksyf2KElWdpcGyAD7MN6L3jwQBr3afy3g/Z/i
         ENQVMbfLeG8z7ee5D3TYZ8IXpz9dsYSFqR7dvALSahdS7DImTr7H7aqum7eGwM0VMzMo
         ymA4L15FcQQLbbczTLcs4a/b/7UTbEBp8Sh24xb5mtJ/jb/dfYh7V9NoaFWUNTNfhe5h
         wJVkQpbEsmJH3/IybgqjbRIjQSzFM6oaSlY9/qD3Ue4IaylyWvwdPhnP6Dwfc1asKTr2
         +tCw9ZvQ4aTdQWgFQVSKqZ3U8gk3WP7eN26EFhpY5ERygSaseRZ+XrYF3phaE/s9fZma
         Lxgg==
X-Gm-Message-State: AAQBX9frUnh0bFNSkpfuV2C2pjMIYV7rfB5A9Lz8spBIjXztR18NLFbr
        B66IgsccdRfJxV1j4adPT1ApZg==
X-Google-Smtp-Source: AKy350Y1ovRQx1f10GgZ8oEgerwPzy42tM/K38eDatHEyM6Q0mtLluw+V3szHNhRcNBxfX4Yn4ti6g==
X-Received: by 2002:a17:907:72d4:b0:94a:7da2:d339 with SMTP id du20-20020a17090772d400b0094a7da2d339mr7465159ejc.26.1681485469533;
        Fri, 14 Apr 2023 08:17:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:39b7:81a0:bd41:17b1? ([2a02:810d:15c0:828:39b7:81a0:bd41:17b1])
        by smtp.gmail.com with ESMTPSA id p25-20020a17090635d900b0094e75d3ba1bsm2575677ejb.131.2023.04.14.08.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 08:17:49 -0700 (PDT)
Message-ID: <20faef75-9182-6e67-8ac5-c8234318ab64@linaro.org>
Date:   Fri, 14 Apr 2023 17:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: qcom,videocc: Add SM8350
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230413-topic-lahaina_vidcc-v2-0-f721d507e555@linaro.org>
 <20230413-topic-lahaina_vidcc-v2-1-f721d507e555@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230413-topic-lahaina_vidcc-v2-1-f721d507e555@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 13:26, Konrad Dybcio wrote:
> SM8350, like most recent higher-end chips has a separate clock
> controller block just for the Venus IP. Document it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/clock/qcom,videocc.yaml    | 29 +++++++++++++

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

