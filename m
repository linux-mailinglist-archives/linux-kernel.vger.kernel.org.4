Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FBD748119
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGEJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjGEJiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:38:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379D31984
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:38:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51d805cb33aso8126677a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688549882; x=1691141882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9E3DFjyS3AwoXNYXQJtajaRjHAR/oH9qWaIvl/POoE=;
        b=XBS9Og1cOUyEZF/mJPK+vLsLJCTSBGYAOXMg/y0XgssJ5a2xigsCG55GWPD9/WEAiB
         LeY55PMcdTlvd4l7+rzT3cd28uvtag3rNH6Xvg450IjyVHp9W8qAnCL+J6Mt7xRmPoJq
         4Bw6lNUSteSOoXN01/gUA9v8zQPm3s41oCsngI7GBEDVYhH6nV6KEECpW69pTpkY9x77
         C6TgL8WxrgSR3Wgnbel037CrbgPNbpRGIO1PlNqV9UoqZFNQWUNiLJOvy8kifyUBcgLp
         7MroPP3h2bch3GFHovB6Iyuk38kNindAcTnI9D18mAgqGwNlSMoR4HzcytGo8m2GlPwm
         IMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688549882; x=1691141882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9E3DFjyS3AwoXNYXQJtajaRjHAR/oH9qWaIvl/POoE=;
        b=Am9sdlsSaayq7qa02Cln03r3d/vjl7yOqzF0cvH5NCTgUZDT7sX/RS9meACzYSJIEU
         CcOIiXf0xsvo4wpDOrShw6QL4UPT/LcoQc1O62g+lIsJxcuf0L1Qv3ldQTEVL5Mibs7M
         pHTT8Z2Q5un/hnJ4YaQiLiwOfuH4q4yVKdws/RfBd5iJ1nIADecaUOemgf8zBccS/HDK
         5E0Krow4ZQ6F8lxbvPj05aPCbBdyXri/yVTuTkAixByEOE4zKoF+wO9JXIfgcPm/hmdD
         ontLpWgbojrybbmMSP2i1Eafjmp2ea7r50//6jRgq/XTHrRlFEbaKBnLys8N1c6284Jc
         3G9A==
X-Gm-Message-State: ABy/qLZQekZXahCK3wgdBZUBtM9nIHCw7zh97smf06mlfH5D+5DQ/TWg
        yGTtOqf4EFHEZ8ttCqlPWAwNww==
X-Google-Smtp-Source: APBJJlHjF6+wzREVkufXOyuuk4kspujEQdmLJnXQZ3iawFOZ9vusY/oG/uaDqeso07ySHKQooD7sAQ==
X-Received: by 2002:a17:906:2c51:b0:978:ab4a:2154 with SMTP id f17-20020a1709062c5100b00978ab4a2154mr11654310ejh.1.1688549881787;
        Wed, 05 Jul 2023 02:38:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ha22-20020a170906a89600b0098e0c0cfb66sm13738322ejb.38.2023.07.05.02.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:38:01 -0700 (PDT)
Message-ID: <9b7e8438-411b-457b-1e5b-c4b37981ef67@linaro.org>
Date:   Wed, 5 Jul 2023 11:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] watchdog: s3c2410: Fix potential deadlock on
 &wdt->lock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>, alim.akhtar@samsung.com,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230705090951.63762-1-dg573847474@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705090951.63762-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 11:09, Chengfeng Ye wrote:
> As &wdt->lock is acquired by hard irq s3c2410wdt_irq(),
> other acquisition of the same lock under process context should
> disable irq, otherwise deadlock could happen if the
> irq preempt the execution while the lock is held in process context
> on the same CPU.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

