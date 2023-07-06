Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAC2749F24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjGFOhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjGFOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:37:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A410F5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:37:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fba86f069bso1123443e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688654219; x=1691246219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tkG15icxF8+0lxZcBajnJD/coTEQOPBpDvoLT5j93I=;
        b=jkkrzgrHN+QuRkqxZ/Jt2Qx5cLKWGCfZSsCB+9Qcg68X5WoIxM6eNs501HstOe7NhW
         DGmNTclHzDA1ZXcOO+2myS1Pg1YhFqatMzmGLmEFv293akEXX+sxPfX5QlJ2BRNOAErt
         hal8gqk4jumw4Vz/v/KlqdPGQQMUrXDwt0NYXGGrfdP7Bju+lPFe8f/wLaZ3CwD0qHXU
         AgaDOZBWkt/kHFkEgxodycBn8KJHEOYbO6gWRE7X3K9uIA31nJkkhoAaQP6NUs2LOt6w
         QRNDwWUCON/+ulgACcM3TO80t0DjYGu04FXKidfOhYsGHeRvR8vccwofygwZUHDBUmMI
         7G/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688654219; x=1691246219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tkG15icxF8+0lxZcBajnJD/coTEQOPBpDvoLT5j93I=;
        b=iTEMWkVioeDR/FFX58IfnuWdoKhzTLo25ZKTVjodNW4V74AKPpyROpTORNmG8rUIGz
         nvubCyWYvdJqyKu17QoBoizPYwbZYz7Li5Kjli8kxVIA9YgPqdGGu9Vf48SNSU3V/kW4
         8n8ZdHzGfrb0n/kMH6tL3+1FlDnTYKFfpU0DUYV/94PZZJ3/kjghLgidfYUkkG0mYhDp
         vtE248LJks5Hq9WIqdugWZX/8JTMrpu5kDHwSgdq4/w0nf/X/5zsAdZ7aFUOF3ciw0uo
         6mq7p1FuyeRjIutk2Y04UBdTk2Diueak2D10l8PWFEg3jkNxwz1zcqm5VKUk3prS9By+
         Rijg==
X-Gm-Message-State: ABy/qLb4I8pfbAzjsyONt24W/hx0N0Zncpz3Iz4vnfm+brmaEqJ8UZ6x
        mrMA2uIBXeKWilCLjgZEg1Gwjw==
X-Google-Smtp-Source: APBJJlHBB8+XNglnt/xo7Szh5+K0MJdtigWdYAJujRod6eYK0FFYcjn//SmM532ZFvFnGLrGlUoBEw==
X-Received: by 2002:ac2:4990:0:b0:4f9:cb8f:3182 with SMTP id f16-20020ac24990000000b004f9cb8f3182mr1468490lfl.25.1688654219413;
        Thu, 06 Jul 2023 07:36:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e21-20020a17090681d500b00992acab8c45sm922642ejx.12.2023.07.06.07.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 07:36:58 -0700 (PDT)
Message-ID: <9e25ca29-9e19-b48c-06a7-f748af3fd243@linaro.org>
Date:   Thu, 6 Jul 2023 16:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: power: rpmpd: Add Generic RPM(h) PD
 indexes
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1688647793-20950-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688647793-20950-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688647793-20950-2-git-send-email-quic_rohiagar@quicinc.com>
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

On 06/07/2023 14:49, Rohit Agarwal wrote:
> Add Generic RPM(h) Power Domain indexes that can be used
> for all the Qualcomm SoC henceforth.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  include/dt-bindings/power/qcom-rpmpd.h | 49 ++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)

Didn't you just send a patch doing similar? There is no changelog, no
versioning, how can anyone figure out which patch is the latest or which
one should be ignored?

Best regards,
Krzysztof

