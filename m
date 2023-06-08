Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C2872814C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjFHNYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFHNYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:24:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F020210C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:24:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977cf86aae5so100311666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 06:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686230649; x=1688822649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9Yk2OboE4KOOjDxWPjnmeKvEIXr2uCqK9TWX1mzSS4=;
        b=yVOpePdYvp2oKWGszjgfNkpPNlXfFQ96SAqoKeJ34PTPaZgP5pn4tdM9MigO17+jsN
         fNwRNPTOx3L9Lx5LJ2hL89UavLvg7Zq4RSkFRJES1WT/TNjmsFnvBbwYPsrgMffdzgNl
         za5uvwimrwdzRicGmR0l529Ew0I3p0SxItFzf0UlpxkCXAspF8D0t/8+wpt8qPqzXRS6
         6vsWJZ4bUfRjZow15EcChB0KFpswQJT2R4BaB0zPdyBmquUnlAuwRaacDc5HFDiQxvwH
         W4XmHCiiM9IT3Qoc34FaQwf3XH2iffC3k+2T0G2QAfz5keeDxtmu/BgrvZ9ZCncZvI3D
         Yzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686230649; x=1688822649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9Yk2OboE4KOOjDxWPjnmeKvEIXr2uCqK9TWX1mzSS4=;
        b=A2v7p/LtbhXO/ZJpM+ZdwFJa/TsCjUE5g1tC4DaZt2/1HSsWoyTdt+Va9IO2Iw0z8X
         tVbTC8ON8XMSYVsVdYiZ1HPTywfqCjADlOWYRyRr+3L6ayt6shddCIPGuCwZum7AZSiQ
         qrVPZ0DWpkA92LS7jaKoIg+7//bnihDhauc5FRrcyDJKvb1btlpGIvlYekLouM8nt1Ow
         TnIkrNtwIWcGOCgVfTvdGuYloitDJ49t7wmu0lKNmUzfh0OGoGJx9YqA4CHuXz3U7r5z
         8zbxW5LhJGeN83P96ERtTTFUITYexETiscdxg+oivgoZ1PKSkH8S67WOhvS3XL/q8b7r
         8IZw==
X-Gm-Message-State: AC+VfDwTvXvsEl+BSetYKQespEPE+KwEbzs4UEGaE9+cTPlgBqv3RQ+E
        /NLNt81o7euAgTmeliGa7yxg1g==
X-Google-Smtp-Source: ACHHUZ6BgqYNNaZ4dGOLWZa98lCbG2t9XjPm5yXqX+ciiwVYZjuibcuzhFFGNHfqnh+AtY7cyjU/8Q==
X-Received: by 2002:a17:906:730c:b0:94f:956:b3f7 with SMTP id di12-20020a170906730c00b0094f0956b3f7mr9332394ejc.2.1686230649577;
        Thu, 08 Jun 2023 06:24:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u3-20020aa7d543000000b00514bddcb87csm560700edr.31.2023.06.08.06.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 06:24:09 -0700 (PDT)
Message-ID: <010e4dca-c2eb-25b5-77e5-d4869727b5af@linaro.org>
Date:   Thu, 8 Jun 2023 15:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 3/8] dt-bindings: gpio: pca9570: add gpio-line-names
 property
To:     andy.shevchenko@gmail.com,
        =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sungbo Eo <mans0n@gorani.run>, kernel@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
 <20230607115508.2964574-3-l.goehrs@pengutronix.de>
 <ZICyGY4OSyM1i6ia@surfacebook>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZICyGY4OSyM1i6ia@surfacebook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 18:36, andy.shevchenko@gmail.com wrote:
> Wed, Jun 07, 2023 at 01:55:02PM +0200, Leonard Göhrs kirjoitti:
>> This patch allows giving each of the controller's pins a meaningful
>> name.
> 
> Isn't it gpio.txt already mentiones this?

TXT does not matter for DT schema. It's is already covered by dtschemas.

> Perhaps you need to convert that to YAML and use it here?

How would it solve anything? We still want constraints, right?

Best regards,
Krzysztof

