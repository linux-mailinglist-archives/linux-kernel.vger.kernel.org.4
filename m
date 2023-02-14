Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D891A696201
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjBNLJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjBNLIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:08:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E9029141
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:07:45 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id by3so13898049wrb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njivcugErf0QzOhhAeetK3MceHXQ4vnJzSNJVLtasTM=;
        b=Z9CiI+lfEedqoDYICCi8f2sGc7JqYmUeRTZLKQpphLSFlk4QgBKj9Y5F2gLqJQormY
         Svyqf8+eBuNcyp26aEjM3fWDSPk47MKifB2N1KLxMZ3hzYy3kajluT7Tt5oTHJrrh+Jx
         tfTwqYG5h1hMTpZRvnLIFD/sXlOYy/yrXLCDalzQqi/pn/XPOCgGEUL4Plmlw5RZNxl9
         pmIEZQuTUFz4PsrZnjX7HvTO4QJrNVtD33Y/QIo51/swXOoommsCe4nIBmcnmumUUaKJ
         oZyfhxkiM1wol/FVHEAnSAbOeLPvXVQ/DHoWTA+Rne98p5GZ72NdoRuBuMk1odduXXKp
         4Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njivcugErf0QzOhhAeetK3MceHXQ4vnJzSNJVLtasTM=;
        b=f6c8KpYdh/gZpQqaBaak5PN3znv5j9cVYHyu8o7plDT1yHMi+ajqVGU54jf4lyFuaE
         aOsckQfINnmvHUb1W1OAtFNiOIob/1SeegUrvq/Cp0/0i96EYwjOInMC2r59HZg8hNPt
         0HfylnW+IRYgz/xSDGkyalKQuzVm8biGRrPGYm3hUAtzqcgaHbfjn4tYG8zJaglqIYPY
         ++/towkjzeWWmQYamYRqHkLB1zqsiAc9ZP7uYz7d84o+/LOWPERfft+cmzCq/BySslS6
         KVje891lVzhvHUR0R+uAaWiVuXBzGHYE1cCYi96HfP5kuVBbWTOLAkY4EJrxAQlK1m3j
         90AQ==
X-Gm-Message-State: AO0yUKUmpu34CjJoA6PuE2EZcNm78Qe+2/ygz/K45MXlWDohkpONl+CY
        u0CAYJoJMLNO+xQ7C6Tkox6pLw==
X-Google-Smtp-Source: AK7set8bi4viGxq7fat55u+ZQGFq+NYv+AijYmbC8wKc0FxIjRBi8GSY6NZMgb28RP/9J6BzH+gHOw==
X-Received: by 2002:adf:f6c6:0:b0:2c5:54fd:2655 with SMTP id y6-20020adff6c6000000b002c554fd2655mr1782147wrp.5.1676372849766;
        Tue, 14 Feb 2023 03:07:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q1-20020a05600000c100b002c54d8b89efsm8709382wrx.26.2023.02.14.03.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:07:29 -0800 (PST)
Message-ID: <e65bb8d0-0e56-62fb-473b-5661751bba40@linaro.org>
Date:   Tue, 14 Feb 2023 12:07:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 11/16] dt-bindings: i2c: apple,i2c: Add apple,t8112-i2c
 compatible
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
 <20230202-asahi-t8112-dt-v2-11-22926a283d92@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v2-11-22926a283d92@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 12:03, Janne Grunau wrote:
> This block on the Apple M2 is compatible with the existing driver so
> just add the per-SoC compatible.
> 
> Acked-by: Wolfram Sang <wsa@kernel.org> # for I2C
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

