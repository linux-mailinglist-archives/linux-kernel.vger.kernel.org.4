Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2145BBADF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 00:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIQWbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 18:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQWbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 18:31:39 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F24D220FC
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 15:31:38 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-3452214cec6so299977857b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 15:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=NrS1isCn7N5y43Qlk5+QPMcpimLruBhGMq4Qmq7NTUsiyQq4RI/T4BLbPt+XE+56Rl
         oEWBPKFpgIUe27pBjgy2Qb3cqFeLSFWROtFzS5dlz3tYdtq2AOsbHjt/34lRoXVIw+Qa
         ZVg1LZZj/GspG36kl0aZkYH3vVlT/MsH5Q3x32nJPxEXYx2I+t4uHTfcT7049udnloKA
         IfyCfzrTxpyD77wPuIYUpcJ489vd6Lpw6LZDL9GPKLWMOPq6HtRjA81qmAh4axRE0VlJ
         yHWJEGVx5O6jJZkGAofdcOt3YpT8T6dnqJDlKacgwGMd1nyAv0FJsF+1vJ+al933JQD2
         dfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=1lJOoRRe1RItmxleq99lar5MQmQB6t7w/mfi6Moc5IjSHjlDiUEHt9l5cit+eZbBWP
         rKF/Hi4F8MDtABHeZXVzfd/KpXo/tm6zqFhjrXzL/bI0R+q9LkYhsQQd0L2T9YbeXMGf
         5A37OWqvsdvsNibzzHr97QdGXTWvqlkgjOqc8xtDoeUsjvCDZPxwYFo4mCAUW2mWMwvX
         nynDYM0a5QVjthh/xyohp311AOP93som1+YreDKcmDBixSGtECYEbrEwiaq0DHvAFfde
         AHlLKEa4qijdccbXdyO7QYiTtyNvDkNOt+ATkHvFlHqYIgT/LzamBV0AzCZcdNKQBTm8
         BPFg==
X-Gm-Message-State: ACrzQf3atjQCJqmQuP/IAA8j2gP9NZ+t4AIvxVwehxqCFpQ6PP8wZ/m9
        l2aLLtDNrpzjmLNuabQF+PXiEX340+gd9sIEDrg=
X-Google-Smtp-Source: AMsMyM5QCLEC/Tnzr0uwflqBzAV4fXo9XP7U+VEMVzbAGbkdMzALAM2D+dnEEUp9eCPxGIFqCYhUFAFhrUpWtftSQoY=
X-Received: by 2002:a81:6a54:0:b0:345:4292:4dfe with SMTP id
 f81-20020a816a54000000b0034542924dfemr9364599ywc.62.1663453897802; Sat, 17
 Sep 2022 15:31:37 -0700 (PDT)
MIME-Version: 1.0
Sender: joy.lisa.kones@gmail.com
Received: by 2002:a05:6919:45c3:b0:dc:a12e:3a77 with HTTP; Sat, 17 Sep 2022
 15:31:35 -0700 (PDT)
From:   Juliette Morgan <juliettemorgan21@gmail.com>
Date:   Sun, 18 Sep 2022 00:31:35 +0200
X-Google-Sender-Auth: ayL7IE1wieD5Wc96bFaNdS8-DhM
Message-ID: <CAMFU_KmFRQVstWfiMNYhxrW-FKbvee=kezZFkkrTKgyvKEz7_A@mail.gmail.com>
Subject: READ AND REPLY URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_MONEY_PERCENT,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
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
