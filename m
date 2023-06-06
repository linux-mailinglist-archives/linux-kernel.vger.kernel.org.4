Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8D723BCF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbjFFIaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbjFFIaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:30:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4091BCA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:29:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5149e65c244so7710923a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686040153; x=1688632153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LtaPKemo+5OQRSz9khHIar6lem1SofUReVEc/bZpdI=;
        b=ZEKuMgBp6AJPtrL0Tm9hgqvNtzHoU32dtPmuXhrHJdBNlcxSc9aKYwvrGoTrXilUPB
         o+04zbiRVnpM36ZmlfoUxC2qYCBq+EDMAPZcKaTXshmpxVUwcDkZvRq2L+ukuwrQqSOM
         o+JPvikvrUVp7wDFKN/1YXKYg9n6PSTseLxAfhskQXEswlLuTJwpl7WnDyR7Uu/my4nt
         Apka2/YMTEIRXrDB/00lqYPfHLuIKiW0KQZQu2Q55B18RMhr3Mp4CxcFh+dbaeaN2fjc
         TUAIbYOlbeX4Zky1N70jXp4q3SlHc0hTwvms7BdfkU0X1inPIuJ2zIFBuD1W3y1Kdk2P
         p10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686040153; x=1688632153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LtaPKemo+5OQRSz9khHIar6lem1SofUReVEc/bZpdI=;
        b=ib6TQFcNs3y1tMRM5epmbOZlh/WHPxFEkN2q6DoJKor9EcE0EOZ0jC13tGL5A1S4Qz
         XUvZMaDeGmbzJ8uq25M73KY+CjOB+nlMI9mlKAfdK9AGyRKgvrx17uxxBhuwYCCujWN7
         F6JhC4AaBcpSLyRXLYj6SunKsOgkR0wK03h+4cp8JKHa2Rn/QmzkbHKzuF8JuPY5T73i
         iFBBxTsievgIMABsberdvw7974i049PFLyu1clxAUvEfDVPyMwN/nvOly+kXafI27E9z
         uUuJoewwZsTkzYtXpYLkX7wTQbBxjKO63JSH6kkcToU1owjKbXl1/pSJMsNSnUtCR7I7
         wuTA==
X-Gm-Message-State: AC+VfDyXyrAWRE7oLSPVqHue+E4PFfNP1vI4rAZuyVEs5fBXs46s+1n3
        62Y6KZ+JNxTCttV7UV/wijnSpQ==
X-Google-Smtp-Source: ACHHUZ7lf/7dv5R+xRDjcr3KbPkgc1lF+HB3EM0FuvBflp3BUXe3OXezvcL0lwCwAYmaJtfPQ9AqHw==
X-Received: by 2002:a17:907:a088:b0:96f:e5af:ac5f with SMTP id hu8-20020a170907a08800b0096fe5afac5fmr1617206ejc.47.1686040152809;
        Tue, 06 Jun 2023 01:29:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gr24-20020a170906e2d800b0096f5b48fe43sm5294629ejb.47.2023.06.06.01.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 01:29:12 -0700 (PDT)
Message-ID: <6fc74f24-9c6d-5582-5e3f-3d6f1b77ee45@linaro.org>
Date:   Tue, 6 Jun 2023 10:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] dt-bindings: nfc: nxp-nci: document pvdd-supply
To:     Raymond Hackley <raymondhackley@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230606071824.144990-1-raymondhackley@protonmail.com>
 <20230606072437.145052-1-raymondhackley@protonmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606072437.145052-1-raymondhackley@protonmail.com>
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

On 06/06/2023 09:25, Raymond Hackley wrote:
> PN547/553, QN310/330 chips on some devices require a pad supply voltage
> (PVDD). Otherwise, the NFC won't power up.
> 
> Document support for pad supply voltage pvdd-supply that is enabled by
> the nxp-nci driver so that the regulator gets enabled when needed.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

