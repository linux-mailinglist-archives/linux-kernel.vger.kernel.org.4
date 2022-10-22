Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4FC608E69
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJVQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:20:35 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E180C58EA4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:20:33 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13b103a3e5dso7240426fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oP+OivOlJKby7VX0wt07yv8oqh7iwPhSwvHGsEi8ePI=;
        b=tOG0B42BsdazxfhzuTyBJ7MA1j+4BSyU7mlZLhPC+gv21gipF1srZBPJ6Tl0G+18gn
         /9Rsu+duFErhwGXP51ACbYH9ri2zA30YUIdygtg91JoQYs5Oixg53edGQpekz86QBmG9
         +22xyQ8DP6kf5d829+L20tN78RFNfzI5s6nR9QYwnz5snTQ7IMePeC0GFnfdNqlhemkk
         bdoluDTNW8y/ISAzRbs493FQ2BX3RC7o5Rl6oZSZvlVehTYIKPHIR29KBbonMGjX84yB
         n7aSWintkxx6mWv2lSFDqIorHujWmSKhdETTdedqQK7ZpP/ROOUzdt1/QVsL86XuTrzl
         sWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oP+OivOlJKby7VX0wt07yv8oqh7iwPhSwvHGsEi8ePI=;
        b=kFIhLTMuClvj/Oo3v/tcJIG6Av+B0Zbf8JEJ+FWt7iW2Kscie5xo3JBBuKzRoNK78L
         MyiTpBlVbk1o5FsMcdXFUHeZz1vZ3u0zGwzPVSV8v98h+UI0neMIH7DPV7152pepbmDX
         2SS4NeNnHSwP5Uhmw39mxdN6jJFaw66nxeHZpO0iKdD4uYZ7i+o3eecKL09HNbaWFsq4
         JMcW1hnn379Ybu4wLzKxlm3AC3QUAl8BFO6rC1gZpMRGseBCOjTihrZDtAFVNcyn6zvU
         j7Q5c0ju31J4C0xxdKdo8gt53rbvabGoWmIDLHiWA/FUhog7MqMX0vq7nz6AUS0Or8/e
         p0MA==
X-Gm-Message-State: ACrzQf2x1a4Aeh7duKcisP0msRGj6hmQb0PkvpxRsXdHqviDHwHoo8Zn
        8W2BbE5ktyJaPZJWkdR54Y5WWw==
X-Google-Smtp-Source: AMsMyM5HZNHKBt3bPjg0ZWDzXEdMLa6L5POsBmjhsTM00sVzPQsTy/DfF+ZSjY7MoJ8YpzkahPsDRQ==
X-Received: by 2002:a05:6870:c58b:b0:131:9324:60fd with SMTP id ba11-20020a056870c58b00b00131932460fdmr33558787oab.154.1666455633180;
        Sat, 22 Oct 2022 09:20:33 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id 32-20020a9d0323000000b00660d7fbf13dsm2373160otv.51.2022.10.22.09.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:20:32 -0700 (PDT)
Message-ID: <bac3646a-13f3-9031-c5e6-b5d24e0d9514@linaro.org>
Date:   Sat, 22 Oct 2022 12:20:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: aspeed: Document
 aspeed,pre-timeout-irq-us
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-watchdog@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net, andrew@aj.id.au,
        joel@jms.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <20221021151559.781983-1-eajames@linux.ibm.com>
 <20221021151559.781983-3-eajames@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021151559.781983-3-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 11:15, Eddie James wrote:
> Document this new property for the pre-timeout interrupt.

Please convert bindings to DT schema first.

Best regards,
Krzysztof

