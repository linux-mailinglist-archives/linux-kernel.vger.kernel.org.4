Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587DC66B44B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 23:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjAOWFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 17:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjAOWFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 17:05:05 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D861B543
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 14:05:05 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b3so40349035lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 14:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DCbXwGfUPe/3mHsmMZsXWr2naFY4gcVo+DgJt9qnP7k=;
        b=RmU0D9sMQGH1qbOjumNV/Jfrn4Cch8i7v/b5zO48V8Bdq/aqwO+nL3ak7hiBMTfF1y
         aB3Rp7mnY3a4+p2TkCA6v00kje8m/OK8lCQqX7hm7FNmdI5uPs34op19jr1/k5/cm5+e
         WEfQ9xkAPD19TmmtDuu7xd/ewvd7TEZuOaOYKlEcxSwpEYLi+jyDLJqiT3W/mgDGgjgM
         iG+7wNY7w7IHCbSnVigXgOPglPDzSUBWiZBPk1sPspwI7GcoLrZu5eZ1Gj4pMeRdvpBf
         mm5waWSkBWKwEFIhateYSLhXy8mv6w8r+9++kuxMgyF727j1VZ4C0imjH8eqnG4NLgly
         d/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCbXwGfUPe/3mHsmMZsXWr2naFY4gcVo+DgJt9qnP7k=;
        b=VygFdVPBwieuNbagGEAkSRkqJ5rRl3gVxdd505aWv4nqLUK/vckvOnFoUNmc/pi0Or
         RSI1GEboO3ixPX8lUtDAPSnTOaXlAYyGalmJc+2Rj2YL3nBv2pLj2ljtMvpsIZ5aJ/ig
         OPzz5BlqzPKpN8JNB/+6lLmvnzOOIlvBDWGxQYil++z2CVviEKZyGC1aTPuI+ho0Wlw7
         b5d0MldoUR2kwVa9eqaBZL7Z+UBjPcU11DSchEatZ4P24K01pbm7oFzKdpxGfWWR2o6B
         9d8RZAsTtVc53XRqIh3UFqMGiOiG7FNNAi9taCOq551mfhGsI2IBaN3p4dATLa6u2PFt
         TovQ==
X-Gm-Message-State: AFqh2kofHRkqjZ8aaSRl+AirtcbWT+N90T0pogEZPaakhVQ7KPC79ziY
        C59LeeOa/Mm7rEUkl0obP8lDk5QnEn+t9UflP7F6iqYl6eY=
X-Google-Smtp-Source: AMrXdXsOve3sb66oFmuJWIgItxAajZcBkCtnzRXb7qPBVlHy6JxkT4zcoQElBrBJmml6EiUCOeFlnU62Sg7bPb3M8n8=
X-Received: by 2002:a17:907:584:b0:7b2:b992:694d with SMTP id
 vw4-20020a170907058400b007b2b992694dmr5612456ejb.651.1673819822492; Sun, 15
 Jan 2023 13:57:02 -0800 (PST)
MIME-Version: 1.0
Sender: ushaman235@gmail.com
Received: by 2002:a50:41d:0:b0:1eb:5b9a:63df with HTTP; Sun, 15 Jan 2023
 13:57:01 -0800 (PST)
From:   "Mr. Daniel Kafando" <daniekafando001@gmail.com>
Date:   Sun, 15 Jan 2023 21:57:01 +0000
X-Google-Sender-Auth: lnvexteC64whT8w5gLQkLRPYeOo
Message-ID: <CAAZU8jfXsb+ajPfwq47V_QR8PiURnjrd-SZbLQQru_Ho1Vm06Q@mail.gmail.com>
Subject: Am Waiting to hear from you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,NA_DOLLARS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:133 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ushaman235[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [daniekafando001[at]gmail.com]
        *  1.5 NA_DOLLARS BODY: Talks about a million North American dollars
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,I'm deeply sorry to berg into your privacy as we haven't
met before I am Mr.Daniel kafando.and I work with UNITED BANK OF
AFRICA.Can you use ATM Visa card to withdraw money at ATM cash machine
in your country? I want to transfer money to you from my country; it=E2=80=
=99s
part of money taken by some old politician that was forced out of
power.

I will change the account details to yours, and apply for a visa card
with your details in our bank, they will send the visa card to you and
you will be withdrawing money with it and always send my own
percentage of the money, and the money we are talking about is
$4.2Million us dollars.

Whatever amount you withdraw daily, you will send 50% to me and you
will take 50%, the visa card and the bank account will be on your
name,I expect your response. promptly so that I will give you further
details. Best Regards, Mr.Daniel.
