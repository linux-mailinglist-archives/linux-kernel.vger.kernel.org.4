Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58F06C8827
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjCXWLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjCXWLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:11:06 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9673320544;
        Fri, 24 Mar 2023 15:10:36 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id ca2-20020a056830610200b006a11ab58c3fso954332otb.4;
        Fri, 24 Mar 2023 15:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679695832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEZB0Nh/4O/z/XC92VKOaEMymhD7WgSbKx5bfGMzpjo=;
        b=a6zxQiGAwCfZdkJpOYG+7nWpnTsubLe2SytfDE0PnTFSHJ9gJLWZuecwBKVIpd4jBD
         yrp1Do8zBkVRXGkIgIh7I0+qnM4IKumriz67c7xt0Quyhe83xQtv18bijHb0C+54AUyS
         ETO+jhFF8+E0R3FIURzoqEMYx59TYllkApEn2oO56Ajki/eiGGtccEUxqWuSDmBOcg/8
         iHaQl6rsthmAkfysLoHHKR+slJLjpN104RtVV12vhb4NY6ItJ1LuHQuERVUjrKH5+DZC
         61il5K9VEyY2CYXG0xANT2g4AVLA/XNg2yEAi+oRsGm8LiE68vcnLlWLB9bYk8RGux3y
         oT0w==
X-Gm-Message-State: AO0yUKXP49E71naKqVTc0ytqvpBJr40GRAvVENLn8F0lf1hEhBrwON6I
        ZR5Vw2gTjxSrW/pFpNGb7g==
X-Google-Smtp-Source: AK7set9vW0zHsHlJLlEylX6XKKkb0rXZiJfoBOVqeOno3AFH8R3gs0Y/UTdHNrqBt92x+oWHzPN07w==
X-Received: by 2002:a05:6830:1db6:b0:69f:91eb:87da with SMTP id z22-20020a0568301db600b0069f91eb87damr2486443oti.16.1679695832134;
        Fri, 24 Mar 2023 15:10:32 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80f9:92f0:b372:78c0:69c1:66d6])
        by smtp.gmail.com with ESMTPSA id n16-20020a9d6f10000000b0069fa641bd25sm2976890otq.8.2023.03.24.15.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:10:31 -0700 (PDT)
Received: (nullmailer pid 69197 invoked by uid 1000);
        Fri, 24 Mar 2023 22:10:29 -0000
Date:   Fri, 24 Mar 2023 17:10:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Message-ID: <20230324221029.GA64664-robh@kernel.org>
References: <d598f5f8-f998-2a31-bb21-97e641793dda@linaro.org>
 <120663a9-aecf-4a43-d1fb-779cd52802c6@arinc9.com>
 <3d2b8a1a-99c9-f53e-4bb3-a8b938e2672f@linaro.org>
 <543ad00d-4171-ed02-0d31-676c6b003e54@arinc9.com>
 <82f517b5-6697-3379-8d71-163b0d17735d@linaro.org>
 <d640a929-b6a0-1552-e66a-3a7bbabbc69f@arinc9.com>
 <2150938b-5433-6f51-c404-2c0f6976f864@linaro.org>
 <1c279b0a-c814-2fe3-0432-2aa6b3dff16e@arinc9.com>
 <9f8e7a74-35c6-6db5-4960-1efa79a23983@linaro.org>
 <6ed317bc-ce3a-2da2-1d96-f0ea8ff0b48c@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ed317bc-ce3a-2da2-1d96-f0ea8ff0b48c@arinc9.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 12:02:47PM +0300, Arınç ÜNAL wrote:
> On 21.03.2023 12:01, Krzysztof Kozlowski wrote:
> > On 21/03/2023 09:53, Arınç ÜNAL wrote:
> > > > 
> > > > I do not see how choosing one variant for compatibles having two
> > > > variants of prefixes, complicates things. Following this argument
> > > > choosing "ralink" also complicates!
> > > 
> > > The idea is to make every compatible string of MTMIPS to have the ralink
> > > prefix so it's not mediatek on some schemas and ralink on others. Simpler.
> > 
> > Which is an ABI break, so you cannot do it.
> 
> No, both strings stay on the driver, it's the schemas that will only keep
> ralink.

But you are adding one of the strings to the driver, right? Still an ABI 
break, but only if you have an old kernel and new DT. That can be 
somewhat mitigated with a stable backport of the new id, but still an 
ABI break.

Rob
