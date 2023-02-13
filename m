Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC848694428
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjBMLNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjBMLNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:13:40 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E2F19688
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:13:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso3350521wmo.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxi66NFp5CC1l7OpD7ouzgSByxm59oZ9221dT1nw3vo=;
        b=kVw2MU3W6ROAjXQRHl0MNnZ4lRpbjkZe/E92qaX3GO8JTshSWmDufPtsXfXf+YP9hE
         mP9+UAsj2yuZHFoBvq1Gw1YsZdF64jlyCXxGwUkGLHUGvfRwA5snq04Jo35iL6d0L0RB
         L8V74WRcfHVhwfQa0onB6tlOcDxf0vtshlT3PERNgFa/4nmgBMReKzFnt1WCyNXGuNNN
         6Ht9Hm7ZV/J+YbE7PKNWNckbP6w3LCWU7aa9d3BENrRoyqIiXFZd/cYNK/hjRwoziXyD
         yPV3DCTEDvDlXpS4KILb/13o1kJwCnprbwOnQPvIh6ZKzUEiy1XbC+fK5OA8Ob60o+2u
         xU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxi66NFp5CC1l7OpD7ouzgSByxm59oZ9221dT1nw3vo=;
        b=R7r+lm7RztwybVaNm4T9LQVKYMoU+1SKsiA+fJIqpP4I6EWEGwJrTpHEQvpoVxYwIm
         kQzzFJr8KFU7/mtv2Me5yMhUjYMV6wYCQ3riInnUxup/rx0qlZ6SVI394VGLU5twlWTf
         +CQLlDDLsF2tS6Y9MyHLDK0YhyCdEifRuMiEMnAPqYbXkmWU9zZgja+vMK/rloPFyqLj
         Clej3Sbc2pH2pzyJ/0B2FWbLongQ6MyeQZEW5ZCnOY43MWg6Kyxm+EPtD+zD+fVb+d/6
         ry7Fid1vGNZ9DWUBfQVeBquBd8VzWpntwn6+mC+g3qJxCZqiWbJBflHKlU5RWpza3hmR
         quaA==
X-Gm-Message-State: AO0yUKV5g+5R3joXXgbENsv5stGgIysI9kgJFEu1LaBcyCIuYPqFIrGt
        qTR2HshJ0gKQmv/USoVXheSHSA==
X-Google-Smtp-Source: AK7set8/EdJsZBGPMFMve7u9aeKH1SjT4x6g4xC1zu0RoHPUUa+B1P+u5IhFA6Nf1duG9va8GSYOAQ==
X-Received: by 2002:a05:600c:1713:b0:3dc:5b88:e6dd with SMTP id c19-20020a05600c171300b003dc5b88e6ddmr20915760wmn.10.1676286794334;
        Mon, 13 Feb 2023 03:13:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h4-20020a1ccc04000000b003dc4a47605fsm17052564wmb.8.2023.02.13.03.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:13:14 -0800 (PST)
Message-ID: <198daecc-9bee-a418-ac00-1ba281dc256a@linaro.org>
Date:   Mon, 13 Feb 2023 12:13:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 06/17] dt-bindings: arm-pmu: Add PMU compatible strings
 for Apple M2 cores
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-6-cb5442d1c229@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v1-6-cb5442d1c229@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 16:41, Janne Grunau wrote:
> The PMUs on the avalanche and blizzard CPU two micro-architectures are
> mostly compatible with M1 ones. They miss support for a single counter
> according to Apple's PMU counter list.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

