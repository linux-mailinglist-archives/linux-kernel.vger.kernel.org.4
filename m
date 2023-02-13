Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AB0694373
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBMKtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjBMKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:49:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA299769
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:49:17 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so8661305wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aT7VvlUOMpPipvm3wlZIQFUoYoelXFY2v3Bc54ifSV8=;
        b=uVsqKR2n23byaQccB17GNoz6E2ceIFKQHOLqJuhlaihMGwJ30tjevxEAGEZKkkDQUp
         JcrWtq+bMvTC4AJDW2dS6feliE6lF7p7/n0NEEFF4wnHiMiP0bQEcKQoP7TEFEi1vzLV
         pZdhbf77a+/tF1lupLVNJNkXRyCmrUz0Fi95sMaHTdQHqIIRDxfX3tLLf07CU9vRT3LI
         us1Mz95V82+S+l6TPFKMtzJl2hgINB+dO2z6hAmjE3vRMt45oiXNwuC6MV8/yemKckPY
         andzKtbiYifzlucHDXFrOKfZfTNRlAcUtCbjRW7ibg1TQ6G1tBd6g1EzU1Bmh1m5N2fh
         f66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aT7VvlUOMpPipvm3wlZIQFUoYoelXFY2v3Bc54ifSV8=;
        b=hCTOBdNxyzKxHHmuL5lTZMQC+CKhHheo9QgZ+eKgTzGCynVhqWe6eE/qcdlbPUBGm6
         LnVCI6AbFoxItEKzoFxRBqdDTSzGYGo5z2g+7PQS+IQ+Y+t8pmhcjd75fdDoN28vOKkW
         /NjmIuO7uczvZ02sc2G73B5obpDWmJm7rFmEU5Wia/vBuL7wkOSRcsrvbP7KncvG7OPJ
         cvMlklcH+6CX1bVQvkQcj6HtzbPCj5COnDYHj7e34SiW/FWi/p7pqrSKKRCLNKor9gSp
         HPCCB4HbYvJ7n5tp5tLNQcmzDgESNRQXnHPI3NZ8Aq+LZ4bVlUu0h749GEybtuTQjogY
         S92g==
X-Gm-Message-State: AO0yUKX1WNsA1J4R3F44EZCrvULzJpESwRsYbkMEG80Twea6fdx/BABZ
        YP+srAazx0LYEwh8O7XAgBLT4A==
X-Google-Smtp-Source: AK7set/iyRzJtsUzppLZveqjUXX5TxSHJLjHGTOcruKk8MIGtnSbZ2Wc34V220Eswb4eIaFuasj61Q==
X-Received: by 2002:a05:600c:a287:b0:3df:fff4:5f6f with SMTP id hu7-20020a05600ca28700b003dffff45f6fmr18380252wmb.36.1676285355734;
        Mon, 13 Feb 2023 02:49:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b003dc434900e1sm14568936wms.34.2023.02.13.02.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:49:15 -0800 (PST)
Message-ID: <9443acf1-0380-fda4-7a05-d603ee010ffb@linaro.org>
Date:   Mon, 13 Feb 2023 11:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/6] dt-bindings: rtc: convert rtc-meson-vrtc.txt to
 dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
 <20230209-b4-amlogic-bindings-convert-take2-v1-1-c4fe9049def9@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-1-c4fe9049def9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 14:41, Neil Armstrong wrote:
> Convert the Amlogic Virtual RTC bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

