Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A008C5F3F21
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiJDJDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJDJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:03:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D1B3A4B5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:03:27 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f37so1862635lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cPUQKMQ52472PTvIXL4JBp6H6bJjgLa4qPT+B+CFn9g=;
        b=AzqV07ggUgW1QRRttdc/P8e19rCB2qQtt6Btx4C1ChE8LKAyRRsuy1aU8BSzZvtpRH
         5QNCe5YElzFsFJIuDcbBV6LoW/Y0wbVVICAZKdWdi71q299McdI5sN/q4wDebJD2TOme
         gD3bflFipgHwOCSs82hpNyOddvXeZHfZ6R9qWuRtukrEB4RWxb0pGUOo6qlpo5wOKBnp
         j6Mx651oV2lnNHWy+486g7zgUcWGXqQxB0I2L3Szkv/Y1Jnp0qqLUrkSdYEbdx6can7w
         QT70yk5ajL9iwocvkiBvzCxUZZE2JRpXLeUMu1OoiFGwULfTwwjHYZ0JtNBi+fX/VNv5
         vAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cPUQKMQ52472PTvIXL4JBp6H6bJjgLa4qPT+B+CFn9g=;
        b=RIAMi4yRr3DUzT1XA/bidrluIUF0VXNaJrFVU0nQl0abJEDBHkXi1ifaXp9tWJCuoW
         +Pd+Dzmofu/zMSZXhtB7HeZAC5e8wCHwwDEM8zg1hjD9dnDSd17KtQjfK5CcUCvYXvi3
         VtNOaoXXCE+YkYOs3cYGfoxsnBbNj8rhmpM046+otjMa8ZbhxzUt8Oz2p3RJFxzORE63
         H5G7IAukyV9IV3CPh+yTEUWeKXrAy3RHR8i/wsadlE24InAihca75Y8P5hla2jSeQTke
         rqRkZxy4K0nqx+X/7SZ8otERqchmwkXRFLT4WPfX0GTE21zX0LOxX9gGNE+iX5LFNp5H
         qKNw==
X-Gm-Message-State: ACrzQf3GxZqM6ikRL5b++HSgsbfVtZXGQtGMbZdYnq6a02dkgti8pS3R
        v/Thb22642u5+RInnrmo+vQIOg==
X-Google-Smtp-Source: AMsMyM48++19pfgzD1iCo7SHvucq8TAT5pl0hN7rV0tOquej/LMNJ1sRgQVsLu0bGAE9XojBy8+dDw==
X-Received: by 2002:ac2:5384:0:b0:4a2:3a45:520 with SMTP id g4-20020ac25384000000b004a23a450520mr3281663lfh.560.1664874205443;
        Tue, 04 Oct 2022 02:03:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y13-20020a19750d000000b00497a1f92a72sm1826435lfe.221.2022.10.04.02.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:03:24 -0700 (PDT)
Message-ID: <886d5a16-e3b2-608d-1163-ab112b2417de@linaro.org>
Date:   Tue, 4 Oct 2022 11:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 11/11] arm: dts: qcom: mdm9615: remove useless amba
 subnode
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v2-11-87fbeb4ae053@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v2-11-87fbeb4ae053@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 10:08, Neil Armstrong wrote:
> The separate amba device node doesn't add anything significant to the
> DT. The OF parsing code already creates amba_device or platform_device
> depending on the compatibility lists.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

