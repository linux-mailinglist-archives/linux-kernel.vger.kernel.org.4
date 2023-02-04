Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7668ACBD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 22:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBDV5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 16:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBDV52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 16:57:28 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A7A23C63
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 13:57:27 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id b81so4357280vkf.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 13:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gZxIsRXpoKCuLQqVWAhTtRUsJaslrtMIMExJm80pfDo=;
        b=m89gNhU7BDneWmSG+eKY73+3B7h3avBi6yJAuuFl3Ukrq0dbtw/8Pm2ER3tUw3ay01
         OjJl4npE1XTpBjz3sfbAh4RCOtyrbfiQPrIUqRC/qGaX+RcL0dlInH9R/Et63EBdRtg3
         CsMa3GfUTbY3UTTFMYYYyPju3PyAKraQK/t2GceV8L4OxHLSiP8TN1ej4puIgKWrSs1T
         GqNg7wAffdQgRfgX56zL20n5b74O1VuUiclDnugncw9TJPixCpGqhJh6aMvA90Vpxh0b
         x8UubQnvIdAyR8tjHWieSw+s23ycrnI6InNA1cUu5sN/Vl+a/y6Y1HUyZjdiwXmYI9yq
         mWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZxIsRXpoKCuLQqVWAhTtRUsJaslrtMIMExJm80pfDo=;
        b=0zEqtg/jXFrKB+C0cgzCsNsARva3mKBabmDUmsy6XHREfaSkdi2+0PY7YOLGPNZQwo
         HL1rABE/sp6Bd9/wg7irWPVcOrk6o7Y8MWKV8vFdb7N7IgzSbO4TY3QIkseOPoSRgnHO
         VnmUnlIHDrfDpUdgruYiSy19bBaM0ILkHm1Pi1n4pLYWRUvj4OHVAOH7r4LEzzFPN4Xa
         XZd8BXRXKAdqiURAIh059kqG6QvmV1DUFYXiiCsRh22erJYMoyZrTwiQveRZT9/dgG5V
         KBnYmgNOgYxegIoScQmNsBoaHwRq7xNj6mLk/tjXmLyod73Mi1G8Cs3UXWHRzXlBZuff
         gMHA==
X-Gm-Message-State: AO0yUKVCI86tdI+hrzTAuSGpAcAujuUkPzmksTFdKDyFQLiVd0U+Chn1
        pQZQ4mZaw/k6gR05rZSzFMz5fL8oM5miqlLS06s=
X-Google-Smtp-Source: AK7set/xlFDpKAT5x+MccPby9b1nBLM9cmoiW77T3Q2Iov8+iPY52OulffSb4bm10G2osQma4o+0bpm8esFW9iG25Ks=
X-Received: by 2002:a1f:ad46:0:b0:3f6:51c4:d2c9 with SMTP id
 w67-20020a1fad46000000b003f651c4d2c9mr394033vke.28.1675547846464; Sat, 04 Feb
 2023 13:57:26 -0800 (PST)
MIME-Version: 1.0
Sender: fredmartins266@gmail.com
Received: by 2002:a05:6130:c15:0:0:0:0 with HTTP; Sat, 4 Feb 2023 13:57:25
 -0800 (PST)
From:   "Mr. Daniel Kafando" <daniekafando001@gmail.com>
Date:   Sat, 4 Feb 2023 21:57:25 +0000
X-Google-Sender-Auth: Yr9MCb5tBN_YZs15s8bbvyLupnM
Message-ID: <CAGM7co-Dth3JqMmm13AuWnKhQYL2EZp-=ocBYBcN1crOaw1fhg@mail.gmail.com>
Subject: Am expecting your response
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_3,NA_DOLLARS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [fredmartins266[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fredmartins266[at]gmail.com]
        *  1.5 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a2f listed in]
        [list.dnswl.org]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_3 Lots of money and several fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodday Friend, I am Mr.Daniel kafando. and I work with UNITED BANK OF
AFRICA. Can you use ATM Visa card to withdraw money at ATM cash
machine in your country?  I want to transfer money to you from my
country;it=E2=80=99s part of money taken by some old politician that was
forced out of power.

I will change the account details to yours, and apply for a visa card
with your details in our bank, they will send the visa card to you and
you will be withdrawing money with it and always send my own
percentage of the money, and the money we are talking about is
$4.2Million us dollars. Whatever amount you withdraw daily, you will
send 50% to me and you will take 50%, the visa card and the bank
account will be on your name,I expect your response. promptly so that
I will give you further details.
Mr.Daniel kafando.
