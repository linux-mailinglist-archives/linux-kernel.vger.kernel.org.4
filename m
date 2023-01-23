Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A201678632
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjAWTWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjAWTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:22:11 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385CF7EFD;
        Mon, 23 Jan 2023 11:22:11 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id o5so10648232qtr.11;
        Mon, 23 Jan 2023 11:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13OGKJbsM6KJUj2kcvvnBWCaTUmZ2jfnnzpHHCmAkxA=;
        b=dGjbYrGLZgVZ+rCIqM7WdkhsBScBCG/aNivswpGhp3PpbuPJ32fxIwUhuuFoIz4Hy6
         bGweT16G34Y51GSrgIChzlljezmmQaCdBdrsG4P19OEfC3AR5smQdy4Jlh/xAA6ib2UN
         2ex58M/1c1jsFf4BTud+41slNRUAGeQhePRevDTwCUqH29IRTGk7IUMUxuuBgCL3Fsc/
         rAAb53D9N1gqdQnbBI3YkVDxRNv3B0f+2nzuZImENqta22zmeRt+cmgN5lAlm1TMtBpO
         vxn79io0I6S3iZ6EBfF5/v6nKMjJAlU2mUj3sqS22y4cXUpJn6muEfR9hNQebMDJPSSj
         O6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13OGKJbsM6KJUj2kcvvnBWCaTUmZ2jfnnzpHHCmAkxA=;
        b=kn9yda9lAapzjJTJ8ifI9Aq2P6TyTVTHNAGBzD43V2JVjpWYSbP9ejm8GhrRW3KXFJ
         FKuEJPk7Y8WQe0776kAV/vjnZR3GBINVdZqEeOfno/2AIa/z5IrbslNpfZ88U8a6mgpb
         g4t2hw1Ze3psOTB17AYu+9DIGEcIDP8dOcV4UhO9a6bLnhnx3le712wtj7IWi6364bwx
         F1BAZaRnil+4LXtwmbTsBSaQ5hIyu3yZf1pIPbjL1Jgm6iLK3DjOdxmCgO6qPs6GNfwi
         i9aFbskH/O1tMWWvUKo4qngWjXVCfAvfIuOOe5993nOOuWeYZptoQnQCssYgR5WTWemS
         sqDA==
X-Gm-Message-State: AFqh2kqrc0jwUN7pyCuMMaDAZ7SbJg/l0nNJI3T/lbagLpWRsJFdneva
        LbiosbQKyud2i3HDT6N8Gas=
X-Google-Smtp-Source: AMrXdXtbzkVoXalQYsHj064hp1V5Sbk2pvDy/0wKasBwlgxhX3djNwVhyTHCg5W2t+69bw2yHtj3Ag==
X-Received: by 2002:a05:622a:1748:b0:3b6:8881:6b07 with SMTP id l8-20020a05622a174800b003b688816b07mr37142147qtk.48.1674501730316;
        Mon, 23 Jan 2023 11:22:10 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g8-20020ae9e108000000b006b5cc25535fsm6497282qkm.99.2023.01.23.11.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:22:09 -0800 (PST)
Message-ID: <6e118c5e-e36f-ee5e-a553-aac47f19ec8e@gmail.com>
Date:   Mon, 23 Jan 2023 11:21:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/6] rtc: brcmstb-waketimer: rename irq to wake_irq
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230120190147.718976-1-opendmb@gmail.com>
 <20230120190147.718976-5-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230120190147.718976-5-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 11:01, Doug Berger wrote:
> In preparation for adding a second interrupt to service RTC
> interrupts, the existing interrupt is renamed from the generic
> 'irq' to 'wake_irq' to more clearly convey its role.
> 
> It is also converted to an unsigned int.
> 
> Finally, the driver message that outputs the IRQ number when
> registered is removed since devm_rtc_register_device() already
> provides a report of registration and the interrupts can be
> found in /proc/interrupts.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

