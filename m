Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DD0729F09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbjFIPrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241848AbjFIPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:47:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E1D359A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:47:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f624daccd1so2409427e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686325659; x=1688917659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzQBDIIZDrg/bwrGe939IqgF7MEUiwgzplodxJt/mqk=;
        b=adenxAUV6Uxx2n6DmQx9ic03Z9zOZdFUcsILqt0a3nv9QfaSkg39xACAmo0ZwYkepH
         qXcbqkOB3NrUgmgGiVBXi4eAPyjqY8Jefhf4GEb7RZaXzh2tAcEn5JzEtqhZcEYvY3b1
         OfukAe+8w1RIYWf4ND+NXee+fDmPU9KwePg3AgguqeC1CG6mzhRhtOsLp94xWrFNqi8h
         GfIphCUy5m73Zlr5NK6TrRrriESTLfCIYtOPeAGXyS9Il8FXzh+7vusYF/zUtD9sHldQ
         6n+ruFaGGtr3EeZiy9pt9+G7+VVSd/49yDRuwFGhYWLo23M8jb16hK3Qzu2zpKdH0aXo
         G5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325659; x=1688917659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzQBDIIZDrg/bwrGe939IqgF7MEUiwgzplodxJt/mqk=;
        b=li0b0vL9AhxAmk4uR/xnBhltOFzGyniiS5bzan2IxifrS9/JVL53uzEgosau0A/+Nn
         blDK2b8yVdTkkDqlIyJcsvTpxh2GAKZQNhLDiemYYPc0Yb/nM/saZrIKKLFAvfuKqD5k
         Btt0IWMzQqgMaIhmCcA/nHCisRmsFCZzlZxL/OTU+8xdTyzkW0rnjvByAKzCQK08g76r
         AuqbA/IaXIwR4qqxVkXP5Nw1n7ooOwTp44fwoGykoi/Bf1R8wNkJCrgSNhTmu3Nurths
         4xeko7akQP8HD+Gdke5HNNJmqZ1JroDYPClwlwZE268E0oju8H8BJTDiMgG3ZtcnnlWE
         GrfA==
X-Gm-Message-State: AC+VfDyaUpDUAilehtiaxua5wDgkV1DuLaR7DAvw8/GZ9bOwZkUcIXfT
        sSsvyprDUSKOKohPx65PYnpBdg==
X-Google-Smtp-Source: ACHHUZ6rGvq+0qd9mBsLv2Jw1YAesA5rIjWjWnNLqb/ZezROn1ctvDQIK28pQqx+oDP7N7hlxlJZAg==
X-Received: by 2002:a19:4312:0:b0:4f4:b28f:6b9c with SMTP id q18-20020a194312000000b004f4b28f6b9cmr1132934lfa.29.1686325659275;
        Fri, 09 Jun 2023 08:47:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id c7-20020aa7df07000000b00514b854c399sm1905546edy.84.2023.06.09.08.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:47:38 -0700 (PDT)
Message-ID: <e48aaec7-b46e-714a-1636-376a67b57669@linaro.org>
Date:   Fri, 9 Jun 2023 17:47:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] dt-bindings: trivial-devices: Add infineon,irps5401
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        Mark Brown <broonie@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        devicetree@vger.kernel.org
References: <9673fc919c6785879975fb1830d5026d3cfa658a.1686233049.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9673fc919c6785879975fb1830d5026d3cfa658a.1686233049.git.michal.simek@amd.com>
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

On 08/06/2023 16:04, Michal Simek wrote:
> Add Infineon IRPS5401 power supply to trivial devices. Driver has been
> added long time ago by commit 9158411b96b1 ("hwmon: (pmbus) Add Infineon
> IRPS5401 driver").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

