Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA205BEA09
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiITPWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiITPWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:22:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E711E61B2B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:22:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so4462681lfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hSS8hZshzPQM7bKXdGBe15EwLhR6arnq8mg1ZOh26co=;
        b=HqKMxcrjmQgvmBArxWLXMov4qsLoUjEmo+F5NlCCQpXfs4nK+kxMzmVfrQSi22nvzP
         wkKoGTtYnbCUy/NJGbZ8Mb7JJTNOuWqVPPma2C8MVChh7RTLUd5HjrcQeU2zIgG+h5hk
         K2fUec4NKM5tZ/LmljUtpo7vOz2X74Kefa6LPgKLypyhGeZIKtdN3ONg8xBzxYYHzEJh
         jRjQwNPrmdl/FjiaNyLeMTJW8UB1qo7Al/CnKwI+HJTMKcDqVyxNCGOkZz0IbRKmKuUy
         LSmkg8TFIxYzM2nMfr146z6MSyn62+nYqPa189CtmUSQ3w3tErukj1tBu6LdUHrbpu9l
         HxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hSS8hZshzPQM7bKXdGBe15EwLhR6arnq8mg1ZOh26co=;
        b=NsAQh0EEZOwcYUCX+WwILWp+2Z/c3PyPL5RqB68R0IFVX57dYAQI6moLm/GkuMuY6q
         LcY5uikIdc/yleqOFfP2kNTYeRr/ght8mVAfZIwjRCgReYLSK8gkYtK+N1a8z/y4xXIa
         7ShGftmIoP/V1URjN8OSrjrtiXTKL7WC2AnaWdxzaoIR2+BJhWmliUhwHCNDPskeeu04
         FGk+iXnbs4WXZSX+oew3T6ZDRI8/yg15VBsPtBF9LqbXXBDEAbqZc5s/Gw2pjmWbrKr9
         bxGsLtoQbXcGqXu2kQ1GXMyDTweKySPOvhNNZmqTiPSnyJjwxXjU6CD5j9TZ8eBRZAj8
         h/4g==
X-Gm-Message-State: ACrzQf3aYrcmDLx56TUutYCdpASx7P5o7kibcwqS2ibS7soMvD4NbymG
        S0HNTe0X7LXEXP9DLty6U+0Avg==
X-Google-Smtp-Source: AMsMyM5zX2QPmcPmITCvmQPq4MBVkTkHJ2/ihJzeJd1GKB6ewnD6ddxAj9mA/GIDchxb+d+XTZW8rg==
X-Received: by 2002:a05:6512:2987:b0:496:ae22:9147 with SMTP id du7-20020a056512298700b00496ae229147mr8137432lfb.97.1663687323270;
        Tue, 20 Sep 2022 08:22:03 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y29-20020a19641d000000b0048b1b2233ddsm9789lfb.120.2022.09.20.08.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:22:02 -0700 (PDT)
Message-ID: <27cc7d38-cb7c-9a36-972c-49326a54ca57@linaro.org>
Date:   Tue, 20 Sep 2022 17:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: sound: ti,ts3a227e: convert to yaml
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
Cc:     kernel@axis.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Astrid Rost <astridr@axis.com>,
        devicetree@vger.kernel.org
References: <20220919111258.3774-1-astrid.rost@axis.com>
 <20220919111258.3774-2-astrid.rost@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919111258.3774-2-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 13:12, Astrid Rost wrote:
> Convert from ts3a227e.txt to yaml.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
