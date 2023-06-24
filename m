Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17073C9F2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjFXJNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjFXJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:12:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA91118
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:12:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so4598048a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687597976; x=1690189976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vchTo0Ol++OLJmq7HkKHErizaURF3xHVTmmMX3ficGE=;
        b=lbMMOlNVSXG7UBvaMUImfSKH7/n6r6Ndl26O12IO6VUdAMh57hAh7TKLUcTQEmzW4z
         8qiviylmAklg5Zgk6kOOVYxUQCvuwmfjxlWR6KoxtUAX+Knh/p/GPT1DhyXmednt/n/b
         XFGWInS0/evgU+4t6VgZJMb5EWyrhwzut3lhcxOnLtNPn6tWeOOijFaxiKqfCoeuO/ph
         r6uzYWtZfjHw6J3donHZpDZT2yNsyrY8auaWHd+eelL363XvSEcKaUJBRm+3FCJFZKaL
         y5nTgBhsjWwFCZ7FCLvn/39YP3rvOVIGdLD+RuJCPk9TREWL+Izhl6x7Q8gWxH2/SJ29
         a1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687597976; x=1690189976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vchTo0Ol++OLJmq7HkKHErizaURF3xHVTmmMX3ficGE=;
        b=ZD2NfjW5atgWOp05uKsGnyCPZ30wvq4weIxK3ZuXwTZk8bhNbghJy99FvMqxKrBNid
         6412YTcsN8OU7URnQBwMRrg8nnWxoxeD4Fqc0krSN+X9FF0g/xxFYV23OJiKGMgzXjhn
         3jCu4WdI1q6IzGqu6enxd/249woG2DU4SGCK0FsG+syZJbnsJ09Z91DP1CTy7ira11mf
         f1raoAe/TuA0BV4DBTfqqWyKhIiyAd6F1uRwGs6iVE4wTbiBZAY++CKDDlkphgcI8dT4
         A/oPdsqerdX34Vqn9daqkAU/FCXC+s1bIWEOCO3ccGr8yWsNnEXWlHeM992Ze67yAt3P
         KnTQ==
X-Gm-Message-State: AC+VfDxw1ICV29VIEcwDS0OK7xHhT2z5qLaOOdpFHWnkflzEI6SNcwkn
        STfT+svpIWutSqV9SWF6ob5wLA==
X-Google-Smtp-Source: ACHHUZ6HroITc5YdkUcavz4MKFxBB8L412c78SNrFWbnl1gdMQWQ0zgOQinmNiUzqMWS9McYR20j2w==
X-Received: by 2002:a05:6402:35c5:b0:51b:fd09:9ec1 with SMTP id z5-20020a05640235c500b0051bfd099ec1mr2819074edc.0.1687597976653;
        Sat, 24 Jun 2023 02:12:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i4-20020a056402054400b0051a318c0120sm461301edx.28.2023.06.24.02.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 02:12:56 -0700 (PDT)
Message-ID: <6bbf239f-d530-2f1e-ff52-361f7c9cc951@linaro.org>
Date:   Sat, 24 Jun 2023 11:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 06/15] dt-bindings: display/msm: sc7180-dpu: Describe
 SM6125
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-6-1d5a638cebf2@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230624-sm6125-dpu-v1-6-1d5a638cebf2@somainline.org>
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

On 24/06/2023 02:41, Marijn Suijten wrote:
> SM6125 is identical to SM6375 except that while downstream also defines
> a throttle clock, its presence results in timeouts whereas SM6375
> requires it to not observe any timeouts.

Then it should not be allowed, so you need either "else:" block or
another "if: properties: compatible:" to disallow it. Because in current
patch it would be allowed.

Best regards,
Krzysztof

