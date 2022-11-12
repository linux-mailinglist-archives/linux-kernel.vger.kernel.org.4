Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F0762667D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 03:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiKLCfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 21:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKLCfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:35:50 -0500
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B0E3C6F8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:35:49 -0800 (PST)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-13b103a3e5dso7271818fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NPQVaKRFdMsCfoyzRXnle/rJ0HMbMVb+ESr80LlYIUU=;
        b=mxVVbB3ndYQwLkE/pcStcp1PVa/eiaYr7eQmnLMvfs1cX/d84D/+xo9qL7WNfINt12
         BXiiduPHKcYINIqKzs2bf4oRyYJRh76jlLZPiESe6vg56IJANPm7pV2GusIj0874q6NX
         cnJBzDUhVqBDOIx9acSOPzSpv5GYtF4Izc8RoEEF0py7DyW7IDOOzejYWatKsofawvxi
         8u/+5pL6ailrKOjnQLGPviYIIL/ra6pSyiafmlePm6uYw+UMKMXNSrKIweAXz0dwCK/u
         q5DVVSsuA/nvUTWyWQi1kSMIW5iOUY7RT81pZpmmGJGzfhes4MFJwtTOYvM/RKub8Y7c
         4pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPQVaKRFdMsCfoyzRXnle/rJ0HMbMVb+ESr80LlYIUU=;
        b=N7hm42+rbUBLsRBmpqMMf/o42PNXTedij10g9w31TqINeiyYHkwdVQ2OwY1LAVwXFr
         yq1oJXERI85mtfoox1CQQsqJvfceA6DuoZ98llRXKwLR+Q4bnc7W8F2EoUHLr0aDRT0B
         FJdtchTYxwnNVpYKYoqCX3ebJReWDzq0Bh2n9H7BQavLJjIWyjQxoz7bdMmuSfJR5kj7
         NX5s9t+81EKKhiD9NXrhBDdHonyxhQoRoifCA5Dtt/3FKteOWz1K995+/44Ir7/+NAad
         qULpfodZS01TmoWDaiFP6z4Q+dSxMm9LymU0UY/9QCTE4+35FZUDSSv0/cJJAeL5LwnE
         vXrQ==
X-Gm-Message-State: ANoB5pmg4XVwPxOyE9HTmO3BMd8YQFyoD5byHe2IxYuNWHAsja27R6UE
        yqOvA6+uHhHZ29bTv9+lxPw9sc2146crlcVfvEA=
X-Google-Smtp-Source: AA0mqf7/KIgRujm2TgfluAnGy+HlKIPMZO9Y/mOsecqdspIJWgZ/M7j+ocK7F4gm7DIMdI5E0yPaDI5lFXSjwE9dcME=
X-Received: by 2002:a05:6870:b909:b0:131:25e6:a59c with SMTP id
 gx9-20020a056870b90900b0013125e6a59cmr2497703oab.195.1668220548960; Fri, 11
 Nov 2022 18:35:48 -0800 (PST)
MIME-Version: 1.0
Sender: carolpenny522@gmail.com
Received: by 2002:a05:6841:90:b0:f5d:7618:2a7d with HTTP; Fri, 11 Nov 2022
 18:35:48 -0800 (PST)
From:   Mrs Lovelyn Raya <lovelynraya001@gmail.com>
Date:   Sat, 12 Nov 2022 02:35:48 +0000
X-Google-Sender-Auth: rZAm539XYEOSSjkqfEr4kkPRhN4
Message-ID: <CAAPPb8Ty2F=gDNjvEj1Daas1gC07C=-wKt+oxxX=65bBa-GrHQ@mail.gmail.com>
Subject: My name is Mrs Lovelyn Raya from Indonesia
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5182]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lovelynraya001[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [carolpenny522[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
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
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20


--=20
--=20
--
My name is Mrs Lovelyn Raya  from Indonesia
,
I know that this message might come to you as a surprise because we
don't know each other nor have we ever met before but accept it with
an open and positive mind. I have a Very important request that made
me to contact you; I was diagnosed with ovarian cancer disease which
doctors have confirmed and announced to me that i have just few days
to leave, Now that I=E2=80=99m ending the race like this, without any famil=
y
members and no child, I just came across your email contact from my
personal search.

I=E2=80=99m a business woman from Indonesia dealing with gold exportation h=
ere
in the Republic of Burkina Faso. I have decided to hand over the sum
of ($10.5 Million Dollar) in my account to you for the help of
orphanage homes/the needy once in your location to fulfill my wish on
earth. But before handing over my data=E2=80=99s to you, kindly assure me t=
hat
you will take only 50% of the money and share the rest to orphanage
homes/the needy once in your country, Return to enable me forward to
you the bank contact details now that I have access to Internet in the
hospital to enable you contact the bank, always check your email
always remember me for doing good.

Your early response will be appreciated.

Yours Faithfully,
Mrs Lovelyn Raya
