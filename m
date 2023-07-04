Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CAA7469B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjGDGag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGDGad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:30:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111891AA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:30:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51dd0205b2cso9224349a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688452229; x=1691044229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3yiVYKtVrIktx4ZXP2LxSktjdyjNOhoOg2Mns2klPY=;
        b=M6HUebP4sZYJ8sIy3Ulw8RejaiM+OUUBFDv0FnO16yEv5/tUV91WR4q1dWdzG/Bq/Y
         NlaQbI39uIzwqCfchN+Ff9c8SaNUWxjoL9ilI5LukBQBpVm8QJrEPn2FBPQe4cqbom0g
         fqknBmeYBapuhiWOH/4Yo6zBFNU0g1+9+bDRxpLdhCgFTCadvn0eVbLiwxh+Ep4TDZUt
         akG00H9lvXGVNRZ9trbrSY4qxK4jw6Utl/o9lCcromjvtwcaV7lG9WqZkfYkQhDS5YfG
         iy8vzgEF/QrxTFJ1mJGqyykCmjMxWPykEf/LuEqNLRD/68I8gr0gBMHRiugUdXjQ4roR
         19ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688452229; x=1691044229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3yiVYKtVrIktx4ZXP2LxSktjdyjNOhoOg2Mns2klPY=;
        b=dTPdOWLXq5psbdglk6wvp7R/dpcApaYjmFbUoJDiOoDUSUarYw01fSP4+N5+k7+uvS
         LmfQrobhpvL1IxQ05PMxPEdBVK1PuDRL50eWkpgHCV9QN2KogJmFCJFyhBkc/CJuhwGo
         Z6meGRmtbEnyKsZr6n+CVjhTvh/GL4jymnK0yTu34chbEVMvmPEFFQDr3RWaCAxHBS8A
         WTebffk210fJ7gRgYTVMEyL8vphNSmw4BporZ1Fncda58Z/DgN18gSm0Y1vFVYIFYrRY
         oufcayjWacmxZDi8099GXtUvWILGuT0hZ7/Zt0k0KOaYrYLmlIjHk4GymNGSf5F3eIqf
         80FA==
X-Gm-Message-State: ABy/qLa6WuCuzJx/qdgSJLUIYKxKJDpviEk+oTiioCnm7X+ZkWVlpJTm
        IdyqnzPXq5PutUb+9DDqk5+aFg==
X-Google-Smtp-Source: APBJJlHEb87nF2ukavgKodzV2jO99ruTM6e43xXxQc8WM7Dsu3Ys8LNXjWdApqFlzHUz/nR3g9drLQ==
X-Received: by 2002:a17:906:39da:b0:973:84b0:b077 with SMTP id i26-20020a17090639da00b0097384b0b077mr12490256eje.33.1688452229530;
        Mon, 03 Jul 2023 23:30:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a15-20020a170906468f00b00992b510089asm6496258ejr.84.2023.07.03.23.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 23:30:29 -0700 (PDT)
Message-ID: <c2edda13-c674-df56-d1a2-cb47b405b896@linaro.org>
Date:   Tue, 4 Jul 2023 08:30:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 2/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230704020239.288500-1-xingyu.wu@starfivetech.com>
 <20230704020239.288500-3-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230704020239.288500-3-xingyu.wu@starfivetech.com>
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

On 04/07/2023 04:02, Xingyu Wu wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> Add documentation to describe StarFive System Controller Registers.
> 
> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

I don't think there is a point in reviewing bindings which were never
tested. I hope you agree with me.

The patch just introduces errors. :(

Best regards,
Krzysztof

