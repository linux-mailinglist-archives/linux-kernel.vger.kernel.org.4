Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBBD6EB984
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDVOB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDVOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:01:57 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3083170A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 07:01:55 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-18e6e11c5fbso13258fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682172115; x=1684764115;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A51qER/+0Uwg373WDhhFIvlu+oxZvJ7RfKVETtmCu7A=;
        b=IV3NJI/cb8BoqQGVHVZhtmQKVe9/kHKC9UkRJZXEhv5jNUa5ROvMBZHEjTzZMqKuMA
         jntEm2dgjQ999EsNNCIa1xFNhDLFUUAi0UA1cgq4Bt8YBqXYUAGH0x5PO4A+hWm8WMfO
         gc3riSWHqA67Q7qHdT6Qv6kntE2cm3kaDwn6C1L4vwJm7yhKYlI9pQL/w7YWqOMOZuDZ
         15eutsnEaF9v5Vz9qAW4PEgDEeKLUfoxwGYXhKH8Ek7hxphB4hWo+SE+Oq5U4dREOek6
         eYSrNTsfdBanslsa4G1Ywey1WXZf6/wzLLqQmaMAKSXf4u7gcITeJzlPAgRVE44DG7od
         ZejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682172115; x=1684764115;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A51qER/+0Uwg373WDhhFIvlu+oxZvJ7RfKVETtmCu7A=;
        b=acsz/KVfk1FUSglhIbI2PKP+d6TRJUp3mQZz6ifK2e/DYlv4PLfpt6MT8Gf1wL6fyi
         tULo1POmQwxk1cQpDQLjmUsK2qpX9kM17/YUBBgxRG2BTZGwVt1AXo8JYZERLpfOIneP
         iECSorUO/y4If09eCbuGqpzmLNmqL1vLYFoQRZp74xn7YMMHv6ugdJH7/Eqd4G53cNQE
         k7pB9od4wRc/p4eHAPANh/QbDb5oijrDnEJCK19QFKl2s41Y0kTnKIDRo/qytbGRKrCJ
         Ns2l+9b3D2UZXwlVgZ/KpPiZQVo0ZVGNKOod+ljkhi+mSwxoamAi6Jm+4Nmv3aW4DsEv
         dpFg==
X-Gm-Message-State: AAQBX9fApY0u+JM+gXldeR7dVVsIkN/uY7KVktNwx3qzZKc5BeOGBADm
        5ccjo27Lb2Hw/Lvl7YIgNhWgXQlAPUtSZndgmpw=
X-Google-Smtp-Source: AKy350aAq9xyjQurrruIg8DDP3teis4ewvAqa991PMosm1zdUWcmDojdtM8Fn5yjA3yMNjRJLYbdyuJY4PZDEn/Mxrs=
X-Received: by 2002:a05:6870:560e:b0:17a:c612:ae0d with SMTP id
 m14-20020a056870560e00b0017ac612ae0dmr5842646oao.49.1682172114929; Sat, 22
 Apr 2023 07:01:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:7f8f:b0:105:64e9:9c9b with HTTP; Sat, 22 Apr 2023
 07:01:54 -0700 (PDT)
From:   Aisha Gaddafi <aishagaddafilibya5@gmail.com>
Date:   Sat, 22 Apr 2023 16:01:54 +0200
Message-ID: <CAJdAvay+6fHtadom=XW6iv9z7M8r_vH7vbH++DvkeeUZp9chfw@mail.gmail.com>
Subject: GREETINGS FROM NEW YORK CITY USA
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.9 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORM_FRAUD_5,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,MONEY_FORM_SHORT,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_SHORT,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:31 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aishagaddafilibya5[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aishagaddafilibya5[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  0.0 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 FORM_FRAUD_5 Fill a form and many fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearest How are you doing today,


I came across your e-mail contact prior a private search while in need
of your assistance.

Please do not feel disturbed for contacting you, based on the critical
condition I find mine self, though, it's not financial problem, but my
health, you might have know that cancer is not what to talk home
about, I am married to Mr. Oscar who was a businessman from New york
United States
before dying some years ago? We were married to many years without a
child. He died after a brief illness that lasted for five days. And I
myself have been suffering from an ovarian cancer disease. At this
moment I am about to finish the race in this way.

Since his death I decided not to remarry again, When my late husband was
alive he deposited the sum of (=E2=82=AC18.5 Million Euros) I have confirme=
d
from the Banco Santander Bank in Spain where the fund was deposited present=
ly
this fund is still in Bank. And My Doctor told me that I don't have
much time to live again because of the cancer problem, having known my
condition I decided to hand you over this fund to you to take care of the
less-privileged people,

You will utilize this money the way I am going to instruct you. I want
you to take 50 Percent of the total money for your personal use While
50% of the money will go to charity" people and helping the orphanage
and the poor I will really do appreciate if l can put my trust on you
to help me claim my fund for the mission of the Lord in donating it to
the Motherless Baby Home (ORPHANAGE). I want you to know that am right
here lying on the sick bed at the hospital waiting for the Lord's call
but I really want this mission to be well accomplished by Gods grace, I
don't want my husband's efforts to be used by the Government. I grew
up as an Orphan and I don't have anybody as my family member,

I am expecting your urgent respond. Bellow is my private email address
(monicaabraham1947@gmail.com)

Best Regards.
Mrs. Monica Oscar Abraham
