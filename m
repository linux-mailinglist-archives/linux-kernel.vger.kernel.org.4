Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7636FFF2D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbjELDFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjELDFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:05:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255D810F6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 20:05:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaf706768cso72571685ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 20:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1683860731; x=1686452731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3b2RvaJXfQ5zR3nTIkcT15IM6elhbQqCWXKfNrsotZA=;
        b=4PXfIb6DjCUiVPjkOTt4RSEzOkcKi1Md1cgslqIfx+lXtSHUpPRgi9KSHJ+kaJQ86U
         2MIRm6aiKKCxyRV+X/3/0mI3w4I7u3d33syOfNzPkP6znVlE0OlINy/8sDZh5UIl5teB
         PC75YsK2id++sRei/5DdjJmyxbAjPlr/7cxATRRIVBpVqZZdT8WMAlzVExK1e8l9Do0X
         89FjXP03IwrI54U6PU20lvDbOVrqz74pR+axEgb19BUnfM5jsW8wm8pG2zwwkQsZJzIA
         kqz1XNk/W5A6KyQ85FGd3X3oHpRpcj6VgPs1N4+nki1LWJgofRqz84NYZMv4cIOGCH7j
         twkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683860731; x=1686452731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3b2RvaJXfQ5zR3nTIkcT15IM6elhbQqCWXKfNrsotZA=;
        b=M/lXWYcWYP+Aj9A30zj0Y/j9OTm+ahXm68mmdOvIsofYoZSyogSEmjM/2o25vc0iCt
         +sHRo9gQjENUq7OW3u6OlNjXfs+6nJEIxf37URdUjpTfR8oTQClco1UNEvAo5BItpNKW
         j6cPEsiYpuxNey42kbwhZXBq35yHwvYCT9XIBMFxRNOrRueXMnqDnJU6WpgXAULp8LhF
         /HZC4ixOEZ2uM09d4We2qmqOczzByTy7E1RkYG1e7VemXgV7q9/JpHN1W17rrkhQ9W2b
         Yj28/MgBOFCvzopmhjGX/0pUJX6i3X/rAc1GWFpMNRP2pjvq56mbnyriqD396KNI9gSW
         hiEQ==
X-Gm-Message-State: AC+VfDx0v29XjIwfgYojnt9ALpjIsJM6EhB3JUPQj7rZBr8HBP6QGLTU
        FYOuaPQaREGHqpjFKuQm8FipSA==
X-Google-Smtp-Source: ACHHUZ4JetzMh5Epbhde5u4VMm1fC53wmGYqo+OiPwR4NlDF/4/zDPSdVcT/mdzohJyTEEp9lU/GQQ==
X-Received: by 2002:a17:902:e801:b0:1a9:a3b3:f935 with SMTP id u1-20020a170902e80100b001a9a3b3f935mr31480958plg.57.1683860731430;
        Thu, 11 May 2023 20:05:31 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902868700b001aad4be4503sm6705940plo.2.2023.05.11.20.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 20:05:31 -0700 (PDT)
Message-ID: <29024a98-e0c3-449e-e430-3041a160e4e6@landley.net>
Date:   Thu, 11 May 2023 22:21:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] irqchip/jcore-aic: Fix missing allocation of IRQ
 descriptors
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
References: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 11:33, John Paul Adrian Glaubitz wrote:
> The initialization function for the J-Core AIC aic_irq_of_init() is
> currently missing the call to irq_alloc_descs() which allocates and
> initializes all the IRQ descriptors. Add missing function call and
> return the error code from irq_alloc_descs() in case the allocation
> fails.
> 
> Fixes: 981b58f66cfc ("irqchip/jcore-aic: Add J-Core AIC driver")
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Tested-by: Rob Landley <rob@landley.net>

Rob
