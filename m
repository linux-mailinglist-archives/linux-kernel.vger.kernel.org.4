Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10F963AB44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiK1Okf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiK1Ok0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:40:26 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384532188A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:40:24 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a7so13361974ljq.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NiUJlplsn9n6lGGdwaVYz/dvUY1Uiz0F8E0WFP5MXA=;
        b=mUY4sXo496dMgRbJDhldHGyTbaS60fNegypcclPyzw/16zckDxAqi3rx0MG0tMyZos
         /7D+YrPdRYNYrR0EQnrbNQ/Q7htyuzDboExz/O3YGlCiAyaKlHnA/LTUkhbf6JtqpHpt
         2a4atD5Hk3YCkU12y6mMmxHSEa0VzAZ70FoCzLTmC99SMuDsL/FZ65NKmqm1OcdqW+pi
         ZBKA6C6ih+VqgYVPK6fnGXgWKT5WeQLTANBTCenMqP7Jd5vPSP9gvq31OFElyn2yfsDa
         5Y+f5SE9f3mOD4n68ud7YJ1SULJg26cRV5YGQfbMLwKltMl2Ld0ElsvKRB0dwrS5j08o
         Wq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NiUJlplsn9n6lGGdwaVYz/dvUY1Uiz0F8E0WFP5MXA=;
        b=zq7EGbpVyjUryd0zemyuSESz7QVcLZ92CKxMnlPYUhVsowEHWK32KFwjCGZU9Nfbn9
         AR3fbSi7iFpHCZoVoGAW9Due1QRAqmhZn0tkMXHlPl7l2DTVvV7GBEBw9m7uX+etJE+4
         Kq5oVcQCOZMzIlOREmHbtYjOxQDOyi64Y0HdgvaV07taVc9y8BN+cu8ubPtlmZ5Rdci5
         FBB4AmQ35Sz1N/UbO3HUMgDbPPsCqTirMs7rT76yDj8p7+Hiul+uAkRVW+hR2tBKHFRb
         MO+8uN58GzGgmPLLljsyIUxupPWlDF4hTSpsihdcRN31AAYIeRJcETNkuLYObgMKgfiU
         ITRA==
X-Gm-Message-State: ANoB5plC3M6+0BZ6LQ3T+S2PHVZT7MNKbmvMpVE6JwtNzyT8jCIy7Vzp
        N+l9JUt4+2KJL3dCVnYPnnCApA==
X-Google-Smtp-Source: AA0mqf44My3TSiQHWXKUbpZ8nXgALHNbYVtTj2k2cv7Q5oTPCaZ+9Bd9an1qmJv5RwWvKlqF7DwXtw==
X-Received: by 2002:a05:651c:b0e:b0:277:3ca2:dac6 with SMTP id b14-20020a05651c0b0e00b002773ca2dac6mr15718506ljr.143.1669646422586;
        Mon, 28 Nov 2022 06:40:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id cf39-20020a056512282700b004a0589786ddsm1752136lfb.69.2022.11.28.06.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:40:21 -0800 (PST)
Message-ID: <5c8c10c7-0d2d-25ff-1bed-d75dde93ee75@linaro.org>
Date:   Mon, 28 Nov 2022 15:40:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221128142912.16022-1-marcan@marcan.st>
 <20221128142912.16022-3-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128142912.16022-3-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 15:29, Hector Martin wrote:
> This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
> The hardware has an independent controller per CPU cluster, and we
> represent them as unique nodes in order to accurately describe the
> hardware. The driver is responsible for binding them as a single cpufreq
> device (in the Linux cpufreq model).
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

