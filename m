Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7CC66DB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjAQKtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbjAQKtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:49:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D452E0FA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:49:21 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g10so21884618wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hw9LSsAC+JoG6t7UQRkksJH/sKygxvY+0Hbj6I0x4NU=;
        b=dYLDQ84qhLknci0JyJ5YViFyJvPEvYzYN9BvqSEZiCSLsxxzXldEKMSKPSrh2d+RBm
         9EsATFRiyaAn4bnCfr5o2BcyOIaefFQHeLcNV6HshNkayK1hvEkp8dHkvBWNPIb3UX2Y
         s8mz8ZZquszsxRxVgiv+TmFHzquHK6/ORHzJCOHnjTqRrqHPexhLF5YLGqQtAZIRp/3J
         NOecZVIbtgmyk+HaKgnChU79SQfA5VaYeS+zTQdYjyphDGx4u01q8tx4m7m0tcByCb9H
         fx+oTd1NF8kFsgJP4XJBso1kZ9NOYdtsenF0LaVAoOka79fHb535vuPGGcg3NbnKrIWS
         6Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hw9LSsAC+JoG6t7UQRkksJH/sKygxvY+0Hbj6I0x4NU=;
        b=jGN/GgsOClV+cW/FG1DOkFfbBoByiGnA484xWbKC0SeSJf3bHBInqa92I5F7V9hO49
         p7iLDCRY9PtBEwtib9uU/ZoA9oCBfl1bEORssfHlIHCDiLhyUBkWtG2m2vQYZNHZC7x6
         o1DpNPqfpqpkKIwvzN3wjVKRJLOIix7yrMoEtQLMeQ2AvQzzdvst63DrShJBdV7Mct4F
         xNMnyrvQqKGi2ooHmJDGsb7Yl5awkeIX8p/JiRKA1l+maSSjVO0f1LbqMEiBDMPvQb27
         2rrJLKONOKfmAe6AEm78dbqYk0tJLPsVha6EMc1q+/+Nbk0q15ppvMR4lFY9QhY8Kp04
         NJBQ==
X-Gm-Message-State: AFqh2kr85QXEefqbnllxy99qOG64AGvDNqJVGBQLWIOQDnXfzucFbm84
        PWe2inEN/ttXROlEa/4KV039jQ==
X-Google-Smtp-Source: AMrXdXuJR/Nap/1o/9BFs2yQmhrWI3X0LsxMxUicPwDCEX41QW7/OEhWrSlO5WJWSaWhGM6Ye0Fpbg==
X-Received: by 2002:a05:600c:1d12:b0:3db:53f:baea with SMTP id l18-20020a05600c1d1200b003db053fbaeamr2320734wms.6.1673952560238;
        Tue, 17 Jan 2023 02:49:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c2cab00b003db0ad636d1sm1152853wmc.28.2023.01.17.02.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 02:49:19 -0800 (PST)
Message-ID: <c5ee50a1-1838-3a29-e800-3492dae63167@linaro.org>
Date:   Tue, 17 Jan 2023 11:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/3] dt-bindings: vendor-prefixes: Add an entry for
 Meta
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     garnermic@fb.com, Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230117094425.19004-1-Delphine_CC_Chiu@Wiwynn.com>
 <20230117094425.19004-2-Delphine_CC_Chiu@Wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230117094425.19004-2-Delphine_CC_Chiu@Wiwynn.com>
Content-Type: text/plain; charset=UTF-8
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

On 17/01/2023 10:44, Delphine CC Chiu wrote:
> Add "meta" entry for Meta Inc.

You need to be a bit more specific. There is Meta Platforms Inc. but not
Meta Inc., so you might be talking about different companies. Describe
shortly the company (e.g. website, NASDAQ ticker)

Best regards,
Krzysztof

