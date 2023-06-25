Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE573CEDE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 09:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjFYHQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 03:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFYHQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 03:16:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB4AE78
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 00:16:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51d9124e1baso1001719a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687677386; x=1690269386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uIrahwiJfRblkW3SQe71HLoNxiAeifXwVotzPF1COO8=;
        b=SLN/+lBuA+L4hOibaG99ROPhT2q+4Zk1BkcUiRXl4SmMBXbIW7ZDZeuRWDY1cBg38Z
         ds8IN6Tf2v7H77bI5N82BPsA6p+sb1Lj+PSR0P8pInIDV1RTT6vqMpSWO9KEJ0hHzfC9
         PstfvAk+/fjKU2B0e7eYYEH2W3iBHla9soKb01tYlDCjDXbBy2hscxufKR4AS0Pqb0fw
         xW/pU4+OdDUQISR5H5kuYf4bnneam72K/FNMC6qv8UwrAGSJsMpE/MizlpDV4DdZLRUJ
         CLXPt0bN46dNwZB1ey2SqK6RPM+T8D3l2FMCfWMHk6CSE+YuPcm2jgpBH2tceoFZhhEK
         CXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687677386; x=1690269386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uIrahwiJfRblkW3SQe71HLoNxiAeifXwVotzPF1COO8=;
        b=i8Pbe7quPD05okwcrNUcGUTmdL99oRCNMZBq4uI9gND0ymFPQmJbIHeJqS6jnZjS7b
         ADkMfrI4ofCrp355qMXzlozyVywWgIN8JKL3jwYNtJ6r0YjKUAcB7u0J21lAZwK4TCJH
         lwCV5RS4HCPhVaQVkQbasc2zeRMKPXl/G5vn8ggNUD2PwPB4v3oMkCyRYTv7xqVgKZgV
         6Fzu4rXHOaZySC/N0L5kvo7qifbUgegh9yeZSXgirPsZEv0wKsJIGVN+4oZ6tm3q335+
         KAmMtTo9Cfj9T85AS/Ue3HtPlWud2kROMeDIet/TaidqgOzprsAVvn4FfVYJ6FFrm1/e
         kWLg==
X-Gm-Message-State: AC+VfDw2Htnl37pkFNg1lUNEERu2YfcRtdo9n4Aa/eHiRR6Apju34kLX
        IC+PLqwSN/Uc24BnQhiRXlhbCw==
X-Google-Smtp-Source: ACHHUZ7yWmteCJ2ASXP6XlOddI/EKOWOLbTyVMMVtsIAE32VSvu1Ve67QKpbz2Drqglycme6vQHnYQ==
X-Received: by 2002:a05:6402:517:b0:51a:53e0:843f with SMTP id m23-20020a056402051700b0051a53e0843fmr15138396edv.37.1687677386589;
        Sun, 25 Jun 2023 00:16:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k21-20020aa7d8d5000000b0051bf6318fd7sm1440765eds.97.2023.06.25.00.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 00:16:25 -0700 (PDT)
Message-ID: <6be00ec7-2fab-7da0-ab47-fcaf3a1ce042@linaro.org>
Date:   Sun, 25 Jun 2023 09:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 10/15] dt-bindings: msm: dsi-phy-14nm: Document SM6125
 variant
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
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
 <20230624-sm6125-dpu-v1-10-1d5a638cebf2@somainline.org>
 <1b40b16e-025a-c10b-e99b-404246de73fe@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1b40b16e-025a-c10b-e99b-404246de73fe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2023 15:48, Dmitry Baryshkov wrote:
> On 24/06/2023 03:41, Marijn Suijten wrote:
>> Document availability of the 14nm DSI PHY on SM6125.
>>
>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>> ---
>>   Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
>> index a43e11d3b00d..60b590f21138 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
>> @@ -18,6 +18,7 @@ properties:
>>         - qcom,dsi-phy-14nm
>>         - qcom,dsi-phy-14nm-2290
>>         - qcom,dsi-phy-14nm-660
>> +      - qcom,dsi-phy-14nm-6125
> 
> Should we start using standard scheme, so "qcom,sm6125-dsi-phy-14nm" ?

I guess the earlier the better.

Best regards,
Krzysztof

