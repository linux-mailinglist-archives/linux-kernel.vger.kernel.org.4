Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145CC6A92AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjCCIgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCCIgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:36:40 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32163559F3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:36:00 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s11so7218550edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 00:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677832531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45hLfdXjorzUYhr9af9cUsgdq6LcBS1WmZTgzmvAu7o=;
        b=QjBrJaV+mpJ2WyDB9RD0VMdTTz/SWjIGRdOMHNvr7yJfkCHkQ/jIqFVRbyL5v3GRfY
         /AgcwO6luBsouTTIYRWNth/w8a5QnLbCDWscb9zU5IsuqRbG9rMO9qg+M4lwzmWO8j8X
         ildBmkMnYXdHXDWa2FgcC0UcCovenaKErUgcKcxzhMeJiM9UySaxykEoVw3ABhwi8Pgj
         AUD/YkRXWjguH7fjdH6XVPl6LbA2b6GjSW92NN3ZlXu9uhVjx+xtgqYoPTrQGYXwLk+U
         zWnuBYYqCoObIL9fpyKHveBdTTD1B3Pa3WSkjYNY7TPrbs86RIi2Kmv5FYVaOaGSLuxM
         T/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677832531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45hLfdXjorzUYhr9af9cUsgdq6LcBS1WmZTgzmvAu7o=;
        b=pkrXdwuoW7OymHx77dYypEKjF4a/mQru9xmp1kNKIzWJIyX87XXA6T4Ak4Ccf4ULl9
         l0IQDccDwyBrwh+cqa3bnUBCVywwAFHTii6o83tMDP8Tzam+81VTZ/zJCLIA3uIhYffR
         /cJfm+rRi0OHmp0mijnkmaV/avz8TDlBk2aUae8B4/l9vDjXAMeJwIWUlHTliQ+7WdYk
         jTlHYGra1rS1QbcB8Pg/I72Q7PUQ4SGOxf7Tf+QVdz/JFfZcp5fH1GMtcqGweegDwiOv
         EFT1M/50RB1w6+7gJR9kAe4UpfIHupZEsC0A3UisLXzxNSOoKQpUln1J8x94RBbXtdUW
         ecEA==
X-Gm-Message-State: AO0yUKULZ9mp8Ks24Z8m8X1oAt5P79jIbslvNzLXxWhLDn/wrLfymFX1
        WwoMbgyNOMLbpwC2ZsjEmrVtDA==
X-Google-Smtp-Source: AK7set8d2Q0EwBHWa3/v/x58sFAMvn69ooUjKD+cUroGILHDVX8OrZEoA2EBVd2lDRPjzr4dFRADPg==
X-Received: by 2002:a17:906:dd0:b0:8af:5154:ff8e with SMTP id p16-20020a1709060dd000b008af5154ff8emr871595eji.15.1677832531497;
        Fri, 03 Mar 2023 00:35:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h30-20020a50cdde000000b004c10b4f9ebesm871150edj.15.2023.03.03.00.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 00:35:31 -0800 (PST)
Message-ID: <af7b3c56-b9b1-7eab-2c73-2ae7d945f548@linaro.org>
Date:   Fri, 3 Mar 2023 09:35:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 01/11] media: dt-bindings: starfive,jh7110-camss: add
 binding document
Content-Language: en-US
To:     "jack.zhu" <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230302091921.43309-1-jack.zhu@starfivetech.com>
 <20230302091921.43309-2-jack.zhu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302091921.43309-2-jack.zhu@starfivetech.com>
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

On 02/03/2023 10:19, jack.zhu wrote:
> Add DT binding document for Starfive Camera subsystem driver
> 
> Signed-off-by: jack.zhu <jack.zhu@starfivetech.com>

Also:

Subject: drop second/last, redundant "add binding document". The
"dt-bindings" prefix is already stating that these are bindings and it
is a document. Write something useful instead.

Best regards,
Krzysztof

