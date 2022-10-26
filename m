Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBC60E3C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiJZOwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiJZOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:52:12 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD1BBF25
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:52:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id x26so771262qki.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFsg3VaRlU5pxW1lEeoGciN3HKmsr7ycQpb1StDHLVw=;
        b=MzkwyRDaO5uwuyV/+Bp4E+fFxXDr4H7nfO6+Ud+q4PAz7gED00dODWJLXSB9bRUwse
         oYB/seLhzgYTA5/wyVjpPRTESprDJbZjPTO8ku75xXfW9nWe7keVEmNDGbWLawoGLryd
         VzpB1NCGlEu/gR7OO1A3q30qqFY8rg72mTIA7pNVUaUr+lUUK/UlZcpusg3gWXGcXziP
         LSWZJFjQdILda4SkKdrF/90vwuTYoZUoScqGMTZu9RXdxA2ZPlYzR2CK4k8/tMpoAY4q
         9BajPohCBtDejb1fU8E3DD48mTrxF2ad0vHHVnxclgsMf4Q/SUaY4nNEZ5epceO6Dks9
         1W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFsg3VaRlU5pxW1lEeoGciN3HKmsr7ycQpb1StDHLVw=;
        b=xxRTJEKUkzQ3BzJQ79UqrqILoqBx916lH2TsahXcUA+0wrE2dO4gii4lKeKqBpnM8A
         n0B9Lw+0QgDnUSzUhQc8Luce5T01gyq9EOLoI+o1ZtSVtVHwIw7YGI0i6dMaALKJJmCV
         3Xs2OCOjVF7jnZzGRFk4kWGtvQZJUGTLbvtYYipJEze1vSjYBrx5/jzRZzGYwqnhgR9K
         W4vdhm00L6tLixoaJFzLo23DdhdSTcq9GTikVof7GoNrnm/7dqBYSI+hHgvocNLeXD98
         vm4YDlz6C6TFqLiXTWhgLnzfnUQk600R4RXwg0rsmHHMRXfK+xyOXD1CfCHhbzOiXIsa
         NyKA==
X-Gm-Message-State: ACrzQf3S4yAojINDRAQAmoP09aTok+kOLOYXFkHx1MEla57IMHW4eNE+
        0c4kuI1qXeiOmVEwl4wVjcyWQEt1KiC1/w==
X-Google-Smtp-Source: AMsMyM43VlfW1crv7c4yz+ryVkPmd6YzMvdZxoS70WyqIwWL8Ks7MzDBd2DCfQtH33HOzeOZ/FPsmg==
X-Received: by 2002:a05:620a:4081:b0:6ee:80ab:25b6 with SMTP id f1-20020a05620a408100b006ee80ab25b6mr31494872qko.517.1666795930463;
        Wed, 26 Oct 2022 07:52:10 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w25-20020a05622a191900b0035bafecff78sm638447qtc.74.2022.10.26.07.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:52:09 -0700 (PDT)
Message-ID: <94b3dda4-5674-8166-f3aa-f3d943e44581@linaro.org>
Date:   Wed, 26 Oct 2022 10:52:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/4] ASoC: dt-bindings: rockchip: i2s-tdm: Add RK3588
 compatible
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221025124132.399729-1-frattaroli.nicolas@gmail.com>
 <20221025124132.399729-4-frattaroli.nicolas@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025124132.399729-4-frattaroli.nicolas@gmail.com>
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

On 25/10/2022 08:41, Nicolas Frattaroli wrote:
> This adds the compatible string for the RK3588 SoC.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

