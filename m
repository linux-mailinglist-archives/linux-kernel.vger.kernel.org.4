Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A086CB61A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjC1FiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1FiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:38:23 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A71707
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 22:38:22 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-544f7c176easo210300097b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 22:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679981901;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=AIwN1VpG3QDlsU4UjpUlcNL7Q3ji7kk1QWySty3KOAAA0xV29boRz8pUtiyYrMN6MZ
         dUtipe/HweOKzqYGEpIBvdMjTjlCd4rfRJfzi1XaGm9ElwhYVBHlzesSioct/IbwWjPi
         o/Bg3CttDrRefyMgpgOM2yDbgbIHqAUEz+DYHiMiswhm3JYvcXCsE5SCMEtxjCXzruUc
         MnVGhvk+DLHk5BRs+fbG+uNLzwReL0brLnp5pzu5qOHxh9OqJZU5ihLtEAhAb5jX7oF/
         8SQTQCJoE9g0ly19ejFCu9qvLPtjMLYu6gRseNEPdvNUAKEW9uVqI48jQEe9vEEnNSBX
         Xg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679981901;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=7KMPPYi2x0jmlvJX5zhm3DI9DI9NsCcm84+MWIjoskUWsHyCQkHAaHc7x4E/+AQb4V
         wh+6z5nji47nGsgIEZzpA3glTOiBo4CdoRbuY4iB8YzygrDj4nq1fxrdOsOZlV+HvRr+
         sNX169UHw69PM4mKFu9AXKmHm9urcyHuXkDaLz4wwUiqAdMFCqUxRHwgY3Po6YZ7+QO0
         BMRaMRI89+0Lc3a1obwlqdnrzit5GvzKAATN43cHqQOlqBBu87tCxIMRbjwXuGIlfYpd
         QRedoau6DjvQw6B9P35qMa8/31/0BixGz3uniPjGrOYXQ9WWJzJ3iWR4O+SIh8vg3XfD
         +Dng==
X-Gm-Message-State: AAQBX9f6cCrk1OJ2Hix0qTHzTIS6WsahMsZ36BGRFxlZMnKAHvAbRuFs
        e/mDVX+EvUqzo+sMNSPt4AknxM3Se1Zo3iGqM00=
X-Google-Smtp-Source: AKy350b+va/0Ve+DAgDZ6zwRSCCOYAFOwJdX8hdS73mvS8dlwjfYU62Sq/BdRN8TAoCi87v1Bz1GJLnymZZDwBx3igM=
X-Received: by 2002:a81:ac64:0:b0:545:6106:5334 with SMTP id
 z36-20020a81ac64000000b0054561065334mr6491908ywj.8.1679981901454; Mon, 27 Mar
 2023 22:38:21 -0700 (PDT)
MIME-Version: 1.0
Sender: aileen.samih221@gmail.com
Received: by 2002:a05:7010:ac25:b0:334:73ac:6c9f with HTTP; Mon, 27 Mar 2023
 22:38:20 -0700 (PDT)
From:   Juliette Morgan <juliettemorgan21@gmail.com>
Date:   Tue, 28 Mar 2023 07:38:20 +0200
X-Google-Sender-Auth: i3N7YkgXVw2-cJc0tAjAZqxsUs0
Message-ID: <CAD5DnU2dKUUv+-Bjq4U8Do5kXmzrwjXC7BayZ_Ct20cZtXG1+Q@mail.gmail.com>
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
        *      [2607:f8b0:4864:20:0:0:0:1143 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aileen.samih221[at]gmail.com]
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
