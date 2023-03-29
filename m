Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC46CD1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjC2GJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2GJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:09:36 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FBA2705
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:09:36 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id h15so12479226vsh.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680070175;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=U/Z6sFFO6R0vJHqNUEPcvi9b7NUvp4qHegZnaDgoQZvyT1tkGM++PU0cIMKqSo2Kt+
         FUMiP4y5zhM1i4dGk980Du4MrhPF/hBHjKDv8rQ5S45D0pV37/TIDvt3I/nNgRdFMTd2
         PZS21xNU6MtvrJK1U5OYOFW68r59gVn3hBJeWHfIa6h8r8MyJC3v/iBw92DxDtAKTzI7
         QFaaTh3GTf688ZFVsyQopOKW5TIuFSyUjZsy20tWF7eqsJQ5LOuaxpeZThJKBSjC7wS7
         DvRvnhfWQBf2Q6tM5Hzg+OyYNhqcrYGsJjdpjfp+Ew04h8mcLpILLWlg8AWlUWoyLFJ8
         JOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680070175;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=QOX937+KTN4HfG+6tDHGfDngwZNe17k0GFddGJbl0SeJLIgrYUi44zXj/8s+3lEof9
         VTqRn9xChixnt4eeVOggAKP846+aM6fxw0wecA7PweVcqh1+sQT5lHrbb3a4A/Axo6v1
         PFqE218oxX4B9mEB7aA1lzQOv40MeWjIWJfVNzYsyXl8XQjKWaZ4ntLSe+oRL0rZhZBF
         IrHWWWrBYhJ3ZQi9YRqoL/+LkmpeAbKMeNrWmY1lTnC7CN53gz81+7XQY8ebz5HWLzxi
         TrIkRl38O/Hplkvaq4iu2O6Oq+AStOOTCoXFo/tTbJMyFVHZYxF1/2R5QQSz2deT+pv8
         hpxg==
X-Gm-Message-State: AAQBX9djg5+eKZCBDz6+LRbsuzBVVo++PSh7KM43X0pjt0rk2aefcvab
        KO+SebiwYyxbHH7tT/ylYkfdpUJBBq99yarayOk=
X-Google-Smtp-Source: AKy350Z/FLpdcWukUmPL6ZQMbnusfiA2jd7H6Z8xHyljDdhkKzWIRBX65TMzX9Gj4sWlOLhpYI2T3nIYd9LYbqgznBc=
X-Received: by 2002:a67:c38b:0:b0:411:b4c2:c6c0 with SMTP id
 s11-20020a67c38b000000b00411b4c2c6c0mr10020176vsj.0.1680070174888; Tue, 28
 Mar 2023 23:09:34 -0700 (PDT)
MIME-Version: 1.0
Sender: jeffbarman03@gmail.com
Received: by 2002:ab0:3b49:0:b0:5e4:a16e:f84d with HTTP; Tue, 28 Mar 2023
 23:09:34 -0700 (PDT)
From:   Juliette Morgan <juliettemorgan21@gmail.com>
Date:   Wed, 29 Mar 2023 08:09:34 +0200
X-Google-Sender-Auth: TKH9cAAlOQxmFDTsSXVAN8TDPdc
Message-ID: <CAN2ScKboi9QFc65EKTSDqfkhPjPoC_fsx0n4srr3ZaGUTASHoQ@mail.gmail.com>
Subject: READ AND REPLY URGENT
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
        *      [2607:f8b0:4864:20:0:0:0:e42 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jeffbarman03[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jeffbarman03[at]gmail.com]
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
