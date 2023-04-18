Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05336E6AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjDRR1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjDRR1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:27:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75BAC157
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:27:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id xd13so41246694ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681838827; x=1684430827;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYEHg2sosnOY0pAhC25Z66tH7y5mKmQfmFvbWvEdvY8=;
        b=jUWAYBzciOdxMLyBKAteFPWMBnIQ907UER8Br2Vyks/pQVV58YB/3Ls5C7XX2LI4U2
         jfNZziZrx0CA7NJJ38GSlS9SOx5z0Lyc+XfLua95FgQP+Jd1xUpnpxsz1MuqPw2AuZpz
         ouVZ4wjxyv80Be9cT5epF09Ijk/TyAbTP0U4+54XlyMp/D5R11CQmJYXI4EOneLwBagn
         PWwQ49zREJ+rtsUSQLihNcpEbLbhcvP5C9a44bagUbOn6BwCfBDmECMzIiKzk53D0LS2
         juTtN5FQ4ke7m49HEyIaAGsTHuqeC/x05yrMil1fHl4mm8Rmg9ft5Hq6a6dGm1voGx43
         VhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681838827; x=1684430827;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYEHg2sosnOY0pAhC25Z66tH7y5mKmQfmFvbWvEdvY8=;
        b=V9Guz4qshRQkcUhT6iWTfWSkyn+Rdei1JzWbjr/GgV74IJ28xya8L5p6NRbAl6ttK8
         o5iZgF0EO6DFPZpWsMMqhReap2e452jaVQpsznWqCx9aDQPfRaPAYHsz+4cAnQdSUB2k
         0i7c3wMTr40dMhKvN2g0WSFk3dFmfACpirSwRnOcW6YTztQ6dDjGTQgKIVd9wjl3IRyh
         zjmghtNY1zoKCI5HyEejLZ5+b1hn4yZAjKQGhuj4Mu+mZRyw9nyuzU6ku1h97+KBpTP6
         +uiokCXWdpq2L+DISmx7aW4Q92da+nn8Lckr2+M5Qk9TnWk1uIqzP9yq94Ee4OoHy4He
         l8/g==
X-Gm-Message-State: AAQBX9cdOINvlA5YaEI7/p1w2EtjSS096kjRqyCtBqTXg2eXsspq8TjU
        q5PF9mUQitXl/Jj/Nz6pvdzpRw==
X-Google-Smtp-Source: AKy350ah1qKGBvGjkmYLETOZpHpiL7PCK1pVCgTZyqcOkD9XXhiJaftKDw0p33OVAjltW7b8DVz1pg==
X-Received: by 2002:a17:906:3e90:b0:94f:6316:ce8d with SMTP id a16-20020a1709063e9000b0094f6316ce8dmr6593515ejj.34.1681838827296;
        Tue, 18 Apr 2023 10:27:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709062a1900b0094f614e43d0sm3829592eje.8.2023.04.18.10.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 10:27:06 -0700 (PDT)
Message-ID: <79416f48-1c3d-6139-7c5f-de1907383a85@linaro.org>
Date:   Tue, 18 Apr 2023 19:27:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 9/9] MAINTAINERS: hpe: Add GPIO, PSU
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-10-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418152824.110823-10-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 17:28, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> List the files added for GPIO and PSU support.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a3b14ec33830..6df959ebf523 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2239,7 +2239,9 @@ M:	Nick Hawkins <nick.hawkins@hpe.com>
>  S:	Maintained
>  F:	Documentation/hwmon/gxp-fan-ctrl.rst
>  F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
> +F:	Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml

Since the drivers are going through subsystems, your patchset is not
bisectable.

Squash respective changes with respective patches.

I also suggest do not mix three different subsystems - GPIO, hwmon and
ARM SoC - in one patchset.

Best regards,
Krzysztof

