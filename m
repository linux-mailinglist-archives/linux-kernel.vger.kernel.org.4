Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F5174D0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGJJFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGJJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:05:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814DCCA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:05:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e29ede885so5280802a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688979938; x=1691571938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6f35wz7ULD2fzoISW+Rel9CAwel/THAnRRoZsJ5VAJE=;
        b=osEFcrS6yMmtiB4L0rcZMhkjYnP3sYFhbjwb/iFCYWiL8fTx7epGPAWvTgPsj6veC3
         uDalYGGs2kIlCALsLkY2fvP861sZA3NVE9h0tB7HtdYZ6pEm0p0hZErCVfNwNqGH6Kke
         gHJagyaQv15rEIT7kbRhU8ripZb9EmNq3+NSVWoNarqI6Sd4O0Aqj8N/uYjr7uzrDOn/
         +43HRDV0kLkr595GCnBZQwT6tCHIuAn5HB/ZiuwmvPuLR1f2K0EDZGhY26cM8rDCzG4z
         1uRjAKF2aDndEPZM4Gz6N0iQwcdViHiC7vQ8q9cVXgHtWM7vBcqqf0VO6v1Y9idy1QUJ
         FyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979938; x=1691571938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6f35wz7ULD2fzoISW+Rel9CAwel/THAnRRoZsJ5VAJE=;
        b=Zngv4XFkiHQuC2sTOQIkzudG0shoWDVvldynjEXqeC8wDy2C4CpKANzSl4VmjW8Xru
         1okiI599lM2sBlCT51HFsy9sZ3pP/U5C1nJtsHMUyRoBE6JP867Sl97xeEpeGN3xk8ws
         xfXM/3ASh2UYrQ2wxEQqoMiqFxnhCtgQdeL7GZaE7b3lQvTMipIZkuoEi4J3/oTNaSGg
         C0gmNQUXivP1GBDdz8SrtqL8qG8c7Vg2hRHJxudBxMNgp7cLN+g5K/AoJFAM6mGWv2rY
         JjosmEzlFytDmFHgvQyT1W0jUUNeLJKdPi8q4epZkM9oq5lgyejZdQAvU3JPiDVoieu7
         sBbA==
X-Gm-Message-State: ABy/qLaWJBXI+Lr57mRRpluyFcgvK82oB0NdYE5/EV3UCChjmLoO7ZNg
        raxR5cmtPPtJNePgyXTP8S6+Iw==
X-Google-Smtp-Source: APBJJlGsVis1H9ajOgg28QMl1SfAXWa9COk2M8RS+/sUAYzS6M58HCjOmEdK8rfiX05YGKCIsIhVUQ==
X-Received: by 2002:aa7:d782:0:b0:51e:6a:b4ba with SMTP id s2-20020aa7d782000000b0051e006ab4bamr10032510edq.41.1688979938029;
        Mon, 10 Jul 2023 02:05:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l9-20020aa7c309000000b0051def9be785sm5470365edq.85.2023.07.10.02.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:05:36 -0700 (PDT)
Message-ID: <1e29715c-e501-3b1f-a21e-c39079804ae1@linaro.org>
Date:   Mon, 10 Jul 2023 11:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: ROHM BU27010 RGBC + flickering
 sensor
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1688723839.git.mazziesaccount@gmail.com>
 <7b2bb4647be8ff7c551d8efcbe160914bceee669.1688723839.git.mazziesaccount@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7b2bb4647be8ff7c551d8efcbe160914bceee669.1688723839.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 13:22, Matti Vaittinen wrote:
> The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
> IR and flickering detection) with five configurable channels. Red, green
> and flickering detection being always available and two out of the rest
> three (blue, clear, IR) can be selected to be simultaneously measured.
> Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
> and tablet PCs.
> 
> Add binding document for ROHM BU27010.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

