Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE636B18B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCIBZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCIBZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:25:22 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89F08481B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:25:18 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f16so268798ljq.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 17:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678325117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZhlZWmAHl1qfY8mNDUqjYUamtFyfeOdIQW1lE6rtEQ=;
        b=RZ/BkHwPquD/5IgwGhMmoSQx0P7hnWPErLDKLwMWtotrbxLt1tQTjflY5PjpIE+0Ck
         QbHZeSUYWqGf5CEFUgLn1OP3q1PGP4NUOPC24o9qncPhdmET4r1MLALswykbEOHKiHhg
         cXLbLXQGlVc+xFMGjD3AgSXZDxha23ZGN7SnjGh7R6SBRlebx5rOmfsFz8PGX7FFeeJs
         kn1Rt/1pbY91xNwRjQp+kGkneGGvyvtqi64OJCfKdo4V6DlOCr1W7URz816nCWOa/XRy
         mf14gMf1c1i+vKU73rEnf9KcIQGGJu/740+IShSKu0arGJ2y5IfyHFgLGQegLBHB+249
         5ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678325117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZhlZWmAHl1qfY8mNDUqjYUamtFyfeOdIQW1lE6rtEQ=;
        b=G4LhbgRm8wSenWlcH5nEZYTmwIvx1f+XnL3IeC5w9BzXMgQkMBTl4ZCetlbR9QpxFb
         YepREjJ/KMAbjNAf3/ZxrATcBC+VxWHlZoJP4HsUYuBJT6i5SanZPf4X3ELAMojpXOtF
         Nu4NMp8f9Yf0k9eANUWaQ9QdB8Pvsmyky9ToIupdSCgcUzQuu6zQBzXr4UDHuownb+vv
         oTpYbzQWA585A8oLWGVJxZW5oNzdOHc686UJoKpWWe4ZrOAqN+RwwmPFXy5uX+czEIMQ
         98Hbsq+Ciyi0Ki3UqsTGzpwmT8QSTzUJObhUFaAxH1IqLnLhnEmBhy02+wLH1KESPvfz
         XENA==
X-Gm-Message-State: AO0yUKU/exQcN8xlzlrP6+XQ5AbzZNcUwLy1FSgPh0AUVSD3XOGDlO3w
        kA+GMpNa4pf8rr91R3XNCQ68Jw==
X-Google-Smtp-Source: AK7set9IePti5k+U2DtXXzXaoS3HeOQezGIJ7bUForYzvPj99M98/fsUa3COHIwJxXgJT9AhNy2l/w==
X-Received: by 2002:a05:651c:331:b0:295:94c2:bc56 with SMTP id b17-20020a05651c033100b0029594c2bc56mr5461490ljp.37.1678325116823;
        Wed, 08 Mar 2023 17:25:16 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c13-20020a05651c014d00b002945b851ea5sm2753747ljd.21.2023.03.08.17.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 17:25:16 -0800 (PST)
Message-ID: <c03027b7-6f21-824b-ab7e-069094044a0d@linaro.org>
Date:   Thu, 9 Mar 2023 03:25:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFT v2 11/14] clk: qcom: smd-rpm: Hook up PCNoC_0
 keep_alive
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-11-ae80a325fe94@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-11-ae80a325fe94@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 08/03/2023 23:35, Konrad Dybcio wrote:
> 14 [1] of our 18 supported platforms need an active keepalive vote on
> PCNoC_0 so as not to cause havoc on the entire SoC. Guarantee that.
> 
> [1] there are 13 changes to driver data, but 8226 reuses 8974.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/clk/qcom/clk-smd-rpm.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

