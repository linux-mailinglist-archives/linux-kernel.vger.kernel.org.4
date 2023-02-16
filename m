Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511D3699FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjBPWsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBPWsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:48:14 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3885332CDE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:48:13 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id p14so3703346vsn.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AvsbfoTrkofPPrMEGXm9NJZhm721PG684wG3M8d2TEE=;
        b=EAwW3Ak0mWK0Fx4ouhKrH0xFzeeNuUn1SJL3I/4hIVo2TwB8yTNGBBAbKM53M3+jWW
         u7maOV4ngJyH+sbNzVFpS2q1BdskC0Cq9upKMsi9NEnL21i4Q/tpNTvje6O9dKlclbT8
         Qg44obyVvz+tNKFq6YfYS9eZNRvVGHLEUv4LLd00/zzdxl4Ucj6ZAt7H6kkOUnX+yRbq
         XQSzTr/cl1Ja2joZjC8FhJ7gtoaPv+S5CL4et6tZnVS8zAhpTN/x64vJt3JESG4yDi3K
         invVDbxyBR/hNgGE3BgyLApk5UqQ7y6qnj+qxjOC6ykl94GuPPWZB+sF/hqQBuIueg9Y
         7Evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvsbfoTrkofPPrMEGXm9NJZhm721PG684wG3M8d2TEE=;
        b=r13QbHADnIXCYkPl4s+l2iXjQm0JKR+vOXLpaDirFBgi6RPVdqu/qFeSGh91LTFb15
         wLNL8BOIYkoMgeUvzhgzxHjkYbbj6rK+vwF3IYlaHPJWROWo/cEyg0385Xq9ta/l7dX6
         N5w6SPqvEt7sMTIKEe4eB/IEbwS57konscGuQt7CE3gaEt476/19AholSIAH8zWnjnEF
         +3jYrz2aqSjPc1CBfw7EYcsMj1hvHUruaaP92tFDkRfq/K7oeYQ14GwuQGWfpo0pe7Sy
         kYJVnGg6GpL+l6MM4UiVMEvLX/jX0zYQ2V+D8QWnPsrw7Yceo2XS9nq0iDBlxaVodb04
         JDmA==
X-Gm-Message-State: AO0yUKUNhQFYTjBjY77DYA2yE04SCLHp9c/EVPq0uDzP98JLlVNMn/j0
        yO/PVBvqHHzvvx7F5suSWXmzO7f7IKfBw15YZHo=
X-Google-Smtp-Source: AK7set/m/5nL/fg8bw22PRCRlO6wQwCmjawf9wWBybJa2gpJ/2fsdpyLC3HE4Rizkl8Nw1bdittJnjpxEh6skksfJ2k=
X-Received: by 2002:a67:e8d3:0:b0:416:3fa4:352d with SMTP id
 y19-20020a67e8d3000000b004163fa4352dmr163962vsn.1.1676587692157; Thu, 16 Feb
 2023 14:48:12 -0800 (PST)
MIME-Version: 1.0
Sender: fredmartins266@gmail.com
Received: by 2002:a05:6130:c15:0:0:0:0 with HTTP; Thu, 16 Feb 2023 14:48:11
 -0800 (PST)
From:   "Mr. Daniel Kafando" <daniekafando001@gmail.com>
Date:   Thu, 16 Feb 2023 22:48:11 +0000
X-Google-Sender-Auth: Tg2TLM2v4_eATD1-MUq_HaHba2o
Message-ID: <CAGM7co8VH00+v8K9WBRFcJ=Zuf4M-VkQZVux9P9n9Z2cL2umYw@mail.gmail.com>
Subject: Am Waiting to hear from you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_3,NA_DOLLARS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e43 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [fredmartins266[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [daniekafando001[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.5 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  1.4 MONEY_FRAUD_3 Lots of money and several fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Goodday Friend,

I apologize if this email comes as a surprise as we haven't met before.I am
Mr.Daniel kafando. and I work with UNITED BANK OFAFRICA. Can you use ATM
Visa card to withdraw money at ATM cash machine in your country?  I want to
transfer money to you from my country;it=E2=80=99s part of money taken by s=
ome old
politician that was forced out of power.

I will change the account details to yours, and apply for a visa card with
your details in our bank, they will send the visa card to you and you will
be withdrawing money with it and always send my own percentage of the
money, and the money we are talking about is $4.2Million us dollars.
Whatever amount you withdraw daily, you will send 50% to me and you will
take 50%, the visa card and the bank account will be on your name,I expect
your response. promptly so that I will give you further details.

Mr.Daniel kafando.
