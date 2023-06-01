Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525E7719850
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjFAKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjFAKGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:06:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40926E49
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:03:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso1049168a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613833; x=1688205833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WO8KsaywxjcSX6U8BECoCcVISsSXERYCN/AYt3V86VI=;
        b=j4S5kWdl3VRytOmeo3nxkdlw8u0wFF93pTVOptBBi9qTp4Ot0KOb5bcE8MoFv93bRY
         sY7h6/H9zu0Zu+2QXm60OrPcq0uvD8BnQRftgyD5ZikvnJK1ricQHhKMVzf4z8KPDqCO
         6zqeqiGYZmmL3g2MnLrqGBsprMfe6tnMXGOmb6TpZHGs5mGLcvs4S6mAPUI84TbZ6ed5
         GO9M6G1SBQ2iV2Kbwnz+JlB/rJRkmmv6ZsAlToqHh+f+AsHxcuyPo4RU55M7a6WvLVun
         LJg4TZ+p8qu6yH1IEYFk9CKwICZ+7E8YbPZjKZCcnY9EQaKdtonjIB7OrvaAqkSiHJsP
         a0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613833; x=1688205833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WO8KsaywxjcSX6U8BECoCcVISsSXERYCN/AYt3V86VI=;
        b=UNbNJifqusWXYBvT+prx7gwmEhZ+vp/GnGZewRRvjGPM7RThvtkKCJWbEmpNJo1WP8
         gywYgNid1Ns0KIrmDRE8IREXalCMNuXReeAV3rb81zGRjvgt6UMPdWrNcrow9kAeQ4W6
         5dqhuy++rQk8KnHm1+pADO6BYyU5d+mwVi4U78JptXAVO/I29lMgjYUbaYCzKm3kzMnu
         RJFCLurndMjVZLZqY3ghcSRkKmPyb33d7R1LUeN6SVDmUitx3L4Z0STCgrirNF4qrSNi
         z/N7D8qym94nZy49EgsUl4wpuyw0vpiOu6QgQUGnrqLHA6b3l7q7nMrbWPIZ9lNzs7Av
         hXww==
X-Gm-Message-State: AC+VfDyNpzBGuoHvdX6BRsie/uckeUKZrfHlhm3SS/Rv7BCJq/f6gvjX
        Wh4k0rkNAyFsCazm6SNkhRyD6Q==
X-Google-Smtp-Source: ACHHUZ5XF35YQhoW6eEwBUCD3iUcY3MK6CCYI1Ds5j3oUuOB+tovOKsrFDij/jYx+59W+nHLeUm8eQ==
X-Received: by 2002:a17:907:2d0a:b0:974:1ef7:1e33 with SMTP id gs10-20020a1709072d0a00b009741ef71e33mr8451695ejc.8.1685613833464;
        Thu, 01 Jun 2023 03:03:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id t24-20020a170906179800b00968db60e070sm10262249eje.67.2023.06.01.03.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:03:52 -0700 (PDT)
Message-ID: <025e29ae-842f-e086-81f1-20380152dc0e@linaro.org>
Date:   Thu, 1 Jun 2023 12:03:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: display: msm: dp-controller: document
 SM8550 compatible
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230601-topic-sm8550-upstream-dp-v1-0-29efe2689553@linaro.org>
 <20230601-topic-sm8550-upstream-dp-v1-1-29efe2689553@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-dp-v1-1-29efe2689553@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 11:52, Neil Armstrong wrote:
> The SM8550 & SM8350 SoC shares the same DP TX IP version, use the
> SM8350 compatible as fallback for SM8550.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

