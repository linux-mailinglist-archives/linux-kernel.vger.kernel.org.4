Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA02C63BF26
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiK2Leo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiK2LeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:34:18 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635F25F84C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:34:09 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id d9so1094929lja.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RF7XWPk6ET+Jv0A41wwTV2x0aCdfJ1hWb46XDQfSBzc=;
        b=Z0CzNi/Q3rocEhDIaRZEwwnlBal86ShB3aV+1QnV/loB8SUSoBoOszctQqAvhQp7Fg
         qHbdJMxm+A+7NypurP7oQGOBwwMbaelgO9qUY0Z+z80MSjWGeNg+fgAaCbSvKWOTk4jn
         ewQ3hnpcgQuir2U2Z0/KmY6ahddSRabrHm44UsKBtUkKDZOrsB3n+WbP2PoTv01Bg1ta
         wacPV/2Z4fXd4awIcNdPLYu+TBK882/HnCnTDlhkC2KZ6gD8qI1OmQtew1NpzKxfxqIr
         h49Kbos/AUqHvgdmxrekDScjbraQ5oxsoM2imQP5nP8ueJVAD+v8I+wdQ5ra3xsUerGN
         zzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RF7XWPk6ET+Jv0A41wwTV2x0aCdfJ1hWb46XDQfSBzc=;
        b=0a92uveMGW9TMf7nL3FqHkuooqgD7KSzCS0YJ+kCS3w9f9Cl5O6TAD9ULNIv0VGBiW
         /JFhL94fEE3sjLYRYMNJc05731z9UNaz+o8ynnVRvNZW5IuRH5OL7a4GyBVimshuYxgs
         Em8CuRtIAzeG0v5H0zJLk2MWSwbKT3mfoTXYizIIgWVHCQx2KHNkpQRMgb9Vkzc72id4
         riMkTowwQNmHpvA3UYuSoyj7mioFKrHqXjvg+NrqSiTmqJd3fX8H0Gzwlz5cY77ETt59
         9wm4z+i9IPB49lh4dnudo9BsifOpWd4eILR5S3y2H8mhoKnU6VTtaiUo749QA2w1Tk7F
         ETUA==
X-Gm-Message-State: ANoB5pl79g4ePtrVY9hXOLPOx69e+qdOMFjtBPXW/5jNRk5mQjrSOwrL
        VLENykON6FAXY9Osv3AuSddwdg==
X-Google-Smtp-Source: AA0mqf4JlmtZs8CFEEdwczU/oNm+5ZzoA1KZF2EvPv3cUE2TdGjgw/JPChvBNcMn+SI4uGWERlzU2w==
X-Received: by 2002:a05:651c:50e:b0:277:1c8d:27b9 with SMTP id o14-20020a05651c050e00b002771c8d27b9mr14138383ljp.210.1669721647803;
        Tue, 29 Nov 2022 03:34:07 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f11-20020a05651c02cb00b00279811b20aasm1518907ljo.2.2022.11.29.03.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 03:34:06 -0800 (PST)
Message-ID: <41aab17b-5040-5655-23df-90618613fbed@linaro.org>
Date:   Tue, 29 Nov 2022 12:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: qcom: Add zombie
Content-Language: en-US
To:     =?UTF-8?B?5qWK5a6X57+w?= <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@google.com>,
        Matthias Kaehlcke <mka@google.com>, Harvey <hunge@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221129183213.v6.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
 <db270248-fc0a-6958-a43a-4ce01ae08347@linaro.org>
 <CAPao8GJe7cXs3PZ=4pj9tieXE-M8wcfiW5AF2v6892jrx9txbQ@mail.gmail.com>
 <CAPao8GL8UPXUa-M6YRy1nT50q+X+Y=Eod_1WL90-8kBLk52Vrw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPao8GL8UPXUa-M6YRy1nT50q+X+Y=Eod_1WL90-8kBLk52Vrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 12:24, 楊宗翰 wrote:
> I have modified patch 1  commit description "Add entries in the device tree
> binding for sc7280-zombie."
> 

No, you did not. You sent the same v6. Don't send the same versions again.

Best regards,
Krzysztof

