Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED662115C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiKHMsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiKHMsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:48:31 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19D25289F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:48:20 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id s24so20917947ljs.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4s4Z1WdUOPpLx6Zbqf7L1892zlqXckJCl3Ja/uP89L4=;
        b=q4zKbmw94I9pKmSWoe1A3Z/AzqpYt6qpaN3SW9lzEWOqTY8eaaaJuqXM1wk6WGGLYM
         7sI2uCTjDurSYYLQu1LE/8Rj4uHJGC+81xE4Q4OnEwH/uqCsLXMy1yiHuAhdbRxtjE5y
         AaTHEEkEAzPsI+cVKXlTxV771Mkg7tCW4n6Urqq3KBG9y5jeZBV0q8dX132l6sNaOCb4
         jQe5GMdRFVrP3Hyqq7uM5RI/fSmKBXO504+GUY+jokmW7j4Ztrhx7fRGiwyr8UWfopPy
         MJ1e8STAA0bb7J07uwj3dFWVoiVfLcYqSIlFHs9W7OZfx09PfDB4zDzlNwDxgCq4HrBS
         86Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4s4Z1WdUOPpLx6Zbqf7L1892zlqXckJCl3Ja/uP89L4=;
        b=s4UnKqPulHEvPjwKIqXQQM+K6JFEaKbwo5eJhYVRQBd5LiKp3BojYr3hQ1MHBER5Yt
         m09iP+NX5d+w/tFnxGNMNMHEZwFZ8QO76kZoyPKAjI30aPxxo4RXgOACMFYLco+d7F06
         ftnUkiUTOoahQBwa+QtA0oD6b9ta6gk8/EzxX8dk0Pl1DiYVJ+PUnNjsozgfikWRdXWa
         7f25ZpA7U6RCIqXKUxj1HWij8RRttBdK3iIQPE5cMYm1boWD+el32UMxCzPIet032w4o
         RB6elrqUbaSEnx6R4wxtBzNI9m9cSptZFcVrOmgpzJ+A+rQv3ieHZcAWfo2exk6R4Aph
         OFEA==
X-Gm-Message-State: ACrzQf0qsXBMs7vHZ9sZorGB0aqFObPrDo9tmv1V88U2KurPS9Wgh119
        s1cSXuebhaKJsN6kzJwcbvrv+Q==
X-Google-Smtp-Source: AMsMyM6tlA5qzQlcNJ0y1TkIG//th+wyQ8gWeyik8VyEAXOPTD7CNbXS8/glvZgW2PFrCL59t12K8g==
X-Received: by 2002:a05:651c:2d9:b0:277:14bc:da0 with SMTP id f25-20020a05651c02d900b0027714bc0da0mr18784418ljo.212.1667911699164;
        Tue, 08 Nov 2022 04:48:19 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id a7-20020a2e88c7000000b0026daf4fc0f7sm1729753ljk.92.2022.11.08.04.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 04:48:18 -0800 (PST)
Message-ID: <6a939e52-b69f-b30f-664d-dfb9f279b5dd@linaro.org>
Date:   Tue, 8 Nov 2022 13:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: sc7280: Remove redundant
 soundwire property
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
Cc:     Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
References: <1667911156-19238-1-git-send-email-quic_srivasam@quicinc.com>
 <1667911156-19238-4-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1667911156-19238-4-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 13:39, Srinivasa Rao Mandadapu wrote:
> Remove redundant and undocumented property qcom,port-offset in
> soundwire controller nodes.
> This patch is required to avoid dtbs_check errors with
> qcom,soundwie.yaml

> 
> Fixes: 12ef689f09ab ("arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital macro codecs")
> 

Same two comments as patch #2.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

