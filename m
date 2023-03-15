Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133966BAA02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjCOHwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjCOHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:51:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4682364A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:51:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cy23so71806045edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d911BX05CiPkms8AKztZoQp6q7GS5syhqZ58jXzG8VE=;
        b=ZOMey7ZhXDYxrd6lgeXdkjCnUX0Xam3eF9j80XI2IE8e3FEzxvB6zLkFKz4qE0kLUl
         mJ+4Sn2A1b6wmIXVS61RepqHwS8ZIr2iLW96gqt89Z4wFiylSSOYYDOuRdloaptLqQZE
         t5VHemA7dW9Qq4X5d13Yd8NQ2SkxIjYlxWgMAF1bE0Rhievdnrt5J9ALMtSo65L5r4Z0
         kWeAr8T71uEaD5WwNLTk8ArZ3aiMWCOHJkxlHOdb2UQMOLxt2CAbrZ+Qxszl5Zy+/Hgj
         tvAAswePut3Mbr6HmtPT8Q2hCRCSFNlueFzhSAFd33p7vfHFkSwrkUosXXkfatxlzCJX
         lYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d911BX05CiPkms8AKztZoQp6q7GS5syhqZ58jXzG8VE=;
        b=seItCGDP1EK+PrlHza9UQ+WnYVtm1mq3i15mFikz1b4ujhTD69R58TLYMzVBUgpU4/
         DuhBWeLNPEtlQPpaccu93FCNBFYooP9qnsaxn7QgmgTJDzb3f7rgQS1FMMgQIIBvhKl4
         1BeM3BrVqs7lhwGOLQ89XM8arUKPKzvSJsYKwm6+1n8PRd4ruWickX2ZfLS4CsdY75+t
         j6Ro/emGOGcBPaZzl6uOXuKnpVPKVQGbyzOVWaHBFe/dVBlWPQ8KrsVhaSKuZAlaqsjd
         ghMutnKUj5JWY8HYfC1tRdxGAcnXEUQTq5AlC2qDtHrjZdutLtX5UTCicmOBRE+v519M
         NXiw==
X-Gm-Message-State: AO0yUKUep54EyeARUslAvN8oWsXD14Cu3eXsnGpDVckqL1GygHEJQjjj
        6Dx48fDymp2TwF/XVkeF14hx4Q==
X-Google-Smtp-Source: AK7set9EccNsOU9Upy9ZTTa9EUYd+AKvXz7iJKuDZ8Q/NNbXPcskakPQHUFzolc0AD1cp5Jh0j+hjQ==
X-Received: by 2002:a50:fa93:0:b0:500:2a9d:1870 with SMTP id w19-20020a50fa93000000b005002a9d1870mr989231edr.13.1678866675656;
        Wed, 15 Mar 2023 00:51:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id q11-20020a5085cb000000b004bd6e3ed196sm1933242edh.86.2023.03.15.00.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:51:15 -0700 (PDT)
Message-ID: <a6d8d360-f379-1382-7700-7bb04de6d9a0@linaro.org>
Date:   Wed, 15 Mar 2023 08:51:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 7/7] dt-bindings: display: add panel-timing property to
 sitronix,st7789v
Content-Language: en-US
To:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230314115644.3775169-1-gerald.loacker@wolfvision.net>
 <20230314115644.3775169-8-gerald.loacker@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314115644.3775169-8-gerald.loacker@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 12:56, Gerald Loacker wrote:
> The sitronix-st7789v driver now considers the panel-timing property.
> Add the property to the documentation.
> 
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

