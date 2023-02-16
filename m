Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8C698ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBPIgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBPIgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:36:21 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935E74A1EE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:36:12 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id he33so3274616ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16RBvX2K5fEOc65TEX4CGMW4aoTgfh9Mm/UNw/VAU3g=;
        b=Ct04YhcQwiyukWh9jRrxjqrgGfT2820R8JZ9p0D8sliT8YMn58C+4+Leupc6/dUpmi
         AIKX+t4YdphFhKgHD0XTs4tlbi1mX1yFM2lMDJ2zBeOaBTi0ZQ6/Z40aiW7nqiI2bha/
         FrbfV3gSIyBHjTHaXKS7Bz/HJrktiN6eiHiGjI1IipCSeUBbLO9hS1+Ko7bqF9dUbsST
         2BsgAkSLaOFPwL98ctbXdQUBDBrKVC2deLNw3bB5k3f5lcKL+ELfsx71xoLoo72o2DFU
         jTcblEPqndNVSRUfDIJ3oDpeN1sxJOw5/nWtlF3hzxd/vaJFQheEBfmNHR2geuYkxV75
         x4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16RBvX2K5fEOc65TEX4CGMW4aoTgfh9Mm/UNw/VAU3g=;
        b=jFp9XpX0ZeVffdwRz/WKeI3f4OOYFiUmbTMaw+ybTpkM9cEuVDIeYt/oa604I4dJlN
         p0sTNKsqQwipeZRxc8L9qoK4joLZEpXOG/gnCmybKAYXD9897T4wX/h9HsUyDKfFtOBl
         kxuZ0K8zOEhi+qXS2JWfuxhFQUzdOdxW8vH6Gf4BpIezkdP+7/BS0MI+QPCt6TFQY0od
         MZY9v8ruJ9+tO7oI/9D2um7lq3JnKt4PaW0SnyanaJKayqQc/tY8Tui5KEsbzOQM6S64
         bLs7m9UyR/GLoA3BNuCfXv85QQUvblqUBSgDhsUQoK0VcUyjD89lM+02E5lBMoTibJP6
         JFzA==
X-Gm-Message-State: AO0yUKVh3M7FA7PjS2WKPjy7vUwKqH1ockD7gOIJCVvl4lctyMzY9Gjw
        T1LyQTRtcOrnsUe4G0bs2ffwMA==
X-Google-Smtp-Source: AK7set+6JdqmHrgsAeZvbyRq8PwsgciY8Be2DD/ZmGB20N36E1ggS7scV9cCgRysBHp/TfIoehBASA==
X-Received: by 2002:a17:907:6d99:b0:8af:2bb3:80d7 with SMTP id sb25-20020a1709076d9900b008af2bb380d7mr1172166ejc.31.1676536571096;
        Thu, 16 Feb 2023 00:36:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y21-20020a17090629d500b0087bda70d3efsm503337eje.118.2023.02.16.00.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 00:36:10 -0800 (PST)
Message-ID: <a2d10295-d9eb-cd1f-8f48-b61f97487208@linaro.org>
Date:   Thu, 16 Feb 2023 09:36:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/5] dt-bindings: hwlock: sun6i: Add missing names
Content-Language: en-US
To:     Bastian Germann <bage@debian.org>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20230215203711.6293-1-bage@debian.org>
 <20230215203711.6293-4-bage@debian.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230215203711.6293-4-bage@debian.org>
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

On 15/02/2023 21:37, Bastian Germann wrote:
> The allwinner,sun6i-a31-hwspinlock.yaml binding needs clock-names and
> reset-names set to "ahb" as required by the Linux driver.
> 
> Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock") 
> Signed-off-by: Bastian Germann <bage@debian.org>

With new data, I changed my opinion and NAKed this. Still NAK, sorry.
Please drop the clock/reset-names from the driver (use indices) and DTS.

NAK means Not-acknowledge. Usually you should not send the same patch
after getting NAK, because it looks like you ignore the comment.

Best regards,
Krzysztof

