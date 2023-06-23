Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7774973B2E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjFWIta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjFWIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:49:27 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B583D1715
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:49:24 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b46d4e1b0aso6438281fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687510163; x=1690102163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/IzfcYheaY+2C+iIc318Id9jWD6NV9kWYTmaOaEJS2M=;
        b=zzEUF2UF3JFf8oHM+EKmxuv5eKaSXKD8Qi+k7j6+qovaDPyFIqhU3QO5PK87uU5oHn
         YSvH5mqaaGibj81PaPDlxCxqp6y+yC8fJShSXFD/IdpULUX90KlZV40Nb02yxw9v+B17
         E6nXeMxwUZ+riq/kQ33uEX9BZn1XMGB7xOqlzacRiX8C+OD+sBbXS3Rf+ehF1nBRs1fv
         freuuzcN0HfXJ1vVSAVaeM7yTLcqIC1zxivfrdHmpFqQFX7EUfhlBCGihbbKZCXWqjP5
         v7EYftAP1rLOuUw0xr5xVFFfGEJQ8FgU005wtw5ttTUKFZCJlGyNePfMtNZhVrwUnN+R
         EVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687510163; x=1690102163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IzfcYheaY+2C+iIc318Id9jWD6NV9kWYTmaOaEJS2M=;
        b=dmHJbnAnuSmMS3UIk6gvyL9QFqzAgzMCDjjnb5LGEzoOgqofpE4WaVpM3iigrbkm89
         Ox/nXZbcGrSni79wTKy0NqLWNSTDKLeirwmyjTyXcCDWo/id0iIt2Sj4mlmIXqlvNSYR
         axX0oQn9EurR5719OVM+MCHqTYARBLu7BWNS6gVStgCCa5zL7pjBNFqcaq0otIzAgM4V
         zRiaCoqSalaWAoPCPW6W5Yp0wy8LJ8edD5562fWE2z8d6hPk+lWPcmgZd+Slhk7e7/uO
         w8+aaualMhHUgzPUkw0DlheABPFoGgyL8W7khfib6u7wQYxnscFY7P3K44uNYz+6wAwT
         RTiA==
X-Gm-Message-State: AC+VfDxW6AYp7ah3kR7IGPLccbp8EwJeVIGW3e1YNWTuWqmLo7YFyuOL
        e3FfGXST655Km/6Uxi3MPSM5mQ==
X-Google-Smtp-Source: ACHHUZ6mnR6rzsfYwn2q0DIgVHx/H1L3imwZXf3H/3i+ulHmEW0dBIa+wPeJj3bXztcczdpDWmJQYw==
X-Received: by 2002:a05:651c:14e:b0:2b4:7559:f240 with SMTP id c14-20020a05651c014e00b002b47559f240mr9906581ljd.6.1687510162992;
        Fri, 23 Jun 2023 01:49:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id c17-20020a056402121100b005158563be4asm5006927edw.33.2023.06.23.01.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 01:49:22 -0700 (PDT)
Message-ID: <dd5d7bc8-5ded-ebfe-48a2-55e330cd7544@linaro.org>
Date:   Fri, 23 Jun 2023 10:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/6] arm64: dts: meson: a1: introduce several
 peripheral IPs
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, conor+dt@kernel.org
Cc:     kernel@sberdevices.ru, sdfw_system_team@sberdevices.ru,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
 <20230623082201.7tfnpjvwi22omleq@CAB-WSD-L081021>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623082201.7tfnpjvwi22omleq@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 10:22, Dmitry Rokosov wrote:
> Hello Neil, Krzysztof, Jerome, Martin, Rob and Conor,
> 
> Would you please review this patch? The latest modifications enable CLK,
> EFUSE, USB, SDIO (WiFi), and UART (BT) functionality on A1 boards.
> 

It's not a binding...

Best regards,
Krzysztof

