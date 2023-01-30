Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352B0681345
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbjA3Oal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbjA3Oa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:30:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A0A40BC9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:28:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10164110wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3McM8N2nTNHlQJb+34FnCzXtbwo9fjKoxA+DQBRkosk=;
        b=W+4S0TS5rGn11tvXQnBUz4wkUQ6e6spHYiWdjrHK+MrbxNyoj92UoUEx93cmEwXl0a
         A25bJY74OMfuP9Yo4JDKC+u9zJt4J6aFd+OdgcHPN5xo0nQFjKkuOvNPZAiTv9iNqL5w
         BrUd1V6BPIKRa9aVyR9vvikKJAthwPQCW0KqxiIJBasgaLSGUcLDjBQ23Np6Pw2U+rn4
         TNlEUSLzvo1NMP1aj6VPEvpBleY3kjj2zcQwQZgZ6nag6MlVL/2XM2j5VlPg8aIXJ7AM
         LbHtN5cTU0bFaoOOwLfQvIpPKcAZ/gMK5tuDVEr6ld5vVxi0bENYztBWilGB4Nn1UY3X
         VeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3McM8N2nTNHlQJb+34FnCzXtbwo9fjKoxA+DQBRkosk=;
        b=BoFmK0v8bXe4g25MExc09e6NdsaVysMtjtUv880OtR8Fj5f1AJX8p3UjLkbNzghD8n
         M78/q1VAzqXvegmMQsydvvLJoc7Y66AQi/EV2Gv43mv9qwuIgSlTBY4HVsCzPpWW7/tn
         NKwhSy8+b//g5J0zjQaiKFgUOnVnUV52x8dvKt3hOorbatFgWUtyzK3O7MzuUu2T8aiF
         9PqyM7tWn2dm+rJPjtuJcR7PNzuemdT3hY/Tc6zDUsIN5ggBWGHAVOcQoon3QLtKpty4
         t3EP5HXRaGNOem/CnhDNbwbg5QNNbtjEY+IrDKPnMgeaMno4toCUVj1tfGh6QbrnfArG
         CFjg==
X-Gm-Message-State: AO0yUKUAIdGXQZi6ap+zvE50mNPcXpK02E/FhaZI5MeSr+7iUto8K1Oh
        ynQ3afPikBPymUEp1HNP44Kcqw==
X-Google-Smtp-Source: AK7set+s835IjnjqvQA+6fK2qQWO3YZKjyof+ji04X1Em1crGP9Vi/S4SYGCAvDntgVbNdkPzFpE0g==
X-Received: by 2002:a05:600c:2283:b0:3da:b40f:7a55 with SMTP id 3-20020a05600c228300b003dab40f7a55mr4473493wmf.6.1675088933535;
        Mon, 30 Jan 2023 06:28:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5f17:219:cb05:7cd? ([2a01:e0a:982:cbb0:5f17:219:cb05:7cd])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003dd19baf45asm813738wmp.40.2023.01.30.06.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 06:28:53 -0800 (PST)
Message-ID: <624f2924-ec30-e0c0-1022-610d1aee761f@linaro.org>
Date:   Mon, 30 Jan 2023 15:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/4] soc: qcom: pmic_glink: Introduce altmode support
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>
References: <20230130042003.577063-1-quic_bjorande@quicinc.com>
 <20230130042003.577063-4-quic_bjorande@quicinc.com>
Organization: Linaro Developer Services
In-Reply-To: <20230130042003.577063-4-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 30/01/2023 05:20, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> With the PMIC GLINK service, the host OS subscribes to USB-C altmode
> messages, which are sent by the firmware to notify the host OS about
> state updates and HPD interrupts.
> 
> The pmic_glink_altmode driver registers for these notifications and
> propagates the notifications as typec_mux, typec_switch and DRM OOB
> notifications as necessary to implement DisplayPort altmode support.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8350 PDX215
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v2:
> - Include bitfield.h
> 
>   drivers/soc/qcom/Makefile             |   1 +
>   drivers/soc/qcom/pmic_glink_altmode.c | 478 ++++++++++++++++++++++++++
>   2 files changed, 479 insertions(+)
>   create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c
> 

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-MTP & SM8450-HDK
