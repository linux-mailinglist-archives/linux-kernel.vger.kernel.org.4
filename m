Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35E760E5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiJZQob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiJZQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:44:29 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DDB261
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:44:25 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x3so3359270qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eryNW3MuBS2cZClUExViTVntvRIArmIXKQHv5fSVePI=;
        b=WybhEts/ElIzV68QagDNZOfEaxXJbAtGLeypKOWhwu1MFguaqDxVRET/+u/v0Akqv4
         exIIOpOOa7Esh1PanjoBMS97rUYDHp9u86mwK2SGAbyXmmM84tGf5NQC9Jjw7ESzcH1s
         YBwVFWdaq9jZJ14gDKE8QZHmTwP8oi/t3BKcyZD8Usvm+jM0BglxzQj+d2jEp0rR9ar8
         Ouhd2DRSaxHZkG6QbZe8AlyS85g8/5ZEw8cMDnL7XG67f4ozALPphvWwXDZUq6Cz+tKb
         yOW2K6/Osm6FrPPPPFzoF4PrZd1Zhpqu+pt1NhVLYpj929U1FxQeVKCupQQ1Q2vdRENq
         dJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eryNW3MuBS2cZClUExViTVntvRIArmIXKQHv5fSVePI=;
        b=j/19+d7I+WcgERGgg5BodUF9Tb+ZDjmhkgYyTU1fcs7sP2uelfmYUomV0H0zGSX368
         2JGl1q55dc+WNlOUu+7tyuEym0G2VgsKp0b3V8XzK+JG69DvFGCc+3NGi5yOBvU3gN6w
         BJF8rRhHK73uo0WEDgLgOyNdQj0GOWYyWBfSFrV+n1D9KwqyicOBhUUGzqNYZWvssFLZ
         O23wP+oVDl/Qqj/y3HIWfbdmuuqO88eScYcrG0zJG9Ti4qDmsx2Z62t/ICDDmMtc6dCt
         vQHadC7Qs7CR2OqgqfgjadC1eqDOFPcspuFPpaAePp7MXmzDn4VbezCjt23hNol9GFI3
         VBIA==
X-Gm-Message-State: ACrzQf1KsE0FlkfuZnaDYqY65+dDt2BjRhJCe0WLpI+Gtu2EWGkzpETt
        BNQ4usnGcChXUgxfPxWm3kzXBQ==
X-Google-Smtp-Source: AMsMyM5WluskmZKejrwkyk1N8wbPZc7RnwUU6zu8s3X5gxXdrCp9yHZ9XLqqxYIk6bOkrhF1kiFFhQ==
X-Received: by 2002:ac8:57d0:0:b0:39c:f3a8:7c78 with SMTP id w16-20020ac857d0000000b0039cf3a87c78mr37539040qta.470.1666802664864;
        Wed, 26 Oct 2022 09:44:24 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id k7-20020ac80747000000b00398313f286dsm3361089qth.40.2022.10.26.09.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 09:44:24 -0700 (PDT)
Message-ID: <0b2b3ee9-1d5a-4849-a20d-486c3897fb0c@linaro.org>
Date:   Wed, 26 Oct 2022 12:44:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] dt-bindings: power: reset: restart-handler: add common
 schema
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>
References: <20220923203603.515714-1-krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923203603.515714-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 16:36, Krzysztof Kozlowski wrote:
> Add common schema for restart and shutdown handlers, so they all use
> same meaning of "priority" field.  The Linux drivers already have this
> property and some systems want to customize it per-board in DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Sebastian,

This is still pending. Any comments from your side? Can you pick it up?

Best regards,
Krzysztof

