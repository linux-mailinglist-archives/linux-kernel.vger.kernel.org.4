Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F35269A783
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjBQIxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBQIxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:53:46 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1935A3B3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:53:44 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id co2so1118157edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdMyS5kj05k5hIY10/lELprESJHEF14WiGNZ270Kdvs=;
        b=l/EGS20kE8i7iyjzvY44HVL0uoaFTmKRNv4FUkPdV+Ml8oQtc6chcUO1mIvZnk89kV
         niqdoadjpXEsREo47u2Ps71s0Rvz4YPj2qvr6gsMdusSFpcFhz1o+h4oGvjejX2OfKY3
         PgiW4V8wisheTZCIONVABxjI0IkducieuEEDxVJyG1igMt2KFgCWa5Km3mjqYMnP8Blk
         EKmL4mSG0GIesfF5to+qMJpvkHbOohFjo0PDhKUwC6BH8JUF0wNjmnKVwsF1Um8EqnlN
         mvn6yN3a9lTS3CKt19JPF5DOe3bB7SO6NcT7Q5NQVMi94oms01Nc1bu3n8wNVvM4CHhl
         j5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdMyS5kj05k5hIY10/lELprESJHEF14WiGNZ270Kdvs=;
        b=50lhbtn5aKf6XDewJ8kvSlXFG1rmoL8t/4kFJzm+W1hAxB59RPrEtZf3dDyHApQhGe
         Na6dHm8ZsnAeS8TLEMQAZ5vbCKmyaHHfNcIK1aGSrpIHk3WD/vVXmeFF7E7fMVfwQcSa
         H2RjPETPrhlfuVtnZZjaDJSN+9T71DJlz56pfPkmTaDYj0STulVR7jk0Y/YZttUjHL8v
         tiIBv6xvye437hOcCkfd3HFC0cbxsvP1yiQybW3dPTOkB5eU/hitIATCT42zFYN3xrr6
         VzlqvkJw3aJfaDhYq5dzzgmnizFBNK9oM8ERBfCgcB+6pzIREVptHIj9uKynD3gCDf3p
         i4hw==
X-Gm-Message-State: AO0yUKXoL3+RRbJf3bOzRbE8YjetI+geLgUTC2tRCbd13bfeWX2DHlS9
        DnxGOssdXqvW3mmWMuSTx56Kjw==
X-Google-Smtp-Source: AK7set/jSw1YzksewYyFFLYa8kRzbh7z8MvwBIzJ1GMMm5Hn/lb3n0dU3vBFcjktl8xK/fNgc9egWg==
X-Received: by 2002:a05:6402:f03:b0:4ac:d2cd:cba9 with SMTP id i3-20020a0564020f0300b004acd2cdcba9mr4413829eda.9.1676624023482;
        Fri, 17 Feb 2023 00:53:43 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k2-20020a50ce42000000b004acbecf091esm1959010edj.17.2023.02.17.00.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:53:43 -0800 (PST)
Message-ID: <96ab36f1-5b74-1df1-c344-0936516fbf7d@linaro.org>
Date:   Fri, 17 Feb 2023 09:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/2][next] dt-bindings: power: supply: Rename the file
 name of RT9467 charger yaml
Content-Language: en-US
To:     ChiaEn Wu <chiaen_wu@richtek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org
Cc:     cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterwu.pub@gmail.com
References: <cover.1676648773.git.chiaen_wu@richtek.com>
 <ec1a341d5731977f3188997f3655e777becb881c.1676648773.git.chiaen_wu@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ec1a341d5731977f3188997f3655e777becb881c.1676648773.git.chiaen_wu@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 09:06, ChiaEn Wu wrote:
> Rename the file name from "richtek,rt9467-charger.yaml" to
> "richtek,rt9467.yaml" to match the "compatible name".
> 
> Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>  .../power/supply/richtek,rt9467-charger.yaml       | 82 ----------------------
>  .../bindings/power/supply/richtek,rt9467.yaml      | 82 ++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 82 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml

No improvements here. Please use standard Git tools or fix your
patch-handling-setup.

Best regards,
Krzysztof

