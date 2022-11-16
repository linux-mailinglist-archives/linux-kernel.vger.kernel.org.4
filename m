Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA49162BE8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiKPMsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiKPMrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:47:48 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C0120BEA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:47:47 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so21619446ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApBIfEwo885xQmDpuBZQZ4uu/5xCkclin3S53sCvBW0=;
        b=lYKfDA6BG2sTTpH7gEBNo4cGkODqXpIzDwGoglpxZDVc5BpDyaNBj20ihPyKjg5E8K
         JxVUw6D8O1Gc3dj0TYqv03DiDRf2bN88xe2SCGVMZf86/2F/jM5ixaiaexYwju2gobUt
         sgdUqhxoNUzIRfp0ga2mzDRuAkjfv0FocGZQsdlc/MrDXZqUxZ7BGNArZJUPUJKqf21M
         0OZMUOjSrpcfXoE46qsWzW85ORqL8Rjr7oajM135h9W8vbDU1KaexCyEBj+PwQU11HnX
         3hUUZO6Wa/Bflef4xmf2tDWYq53v5KpVkziA2lhlMFIOXOMuaU6Es5DtQ8ylDArgzwFM
         +dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApBIfEwo885xQmDpuBZQZ4uu/5xCkclin3S53sCvBW0=;
        b=N+ljNPbb7VkLAQD5fzOxygOxoBJdEsPnokV8RBIhPwk/9dLk97hHi5yJhiJ8HMiFe6
         txlAZPaSm1xoHSsx56tVy522rZOjflnTwq6c9vjkY+hvovYZJJ+E+cnYyhtGZhmWt5il
         Z8DzW+mg0lgicqTijRLqWSXrWoa6mMQdHydfsa0CXrULaUg82ErVWaMtvufg6RjUcTTO
         9B8ufz6e5vF7PTlFLePeERrLXgHrPDc8UhwoX+YwvjPTTLDYQMsqzIKnp6IERyci27ub
         MfvgLEq2siQCNL0zsoSYgYvkIJNedIIoMaad91/2torW+0ieXef+DNrTj/CZwIdhJImm
         aXPA==
X-Gm-Message-State: ANoB5pm+i9GyLanQlb+PMNHiN99R9j/EVs9fp8oVbhxecC+KHg8pYfKh
        HwD34mpikH9r19CiwBjkrUsH9w==
X-Google-Smtp-Source: AA0mqf44eCR7hbsG78OJeZYWtRWIaFn9x1lu0KtuyV6erCUj4leLCb3kXt25JP97j/F6tV7KQq3ozA==
X-Received: by 2002:a05:651c:198c:b0:26f:be44:5349 with SMTP id bx12-20020a05651c198c00b0026fbe445349mr7433580ljb.348.1668602865849;
        Wed, 16 Nov 2022 04:47:45 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o14-20020ac24e8e000000b004a93b8508edsm2584064lfr.181.2022.11.16.04.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 04:47:45 -0800 (PST)
Message-ID: <b98026c7-4e54-025d-cf90-61054e887dd3@linaro.org>
Date:   Wed, 16 Nov 2022 13:47:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/4] dt-bindings: arm: rockchip: Add SOQuartz Model A
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116115337.541601-1-frattaroli.nicolas@gmail.com>
 <20221116115337.541601-4-frattaroli.nicolas@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116115337.541601-4-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 12:53, Nicolas Frattaroli wrote:
> The SOQuartz Model A base board is a carrier board for the CM4
> form factor, designed around the PINE64 SOQuartz CM4 SoM.
> 
> The board sports "Model A" dimensions like the Quartz64 Model A,
> but is not to be confused with that.
> 
> As for I/O, it features USB 2 ports, Gigabit Ethernet, a PCIe 2
> x1 slot, HDMI, a 40-pin GPIO header, CSI/DSI connectors, an eDP
> flat-flex cable connector, a 12V DC barrel jack for power input
> and power/reset buttons as well as a microSD card slot.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

