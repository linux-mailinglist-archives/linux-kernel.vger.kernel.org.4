Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2986E8A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjDTGj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDTGj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:39:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D87173D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:39:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dm2so3938768ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681972794; x=1684564794;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09ttSX06oRnzdKuIS/gGoRYpeZHjJP0fBn470Dk7WKI=;
        b=URWU27nUi+ZC6PB9IGlaVPdy66qcZNwDyXZODbLFMW9ULtG9fJMMIFDbY+OvgoPv4A
         ryc9Xq3iCtuM5W2ZwzT/A4NMakbPix8/BnO5jkfuXajSfeUv5/50FSqQl1OCUJbMN8Hb
         ZTtILOkysGMYmRV/oglIMpCdIFALBiOr8NmLqRx1SZY8MzJC9j3CnIlcyoerHOodyC/i
         RW8fZpd+db3NtCbzNZ9e6nHo2NlsBQo5jC9DVpIXUnCRDJItfP+9ZmglFiZAd1Du5vqh
         cA4pX/3gOcZXOgT8zs8hTVgcsyEQCO3n1r2nBkPvgFEaSLThEqkJsnxmRcnT76PsDyn7
         ppkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681972794; x=1684564794;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09ttSX06oRnzdKuIS/gGoRYpeZHjJP0fBn470Dk7WKI=;
        b=IinuvQXG/4htwzkGPgBCKxRDckkQ0mAWpouFeexR7UJWawouTwWBQ0ta5s1NhQpeZn
         2iJ7h6mrZEDrwPTxy/iOEauVGeI2SMhaEEG6bIEmdyYWREweUQN+SRuorhmj7CVTC64h
         O6SlTbvZpsuXy/Xak8GXnQfY5niXXx/LnYUOo0Zge6hLFuiZFzQ+OZChmMgrxwDZR5IK
         6JECp81VNPTIk7T10abpTHuuP8Er5GjGjJnUnIODC/sr69mOZGZ2vBu1aXrbs6emF//9
         w40Cu+u4s6fo/cBRXadU+T98YkMarvYDCb2NX+5QaLr9tKVMnbQLd6BzeVZd6dWNABNI
         HRIw==
X-Gm-Message-State: AAQBX9flZrDjM10HhW8sEAjoesU2y4zDQBQpRi3MxTL28gQA951/DAlh
        Ue646jFXXNUHxdO/6GxFwqJIkCFzVTTWexjZNjA=
X-Google-Smtp-Source: AKy350ZkLDotsvIhgpna4rpgWf6PRs40yDHyvyI6+vxisGvd4RPTAiGxuYFT59fY2iNTCY8YFEdEUrrKB2KS+xAJfyU=
X-Received: by 2002:a17:906:b104:b0:8f4:ec13:d599 with SMTP id
 u4-20020a170906b10400b008f4ec13d599mr615337ejy.27.1681972794084; Wed, 19 Apr
 2023 23:39:54 -0700 (PDT)
MIME-Version: 1.0
Sender: mrselisabeth73peter@gmail.com
Received: by 2002:a05:7412:cf11:b0:c7:220c:a1ec with HTTP; Wed, 19 Apr 2023
 23:39:53 -0700 (PDT)
From:   "Mrs. Lenny Tatiana" <mrslenytati44@gmail.com>
Date:   Thu, 20 Apr 2023 08:39:53 +0200
X-Google-Sender-Auth: lpIcCTGzLt2EZwTOa4XT5a1BEr4
Message-ID: <CAHZyUcjp2xptW_zrmVopf5KzDnE+xEWwNF8320UEz5Od+tjYxA@mail.gmail.com>
Subject: Greetings dear friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        RISK_FREE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrslenytati44[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 HK_SCAM No description available.
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 RISK_FREE No risk!
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings dear friend,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS
CHRIST the giver of every good thing. Good day and compliments of the
seasons, i know this letter will definitely come to you as a huge
surprise, but I implore you to take the time to go through it
carefully as the decision you make will go off a long way to determine
my future and continued existence. I am Mrs. Lenny Tatiana aging widow
of
57 years old suffering from long time illness.I have some funds I
inherited from my late husband, the sum of (19.2Million Dollars) and I
needed a very honest and God fearing who can withdraw this money then
use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR
CHARITY WORKS. I found your email address from the internet after
honest prayers to the LORD to bring me a helper and i decided to
contact you if you may be willing and interested to handle these trust
funds in good faith before anything happens to me.

I accept this decision because I do not have any child who will
inherit this money after I die. I want your urgent reply to me so that
I will give you the deposit receipt which the SECURITY COMPANY issued
to me as next of kin for immediate transfer of the money to your
account in your country, to start the good work of God, I want you to
use the 25/percent of the total amount to help yourself in doing the
project. I am desperately in keen need of assistance and I have
summoned up courage to contact you for this task, you must not fail me
and the millions of the poor people in our todays WORLD. This is no
stolen money and there are no dangers involved,100% RISK FREE with
full legal proof. Please if you would be able to use the funds for the
Charity works kindly let me know immediately.I will appreciate your
utmost confidentiality and trust in this matter to accomplish my heart
desire, as I don't want anything that will jeopardize my last wish.

Please kindly respond quickly for further details.

Warmest Regards,
Mrs. Lenny Tatiana
