Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724C66AAFEB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCENbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCENbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:31:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820F1126F5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 05:31:52 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id k10so4282431edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 05:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678023111;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYU3IZQDcyAinIOEBmNvAQ0I4IvNbd1yC7kYUTJDSMU=;
        b=pfaDpSiWb7I5T9Q9XRrS6EL/gzpAVm93JhF3C2ki/AKOPTPqSod9Lf7URM7GnGD9Nz
         u7yQBsGOuZ0TGmUkNjhle2DaIxkYQWiAe+uojr3Mx2+OppOQA5QXgbGAbfb6GzIwbjF1
         o1u1OH8iAM78GRJ+ncyCtmBCbPdzP17B8c1OcCunkDVTtm67vl6gVvg2F01DbaARFeRU
         su9NV7MP7+wW3wQAKiKySTUU2H3im0Ws2CXlR71Tj69eOaz9bQGumYRkzg7If5rdsECf
         RoE29/RrmKZm63Ds6tNf8sTP+iD34tpqNBvgyjciG3RtebQF8W4Le6JE2zOtSugBd957
         nR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678023111;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYU3IZQDcyAinIOEBmNvAQ0I4IvNbd1yC7kYUTJDSMU=;
        b=UrqnG8atgLzX7tDG+gdvmy49d0wTqkRWa1nnJ0QaDcK8L6q3wO88MClhO30JMHZT1L
         qaKZPmGZ2lp0WBjmZJjDzHGCurdJZMqEPjVumAXkvx97t/E5kT2lye9h+sEoOGlO3EiP
         6SNVLiZ55ktzoUDandYcQsabFvVkwOGd7UemqikfnULX5RkmCMdLxEtxUAiwPLqf8FYw
         QoCu5EQwD6Q3BF9CSOelX3ZVRrvxvE1jZ0nv0omyh9WhFJc18oNRi14pSqtk8FpAZYWT
         idJiuTUPSHjSrGuhIMU9hrqd+fGJ2kOu8Nba2comHcezWvusD5wvnJJs1iaVWU6Wjh1N
         qNtQ==
X-Gm-Message-State: AO0yUKWf8TVmMT1bNY6MK7OFa7K8/RhQvnEVle5/klsffoSZ2JFDOnOx
        EKAWW2biaTxiy8qHbdTDNYn5wA==
X-Google-Smtp-Source: AK7set9VVeZcdpiS8HZtHwdQtUzByMHqlqxfuluMzmuGmUy04g2fBkTsORK0BJCHBACv1doqeUG64A==
X-Received: by 2002:a17:906:76c5:b0:8aa:c0a4:2aa5 with SMTP id q5-20020a17090676c500b008aac0a42aa5mr7778712ejn.16.1678023111062;
        Sun, 05 Mar 2023 05:31:51 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:71e7:13d:1c29:505f? ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id gj14-20020a170906e10e00b008df7d2e122dsm3198395ejb.45.2023.03.05.05.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 05:31:50 -0800 (PST)
Message-ID: <187dd727-7ff9-02c5-7308-65abe29570dc@linaro.org>
Date:   Sun, 5 Mar 2023 14:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add support for BananaPi
 M2S variants
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230305132044.1596320-1-christianshewitt@gmail.com>
 <20230305132044.1596320-2-christianshewitt@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230305132044.1596320-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2023 14:20, Christian Hewitt wrote:
> BananaPi M2S ships in two variants with Amlogic S922X or A311D chips.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

