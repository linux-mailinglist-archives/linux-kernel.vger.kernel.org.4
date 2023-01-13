Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEDF66915E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjAMIlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbjAMIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:41:24 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5973E870
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:41:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so50689509ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yz1iep6wwOeN+vmRCG5+ADl2hYT6VJO9EZLLoXnFTT4=;
        b=OlhSzGW8EgrgMP1Z9Eq9dQ0rABO1GoOJqbb/OQy8GNngicmpYf0/Eu1EYglMp7RHoS
         3/s7+UDUhPFp7YqV+rb27RJHi5+9d2SMnA9vMI4T6KY7HEzYIAiuvULGmMCBmP5GU6ZO
         3N02Q02Kw5oKmBSPgJX8R3xB2l3kzrJxRmOTR0IKSNgmpI20J2kJzCorq3m8ERXRbILE
         Gw62ITtgGut79kPUKXteSVfCgjZkmepWkjuNZpFwMEeTIDeYQljKYd8BTrR2yKNRspMH
         BByTeCfIVwsZH6GLnUqJo2bM5w39556+jV7gyS/+kzPAYfrcJLC/zDOkRI6xXFW0sTIJ
         MpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz1iep6wwOeN+vmRCG5+ADl2hYT6VJO9EZLLoXnFTT4=;
        b=Mtf8/eHbXw3eZ13EgqZqZF1On5+ZOG0uo1U+ISn3wPiFLCrIsHO+cAtjxInpDQ/628
         Ck2HdmkCYlBXxou4TzJUNDz0urBpoEfWApLHuoiiYylQ89oZaxQlA16av/8Mk7J2AX1Y
         hz+AWXxS2D+hzOFI/lHXHOVw+OKgXw8cF0AJH5zDTb/3ebMHvA0KYeCSI5PChmq+oqnJ
         cx08JpuU/y4pxbZMjmCahrjaoQ5eylhBEKqLsl3mL2eBMS3ZzQVTEXPUD5d1qoSBB6Sw
         YQtitbYtG4JIbToGLnZXlpHbQq2k2MUR51//+PIQPHSttK5Imbi4qvpTTYGFQr1UtvPk
         QLWA==
X-Gm-Message-State: AFqh2kpyDmse0wvBGlIp9bjgzQbWV6Ww4k3JluLhsQ0YVDVcUBv391YQ
        UFItwVKSZiUK4ixveCk6GVTVCg==
X-Google-Smtp-Source: AMrXdXvb3jZmU5kReftlX2XLV/8iQFknuSeVjV7HaRg0dX2snzktfWyLZRA909hmS0Py6xIypC+Vew==
X-Received: by 2002:a17:906:2857:b0:7c1:8f53:83a0 with SMTP id s23-20020a170906285700b007c18f5383a0mr62796871ejc.13.1673599266400;
        Fri, 13 Jan 2023 00:41:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906310f00b00738795e7d9bsm8198314ejx.2.2023.01.13.00.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 00:41:05 -0800 (PST)
Message-ID: <4ab67085-b589-2a90-4289-a4f5665b182e@linaro.org>
Date:   Fri, 13 Jan 2023 09:41:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/8] dt-bindings: mfd: qcom,tcsr: Add compatible for
 MSM8226
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
 <20230112202612.791455-5-matti.lehtimaki@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230112202612.791455-5-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 21:26, Matti Lehtimäki wrote:
> Document the qcom,msm8226-tcsr compatible.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

