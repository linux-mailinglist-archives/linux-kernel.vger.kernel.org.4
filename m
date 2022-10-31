Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7296612F64
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 04:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJaDy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 23:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJaDy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 23:54:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DE7C33;
        Sun, 30 Oct 2022 20:54:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d24so9687874pls.4;
        Sun, 30 Oct 2022 20:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrjorLBlvDtmWtMSJKOwvcOGTL2TqDIUVSt7WPVuaGg=;
        b=kxC/JHgD5g+3CdtjhcprQSYNsvW7ZfjvM7O8/VZrDSZ6xzM5VD1ENqgdVMAtHLpNvn
         4Lpx9e6TFgCLM2Sv4Ujo30KCW0tjWYxRVqfdGf+xRHOCN506soQxcqBOH9P1au6xM8T3
         bBx4ZisODvpk/FU1HMV6VMI2rGJIu0Ke/x+/RUstPdW5rcBBEUly34CUdOE2XPkD470O
         0NJwu9xKy7cCGOHFuxEudkBQ7V9HCPVOATRBksYQuUt4TGoafbTGmo/ZZGrGptf9ZYzG
         hwq/1s1OXs5gV6Po7eB+nlfKdVdDBx7ScvzCa4RDldzLs+coPmcr6nQ7oPaAbeph9RH4
         kRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrjorLBlvDtmWtMSJKOwvcOGTL2TqDIUVSt7WPVuaGg=;
        b=WYY4wDTjkVKDUB0y9U3L/uwZmfF8ooMGAm6j8PCxPNcQ40p+1Aq8tZqHUv8Ot+AdyO
         u+jRl/Wmy7+bgs3lAGl2NyQ03Wanua/JrdLuH/KU689GyueGYpB2uys+ciH8EwUbUqFK
         vjxw/nq3OdSs7sOmfcPBHrT2UHdHynkw849en/IQi9sMqcM+jsvqnN7LxfOLEOfMqCpX
         fXaUrwdbkNDNeV7npsiEN57VwpRWFV/73vpKYw/7Ry9lO1NTUaN/6U4rgtwa8UewXBe4
         Ql2i9iqDIRW5M/F4HLvTO+ye1ojy2f1Lvm4ONy2OwWlMKD1Y0ydmmSXw5uYNh1DKEx/5
         7PHw==
X-Gm-Message-State: ACrzQf0Cu3489koA5xy40/CTe3bKeMO/bKO8UU5t9ra6Zx/Duily4VOF
        h/myjm01p5Khm/42IVheRT8=
X-Google-Smtp-Source: AMsMyM5kp2e8NvsHp2XdASiuuGMQsvky9EELpwXRgZCNLWHCX16hweF8Nt6o+0Xy3gQAwzbejcE8zg==
X-Received: by 2002:a17:902:e54e:b0:187:ba9:4305 with SMTP id n14-20020a170902e54e00b001870ba94305mr9109070plf.167.1667188465185;
        Sun, 30 Oct 2022 20:54:25 -0700 (PDT)
Received: from ?IPV6:2001:8003:d90f:f801:7164:b4e6:b90b:c4d5? ([2001:8003:d90f:f801:7164:b4e6:b90b:c4d5])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709027e8b00b00186f81a074fsm3332363pla.290.2022.10.30.20.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 20:54:24 -0700 (PDT)
Message-ID: <67bef642-a301-e825-142c-afcfe8c898a1@gmail.com>
Date:   Mon, 31 Oct 2022 14:54:18 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] staging: vchiq: add 'static' to function definition
Content-Language: en-GB-large
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        kernel-janitors@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221022043548.1671644-1-scottjcrouch@gmail.com>
 <Y1Okpjbi2kKU2GFz@kroah.com>
 <52599d6e-dc16-4186-9fb9-d17ce428fe9c@app.fastmail.com>
 <b874e6ff-6a19-410f-1fe8-2334a58f503a@gmail.com>
 <d64dc0b4-ba82-49f4-9a43-c50b735ad91d@app.fastmail.com>
From:   "Scott J. Crouch" <scottjcrouch@gmail.com>
In-Reply-To: <d64dc0b4-ba82-49f4-9a43-c50b735ad91d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/22 21:46, Arnd Bergmann wrote:
> Hmm, I see an of_node_put() between devm_rpi_firmware_get() and the
> error check. With OF_DYNAMIC=y, this is an external function call, so
> I guess gcc can no longer assume that drvdata->fw is NULL after that,
> so it doesn't make this optimization.

Ah, of course, you're right.

> Ok, I see. My best guess would be OF_DYNAMIC

I checked and you are correct.

> but I don't actually see how that changes anything in this file

Yeah.  I had a look as well and I'm similarly puzzled.

> This would mean you only get a warning when both RASPBERRYPI_FIRMWARE
> and OF_DYNAMIC are disabled. If you can confirm that, adding a dependency
> on RASPBERRYPI_FIRMWARE is still the correct fix.

It builds ok as long as OF_DYNAMIC is set; RASPBERRYPI_FIRMWARE doesn't need
setting (maybe since devm_rpi_firmware_get() is a static inline it's optimized
differently?).  Perhaps RASPBERRYPI_FIRMWARE ought to be made a dependency in
any case, but since it depends on ARCH_BCM2835, doing so will mean one is
unable to test-compile/run sparse on x86.  Which is fine; I wouldn't expect to
be able to; I'm not really sure what accommodations (if any) are usually made
in this regard with respect to drivers.

Scott.

