Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFD2745DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGCNqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGCNqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:46:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5664E54
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:46:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992f15c36fcso379397366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688391977; x=1690983977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orUm7AK8inrlj6FnQoFj2Etgcxq7vpMiWCKp5M1Ochw=;
        b=zIBJtJChIqmqPKxcQqMpbJWa2yjGX9at6YH0avVdjWoQEkHhmFBBMIeYp+JE21km0W
         R71M8+T4Gd83ATEvgKwrkgdvI5I/Wvwm/JCRrmey5uNzJ5jFHpY6hyEhNKgZcg0IhuVR
         nrdy6fYzdADFFECkRQglrcCo6Sjk4/QFy8QnEi7gxsOB3F/wCNBVGIy2Idcpl299dEOp
         H4YLOTbjoeSD54AyohNTTOuhQvIrQvPWGmVzN9yxkyYfQMnVmWTUhexiFPQ3JGIAjzXT
         D0oCucafGm9yvpa7T3bYlx/UuyAkM8XyFnKlN3yuCAfUmNC/CrIvDGa4jCRE8m8aH1zg
         4/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688391977; x=1690983977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orUm7AK8inrlj6FnQoFj2Etgcxq7vpMiWCKp5M1Ochw=;
        b=lcudb2ocjQgR1clAH4qeomM51pJL9qu0zka2To0mARDvbLPjErai8Qi1J8uzYDJSuF
         Z68TyeLJlvFVmNqTOyKTdPa8bxtNyCY3JJ3DtC58JciPsOWBAlcrsa2SI2/y/E2Y8VK9
         YXVZ4bWmz0nVcJt4RL6JLMDxf2cvtUmlJfUiRAFBCPAFq8ZZDVVMeyEb9ebfHMXPuNCn
         u2vNzIYHUAJqAhzB+y7UaGuKf52kKAhvtZ+17Fdrq0myqrMHUzvZkodHnzs3u7/Awo8O
         HqAymM5jTwkgMz2wQMpfNPUtZtZgdZbFbiymSe/Oz3IXSUkILVPxRCTBx6L2qA/7fvT/
         HPIQ==
X-Gm-Message-State: ABy/qLYAGgfk2rC00a+dTKY44QrwNj1aP5yAQqBdQCTSROlx+wEG2Bxq
        wG0iM0jyPJXHvBFx1g1mWScROg==
X-Google-Smtp-Source: APBJJlHhuWgWnUgUTwbRIjOLubYyaQ4TC5RAC8Wmqq88LAzrBBjLSjiWEzV8UqJjRafhQj3UTZ3RWw==
X-Received: by 2002:a17:906:2dca:b0:989:450:e567 with SMTP id h10-20020a1709062dca00b009890450e567mr8076675eji.65.1688391977374;
        Mon, 03 Jul 2023 06:46:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j18-20020a170906831200b0098733a40bb7sm12012594ejx.155.2023.07.03.06.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 06:46:16 -0700 (PDT)
Message-ID: <2ce57c29-ff1f-2f3f-df59-528503779243@linaro.org>
Date:   Mon, 3 Jul 2023 15:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: soc: qcom: stats: Update maintainer email
Content-Language: en-US
To:     Maulik Shah <quic_mkshah@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_lsrao@quicinc.com, devicetree@vger.kernel.org
References: <20230703092026.4923-1-quic_mkshah@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230703092026.4923-1-quic_mkshah@quicinc.com>
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

On 03/07/2023 11:20, Maulik Shah wrote:
> Replace my email.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

