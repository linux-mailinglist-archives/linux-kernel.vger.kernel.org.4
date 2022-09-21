Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AECF5E5492
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiIUUkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIUUkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:40:47 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1009A9EF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:40:46 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-12c8312131fso10895239fac.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=G71QDeZIK7R3zcfTG/iRObG/pJmlsMoiFD4eUJdIpIk=;
        b=qzirRr7u0DDJhhCe1Y77bRB53FJkchK9KtG0IOL5c8TDdYCBbVr6WsCf1YE89OXR+3
         TPjOHCyshc3/Ym6Bb3njVgBhoE5fiFiox8v635R+6eRMWSlXaYE+rI81ukBxPJjkmrqr
         cvk26jV+Seq5JpjteBwBha7wKuqKC1S27lRS3IqbWChYeC1wpc9Z0FAtzj1lKmo2teeG
         Gbj3HhQJ9k7me0E45cKuggBYpEIybx5+c3ugWpptJQ9MKPhftvXvwn4UYI7d+OwbRpMn
         VIBdTeAMgz9droeX3+r/IUeQQJKyLdsUZnQthOCjIuVeYvqGIUEBZGhRLq8dmsBe2ugx
         gNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=G71QDeZIK7R3zcfTG/iRObG/pJmlsMoiFD4eUJdIpIk=;
        b=Pvna7HvsNbkWdxHruEXeWLQ2NVrMx74qBT3pPjRCMu4rKs9gSIvkyWvEJn2WZI7/Ns
         nsYRDsBIY+FcOXS1jwMCZUNsZsbRdlz9TVMRfJTQRChVI+//aJmxGZQ5IQ28BhNoLmSE
         GueaPKLyuxJQe2KFlzSqylRCm6Ohrhw6fWKyVQ3PW9iiSnrRIslU0y4NKhd1yPudrB89
         2lkfXMPVJb9CaQmdvpD9nyoJaU/FZm/wBLYgvEJR6baje/LJ5aHhmnAGQuKAmqMx0zCK
         kj1B3wlsG4NOPCFJ+00PbiGYM9uZ5k2sL0fUP33774Yk4weqLq/vz9DjV1fYyLIfD/YK
         ojew==
X-Gm-Message-State: ACrzQf1/GAAmq7Dl8VylwyVEPzjSZ5M6XZz1vYYr3nQDQzHFXkIpc+Ps
        NUVr+v6dASyws7kVZhIYpoq6aOjLI01S4AcPrTo=
X-Google-Smtp-Source: AMsMyM4qqJvOJudsNJK4cZQD2AJQ3MUiqVTezErrmRx7kLgZjnDWPLProSMdVHoevgZPRGZgsrUa8Fnj/sjIHlDw6KY=
X-Received: by 2002:a05:6870:a925:b0:122:8314:b7a4 with SMTP id
 eq37-20020a056870a92500b001228314b7a4mr10485oab.118.1663792846226; Wed, 21
 Sep 2022 13:40:46 -0700 (PDT)
MIME-Version: 1.0
Sender: cowardjulia3@gmail.com
Received: by 2002:a05:6358:441b:b0:b4:f987:26c9 with HTTP; Wed, 21 Sep 2022
 13:40:45 -0700 (PDT)
From:   Mrs Lovelyn Raya <lovelynraya001@gmail.com>
Date:   Wed, 21 Sep 2022 20:40:45 +0000
X-Google-Sender-Auth: 7warlvX9fZT5nhwYyyXGcCRHNzM
Message-ID: <CAOZ3-Pud=b6gXDD6Oruf7C7JD3y45ZMcJNgH=b2qpu-O9kKuEA@mail.gmail.com>
Subject: My name is Mrs. lovelyn Raya from indonesia,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:42 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8188]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lovelynraya001[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cowardjulia3[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
-
--
My name is Mrs.Lovelyn Raya  from Mongolia,

I know that this message might come to you as surprise because we
don't know each other nor have we ever met before but accept it with
an open and positive mind. I have a Very important request that made
me to contact you; I was diagnosed with ovarian cancer disease which
doctors have confirmed and announced to me that i have just few days
to leave, Now that I=E2=80=99m ending the race like this, without any famil=
y
members and no child, I just came across your email contact from my
personal search.

I=E2=80=99m a business woman from Mongolia dealing with gold exportation he=
re
in Republic of Burkina Faso. I have decided to hand over the sum of
($10.5 Million Dollar) in my account to you for the help of orphanage
homes/the needy once in your location to fulfill my wish on earth. But
before handing over my data=E2=80=99s to you, kindly assure me that you wil=
l
take only 50% of the money and share the rest to orphanage homes/the
needy once in your country, Return to enable me forward to you the
bank contact details now that I have access to Internet in the
hospital to enable you contact the bank, always check your e-mail
always remember me for doing good.

Your early response will be appreciated.

Yours Faithfully,
 Mrs.Lovelyn Raya
