Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38A05BEA0B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiITPWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiITPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:22:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6367C5FAC7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:22:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so4464641lfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rLmosHOkteJetUfMH1iOxaM6TfQV6pI0UvsDV0r2AOY=;
        b=dryOEWp1Y7+Mku+Pejx7aLr/rw7huzEYdezWS0xLztYGKxuuLQJw8FNfkIFjf2EgBQ
         6nD7gHKi87xl4KoJm2kWuXzfZSR4DgZUIh4qW9Gkg0UYqa0H6UA1Tou1NxcTThGa8H3l
         YtH5murKuzBrToHMVSbJ2ep4IQkL9AU1w0OcCSjdV3g+ohb/mCO3J0Nsa46KVxUDxGZJ
         tWgzc6qAxq8wJCUiy9ezPznPUvQUzlYBM1zkUiMqLQmZSMh30MQ2eekGVO5QPI/RTvzI
         XnoRaAH6b0OdB1Sej7DCsmBf4p7kfRFALt+mFKN3z8Fvo9vKp1kBEgENcWnKNHA5CHur
         SbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rLmosHOkteJetUfMH1iOxaM6TfQV6pI0UvsDV0r2AOY=;
        b=q4Jb7OP8iqxFeNU5sPeIEbay5kDlTse2/2eXLiS+65/DJ3X8y5uBIbcHLFyzm6hD7Y
         4tQR9mhibD5JMRU+JQMV9PSrFpuYsn1Fhsu6/aufqyEElfpE7572BJT8B+r/g9wag9Zv
         Nd92256E6ZCtWS5L09Ca23KQlD7/s3hGTh5/EqoTmf2Sj0GePnnua6yKy/wfTMM9M9Vp
         9kLAZH4NdaHsaLeEdTl9hw180EHQqVIrIAjcVXimY43ahV3I3AgUa5Mi1HvgQb4aspJn
         7QI/vkAgyLW2kYMpuA1WBwaXOY7aNJcfaPgVtec6iIcICgglui88h+Vnsb+iMw3dQscb
         4IAA==
X-Gm-Message-State: ACrzQf0j2CBoUIoDEi+HPi05yuOp39ojqw0jM7cDHEyFEb3hpUjlAK1F
        aKbId5YffaOMp+RYFlamQXLW1w==
X-Google-Smtp-Source: AMsMyM7CufcP7ESkPRKYW0kpVcKVublFAAxZwckLh16qjJbuGNV+C3YGWX7p770ab5ehifq/4G7sbA==
X-Received: by 2002:a05:6512:118a:b0:49a:d52d:d144 with SMTP id g10-20020a056512118a00b0049ad52dd144mr8892398lfr.239.1663687346754;
        Tue, 20 Sep 2022 08:22:26 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i1-20020a2e2201000000b0026c0158b87csm12644lji.29.2022.09.20.08.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:22:26 -0700 (PDT)
Message-ID: <79658ad6-fd1c-68aa-88e0-6ad5274bea9d@linaro.org>
Date:   Tue, 20 Sep 2022 17:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 2/3] dt-bindings: sound: ti,s3a227e: add control of
 debounce
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
 <20220919111258.3774-3-astrid.rost@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919111258.3774-3-astrid.rost@axis.com>
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
> Add devicetree parameters to control the insertion, release and press
> debounce times.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  .../bindings/sound/ti,ts3a227e.yaml           | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> index 327d204cf957..76ce323ce965 100644
> --- a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> +++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> @@ -41,6 +41,35 @@ properties:
>        - 7 # 2.8 V
>      default: 1
>  
> +  ti,debounce-release-ms:
> +    description: key release debounce time in ms (datasheet section 9.6.7).
> +    enum:
> +      - 0  #  0 ms
> +      - 20 # 20 ms

I don't see any improvements here.

Best regards,
Krzysztof
