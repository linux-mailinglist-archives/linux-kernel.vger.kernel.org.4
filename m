Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3375B6769BA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 22:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjAUVxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 16:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAUVxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 16:53:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9090A17CF3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:53:50 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vw16so22038660ejc.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u1FS23f9lMOyJIiIZuP0A4Qiyf73vPOUb05pwu8u1Yk=;
        b=PUBrTZibudb8t1jCd0OFYhIKtwwkOvb+QOBVGBmdGpTi/6hfNLDgM0ipgNrRV+yLNQ
         Mp1P3nvFL6qCZIABT7IXlga4Vo3JTlLG208U7Xdow7yidmKM9zlUAfpzXTGDQrRjY8bG
         4UN91dyptDAgZTMOv5hkiQHYP96VP6T2d+ocnxG4eWZIu/A1CP/Uk8oV/IiQGrxCE7yH
         UK8qzt78pI5CBwMw/eTEaSdlSAoa7l6HADqO7CB28DxZ8UbFbMMTeZCR+Y9K41qrkvNm
         f4RuHBHuYyy+OpfQ51oKIkcRBUWTPKNAd0RmCxlGfvqL0PWp/9SpGLieyf3ehidDt4xG
         moKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1FS23f9lMOyJIiIZuP0A4Qiyf73vPOUb05pwu8u1Yk=;
        b=CtehQsR3rGI6/cxGs2Ax4lTv/esLkHyaJ7BdDbf0lJWGX1lnVo5oYR6EhDbhHoemmd
         pbBeJ3eqcIOusRaCgLbMkRrXCR2airRgl6FPl26CmNE3PDYXgWuaBQQti8xHh0TWsibh
         qGOxbjQBSHucbql8G8A2JFj+ISA4HWjPUeS7b3Y5Ksus7ZyzgWm9+Jtq8QGI7wmjrV5J
         18mCs/JiNGeJAM5niQN94FqO07unVbBjrtSoBNPzO1ABclatT8bPaTAiOkYMlAZ1skwE
         bSM8EYRoi3j1lefsuD+K43k3Bp4cZUqm/SRtZ3WxWpfUrQDMYjYftouN6qB1On49bmZ1
         7X2Q==
X-Gm-Message-State: AFqh2krIs+HH8q1sE/htHP4bsM79jVrYPL4j5pFWkOX571NvE8+baR5d
        t58gAbpBidHKCzSV9iYZskYRPUnxoTtWoZS64Uc=
X-Google-Smtp-Source: AMrXdXvgN8MBlOArhDlezRaJf5HbQ4d/ijraBIv5bYpb+nBpWzNlaPkDmNDt04PygoOyQfoySbSrdM8P93F5TZhUSAY=
X-Received: by 2002:a17:907:20ae:b0:84c:c9fd:42ba with SMTP id
 pw14-20020a17090720ae00b0084cc9fd42bamr1690145ejb.98.1674338028986; Sat, 21
 Jan 2023 13:53:48 -0800 (PST)
MIME-Version: 1.0
Sender: mrtamuhfariq1@gmail.com
Received: by 2002:a50:3a5d:0:b0:1f4:9f9f:71d5 with HTTP; Sat, 21 Jan 2023
 13:53:48 -0800 (PST)
From:   Bello Abubakar <bellobelloabubakar5@gmail.com>
Date:   Sat, 21 Jan 2023 13:53:48 -0800
X-Google-Sender-Auth: J2ERaFohDIpS4E0kTUGo4C_SJS4
Message-ID: <CAO2k2xc6hjF0DR_jV0nRz0RWzahYZX4-41YnGPLzga6Sd2_RqQ@mail.gmail.com>
Subject: URGENT REPLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5354]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrtamuhfariq1[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrtamuhfariq1[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hello,

I am a relative of a politically exposed person (PEP) that is in
financial regulation. Due to my present health condition, I'd decided
to write through this email for the security reason.

Therefore, kindly treat this as top secret for the security reason.
I'd after fasting and prayer choose to write not you particularly but
I believing in probability of you being a confidant chosen by chance;
luck to help and share in this noble cause.

I need your assistant to conduct secret transfers of family's funds
worth =E2=82=AC90.5 millions Euros. It was deposited in bank clandestinely.

I am in grave condition and I expect my death any moment now and I
want to donate the fund to less privilege and you will be rewarded
with reasonable percentage of the fund if you can assist.

Please contact me back for more details,

Yours truly,
Bello Abubakar
