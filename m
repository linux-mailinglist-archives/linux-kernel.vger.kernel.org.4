Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CBC60AF50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiJXPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiJXPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:42:50 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BFF9DD95
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:33:59 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id 8so6161485qka.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cN6ievQ13OKelgQO9QAAFjWOVAIp8kFl6S2NHqMvnjE=;
        b=LHKQ5P4Tj7SB7wxOyr0cPnL7Lw8ep/oRa1X6oDKGwCzAm5Vmpbd4FV0qhA2ld6wYZ1
         HMoYvJm4hO2bzFwHaAlRSRkxHjMSGMqlkOL8cEEOD7FUo6drKtHWFiuH2ofO2jtQy5lP
         qEqaD/lEcUCgHuanQPpuMzHeHuh08Wl+W+4g1bmrQVNFbmQOb9e7Wt6CtA3ootl2X2EV
         PQgyB+8JsENxJNgEf8rjjNT0tTAx5iQeKbspRIhTT4dpbYHumEMxWSvs8manl+XBkmZ8
         ZhXCD7yhmyZVhl8tKYbbGjaRZomARDLLrbR3D97tRGdEshm4ntOmtGvJ0CQx3eLIwf2D
         MzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cN6ievQ13OKelgQO9QAAFjWOVAIp8kFl6S2NHqMvnjE=;
        b=ROP1hwt55pX9cDtSExj4+bG1GbIG6ALR37ARaMfQLW23cg1ohq3qun99uukh9Fpczy
         /qSigLOCi+TzvCSQbm3WZ37M6LwQf1WgDy6PiLzYYGlhj3/Ubt8vHp2J85F4rzXUCJ9T
         Wum5RrZ/Pae0m2MMLv26ffpxJFWuaM/0EQbk+G6Km9Y545pCv90HT5ZJ758EA74tEJ1L
         uYrPihkWIoDsTiiMTryyhzIkxz2jwkU5TXL2ea3auoDnddhItav0tB6kwo3FQpHTREBF
         00Hy0rBHOvsExwGcMUwXyWHe4sLe4wjM9lgM/sJ1upU9GxvqoyeXO9Z4UbedhCLZ7CoT
         ksdA==
X-Gm-Message-State: ACrzQf03os7AvxoJNY7A0S5FDBEr8thsqvUFPRK4cRHJCRjC9+Rxi/Zu
        Hds60OJamV/quJqXmxn9XlcfP6pHM38tnw==
X-Google-Smtp-Source: AMsMyM5LZH9fzYpnRkQmI9ibZVvwW99/0fwSADaB8HWLnzA5NP3HlQNPHGWawkh79UOs7VJEuo47rw==
X-Received: by 2002:a05:620a:348:b0:6ec:a429:cc88 with SMTP id t8-20020a05620a034800b006eca429cc88mr22650579qkm.648.1666614686900;
        Mon, 24 Oct 2022 05:31:26 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006af0ce13499sm14986172qko.115.2022.10.24.05.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:31:26 -0700 (PDT)
Message-ID: <c4af67db-c7c1-84bb-c5c3-694098946bae@linaro.org>
Date:   Mon, 24 Oct 2022 08:31:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 07/21] power: remove s3c adc battery driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Lee Jones <lee@kernel.org>, linux-pm@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-7-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-7-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c-adc driver is removed along with the s3c24xx platform,
> so the battery driver is no longer needed either.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

