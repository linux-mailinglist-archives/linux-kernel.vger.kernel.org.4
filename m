Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057CF6C8B27
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 06:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCYFp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 01:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCYFp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 01:45:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61895F7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 22:45:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id h8so112662qko.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 22:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679723155;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=idNz/3jQ1aX3+XkGprlQ8wOoPaFYX5pDAPAj/OIAMpH74wrY8QcCs3IuKYSJGJyHK9
         jFALYFicRc2ui6guiCKFFxwLVT7dn+rEAO3xv9BQIdHREI+QR9RJZvCF2sgaBZQ1ExvH
         iDeTv2ePkBtU/AMK3Cc9X5vpq3lriHEODhbFj/5+jJ4sd5yIVP2YOtYrdjIR+SsDbpGX
         4vh14rogtJrkdQil68r5iJrJtOL3YLPWjiBc4l1b6tuPd/EjTOTAhUGNALj9VqaGKfwa
         UwOOFYr/Rtb6KPylFM+NHSTzR+AX0igZimw9Doc3/KerVLcTJ9kmL1uHnNyJ0chFf3mE
         ctiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679723155;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=mUo4I/qHrTsWYwQTkxDA3vY6Zp8hH0nGHAt2ua5hnbqgqkBD3N9FGVRBbIAj9F4u2a
         arxvw6dk9WPUEJPFWkr5ViJUQqBvw13T+i4kaDPgWD0KG/vxqO8o1Kp/9QR2QzXP4SfM
         2gmfOOQr6OQnHdQx7ovezhtgQr2UyCL0SXOpWU4/5bSFlXesUPMS6bdoG1+pa9r/ll1r
         FKV+7eF437//O5wL3jCfTQcqYXdTMf7w04+UnvWg9lZu+iF1JpjQSpb7xsxslLKpyrgs
         BCyHyg3piAOxw7FNcpPOfis1cVS3vftp4WkGrgSir24xSl1mpGMrdPsRJeCX5tvD3+ec
         wCYQ==
X-Gm-Message-State: AO0yUKUNnmycNzkRKzi9f4QjhwlMFAvlypej99X9Rxe/oWZC+o56bOHE
        k1KHojHfu+XWC5J9QZjWyETyvcFxu3sdvGqaeyM=
X-Google-Smtp-Source: AK7set/BHSC3p1URcUy+3+BGHbCuRJTuFdqfIZOyYCxzlpF4O3ZWofMyfBoOdjEJuqRKVjxUZmaGa7lePw1u5J2LD+s=
X-Received: by 2002:a05:620a:2454:b0:746:9072:5107 with SMTP id
 h20-20020a05620a245400b0074690725107mr866912qkn.1.1679723155392; Fri, 24 Mar
 2023 22:45:55 -0700 (PDT)
MIME-Version: 1.0
Sender: yesminesamih111@gmail.com
Received: by 2002:a0c:f512:0:b0:5ad:a8e0:f384 with HTTP; Fri, 24 Mar 2023
 22:45:55 -0700 (PDT)
From:   Juliette Morgan <juliettemorgan21@gmail.com>
Date:   Sat, 25 Mar 2023 06:45:55 +0100
X-Google-Sender-Auth: ClulqlhVov24abql2LmfKDMvPVg
Message-ID: <CAC+tdQgXHi5m4oWMagE71=whhXqWFFZ-aNw9w5koUMGMN6br=A@mail.gmail.com>
Subject: READ AND RELY URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:743 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [yesminesamih111[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [juliettemorgan21[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear God,s Select Good Day,

I apologized, If this mail find's you disturbing, It might not be the
best way to approach you as we have not met before, but due to the
urgency of my present situation i decided  to communicate this way, so
please pardon my manna, I am writing this mail to you with heavy tears
In my eyes and great sorrow in my heart, My Name is Mrs.Juliette
Morgan, and I am contacting you from my country Norway, I want to tell
you this because I don't have any other option than to tell you as I
was touched to open up to you,

I married to Mr.sami Morgan. Who worked with Norway embassy in Burkina
Faso for nine years before he died in the year 2020.We were married
for eleven years without a child He died after a brief illness that
lasted for only five days. Since his death I decided not to remarry,
When my late husband was alive he deposited the sum of =E2=82=AC 8.5 Millio=
n
Euro (Eight million, Five hundred thousand Euros) in a bank in
Ouagadougou the capital city of Burkina Faso in west Africa Presently
this money is still in bank. He made this money available for
exportation of Gold from Burkina Faso mining.

Recently, My Doctor told me that I would not last for the period of
seven months due to cancer problem. The one that disturbs me most is
my stroke sickness.Having known my condition I decided to hand you
over this money to take care of the less-privileged people, you will
utilize this money the way I am going to instruct herein.

I want you to take 30 Percent of the total money for your personal use
While 70% of the money will go to charity, people in the street and
helping the orphanage. I grew up as an Orphan and I don't have any
body as my family member, just to endeavour that the house of God is
maintained. Am doing this so that God will forgive my sins and accept
my soul because these sicknesses have suffered me so much.

As soon as I receive your reply I shall give you the contact of the
bank in Burkina Faso and I will also instruct the Bank Manager to
issue you an authority letter that will prove you the present
beneficiary of the money in the bank that is if you assure me that you
will act accordingly as I Stated herein.

Always reply to my alternative for security purposes

Hoping to receive your reply:
From Mrs.Juliette Morgan,
