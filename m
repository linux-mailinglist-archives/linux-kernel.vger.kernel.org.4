Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AD86E8236
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjDST57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDST55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:57:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E213426B5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:57:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id vc20so1104928ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681934274; x=1684526274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QStVBT8Fo+0q7XfSVeUTQvruEN5UNY1t/XQiKMnzwNs=;
        b=g+4OJ9XeTAYXp7Mo9G1xc+pajMUg2awcJuYLhTQC4EoG2GdK1cgz9uKlY/EMyFuvVd
         nqxzeIhS08Wba8luhyeEsWuhppD2bNoGHCkKo2n/Ib/TuTCaxFKWFnP0wSU29ikXhwgy
         xB5/2EYP8d600Q/Mzw3MYcdshjwZo843v5I8b2o1Vylb2Im/YfE1eDYD+Ig/HLLv4hMg
         nKAg/mYdzquRdmfEprv7NTnnsvfjaW2ZgUu9TGUL4Ge3viFhF8TxyRyoB88fnKbxdR5l
         YExH40C9ots6iQEO0rXhtc4GVGZppUophp6QdatRoRBSx6vIcm54tzxTr9xFAHeL9nFe
         qsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681934274; x=1684526274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QStVBT8Fo+0q7XfSVeUTQvruEN5UNY1t/XQiKMnzwNs=;
        b=l3X6smcc91nTPPBEESWOT18AlFs7WCZ1mjFeufMn31VfgsICoTWiS2WVmsB59lxt0J
         WBM8LDy7QKf576xAM2cNPygJvP/pCk+JMEd3aaOB/2VCZBbZM94F6JhuMyUgnTSTbP8v
         6E5Za5KUgTW9rBceMkuwILgGrFdyWZatWPXMo6f1PGrrqK/X9fjkfmecZgG9pOAPVUyh
         X+lQVhZ7slwIlUeEUIfhch2koTTfqshfzBz+Z24DzJai07zG3wbpcS9m42olqrGOkEKl
         s4qjZFci5rSB8maZBzgr/w5RzIbXK/OJzNayj+dfD3LGFm68BMJ5IbaEsujZT1zScbt2
         Rxow==
X-Gm-Message-State: AAQBX9cCTzoEFQU2dD/F+1C4Uxr0ohfrOPoORiWXGxHNm78lh2iwynB7
        8oewE2fVV/SAuXKLYFHj2yhhHg==
X-Google-Smtp-Source: AKy350bd9rGROaDLjeW164+cgbfte4quNOdy5zEwI6FGqz7iZxE4bjvP2EuL76GKHtsqtZeFNIDTnQ==
X-Received: by 2002:a17:906:2a45:b0:94f:1ac0:850b with SMTP id k5-20020a1709062a4500b0094f1ac0850bmr16253833eje.71.1681934274369;
        Wed, 19 Apr 2023 12:57:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:976c:1d6c:6ed0:8935? ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906231a00b0094f23a3c81bsm6603043eja.23.2023.04.19.12.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 12:57:53 -0700 (PDT)
Message-ID: <0978f227-1a6c-60c2-a537-98b8f2914a3b@linaro.org>
Date:   Wed, 19 Apr 2023 21:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: amlogic: add Xiaomi Mi box 3
 binding
Content-Language: en-US
To:     Karl Chan <exkcmailist@inbox.lv>, linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Karl Chan <exxxxkc@getgoogleoff.me>
References: <20230418145515.19547-1-exkcmailist@inbox.lv>
 <20230418145515.19547-2-exkcmailist@inbox.lv>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418145515.19547-2-exkcmailist@inbox.lv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 16:55, Karl Chan wrote:
> From: "Karl Chan"  <exkcmailist@inbox.lv>
> 
> Add the board binding for the Xiaomi Mi box 3 Android Set-Top Box device.
> 
> Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>

Your SoB does not match From. You have been told last time to which you
did not respond, not fix it.

NAK.

Best regards,
Krzysztof

