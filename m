Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B435FC6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJLNjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJLNja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:39:30 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5C5CF86F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:39:29 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i12so10906812qvs.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2VehAd5gLQUv4UjE5b9cSzsj4fTXuuHSx3swmWmJNA=;
        b=fJWiIY/JGjWLeyzCpk4oWFV/lIWxyXQPkMhfz1zbPFlyE6tFO2nq7Kh2ZLTite/2Fq
         i37gD2sMeQf66PxslJOZTHoz0pd+5TPQRpCB/YjIsBqf8cUr9142k+H2wRXZVLjzkVll
         mKVoA56GC0ONVs+SEd60uCznFZViPHRLiNmtFe7y9wGkvH6n8AFfIBqMoC3glbCOCazJ
         DHN3gCERAIHdL6tsNdIxekmr8I2ouzrz3LCBF+sbyN8SIsOx9DesBtUtXIKpBt/ZONtf
         Lr3YUyJITtBSPVuEDD2e2m/EJryMTX/Nb6qUE2buNe2orPmJFZR6J04nwYBulMkiXYOW
         xKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2VehAd5gLQUv4UjE5b9cSzsj4fTXuuHSx3swmWmJNA=;
        b=dqGS5kbfc0+M7BFe1TAN1yRnE/cXR0GPcjI1CjnmasyI0qrSTdD433Jae/sxFDeyFa
         bI2rVdYOyNO+2noE7xaN+K1eFkPFXtMlAnRA/+TaVsn6DKrd9ptw4Mx8CkkeMFMRJkWN
         mjPHBpwpRLff4asGFHYp2v93JjleDRRxlP0KjBMuHvHoWS0gNbQ6eNwwLfIc7W8laDyx
         +l8FvJDOP/KekUsJFe6IMI9OgqsTGMjlnNgDSObPFYsAEPE0Fj04RuxDSVIf7kJ+D6b0
         EFmzRx6KxQLWlrZgTTNR6PuhzsoRb1UH8Jea/i0K5gNLhHSfmX/P/iVyT4xzh8v4n0v1
         lxJQ==
X-Gm-Message-State: ACrzQf0z7YXROsm7fyIBY6zvWi99zwQLqU+RhADTle8FfGo0yn/cn1PU
        Bpujt8LQLZEaqY59jEa92YCbfg==
X-Google-Smtp-Source: AMsMyM4N7b9QcbpBeYehJ7xsQquGCxt6+7p6LALgbmSOwHp2iV6KBJYnmV/JNuTlYeNrwCM7dsFYEQ==
X-Received: by 2002:ad4:5d61:0:b0:4b4:4f2:3099 with SMTP id fn1-20020ad45d61000000b004b404f23099mr12911230qvb.77.1665581968459;
        Wed, 12 Oct 2022 06:39:28 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id d12-20020ac800cc000000b0039cbbcc7da8sm1916600qtg.7.2022.10.12.06.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:39:27 -0700 (PDT)
Message-ID: <76415dd7-aa74-7bf7-1952-dd1c847a5b57@linaro.org>
Date:   Wed, 12 Oct 2022 09:39:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 06/11] dt-bindings: thermal: k3-j72xx: conditionally
 require efuse reg range
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20221011231727.8090-1-bb@ti.com>
 <20221011231727.8090-7-bb@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011231727.8090-7-bb@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 19:17, Bryan Brattlof wrote:

> +then:
> +  properties:
> +    reg:
> +      items:
> +        - description: VTM cfg1 register space
> +        - description: VTM cfg2 register space
> +        - description: |
> +            A software trimming method must be applied to some Jacinto
> +            devices to function properly. This eFuse region provides
> +            the information needed for these SoCs to report
> +            temperatures accurately.
> +else:
> +  properties:
> +    reg:
> +      items:
> +        - description: VTM cfg1 register space
> +        - description: VTM cfg2 register space
> +

BTW, you have additionalProperties:false, so how you coded it won't
work. Test your bindings before sending.

Best regards,
Krzysztof

