Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFE65B45CA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIJJyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIJJyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:54:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42244D27D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:54:04 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a8so6759084lff.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nGB1eH+3YKYlQxfebPcTH9aYOLxz9Odp7+V7DTmi6rw=;
        b=KG/jKE9eJLKyuIo+VLF+hq1v8WKbwaXb2CB1x+cN8rYSxuBllbtpxwMbLrWm/bT04T
         WyLoDnIwu9X16TJVAU5mu4aAt7Fbb4vcZB/oTh8QRqtka9TGeSCOwxlXeGzOH14P5pr8
         OJ/WHW0lBYpXRx4viTTTdK2bbFawt1Q6EtDqTHn0JkbXzI3Aso62XbbGKBVVJPp1Qi5p
         hZOmJkS2XrYb4AnC0YO6CF0QE2VNpYepl797Z4WAl+LB+tRYHKKoMY/SVQRKyvvPBVMG
         m9dIvgBYfZV1alxD7ivNobc/rA0lBaq3hhCOYPiewSUQNFeYsumvlKxTp7M0NN5DQUqL
         w9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nGB1eH+3YKYlQxfebPcTH9aYOLxz9Odp7+V7DTmi6rw=;
        b=Mt0O3bnKPB2mig+abtlWxstLXmbPlRxusNtkDV+iFVdfEMhzqpmeQtk4g9yn7hZtYG
         9RpxVaBBNpyH/ZLDF5dCBdv895QlwUt+kjWhLiYumKs+aJV0xU/8o7rTtlo4bbuMn7Tu
         /Jb2RVaBYgCtvs1jCIP260bFwLaZpzuI6+8Tj7Oz9/LtJSxuZrk8HF384RnSOyJ+z20i
         BlOP2mW3riFaDhIYdZfi889RGSyDiKmfZ88qGnkow8VUg2Y0VAMTwuD3zAXSG3QCKV//
         5IhpOR+iJX2l6tQZ7cm/C0vaIXmUxZOxh9c4bSKU2n6ZktRLaRCOzZt8ZddL69F2rMio
         XgNQ==
X-Gm-Message-State: ACgBeo0MITpXCg7rals3UgWCuybUG8F/IcelSgrRu7PBtu27HLMlDGP7
        2MzH2lCQXOMhDYEzloNe44Q04g==
X-Google-Smtp-Source: AA6agR6yKiJIkOeCvvAjvFniHPVqzLuNpnS2U7oFcUbfk1Gf0CX7xdQoS/kkXI97ntqfaPtR7++x8w==
X-Received: by 2002:a05:6512:b8b:b0:498:f32a:3c1e with SMTP id b11-20020a0565120b8b00b00498f32a3c1emr3186445lfv.123.1662803643026;
        Sat, 10 Sep 2022 02:54:03 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z14-20020a19650e000000b00490b5f09973sm208638lfb.92.2022.09.10.02.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 02:54:02 -0700 (PDT)
Message-ID: <7055eeb7-0ca7-37f2-7e7a-3880a8f0323e@linaro.org>
Date:   Sat, 10 Sep 2022 11:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 01/10] dt-bindings: apple,aic: Fix required item
 "apple,fiq-index" in affinity description
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-2-j@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909135103.98179-2-j@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 15:50, Janne Grunau wrote:
> Fixes: dba07ad11384 ("dt-bindings: apple,aic: Add affinity description for per-cpu pseudo-interrupts")

You miss commit description.

Best regards,
Krzysztof
