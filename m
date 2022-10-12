Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECB25FC602
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJLNK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJLNKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:10:51 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B87C30E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:10:45 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o2so3172070qkk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7G2Yq+rJ1ZhtKUz9+hk3hjumuAmKCtJeLM6FaHLR48=;
        b=EBBu9Jumc1NjlI14sXDx18bN/BhlEoRIemgjAThwEMFR4FDMdr837XPmF153c97kiv
         KgcAuD/nM2Euj12kgMiaOXwAOTRq++/xwzxIHQmpe6xRr1dqHJ9MqCeA0wdscFQgL02T
         CF1Hk19v2NS1ExOdWA0ZFZYbLAmAIWU+Xr5GoCiIpHRVVNzhVvWjKtRJH29P+eGXrADl
         6nbKtAfmckcRubnodOptTE8/cnKXnI8/6vjIoMXu3UUADv+mF4+YcqeTq3/VO7ndRtX1
         hOhdAW3sgs2C1nkaSDXIr6P4rIAH1T94fuJJEAZ3zc7ZiMBzfB3S499/GZOz10ZE7NX6
         cigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7G2Yq+rJ1ZhtKUz9+hk3hjumuAmKCtJeLM6FaHLR48=;
        b=bgHgUQJJLT36sm469xcK1Ht5NDzs4Lw+LpvLIXreTg/P8MSg86XREr9c6aKWXc8RV+
         45ZPPOeyRed7IU7d+iraf4UOxHTECTB+1g0flME4p4cRd5277VqdPV3lSGbl3vE5zdql
         iS8VgMQWzD468Ydqg1aRAULqNpubAVGv7jPZJ39JFGzLWBoN3ueZwABP4hzShLYutjr6
         Yfz0XYF8szx0vL82no//vdAkgfoQsLvJLHSkADHBHpc0dGSj7zyXPL0+Wln93zcueSY6
         2vDXobK5yDc17SyLhzg6ygNKq/CCsg7mQ7eYOkfVC1I2Cyq8M6G94k6Y+O/Bp8zChCCi
         zA5w==
X-Gm-Message-State: ACrzQf3NgQV5DXbgL1hHgIPWQqPI72qWMEdR0HsLQDKUq6wKmjca3QsH
        hpduPJkskP1yQ3K9haxd1PDYSw==
X-Google-Smtp-Source: AMsMyM47s2HEd/ei/G/HHcLx+xnZuL6fbjDhrLQjxBM2msx4b/k/ATJETtbWtIuy6tjp4xspUJ11Ug==
X-Received: by 2002:a37:2e84:0:b0:6cf:8dd4:7adc with SMTP id u126-20020a372e84000000b006cf8dd47adcmr20148712qkh.723.1665580244143;
        Wed, 12 Oct 2022 06:10:44 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id br7-20020a05620a460700b006e9b3096482sm13642940qkb.64.2022.10.12.06.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:10:43 -0700 (PDT)
Message-ID: <4e5ed6bf-8af1-d8b9-b89a-e9207a6ea756@linaro.org>
Date:   Wed, 12 Oct 2022 09:08:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 03/10] dt-bindings: usb: sunxi-musb: add F1C100s MUSB
 compatible string
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
References: <20221012055602.1544944-1-uwu@icenowy.me>
 <20221012055602.1544944-4-uwu@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221012055602.1544944-4-uwu@icenowy.me>
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

On 12/10/2022 01:55, Icenowy Zheng wrote:
> Allwinner F1C100s has a hybrid MUSB controller between the A10 one and
> the A33 one.
> 
> Add a compatible string for it.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

