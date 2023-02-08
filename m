Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA3E68F63C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBHR5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjBHR5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:57:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8524FC33
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:57:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o36so13913352wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIbh91yDi3hjRSK7EFgWT8DXPfU5NF3sKbYrP5BUi94=;
        b=dCopafmxD7OpCvsat1jY+V1MqgKO1ql0h/53QmoG71/cdD946DJ9co+DwFNWTOJR9U
         FWNaGvHCnYkCLTWEPRqQUMPlOWXl2b0PnyQiJnyYwc9H5EYOErZrd7vKBGgNNIAfGl0+
         rmZnvz1zUXttPEYTRahBL0uvBqus+vZ96RkiE5erVsdxVoMWG/1CWUxvkmaix1NkMs54
         7Njd2GKZckFjlrjDen4MQUmvO+q8m7q05LXkRAd0a69LVibnsw4Q8+4SdLig8G6NWaCl
         ZeL9ogJ/GnSZjn2bvQiZdIGGdtB/XFclNiH/JRgCPuL+G3zDZuG60oqZok4spnNT+Hnm
         Ghwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIbh91yDi3hjRSK7EFgWT8DXPfU5NF3sKbYrP5BUi94=;
        b=zDDnasTo+eNGubx7YuocqQ36blM6sY5/gWzxxmsHDgVlUOoUn+pbiI/jrGDwNAzhqL
         Kry/ZeR1SdMRs5cTTTHp4b6lxWFt0iTZ5yGOXyFaz1xGMy2wgdd4QP/L5X9HYoY+Qg4e
         1gNrtGgs/Zh6YDjXQNh3T9dmwMBg4mbGbcnFG61gne/fA5plcqXKlgDlP+f56uvwwc7q
         HH2JT8qWQJJp983Y457EezvGROWNTp0N/4MT08hJZmytRe1eKJNVLb5jPK5XhLFltXGB
         D8WpayilBKJqxLudpLpjEt5K96srT7rSIQfEUkb/+ZkQf92KTudg18xCl7p/sfx0ZFAk
         zLoA==
X-Gm-Message-State: AO0yUKVN1RUfIcO6daL2Kbo/Et8Bzkz2BhspKqZUslmOj1+MHVkOf+4I
        3OtDR4n3kZQpFounknKA2IOYiw==
X-Google-Smtp-Source: AK7set/agXvUr8o1RIcasdIWPQxgRIVGIS6wQ4uZ6pkHa3ZW0neyWPF4V2VmwO8dkPy+UxxjygeJ4A==
X-Received: by 2002:a05:600c:491c:b0:3dc:1687:9ba2 with SMTP id f28-20020a05600c491c00b003dc16879ba2mr7082656wmp.35.1675879029806;
        Wed, 08 Feb 2023 09:57:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003dc1d668866sm2519023wmc.10.2023.02.08.09.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 09:57:09 -0800 (PST)
Message-ID: <313a6c91-e4d1-98da-9c77-fdafa66c0744@linaro.org>
Date:   Wed, 8 Feb 2023 18:57:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8994: Convert to dtschema
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230208172552.404324-1-krzysztof.kozlowski@linaro.org>
 <Y+PeR4EFfcVDbUfV@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y+PeR4EFfcVDbUfV@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 18:39, Mark Brown wrote:
> On Wed, Feb 08, 2023 at 06:25:52PM +0100, Krzysztof Kozlowski wrote:
>> Convert the Wolfson WM1811/WM8994/WM8958 audio codecs bindings to DT
>> schema.
> 
>> Changes against original binding:
>> 1. Add missing LDO1VDD-supply for WM1811.
> 
> Both LDOs are present on all variants.

I see LDO2VDD on WM8994 but not on WM1811 and WM8958.

Best regards,
Krzysztof

