Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED678658BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiL2KbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiL2Ka5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:30:57 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8401395A4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:30:54 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g13so26954138lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAox9jZdEvifzmLQL+c6tUgFpF++A9pWe7sG2ptRj0I=;
        b=vW6WcxQf2oA57xpF12GrMN5nxO7C+GTBWRcwy6OFCaQ1xipbnG2BJ3uqema3wdK+df
         2x/+KN367tqENjlU619vns3XOhuW+19APzRsdN7o6SX2WrIRHAYFAoPKlXMbJH+ME1Gd
         eC2mihlLh2q+JUxZvFvcTE0wIk7Ye7MbIZ3H4Z4h/kL3FMUJJdY0uu9D5DdYs2xB7ebR
         wDsFP6ownoJPAxDyIlGLDQK2qFhcKuHZ7Ydv+hhzGyj+/w4WvEYdiwAtCDn/mayPKvya
         plVvgsNoqiJC/agaS3LXF+CQQdl9yngkvMS9NzbUftg+6EBOP45InBgxPS+p9SnA8qHo
         iiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAox9jZdEvifzmLQL+c6tUgFpF++A9pWe7sG2ptRj0I=;
        b=F5fZeVB2Jc68B9v0sOE2TUPnYlzhJHXw1ZSwyZF/5bTpPHK/EYhWakx6M4rCPMQwL0
         YUqbhBqxl1e7BUE7T8L3+gGyAAJ7PLTdZYMT4UUuqVs9rdazudwxLShYLw9zImRIPPAc
         LcCrNS6fXBF3VzJbZDkhRnmqcvS1mAniYWuhFjU1e3MSblG8f1HxZgT3n1umSTD2ny+1
         X2X0Fqy/SjcAix4D70g+rHxBHvdsJI3EJ2fW1DabEUbZm2xMXes4ZNNrnJwTr4ohpr49
         63x27F4Q73aZJMMYu3NgnxrJEDBwahcF4Z3ErXjsQVWCcpCJMQMXGCOtpdDqRSCa5nID
         EC3Q==
X-Gm-Message-State: AFqh2ko5BCiHWpaohU40xKglxLxBXOpDkr7Cs4cUta8JuQWOF91RnrAZ
        DJZhDBN5fpBtRD8vX4EHHt/5+g==
X-Google-Smtp-Source: AMrXdXsUMVEakLd8I9Ld+9cvNnWvLibPZXo9wxW/3r/FhHxjIMmijyS3NwrUfhTgMxmGNghGO4E02Q==
X-Received: by 2002:a19:f70b:0:b0:4ca:cb4a:1875 with SMTP id z11-20020a19f70b000000b004cacb4a1875mr7178275lfe.45.1672309852903;
        Thu, 29 Dec 2022 02:30:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bu16-20020a056512169000b004b5ab5e904esm3027993lfb.306.2022.12.29.02.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 02:30:52 -0800 (PST)
Message-ID: <a606f91c-1a68-09c7-2081-03484fd0d513@linaro.org>
Date:   Thu, 29 Dec 2022 11:30:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: rockchip: convert
 rockchip-dp-phy.txt to yaml
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        vkoul@kernel.org, kishon@kernel.org
References: <aa6fe473-71f2-edba-f009-994a3dbc9802@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aa6fe473-71f2-edba-f009-994a3dbc9802@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2022 10:44, Johan Jonker wrote:
> Convert rockchip-dp-phy.txt to yaml.
> 
> Changed:
>   rename file name
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

