Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C7467372F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjASLmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjASLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:41:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4B7613C1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:41:33 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o17-20020a05600c511100b003db021ef437so1038510wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYOvjlwl0WXMSXebaPJNqoXn/q1ZOrj7Uib9J48klEQ=;
        b=yl4OrnSWHlPfUgVPfr5hiJP9JWFPRsMmIfXFh3YlCX18cvMdAHZHlEHIFeiT1zNI+o
         5pc9Q/OD6q6GGXTq4QcZJcCtQXeeudouPIgyV5zbfctTrsx/VO7HzyTUXfxmZON9Hx5N
         ziUGp4gL3XqtcmhqXg+CX+B4A+7quujnscDCjbRUHy3oP67R5hv2lqnNbXH91AYKRzL4
         yWVmkDP3QvWWDknr/cy0EHb53vBWl7hnXvuXk1jW7ikXr9+dNzGpTOfY+rzc6GodHkNU
         ZOt2WIJaj0CzzIF1HICs2HqbIWteg8TBUslBtALh2b/bSJ7zUkDj3esZh12jMtT/8MPn
         af3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYOvjlwl0WXMSXebaPJNqoXn/q1ZOrj7Uib9J48klEQ=;
        b=K2Y/gmgRvNVjybMig52z2AeheKqHqUJjBe4k02metBNg+heBzRTAl93UVperEQZ5In
         RSlW+nFHAo7Mfx2xPiNJdZxXbBtXNhjzK42uQjlhK+j9r6K4SBjfjyfkzT5QyPTtvOm5
         6QFyQQbfrKIcfkWgCQZaeafcjfR8K23Rtvz5/I1CTNJN9743rHRSRlWVuRM5sk5Pb2Es
         NOdWUlLnXmMQlZZGEKj39yyLGJRch8I/rOJ9EfaNBudgnCBLGgTgJITtCdhLCRdvg1Tz
         Yhe0BvvEVh3GNiaqBQyAU9M2gchzg/4P40x3t+4+LNNYnf/RiSJN94L5IuQT0mknZLPR
         bmiA==
X-Gm-Message-State: AFqh2ko8PkRlxPyDy7CC3FYQZDQZzSiBZYP4pgFMgIrSdeRiEJn9BkIp
        XEG6xz/Aox+Okax1WRbm9QIc4A==
X-Google-Smtp-Source: AMrXdXtHS6SvxwK9iV2AcI3FUA0m9DIgiWWO1JNfk7dLWG5HCW/LpgsoUXY0pOzd42qR+dmaFQJqpg==
X-Received: by 2002:a05:600c:601c:b0:3d3:4f56:62e1 with SMTP id az28-20020a05600c601c00b003d34f5662e1mr9937262wmb.27.1674128492381;
        Thu, 19 Jan 2023 03:41:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e12-20020a05600c218c00b003d9ddc82450sm4433678wme.45.2023.01.19.03.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:41:31 -0800 (PST)
Message-ID: <daecc5f8-026b-c72d-8c26-5580ae32b4cb@linaro.org>
Date:   Thu, 19 Jan 2023 12:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 4/7] dt-bindings: mailbox: qcom: add missing platforms
 to conditional clauses
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org>
 <20230118132254.2356209-5-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118132254.2356209-5-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 14:22, Dmitry Baryshkov wrote:
> Add missing platforms to the conditional clauses selecting whether the
> clocks/clock-names properties are required or whether they must be
> omitted.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

