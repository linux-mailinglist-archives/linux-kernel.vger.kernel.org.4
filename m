Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3717F5B3123
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiIIHzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiIIHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:54:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860F78F976
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:52:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q21so1398167lfo.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=H3jTggW39q8fm3aTawxMJXs7n4OJhbpJ8Eu66JkV7sg=;
        b=tMiTZ9kBcLTSnBwxlM7qRCkLS5VEX+ikMY+6KNcBfL/K1eFfkjtQAty6zI8yFAQeBK
         TAueo4EMTGNT+zU0YXpVMemtroM9uG8/2ID80+XP36PH5+9LjKk1jUFkbHwq2/LV8q6C
         O49XhMhMEx+wD04J3FHH97UlihP8butM4wfGqA2FeV1up4K3Dqa5dFSMGztrlHPdncDI
         BcwTyewKT2NvCvU1zufk/N62V22lmfRI2FqjsXhar/sHkh3ggw4R6lcjT+TZR31IevJh
         7Sjk1AVZZW0w3BTx9a9k6t2jS8TEwIMuBwSp5f/c4XDaH2+LERqNbOLSYo4P17KCcS80
         7I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=H3jTggW39q8fm3aTawxMJXs7n4OJhbpJ8Eu66JkV7sg=;
        b=JqyL2+UZGBa+3P1IeFkMOutosfe5YBGrwEIt5KSEokkZ342Dhyb94hbEIURkvqfU/R
         6oKrGhXSecYau+NJyP/NdWO0gSRVRQl1hiHNJqukVH6IrWgKtD6b7nBImtmLlRQ2whmE
         TyEALhPMowFCyipP2kGIy166OX+B6aPHrPVKamLI6efFGtumzXVCrd8yN5YhIvDlHQpr
         hg7xTjwkFubWv2AIh5Iod8vW/8CS/YVbA806NDGpxI++ZXCNv9pnocJcutd+jfGAUON4
         KMuXVdHS2UT4fmupCVyKCsD2et67xMF1ufZGzZUsSJkmOmrZBmwb/gZ3IL9Ysmje7Wdo
         1Rxg==
X-Gm-Message-State: ACgBeo22wj3krpoUzP4F0UJpqSy549jvxUlr8YJ01VvrSJb995IghT0B
        OYQARYzA+3+CAAqGjcT4jYGTDw==
X-Google-Smtp-Source: AA6agR6RMZ+XZIiPmcU2JjIgbPC9jWYTi5BjrlN4ZEWRoIILkP5u1HCl1iJMJF5UN1Aj2o/Ag6dYWg==
X-Received: by 2002:ac2:41c1:0:b0:494:65a7:43ef with SMTP id d1-20020ac241c1000000b0049465a743efmr4265291lfi.592.1662709938774;
        Fri, 09 Sep 2022 00:52:18 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h14-20020ac25d6e000000b00496d254bbd9sm159806lft.271.2022.09.09.00.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:52:18 -0700 (PDT)
Message-ID: <02b932b9-a100-3e35-ae57-575ed3dc5f69@linaro.org>
Date:   Fri, 9 Sep 2022 09:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [linux][PATCH v8 1/2] dt-bindings: arm: at91: Add info on
 SAMA5D3-EDS
Content-Language: en-US
To:     Jerry Ray <jerry.ray@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220908222125.19059-1-jerry.ray@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908222125.19059-1-jerry.ray@microchip.com>
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

On 09/09/2022 00:21, Jerry Ray wrote:
> Adding the SAMA5D3-EDS board from Microchip into the atmel AT91 board
> description yaml file.
> 
> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
> ---
> v7->v8:
>  - correcting patch subject line.
> v6->v7:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
