Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A037C6D5870
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjDDGJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjDDGJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:09:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E5319B2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:09:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i5so126279809eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680588538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xckjHRqAlVFqSSMovCWlCEaEkbe+U6hDZsaBMakZfUw=;
        b=gFgwpbl0BxgP8SYTBqiWNf2YY9d3jy7QlcfGKO/CRBGqx43V6Cwypg8ziYR/58dhIR
         1Whdkl1X7pMXJp5wm6mvVgpG02B3dEkS8nzgCnwATfmWu26uWVtSxbedfw02/3lCO/kl
         QDah2AyLolNEgifPwqCzCArs2DnGXqFYJ1FLyxAH+57XL+y/P4GcaNyKTgCwWjY3rm5Q
         niIbVE1ULhpI9TRCxko1lbfM+i3E1+u3uq77dzjv7/Gb4PBtPzunBBIzR1ziQ5EJQZ0/
         c0iBSOASALb9TyjLJGdGaTloNVaV7ZRDjIh3Vs4oRYkStEBxg+vMKYCylwdWvPHkrZGD
         XtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680588538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xckjHRqAlVFqSSMovCWlCEaEkbe+U6hDZsaBMakZfUw=;
        b=xFnIbZ691LpUu0tkPukM9U0sX2xi6Z6roRIUbPYg0KMMpXvbw4smuv6vGpP3918iiO
         Pv+8SM/zacBwx2D5hiHd885iJ3LC8w4kCNWqNHalJfby1aL5vCFtkCjYqrC7t/5MBL3/
         AxHpyfSYm+GnKZh7EOSna3ajpWPet9fzY/7uFJdtOmvtdOO6twbri7jlcPinwj0UiVEn
         uy5RrrZWVDzLUWzSsBYgzFM69hEb1kt/rbIOGbM0qlXwxQCugvpjL/beg2fsjdIFco3v
         qMoJPMl6F3pvf6pzudeeaZEEBczVYUqluWqmRpIYI6wz3h1y7ehSGPDW0ps58BOcw8B3
         jxxg==
X-Gm-Message-State: AAQBX9eMwd73h+E7JF4Asd8SCrKzo/7uuuFVeerPjgszrNicwm3L4dlo
        1+RXyCF1p5ReoyG5+LGHh47lag==
X-Google-Smtp-Source: AKy350YGab/IBm5Uh9cFgleOLNHy7MnDU4Xj92g56W32VU95LNOGjOX54YB+TQ+uEJGtIXVV8ljZTA==
X-Received: by 2002:a17:907:a07b:b0:932:ba53:83ba with SMTP id ia27-20020a170907a07b00b00932ba5383bamr1380544ejc.34.1680588538620;
        Mon, 03 Apr 2023 23:08:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:233a:5c18:b527:381e? ([2a02:810d:15c0:828:233a:5c18:b527:381e])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906825800b008bc8ad41646sm5453187ejx.157.2023.04.03.23.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 23:08:58 -0700 (PDT)
Message-ID: <4816461e-38b7-ba79-dd64-859fa0ee808e@linaro.org>
Date:   Tue, 4 Apr 2023 08:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 8/9] arm64: dts: qcom: qcm2290: Add WCN3990 Wi-Fi node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
 <20230403-topic-rb1_qcm-v1-8-ca849b62ba07@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403-topic-rb1_qcm-v1-8-ca849b62ba07@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 19:36, Konrad Dybcio wrote:
> Add a node for the ATH10K SNoC-managed WCN3990 Wi-Fi.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

We had these talks a lot... All these 3-8 patches should be two patches:
1. SoC DTSI
2. Board DTS.

Splitting superficially patchset on initial submission does not make
sense. If you sent it in separate patchsets during development - release
early, release often - then of course it would be fine. But hoarding
patches till everything is ready is not the approach we want (and we
made it clear that SM8550 should be the last such platform) and does not
justify later fake-splitting.

Best regards,
Krzysztof

