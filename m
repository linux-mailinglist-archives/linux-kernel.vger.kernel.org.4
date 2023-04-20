Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E176E98BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjDTPsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjDTPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:47:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF903583
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:47:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z6so7434063ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682005676; x=1684597676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zma1GNPt9EEK7iZLlPOEbxI0+LETt5GJfYYZFjvw0+A=;
        b=Hwltqq0sRptiTJu2kS+pPX1lsWf9yS0Gmpz43opbyCUKIKu9Y5T4tAikJC964N+gf2
         M1igOljc4GVr/RoALtQaKQi8p6E3AIEWKdE8NrkFoLQ6Ps2buGQ/bAWXYwWf1E4vyROb
         4AIVLWD3zuhVDi/vSB9tKDzdB8fO9xbb6OCNxcrofSgi8TdstjEScxRyTKAYlv9r62qS
         J3exWydC8/Os2bBW+i6WCTn1/1NkfS7V26AZIYK2BaWJb3RDQ3PSrjE9h40yN0WU4NPZ
         8Aw2gBx+a2kpujAKn/fyXtUkK1VmOIKgH03htOi+0RkHF4ecl3DU6MmPJGIv4Py+RlC0
         Yq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682005676; x=1684597676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zma1GNPt9EEK7iZLlPOEbxI0+LETt5GJfYYZFjvw0+A=;
        b=ALYpoH4snjI4ZjUr1CaVBMN/Ef9pfzPRTCvaGB5LbGYOTwXqDlWeNNZ7vCv7X+PUlC
         J68GmKyW4NWJ3nC8tbYjDnzQgL6PWtjz4sLtWwMZ4UM9EN981i9SGSgz/frP/BwHrSxT
         YwWSrhzfHLgEVlTatjBp9LB4LqbbUXDwx/iXaJUp14ZzbxAbB9BUAkinjdrXObuL4ebz
         5Q3cPzcYbZ4GYt3oXKvyLPuT6kjHfjRxfEDzSI2UWbytXmdzaELO3w2TjHWRXOF8rwJV
         itvPG/JwOeDhHrEJFMD9PSt+wG84kXSysGWtMmnWt2AexeHFqL00T11QyLs/yOVnK522
         rQjQ==
X-Gm-Message-State: AAQBX9e+/RZmCvYOkIylUW8+Y3gaef7dJ3vtmWg7vvaJfecjkfrIt5OQ
        SJka/JiOKHzxVPHAsnMQVwk9ww==
X-Google-Smtp-Source: AKy350an5EXsmftkmGrxqo8qUQvDzhHWDnvbfN6Kdn+/2buiI5e5pQb6qso779JHSTxr4BbWt5vUkA==
X-Received: by 2002:a17:906:171b:b0:94e:1764:b09b with SMTP id c27-20020a170906171b00b0094e1764b09bmr1968487eje.45.1682005676356;
        Thu, 20 Apr 2023 08:47:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906844700b0094f7b713e40sm847299ejy.126.2023.04.20.08.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 08:47:55 -0700 (PDT)
Message-ID: <39c875ec-1e2f-407f-4684-52a5901df7d7@linaro.org>
Date:   Thu, 20 Apr 2023 17:47:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] dt-bindings: net: can: Make interrupt attributes
 optional for MCAN
Content-Language: en-US
To:     Judith Mendez <jm@ti.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Schuyler Patton <spatton@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
References: <20230419223323.20384-1-jm@ti.com>
 <20230419223323.20384-3-jm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419223323.20384-3-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 00:33, Judith Mendez wrote:
> For MCAN, remove interrupt and interrupt names from the required
> section.
> 
> On AM62x SoC, MCANs on MCU domain do not have hardware interrupt
> routed to A53 Linux, instead they will use software interrupt
> by hrtimer. Make interrupt attributes optional in MCAN node
> by removing from required section.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

