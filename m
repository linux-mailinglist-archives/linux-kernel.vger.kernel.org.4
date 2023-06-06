Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973F1724970
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbjFFQoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjFFQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:44:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6077EE62
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 09:44:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30aea656e36so5174474f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686069860; x=1688661860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRp5PHBpg8WIzprzQL0TsZx+F3FtU2GvDJeh/9Ru4Wc=;
        b=Z5nLUMBaNRug+W5PT3bVydchopyrR+8KaAF7KMJ7TzWo8Eh+kt9kj855l6mr3AdgS4
         tItgcjZJCLyPmC8MUofqAFQZZhSyBRyHCfA7+9XhowUXAj1+z/2fgDHVgl8sz4hwvSdP
         cy6xb4ihLF5m1M/a8fk0FyV4eLCMv+uSXKZKRoObLEYIrZHM1q3sRfDUzyDJFMx8P/eA
         IRzWQKGhjQpGy2Mary86tJhFyyNEaqwRcWJoBqs0oxaXRpWaLg8U8bdf77QN8D/a3qd9
         bdyM700RD48A5lLxPgdamHmzoEMDZy2LLO9wqAZIb9WC3NbsvOv2rE/PFz7k8pGpYcuj
         iFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069860; x=1688661860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRp5PHBpg8WIzprzQL0TsZx+F3FtU2GvDJeh/9Ru4Wc=;
        b=j1xBO0PI3bRo6MzniJuN8By044TCwCRFLDZQb9BE4L7CtR5aGqol/uSuyOSAT/xIwp
         HoPdBv6yLXm81JTj4CE5hAsNQgQhJ06hsARkS1Ck0NTWioV1rOt5Ep2Jn31zW3Kgrmqs
         E1ij4Yt0hkOt8EjVmU2sW9p+7x7xn8xPC1bw5beR0z1BS/FqNTncYxRQ7tNjwMsRCbFa
         o1paveNgelgrFfmLdKQm7J0hkp15dGCJUDK221DzmklRU4gAOF9zeb5ykmfHnEYU5rB8
         Pc6xQ8lJmy4oxN/+ux4yFvKk+03zWrLruMcWGSXSfdofrmAs3ZVFjqB2SzffVCFF4MOw
         tiZg==
X-Gm-Message-State: AC+VfDxRSFfb4uiK3lEhqp+s2zoF393WOUP9xV5/xUP/G0s08n9MbVAN
        MN1mSQcqG0LOgbj2f08Mimiyhw==
X-Google-Smtp-Source: ACHHUZ7oUuVYB6IWjdvhNXvcxkg/hAvPoJ1vvsVmuCxBI0e7CRve2sGqcp0sO4OroMYqbswanG2v6A==
X-Received: by 2002:a5d:6685:0:b0:304:6fef:f375 with SMTP id l5-20020a5d6685000000b003046feff375mr1903865wru.70.1686069859758;
        Tue, 06 Jun 2023 09:44:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d8fb:84d9:d402:6b22? ([2a05:6e02:1041:c10:d8fb:84d9:d402:6b22])
        by smtp.googlemail.com with ESMTPSA id k9-20020a056000004900b002c71b4d476asm13097894wrx.106.2023.06.06.09.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:44:19 -0700 (PDT)
Message-ID: <3c7e9e9d-feaf-b3c9-d8e0-1ef18e75745b@linaro.org>
Date:   Tue, 6 Jun 2023 18:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/7] ACPI: thermal: Eliminate struct
 acpi_thermal_state_flags
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2703629.mvXUDI8C0e@kreacher> <3186378.5fSG56mABF@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3186378.5fSG56mABF@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2023 14:18, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the enabled flag is only needed for active trip points,
> so drop struct acpi_thermal_state_flags, add a simple "bool valid" field
> to the definitions of all trip point structures instead of flags and
> add a "bool enabled" field to struct acpi_thermal_active.
> 
> Adjust the code using the modified structures accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

