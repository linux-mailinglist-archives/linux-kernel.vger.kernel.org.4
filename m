Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B895BBD30
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiIRJ44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIRJ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:56:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4C82B243
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:53:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i26so42284039lfp.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QDWJzJ5lOaQpmmHjTfXtnrSgkhZoBRswnPcVPm00MkA=;
        b=KbFOyRvQj0ncFWAI//huMSQy3AYbmIwXMzjUXhQ+9/suNPuG65Ztv+nihSdZtzKMGk
         IQ54DNEe4uVVL6aADC0zr3+Pt/mDK0s6OFpmTjcHYuCUil8Gb1GdDQpZ8Ddam2KoopX7
         9IejLqPh4M1FsmETpKvkrO3C2fBOuy9GZ6oFJ236F3gcManACpaKt4xlBJOMv59c2lLi
         /zORYq7VSe0KrUkmxYsVwdDOcVlpLZNuDLJosyg+ajuLWMSLAnfjvorkC+btwzBCQa+Z
         kWXXPxQngcDpAUd/GaEt3+FSO7PL7m0cRdxE8oY8uK+6ul+4sIRQ2rGjZjh+Xp7pDz5I
         sPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QDWJzJ5lOaQpmmHjTfXtnrSgkhZoBRswnPcVPm00MkA=;
        b=VLhJbvjs+dturF9KTBk344zjAAWdyexvYPMz0cerGgHKiY6kgipF0SPbfo7DG2aGiN
         c6zR1+1eLIVXUSbqqT0tBD8rTRI9o2BkExtkDm+Vgae4xDUZkdtOw77e/HX8NHUx+PcR
         EeDsrIEXbdLGWJzw1TLVyERlBKOevBPY4WZaeE9/WCttFL+tgxylBNr7EtEgcMFKgQF2
         i9jSAUoZ4EWhX22lp5hzwS295hqwooDYazy1fqtn5FSp8h7+LGotaW7A6HWT1Yb2aMPk
         v5rYJzOryyt8C7OSyOQiKlHWTYIA+1X/XLfXHTnUKrtVUr4V3kFXrgwLdc8yi0S+yYa9
         OPcw==
X-Gm-Message-State: ACrzQf0a4cMY+K9sPduXIVxxrWmiLne+yqcWsr3QfmsAUUwd0uTZKtWA
        JfkGjOlzLGWSZFB8AvVA8auURA==
X-Google-Smtp-Source: AMsMyM7c07FRjcZpKxTq1oEq3imUr70ESSilmyj+j19JPwmumypPu6CuZ1jOc7lYzYyjNHtpCQoPtg==
X-Received: by 2002:a05:6512:2308:b0:497:a290:cef6 with SMTP id o8-20020a056512230800b00497a290cef6mr4563377lfu.488.1663494717767;
        Sun, 18 Sep 2022 02:51:57 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be32-20020a05651c172000b00261b175f9c4sm4461189ljb.37.2022.09.18.02.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:51:57 -0700 (PDT)
Message-ID: <cb86f0e0-700f-872a-1e58-9111a96ec5b8@linaro.org>
Date:   Sun, 18 Sep 2022 10:51:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/3] dt-bindings: sound: ts3a227e: add control of
 debounce times
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dylan Reid <dgreid@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@axis.c, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Astrid Rost <astridr@axis.com>,
        devicetree@vger.kernel.org
References: <20220915113955.22521-1-astrid.rost@axis.com>
 <20220915113955.22521-3-astrid.rost@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220915113955.22521-3-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 12:39, Astrid Rost wrote:
> Add devicetree parameters to control the insertion, release and press
> debounce times.
> 

Thank you for your patch. There is something to discuss/improve.

> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  .../devicetree/bindings/sound/ts3a227e.yaml   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ts3a227e.yaml
> index 3512b1f1e32b..8c27f298733a 100644
> --- a/Documentation/devicetree/bindings/sound/ts3a227e.yaml
> +++ b/Documentation/devicetree/bindings/sound/ts3a227e.yaml
> @@ -44,6 +44,35 @@ properties:
>        - 7 # 2.8 V
>      default: 2
>  
> +  ti,debounce-release-ms:
> +    description: key release debounce time in ms (datasheet section 9.6.7).
> +    enum:
> +      - 0  #  0 ms (0)
> +      - 20 # 20 ms (1)

Skip comments. The values are in ms, so they are not helping.

Same in all other places.

> +    default: 20

Except that looks ok, thanks for the changes. Appreciated!


Best regards,
Krzysztof
