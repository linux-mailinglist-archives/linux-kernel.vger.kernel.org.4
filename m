Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE41674E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjATH0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjATHZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:25:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AB1C143
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:25:57 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h16so3989602wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9i+Qv4HbQL4wTmwii3nOO+NZ/copcGQilvpnum3F3M=;
        b=IR/FIY8pS3+kqyyg3eNASM67BT3+BwXFJTsQkQPWbb7nGAHU3nXxnGYWKViEP1b4zs
         zUPrAO+XB3ZN8yOLqYNyUTQV0s2/5IXvm1aYbJO7RnowcPumYRKRDNvsmQQqZ+l6vx/2
         /yGaRhF6Vj5BYYtWCrWsEzFr3JPxqaq6e/zBS2tKSZfk2EQAAt9XuKdmIUDzZXcS8Z1e
         Rh3dJrKlv1sAilKaVuq1efC3vRz7f5LZs8dLPQo0TM55K0cG9luxluk131P+cW2mgHoL
         RgtPf5ooZ2nzbPEUmw3nYWJWGB5FvyJCEGoR4Son5jtuhI2ndLSy5b2hrMogk5nvH4LM
         p8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9i+Qv4HbQL4wTmwii3nOO+NZ/copcGQilvpnum3F3M=;
        b=mRRgt6pxJaZx2HDsKQIv8Fvxne1bzq0B4t8MilFMrZJ6nEd8XNSgXELMdd1vBTgVAX
         jOOUMf3J/A+gkrjCsboEioxVUKqsIy1xPkHsrYyQG96vrfjErgsK35Us8Wgb6BIzVHzM
         ed9ZlXeSaUSHonNrIvY5P5zw6KqfNMWGzTDl63HH3i9XWE1R8qjve3gjpoUY7P0QSRgX
         JZDup93I50zyG0hcAIZW4lEr9MBEflTkFWu652x0SmyPq77VtupUqNOgLzcs/EkbT/Ww
         9nW1lPocErsC9QiywYNp46+2r0mBYJzBVPeAN/CiJiNUK4WUvr0VMSxcNCQ7ETR2lJlm
         IkIQ==
X-Gm-Message-State: AFqh2krJYEx/Zf5fggJmQwnAdkRotywVc8azRjUJUiSRw91gJ7qUqbtF
        uYfY8PoDr1nhUEhAlXFC4z0dYw==
X-Google-Smtp-Source: AMrXdXu1tnJAiVhajJfg57xXl5eiuSAI60G4qJ3fw0fpK5VpqvH2qkRBe+F2spmEiznl0QygzEWwZA==
X-Received: by 2002:a5d:6b4d:0:b0:2bb:f88b:43b6 with SMTP id x13-20020a5d6b4d000000b002bbf88b43b6mr11897926wrw.3.1674199556125;
        Thu, 19 Jan 2023 23:25:56 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm34958634wrx.21.2023.01.19.23.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 23:25:55 -0800 (PST)
Message-ID: <53361cab-0b41-0613-2fa9-64044cbc4e2e@linaro.org>
Date:   Fri, 20 Jan 2023 08:25:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] Documentation: devicetree: bindings: Add compatible
 for Samsung Galaxy S5 (Exynos)
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
References: <20230119185848.156502-1-markuss.broks@gmail.com>
 <20230119185848.156502-2-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119185848.156502-2-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 19:58, Markuss Broks wrote:
> Add the compatible for k3g in the Samsung Exynos5800 boards section.
> 

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Best regards,
Krzysztof

