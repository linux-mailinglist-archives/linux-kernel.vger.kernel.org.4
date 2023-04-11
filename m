Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C46DE0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjDKQZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDKQZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:25:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DDD30C0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:25:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94c67e52a65so82452666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681230341;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n4pN0D9VuThWZUSG0wK1df2D171dEbvuMFuz0NllzvM=;
        b=beBh2tRYUlndBBDBXrhqMnHvr8qHthO1QAZBaBNo+8s9qVG+FghzOXJ2G1pvHBG8Zj
         27eAy6InpwvsEfnVkudVStHlpJipiZGtKrqK30NsyU24/DG9GOJStKCUl8UhcHEHYjap
         LE34iMRiUXALFUDo3VKF348WPUHApfQH262EwSQUttp0rftaZ8MMC8VI8oKGMTFPLhie
         Q/OPz+cYTxDL9XGk0v+AyJeoh2xskh0y6kGtJt7yLIselY+UPZ8BUF/jmtEE1Xno+Wia
         8PJKXGRjtZf/fdjOux9t4emwLJkTTyTLIvrCjCB5pLEWcj03aL2/dUesD1b/GIWX6WKP
         am9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681230341;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4pN0D9VuThWZUSG0wK1df2D171dEbvuMFuz0NllzvM=;
        b=n/F9S1zWbzfSGt/m6AQ/Qi8aOY1XoLC+hLs+0Wc/dLYdLgqia6wcMzrHydlfp8Nsk0
         vaA5YksC0XPNLpGwNKtfGhwN8mstHmRlyxReYMf/33HYkuRRwBWASOL8qpXRLEaCWbT5
         d0QZenTvo2ipOy3FWN4XUxJylA1G4ih+wCM2AiomBwq/7XQywyita7rWZvJ2+Duc0gGS
         D0nk2AaYUWFn2Vcy6NdFyPk8W8NHia5UC4cIwrrO1fAi1EHi+zyuGslFbZrfzPQTnVDe
         EpXKvUA2w745L/VrdHoCplsw1xzzQ+/y/0AK3wRIyujBhnGFxyJ/t5Fk4GoZvU2ROt26
         lEmA==
X-Gm-Message-State: AAQBX9fFHcq24CNsM/8BuMB0p2GP3V1sNTGEgRy8e2Fy5A82DYKq+wnG
        4T6pGW3iDPS+qHAXDgS3CwutFePkvRH9gDLEg/I=
X-Google-Smtp-Source: AKy350aqESOGF8H17ENQH7ojuh+bCJMAnBVBm9S6gRFFUTNY7b88sqEEL2AYinPb2G6eqSQeqn3mIkT90EEt/41h/CE=
X-Received: by 2002:a50:9f24:0:b0:504:ca21:cc64 with SMTP id
 b33-20020a509f24000000b00504ca21cc64mr458514edf.2.1681230341195; Tue, 11 Apr
 2023 09:25:41 -0700 (PDT)
MIME-Version: 1.0
Sender: donnamcines@gmail.com
Received: by 2002:a05:7208:112c:b0:66:70a4:2fd9 with HTTP; Tue, 11 Apr 2023
 09:25:40 -0700 (PDT)
From:   Dina Mckenna <dinamckenna9@gmail.com>
Date:   Tue, 11 Apr 2023 16:25:40 +0000
X-Google-Sender-Auth: skAErOEVzbw0r_iqUvs0QJyW_8M
Message-ID: <CADM2P8mEXLkYmA6VeUt9P9TSkdqEpTPgD3-Z8OwbnqX47gMo=Q@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.9 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62d listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dinamckenna9[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my dear.,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina. mckenna. howley, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ( $11,000,000.00, Eleven Million Dollars
).  Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for..
 .
I'm waiting for your immediate reply..

May God Bless you,
Mrs. Dina. Mckenna Howley.
