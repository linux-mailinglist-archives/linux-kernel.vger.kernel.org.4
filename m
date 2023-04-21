Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A929D6EA49E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjDUHX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDUHX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:23:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2BFBC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:23:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-953343581a4so171997566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682061835; x=1684653835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prqrfzm1qDAOCB1S3DlddybXVErcXD5n4O11g8gCXdo=;
        b=JOhZ1ATLNeARFmRj1IkbfMUpPFUJqheOPyhwJrivu5pBziPkUWx4NHgk6fBcn6UpaL
         O2kTcHxJX/OxXzbzZQzmj8B/TzJV0rxP6indgTWrKY8AISZYvGRbKmiNWk2AJLgah1In
         7lwROoMppcQ1K0viXlTcAfs9JrdJh85wSTaTE9ZsMDBHag7C/qkMye15gNIhCJBGns+m
         WgH1RbTGGqrI5wJAyXBvMBVwkrQMnfNLU15XIEOxdLhmlu5tqmhrfiOLbtX1hNzliICe
         zdt79G9r9fH7Gc5+qbg54SdFCmRI3IidR1p3wxveNw7ZAqC1t4ErfUWc0mA7z4x8YOJU
         Pmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682061835; x=1684653835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prqrfzm1qDAOCB1S3DlddybXVErcXD5n4O11g8gCXdo=;
        b=mAeVx4sGPFv31R2kfHYmbs0hBx63Lzo7sTYZlAlHO67Er2NWiDzjkORhEPpB81TPeC
         x0RsA4DPdenkdamHTNs9zfsuJO1g+TC/C5zN04X0gqNGi+AanPorypg2qTBoHVMwvPpk
         BGki5QKBe5Xpps4ZNQ3U1v7FEwriRKyt+bfvQCaVfjz5hKtlEl9CBTq/8Y6E5EPNxfVV
         rSMY4QYgSlR6p79mvIpm/ttIw3iiNbwbV7512PqjgkoksywmQ76AvTwE+nWB25+BdVze
         K6gESBAi6g1PwdICehdqRhLFd+n4U0122Q3PCevQJ8CtKwOP2BbQMuLd5hQcb6icB6PG
         t5aA==
X-Gm-Message-State: AAQBX9e1dK5bLvTN8EKD2K4x1KDXO2BJ7Hd5Q18zbIHjyvKDDc7hLZfT
        JOIQMJWU/Jes+4z8Y49woVhqhg==
X-Google-Smtp-Source: AKy350YgcUsXsalWPaVeSw5M0+bkcudrenAyULZM13pxyUXbMr7Y9HVWrdBHEXIxeyZssdARWUhEaA==
X-Received: by 2002:a17:907:3ac3:b0:94e:70bb:5f8a with SMTP id fi3-20020a1709073ac300b0094e70bb5f8amr1119505ejc.66.1682061834884;
        Fri, 21 Apr 2023 00:23:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:668b:1e57:3caa:4d06? ([2a02:810d:15c0:828:668b:1e57:3caa:4d06])
        by smtp.gmail.com with ESMTPSA id gz19-20020a170907a05300b0095076890fc1sm1721175ejc.1.2023.04.21.00.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:23:54 -0700 (PDT)
Message-ID: <ee5e2621-36db-864d-bdde-885232381a23@linaro.org>
Date:   Fri, 21 Apr 2023 09:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/3] dt-bindings: timer: rockchip: Drop superfluous
 rk3288 compatible
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230419181309.338354-1-cristian.ciocaltea@collabora.com>
 <20230419181309.338354-2-cristian.ciocaltea@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419181309.338354-2-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 20:13, Cristian Ciocaltea wrote:
> The compatible string for Rockchip RK3288 is wrongly provided in the
> 'enum' item, in addition to the subsequent 'const', which allows the
> usage of an incorrect specification:
> 
>   compatible = "rockchip,rk3288-timer", "rockchip,rk3288-timer";
> 
> As the rk3288 string is also specified in the top-most 'const' item, the
> binding already allows the usage of the correct variant:
> 
>   compatible = "rockchip,rk3288-timer";
> 
> Drop the unwanted rk3288 entry from the enum.
> 
> Fixes: faa186adbd06 ("dt-bindings: timer: convert rockchip,rk-timer.txt to YAML")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

