Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC7662F6E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbiKROLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbiKROLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:11:31 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD08E3FB97
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:11:26 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k19so6946224lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qtp5Dpmra1/rOA49Eh+jNdwLgrIa5og9y5Ys93KPSHE=;
        b=vpE5DEJrG9SOD9w/HFMLfE+1HP8jFqbFKMfAWW2yiYMYsnFIimIAFmNcn+m4tALgkp
         LgHY1KAwVbOgdyTKjt7CvX1Y59QgCHQEle+seAwQZCt3houzT3w+2rSzCrrgqSHwPk29
         r8Hdzf0Iy/GEMs98J+C49B3ckS8l22abtCS1eyQwm7hv43xlrCLHnZ0D+BRoJew/NIc6
         SF7Fg8sdLhXejVfdYHpFJnGsqa8LbTugeMVNS2hW8H+8SoNg5/kxvgytJZF8kX1up8Hn
         BCdOGOCSEdzX4buLWUCi5BXQHqPDENkp560Do51lXcvNTk8zxeFGuPVpMrMIw5z2o4wY
         XGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qtp5Dpmra1/rOA49Eh+jNdwLgrIa5og9y5Ys93KPSHE=;
        b=yec4KJpaPifgkgcvpsBQ4d18iNZfByy1qxFhcOg/EblluoEQVcLh1tiYM8+6ERq9vX
         H8g3saQuQchjcUFEL4znn5ssNMXJqsk3LhMGak+sYix9h0PflONdD4YCo5ZJyu5CVBJV
         0HQGIJ1Q2XTHFWzCZ3meiJ3wf754hmtn0UyQpBY26SlgFT+ZgzTpMGDx7r/Zbd4Ow9hH
         ts/ndCVXg7y37IcCm8vYIpVdZpNi2U6yv02S0/xaKcwuw4ElY8U5+i2y+oYqxuSRv403
         WCzEd7EpfKE+cfvz5N17hk4FUQHJ1DVeri9pZ3RyK63iFfw6aN0NoT3RCNupdvpxvGWt
         Nm1Q==
X-Gm-Message-State: ANoB5plKaeVRYCeBoHjsAn4cK1sln1oe4rQt6kGRi7qwZqQDCWJtZHFl
        1soZ45gNlKHwIL9lCakJMQzYNw==
X-Google-Smtp-Source: AA0mqf6ugo5sJDhmwF3aEBoUOKms4A5DsAn015MW37RuR7hfvqxQ1IS4rM/frjVmlKUvKbpu2GIi+g==
X-Received: by 2002:a05:651c:50b:b0:26c:5db6:cd84 with SMTP id o11-20020a05651c050b00b0026c5db6cd84mr2545700ljp.114.1668780685230;
        Fri, 18 Nov 2022 06:11:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j8-20020ac253a8000000b004946a1e045fsm666659lfh.197.2022.11.18.06.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:11:24 -0800 (PST)
Message-ID: <07961c68-62d4-efee-5618-9e7f6342923b@linaro.org>
Date:   Fri, 18 Nov 2022 15:11:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: add support for InnoLux
 G070ACE-L01
Content-Language: en-US
To:     richard.leitner@linux.dev, linux-kernel@vger.kernel.org
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20221118075856.401373-1-richard.leitner@linux.dev>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118075856.401373-1-richard.leitner@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 08:58, richard.leitner@linux.dev wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Add Innolux G070ACE-L01 7" WVGA (800x480) TFT LCD panel compatible
> string.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

