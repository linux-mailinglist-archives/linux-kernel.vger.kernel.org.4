Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98098714E95
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjE2Qkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE2Qkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:40:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CAAAD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:40:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f4bd608cf4so3888667e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685378436; x=1687970436;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mdl7iyxHLsZbGeCo+UifIEdOQsnJf9ko2YU5LKNcJNQ=;
        b=fb8DazAavEBHhoCImpwoUOH3OpyDrNE+CRsfytcf3Hmq+ITERQghdpLrOV2WMgs/7O
         LGfY9K4sGfM9uLJqtC3rte1hkESQI/Qw1HT19X2WRFRwr2tMM9g6XmBnTwqpAQT1Xf5D
         OBnl8l5QxS9y/SYVkWtu2rA2DYXR2GezroOKLwfmUWnbYnZwrQRbHyonevjS+KTuInXK
         YVjHPWs4IymwqcKjX4MCBA31SmGZ4BSJ1ywuC505TBpnZRpxfp0XyBDvptfIYj1vifpY
         bg+D9poeM7JKXSmTgG8lJB1X+MGB3KWm58APohZKPKIWC/Bh8NxrBHogQ0fBjoPzHbiF
         zPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378436; x=1687970436;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdl7iyxHLsZbGeCo+UifIEdOQsnJf9ko2YU5LKNcJNQ=;
        b=YxILH73bLcivmrrnaaHKuBoM92oyrTLxXsCjN86/6Qeiaw8Zg//Ea3mxYz7Ku5G4R/
         Xn/rsaZYNOlT7/Xdi8U61KU20ac4JcqR3mQj12XlrilttIV/2z4J1Er0OhHIZW1USxq8
         WndEeIwpVsgE+zgG/wT/PM0g4uo6Y8F5lI1dGENT5LLKwFUAryMaIy4c/YjRaPfAdeYh
         gK2ubtVJV+Msm/ECqJS5f4vCoZCvIFMmhuOVONM9qgTQ2HXY5ZHRpZU/8CQfKzAZ4Uy0
         NCU0Gf6i2s507FI6+A6lCmdAAaEH7wKTdSYIzOp/kA3+NDhiz58HL0jq3t8//uGPzK/m
         mNTQ==
X-Gm-Message-State: AC+VfDweDamwqicUbxDVaVn2aWeqtmbzdZsk1W6OlFSZCIOugVx4/uoI
        LymWKC2M4mQXxXDF7yxEhR4gwO/cWhxP+Zw3mQ8=
X-Google-Smtp-Source: ACHHUZ4BQtyBj1Q/Wx7HZ2s3Xo5KXv2d/Z/pXM57f7vGX5vUwdNu3sIGDK5WljZEAjCAbUX+spGY0SJF2z8lm+DDy/k=
X-Received: by 2002:a2e:9c0e:0:b0:2a9:fa39:236c with SMTP id
 s14-20020a2e9c0e000000b002a9fa39236cmr5166424lji.9.1685378080349; Mon, 29 May
 2023 09:34:40 -0700 (PDT)
MIME-Version: 1.0
Sender: samukafand@gmail.com
Received: by 2002:ab3:4719:0:b0:230:9312:c4ef with HTTP; Mon, 29 May 2023
 09:34:39 -0700 (PDT)
From:   "Mrs. Ella H Jonathan" <jonathanmrsella@gmail.com>
Date:   Mon, 29 May 2023 17:34:39 +0100
X-Google-Sender-Auth: _KdIqVeTVmSX6Kgyt4LvWq4v-z0
Message-ID: <CAHLDSs=OMcyWUhcwzFb-3y1aNC+gU5=o80cNTZ8Ozd5Yw4a1gw@mail.gmail.com>
Subject: Greetings Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:134 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [samukafand[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.7 SCC_BODY_URI_ONLY No description available.
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.7 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to you Dear,My name is Mrs. Ella H Jonathan, a citizen of
the United States of America. I't is my pleasure to meet with you here
on the internet. I know we have not met before but my instincts led me
to discuss a very important project with you that will change lives
for good and I promised you will never regret this offer trust me. I=E2=80=
=99m
currently hospitalized in a private hospital here in Texas as a result
of brain cancer. My purpose for writing to you is for a charity
project with your help, the fund that I have in my private account in
Burkina Faso.
It is clear that I=E2=80=99m approaching the last days of my life according=
 to
the doctor. I=E2=80=99m offering the sum of $4.2 Million to anybody that wi=
ll
invest the fund wisely into profitable business ventures and donate
part of the profit earned from the investment to charity work
worldwide; I am helpless to do so as a result of my health, I urge you
to help me fulfill my wish.As soon as I receive your positive
response, I will detail and also direct you on what to do.
Regards,Ms. Ella H Jonathan
