Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A6E74E9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGKJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjGKJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:02:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A4EB7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:02:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991f956fb5aso628302966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689066135; x=1691658135;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5FA+/QEntU0LG5SCj9kJTqmfkcpSYPKv5C0T3kXVRCI=;
        b=dEhY4MX19hr4ctPkpyO9K/PgHdzXEhVjIhuc4856r8d3s5Lf3/56+LFzEIuTDJabqC
         DNNDnH0kWM/HmZPd+REBhBgaV63KSCv+JEg7GUoe/31XRn0x2/83Z1ym/DM2jEmTJhd+
         tgpp7rpXjxahMYtTSm6zGpUo9RO8HGX2JcP/illZQqYdzupl1s3gJlvDFynRa0HIX94P
         x5DVHlGGqpbrxXDomGX+ix+TT3ZfOgGBzAdNGCfh9q7mJTS9w+pFKpigHvyfOEC+8NjV
         qyLj4E0Y7u64lLOMf7lnzj45zahzukcmzMg4HgdMFwUceYu9rsrhY9YAWAJEne11mf5J
         xdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066135; x=1691658135;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FA+/QEntU0LG5SCj9kJTqmfkcpSYPKv5C0T3kXVRCI=;
        b=M5PGGByZ5NpvE6bXo0E6XT3r9tayJMLpQHDI2XcD7if+3sktXFP041uEKjE8Fr+G8N
         NQq/AF4aZR5Rw41/KBoMA6jwLBufbB8q2i89x02z+SKzgCpB4h7zRcnZCOxy/97sp3Fl
         9u/TEVmuYl3Cw+pypv0rkuX56Bhv8zd/+OlqUgUqw3u4ihmpX04zyN8yrF6xDGgBM2DD
         uC38qsZWcBUORXTMUUNldEqlb0trIDcJ+4RGnsAJFVEzccvCowi1W7Z/pKMw/ikszvez
         LpXlA7RGfCAUp6B0k6ggIB9S6z1F21txQax7aLR+1cMkKPbpczjHhiJkKGQ5JN2HAbKy
         SXgA==
X-Gm-Message-State: ABy/qLbHAp9EMQBGbcb8+P6IKT2OcmuydQA9TGimpY05dpZ20x0zJEBa
        9toyxoSkJhCUcq1ZAwS11C2Hww==
X-Google-Smtp-Source: APBJJlG37y8uEFiTXGPVZXECGPfO8QctpW441f9tYtuSYBfOP80+BrY4WwF7MOu48j9LhGXuAjBN1w==
X-Received: by 2002:a17:906:6491:b0:993:d7f3:f055 with SMTP id e17-20020a170906649100b00993d7f3f055mr10863110ejm.11.1689066135075;
        Tue, 11 Jul 2023 02:02:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id rk21-20020a170907215500b00993150e5325sm880513ejb.60.2023.07.11.02.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:02:14 -0700 (PDT)
Message-ID: <3b81541d-e9b0-7617-f9c7-ab8ed053c422@linaro.org>
Date:   Tue, 11 Jul 2023 11:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/6] dt-bindings: usb: dwc3: Add IPQ5332 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1689065318.git.quic_varada@quicinc.com>
 <c1173429e75b493a8290ac5af6fa566f7f9ebfb8.1689065318.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c1173429e75b493a8290ac5af6fa566f7f9ebfb8.1689065318.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 10:51, Varadarajan Narayanan wrote:
> Document the IPQ5332 dwc3 compatible.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v1:
> 	Add ipq5332 to interrupts sections

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

