Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA566BC52
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjAPK6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjAPK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:57:46 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092243596
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:57:46 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id z194so1597796iof.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kEVCWhwaEt+bn9i52bVqpmK9bg670xeHDRX6VYKdr8A=;
        b=Y+10qfnyfB0ZBOAHKkltK4/g34JlA1BuLVY55+bEEWPbI0tbLcpiZZqr3fpqQd6IIt
         28dmVukyPeYBPyET/DvCp9kTTFt6FscynPq8LxNuh+vO/FSB6BdBXX97nTG2XhWblMNq
         STMsgmD7uiWf5KjfOtThKLR2vCwxBmcI+dOR19UqQ7NfpgT1k5S7QT7Ep4gON2C5Mtlz
         m4itAmesgdjjqddJ5Jf14VLY0OorpjsN6YEBRmdK7ZjqYDw9iuO5tFZICr8Ux5X+5bEw
         yjmM1z+YaXTdSXsJuFPc2nnMQZ4jq3Bzf2apVSdp2MvetuUPkBf2E4cLfx4cWOU/Echp
         6FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEVCWhwaEt+bn9i52bVqpmK9bg670xeHDRX6VYKdr8A=;
        b=YlPupxo2Ha3vz6vBSIQ8OOgV+aAlWFbze6UpgY+zCiMm7PFTmepRVgCVFTvWcGmbOO
         5sPQDF86YgofDgerhaECmwQSQXq6C9kcQIjzv9mMPlgSQ6Bi50s7aIBobigJhxp5KpaC
         lTReoMnWNvGnAm/3uO7A85Zc1JC2hn5HEd5C4iQJ7TXnYILRYDhFh513X9vIlJpCvxsk
         hufbw3mzVAOynBfs1ZKX/poI1peqvBFVsnMnckHPOc9a2uWDm4ezM59L29Ygb043Ndb5
         57smgBjw7KZktsvpp9oPnZbtZA8JXT4AmVypwtNrQKw/vWvH4pKcwoXOlZ7ju9fOj9iP
         OipQ==
X-Gm-Message-State: AFqh2kqY9L5liNnhFWl6ZgLeonZDpuEyaG+e2k7Y+fpdfdLC9uW77wLH
        8qMhUkP+NAcFgD/yYmML4tXmrpdo3NFUPILot+c=
X-Google-Smtp-Source: AMrXdXt2aMohjyK8GKfgJII0fUdxGT4SW5NcL+TvbM+R93dTXmjFbGzCMnIZv0a282x6b7INV7phBS2Qcjgw/SVMfs8=
X-Received: by 2002:a05:6602:18a:b0:6ed:13b9:2e1e with SMTP id
 m10-20020a056602018a00b006ed13b92e1emr8489378ioo.172.1673866665290; Mon, 16
 Jan 2023 02:57:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6638:12cc:b0:395:c7de:f14c with HTTP; Mon, 16 Jan 2023
 02:57:44 -0800 (PST)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <awochambers004@gmail.com>
Date:   Mon, 16 Jan 2023 02:57:44 -0800
Message-ID: <CAH2diS72gv+nPm5EH+BaC0XyxRqcf_Zgn9QXOy-Jmm8_rqibgg@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abrahammorrison443[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [awochambers004[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [awochambers004[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo! Haben Sie meine vorherige Nachricht erhalten? Haben Sie die
Bankomatkarte erhalten, die ich f=C3=BCr Sie aufbewahrt habe?

Ich rate Ihnen, sich an meine Sekret=C3=A4rin zu wenden, um eine
Geldautomatenkarte in H=C3=B6he von 500.000,00 USD zu erhalten, die ich f=
=C3=BCr
Sie aufbewahrt habe.

Kontaktieren Sie sie mit den folgenden Informationen.
Name: Linda Kofi
E-Mail: koffilinda785@gmail.com

Bitten Sie sie, Ihnen die Gesamtsumme von ($500.000,00) ATM CARD zu
schicken, die ich f=C3=BCr Sie aufbewahrt habe.

Herr Abraham Morrison
