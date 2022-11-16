Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77D62BE58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbiKPMjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbiKPMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:38:50 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1270012AC0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:38:12 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id r12so29281606lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWJAiHuao2wksgZVwWdOSdJWwx4snrwk0QlUUJY7r0U=;
        b=dkuJMOoWXQsg39hwk0ghRuU1VAi2+jEZ1mijs80PgXh9Pe8by2pamij9MFcUNwEIlH
         5x/A1fnZ6RxJ77sT6PtdyJf35cQDd5tNaY3HEpLfjndRK2at7lcD1SMgr2z9qdpSk7XN
         NOEimqWDjM3+N+08F8f+OLkiC0eZy0twmC0O8cuNmNWdocIA7llsWkJ+zkShfo5yBg7e
         oZd7a2wKDSDkF0zD8p/tzwA80rFEzDCaAZbhCpOn0IM/tikTTa9HjOZVjWKgz3Ldqf0g
         0BWEYdrczijZPnVQFEKbF7PSy6vmIDDFf6TpvbJSz+TLIVZ5VwxP6o+RNIc5mkTqUy8f
         gNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWJAiHuao2wksgZVwWdOSdJWwx4snrwk0QlUUJY7r0U=;
        b=JEns3E8ynIF0crUhPsBNtOjabXmC+zfPiF9omJ7OYA15Ssa1kfEVwnUuXZ6IRPIk6Q
         CQc+6uLp4/ZPqRgdr4npFiJI+hywUVTk2GqFT9TPMF7II8yvZhINIFnxTjHeZI4Utuwe
         6p6wd0Co4NdJdzY4pkaYhkxcVgPKa8/tdO0ieT8O0RIMRBQe8+gCQd0Ygi2nVJN6/ITg
         NPc8gUE7KH/fGsdieDBt+/7D/p2CD05nrWQDVxvMO8yuLt+1Xp2E4bH/rVdTJgUrdnqQ
         3xXsRe9g9t4rC17bVGL6IywX4qgT2vbr526jh/svxvQXGVObNeVWkku6GKQPUsrJdJ+w
         fzZg==
X-Gm-Message-State: ANoB5pmYWIO2ZP+0BCCd2VgBKfPjBzNSfoghl/f4rOewHjUP4tOSHwL6
        TN+XC99ZuVX9zIkHORl/8Npc5Q==
X-Google-Smtp-Source: AA0mqf6YDxW+75x0nxMUiolXptmkvA/8MxUMdrG9p3CByMz/nWHO5QAjt/l8/Vk8798kTwl3xgpGiA==
X-Received: by 2002:a05:6512:400f:b0:4a2:b42a:6d7 with SMTP id br15-20020a056512400f00b004a2b42a06d7mr7942679lfb.649.1668602290332;
        Wed, 16 Nov 2022 04:38:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f18-20020a2eb5b2000000b002778801240asm2996879ljn.10.2022.11.16.04.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 04:38:09 -0800 (PST)
Message-ID: <2c61fc44-ec29-98ae-55ae-587d82186485@linaro.org>
Date:   Wed, 16 Nov 2022 13:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] regulator: dt-bindings: qcom,rpmh: clean up example
 indentation
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221116102054.4673-1-johan+linaro@kernel.org>
 <20221116102054.4673-2-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116102054.4673-2-johan+linaro@kernel.org>
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

On 16/11/2022 11:20, Johan Hovold wrote:
> Remove a line break and increase indentation of the continuation line
> to avoid having the 'regulator-allowed-modes' example be reproduced
> verbatim with four-spaces indentation (instead of a tab, which is still
> too little) in devicetree sources.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

