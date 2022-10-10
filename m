Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569C75F9A90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiJJIB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiJJIBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:01:55 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE83D53024
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 01:01:53 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id y100so14791613ede.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXUl3DqLFbTtFtCoMEclQM3ZbKkw2ZlACbyEiXC/hso=;
        b=IwBfBeV/wa7Vvc49Xe7/11KjSrRk7jQxcXKH6Cm1dZsP29LdDMBDgfo/hh89QVrLSY
         OeWtlUtwMR4xgf9IdScn7XxAxGP2Mbk/JoAz7RPH6MiCdM4K3ujxRrO9KUJvN6Ud9hHq
         oPo/XE+f/U9rfUBzrkstGGKoWaTTJdj8SPHwegNyaalGBxTF65IqsSOA0LFXJiN53QHC
         r4kAMAdhodXMI3Wb/boahRum8OzUlkaKXZtcIln3mK34LeAeiXfFlC4IFzINUdek6S97
         hiTiKa5gkU+mx6uaz05MmViZSIlFOGT8fw4jxFIIPOIeb0D1MPO4IjWt1MBRixAekFm1
         w7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXUl3DqLFbTtFtCoMEclQM3ZbKkw2ZlACbyEiXC/hso=;
        b=Zh07jg9hsdBQ5fGOhod10d4kPSzhm2w2zXHU82ob+ApELFNHLBVYXaflABRJ1btOAy
         Lut6uzCElXG/j5RFOqLEoiXqInahdr804yh61SAtx5midmj1YRvtwVkMVfdBkTqXceJb
         6284B2N/dZrhLodHrcb/C+KnFSFLySD9ikExHATPCliJhnGTOy7hqKEc1c2vLtJc6QGZ
         XBR2oNWNiiXBou7eDdZd+LIKK3F5nCDGSjfeR9FkR9OPTWmpE7Z3W867rULQu5UBVnkr
         tCyoEAS4ZmEUWNU78eRI1/tsIzp+rJor2xHWqaMa7bZBAIJvEsU0E6oTaG4c0L/DQe+h
         d4Cw==
X-Gm-Message-State: ACrzQf0+G3dPpeYFRwy1QUugTlb7/jETOgq+V217ZppDS34mr99SDyJ/
        KdTFvfi0GrdSWDWkvMVrjxWwCgKtWjlSPNQ5Wks=
X-Google-Smtp-Source: AMsMyM79yeEHcxBQX0twBFEwSiz84k7mqtMS6bsXW4gDUctGELACwVqhjFuYPxZw91Q5VdqtigItM/y8gcZBWpp1Qog=
X-Received: by 2002:a05:6402:5192:b0:459:b6e8:b45c with SMTP id
 q18-20020a056402519200b00459b6e8b45cmr16458977edd.233.1665388912404; Mon, 10
 Oct 2022 01:01:52 -0700 (PDT)
MIME-Version: 1.0
Sender: mattwesst445@gmail.com
Received: by 2002:a05:7208:c04b:b0:5b:81d5:4720 with HTTP; Mon, 10 Oct 2022
 01:01:51 -0700 (PDT)
From:   Ibrahim idewu <ibrahimidewu4@gmail.com>
Date:   Mon, 10 Oct 2022 09:01:51 +0100
X-Google-Sender-Auth: pP3T6Rty0IVR9neElKsOQZacRDI
Message-ID: <CAEg6tVcZDAK2b6aPYkokqhev0QQyB0XzzZwxvzdDwtSHihUtbw@mail.gmail.com>
Subject: BUSSINESS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_SCAM,
        LOTS_OF_MONEY,MONEY_FORM,MONEY_FRAUD_8,NA_DOLLARS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:544 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5814]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mattwesst445[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahimidewu4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.8 HK_SCAM No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  2.8 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  0.0 ADVANCE_FEE_5_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HELLO..,

My name is Mr. Ibrahim Idewu, I work in the bank here in Burkina faso.
I got your contact
from internet search i hope that you will not expose or betray this
trust and confident that am about to entrust in you for the benefit of
our both families.

I discovered an abandoned fund here in our bank belonging to a dead
businessman who lost his life and entire family in a motor accident,
I am in need of your help as a foreigner to present you as the next of
kin and to transfer the
sum of $19.3 million U.S dollars (nineteen. Three million U.S dollars) into your
account risk is completely %100 free.

This is paid or shared in these percentages, 60% for me and 40% for
you. I have secured legal documents that can be used to substantiate
this claim. The only thing I have to do is put your names in the
documents and legalize them here in court to prove you as the rightful
beneficiary. All I need now is your honest cooperation,
confidentiality and your trust, so that we can complete this
transaction. I guarantee that this transaction is 100% risk-free, as
the transfer is subject to international banking law

Please give me this as we have 5 days to work through this. This is very urgent.

1. Full Name:
2. Your direct mobile number:
3. Your contact address:
4. Your job:
5. Your nationality:
6. Your gender / age:

Please confirm your message and interest to provide further
information. Please do get back to me on time.

Best regards
Mr. Ibrahim idewu
