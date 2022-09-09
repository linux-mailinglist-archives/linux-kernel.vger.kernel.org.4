Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8EF5B3C27
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiIIPiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiIIPiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:38:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC100148B76
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:37:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u18so3326198lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VoZzh6+McgoHrR9WlHSy7ZyYvs03BD9luhicUduQeYI=;
        b=fa8xcnnrlb/OUGc0uUaLIGzjkqk/MICCRSJuI7kQS1uQkN6xDk9SU3VXRBpPF4xdi8
         fzORqv/MF7MheAQxJ9UVipb2YBOZ6AUyjCqYyQWRezq5PdU9pmipSjCAnxa0fOHK4Sj2
         bEA3zXlc2aJ6fONdhWP3vStLRCsIJS+6E5A9iehK6H5kxHabMDT/LjXKQJoEFk9fGe7i
         iLWYJCuGqRfZkBPQ2UIfJGupU2LoipdZg78ZUBt6yXHyXUejnWQyp1QCz9pjQU5EKyRo
         qYl631m0O4cKoRZkf6W1fs4F4iuPjSs8+ynFPPqOVUftPqhe4WgtaOjizOF9c4TKczEH
         qdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VoZzh6+McgoHrR9WlHSy7ZyYvs03BD9luhicUduQeYI=;
        b=jUt3IOyCaT900QbMZVw9l65AURBp3eP3Y3Am1Ijt8LagctZo7W/jHg75UM7YOtmY9K
         It4IPNpzv9mTmYaXpecWk/rciu49lEuV0DWi14IXrIApgVo8ZXH5drtdEDnWcO9WNF2l
         xYrE+upJYTx3DR1DeUsT1iZlMSmQ9By6rUIW/Ade4u1TxiHYnBkbKpqdALbrhh7QfaFh
         GVShmNcUkyLYlWqmMcQKrizo2wJfmf3tf/gS9zwpY89nexR+P/2c8CgRR5mKHwEy+Zmr
         muriKXNbFF1o6pUa9XvPF6v1zcwY8P8hSl8EnGY0Yk8tpic/JZUNhqhnxThI0BxMJROt
         6UEQ==
X-Gm-Message-State: ACgBeo1V9xH9T9ncBdKNx5qekBkbnqwx6HaFYBDs63fLtrd8SAwZRE9L
        P9vmw9WAxucklbLh2aKU4eORjA==
X-Google-Smtp-Source: AA6agR7mMPp8s/Sn9BVO1OaUyAMNzkR5ybFeQm28JQpriCYcArQOkyLF3ZbKL0uWEZH/HDxNamc9/g==
X-Received: by 2002:a05:6512:1044:b0:48b:49b1:cc85 with SMTP id c4-20020a056512104400b0048b49b1cc85mr4719743lfb.57.1662737807755;
        Fri, 09 Sep 2022 08:36:47 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n27-20020a05651203fb00b00497a99e7b73sm115011lfq.246.2022.09.09.08.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 08:36:47 -0700 (PDT)
Message-ID: <22a68bfa-c465-98bb-d199-707aaead870a@linaro.org>
Date:   Fri, 9 Sep 2022 17:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH net-next v4 5/5] ARM: dts: qcom: ipq4019: Add description
 for the IPQESS Ethernet controller
Content-Language: en-US
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net, Rob Herring <robh+dt@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>
References: <20220909152454.7462-1-maxime.chevallier@bootlin.com>
 <20220909152454.7462-6-maxime.chevallier@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909152454.7462-6-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 17:24, Maxime Chevallier wrote:
> The Qualcomm IPQ4019 includes an internal 5 ports switch, which is
> connected to the CPU through the internal IPQESS Ethernet controller.
> 
> This commit adds support for this internal interface, which is
> internally connected to a modified version of the QCA8K Ethernet switch.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> This Ethernet controller only support a specific internal interface mode
> for connection to the switch.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
