Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3033B71791D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjEaHzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjEaHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:55:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B953A19B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:54:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5149e65c244so4483068a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685519640; x=1688111640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=suMN4n1BQ2Z7VU4EicsbwuyOBR1pEV+6Sounu4iuM0U=;
        b=A+dncCJbXSV6kSVPSolkbyxdvYQgh78/2P6Mxm5SwqhtgIwtPGJcWPOCn2HHPS8CZU
         5Wm6uBWJvU48wgmG5ogwKoX1rNY5Z4RvNjhYSfdKVup3NWmYut1ny6EzBC/0KBEdFYZG
         xojVvnM2ROqLlEAcS9yaN4/6x6eWoBszGXQOpJIHAvRGhkMWrxnPPLFGhWYVSsSGeEN9
         2H039xpBhxvO9MhPMs3niA9LdSl3yS9GN3cvnO02PehmLZyf7Z3iF22kZ2fJ0LQ6a+6r
         o7q7EgJVKnuR6VScDRFC0YASfU8S/WZdZZm5f5DystD06dKFWoX6h19/bkbktB7qdXFQ
         NluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519640; x=1688111640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suMN4n1BQ2Z7VU4EicsbwuyOBR1pEV+6Sounu4iuM0U=;
        b=LV342/0l01ZlisjoGFagfEloqvv4HPIIPbq2werYQ0oj4AtlQYKIL4m6HIksRR2PaF
         3ih5vExZ8c9fZa/nPVnW09BXw44hBDr0jvYhYGkSwEIgyP7+LfsA0kH9ugLRiYxAUtRx
         DCST+E95j1wxRGcUTmM1iqx+Rjactg0Usb10Jv21gBSPBaaQDg+dMwK2096KCwuC5hH/
         6ZE4Pp/kL9S9X40npFu4bJGFcUObElffKAPv2wxVb554zqsYzrRsH+0MKRwhCdylpDbX
         RT+tMHqVh/ivD1+UZo/seZTnwT+mPxNsONkRVEyFejUVtGf5NZi3wD3ylMOxR2WQJ/6U
         VVgA==
X-Gm-Message-State: AC+VfDwyjuHvEheKG6UMTSYSEkT/etBN/jF8LpnqTnooYM1H1RSD7fFR
        Jo0YGo4/eveOqG72mRSgYJGqyQ==
X-Google-Smtp-Source: ACHHUZ7i7M8zh8gh6sQ1ZK5S6VAQvpJeaDVE/ihPO9ya44BVZ1jGFqvdF+9ycji5LoT7N7p0i74PDw==
X-Received: by 2002:a17:907:d8a:b0:973:d1ce:dbe8 with SMTP id go10-20020a1709070d8a00b00973d1cedbe8mr5163876ejc.46.1685519640052;
        Wed, 31 May 2023 00:54:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b0096f8bb60c96sm8511314ejb.100.2023.05.31.00.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:53:59 -0700 (PDT)
Message-ID: <ecb3728a-575c-942e-ffcb-659f218e0b01@linaro.org>
Date:   Wed, 31 May 2023 09:53:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: thermal: mediatek: Move auxdac binding
 to yaml
To:     Conor Dooley <conor@kernel.org>, matthias.bgg@kernel.org
Cc:     rafael@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20230530150413.12918-1-matthias.bgg@kernel.org>
 <20230530-thaw-unpaved-a1708d46eb5a@spud>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530-thaw-unpaved-a1708d46eb5a@spud>
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

On 31/05/2023 00:02, Conor Dooley wrote:
> Hey Matthias,
> 
> On Tue, May 30, 2023 at 05:04:12PM +0200, matthias.bgg@kernel.org wrote:
> 
>> +  The MediaTek thermal controller measures the on-SoC temperatures.
>> +  This device does not have its own ADC, instead it directly controls
>> +  the AUXADC via AHB bus accesses. For this reason this device needs
>> +  phandles to the AUXADC. Also it controls a mux in the apmixedsys
>> +  register space via AHB bus accesses, so a phandle to the APMIXEDSYS
>> +  is also needed.
> 
> That double "also" bothers my OCD greatly, but it is a faithful
> conversion.
> 
>> +  "#thermal-sensor-cells":
>> +    const: 1
> 
>> -- #thermal-sensor-cells : Should be 0. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
> 
> How come this has changed? I didn't see an explanation for it in either
> of the patches.

Yep. Please mention the deviations from pure conversion and if not
obvious - justify them.

Best regards,
Krzysztof

