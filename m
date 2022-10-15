Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1635FFC9F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 01:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJOX07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 19:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJOX05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 19:26:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710B1371B9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 16:26:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s2so11429312edd.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 16:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aF9nFwwA4H8y+DQySeTN9I4LSFxeOQ6cH2LPftSBU4=;
        b=PylwGucp8DT/F1QFDw2FtDbSSwSvUVHllt57G/O0Tk9zAnQtE1XBU941y9DY9sPzZL
         IGmB/KsMRAMLUVoxgHWJwKrc4+USJ7vwNR+0E1Blo8f77Vkmp8mxGhWeyO2vJqgcxeir
         VoPFdoUeKmE53h704uXLL5c0K75eVG5GvPGA6Yii60pZIPHGoYW6aGTvukFgKwcPZtsG
         Gkj5U682jaml2bixgQCcnr+4rXxN7heF3Ayq89zMqXL/2m1pGnA1LOlC3NydNU7ICvM2
         gKew6+l4NTv3c6EJ4VtjmblcrlmSkpvHikhhAd88xjpgypG+MmZ/RyG4plDft1YWJDq9
         XqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aF9nFwwA4H8y+DQySeTN9I4LSFxeOQ6cH2LPftSBU4=;
        b=Eh46PXKPqa60skf220P8LFn9py7Pal3KWNrVYW3a6Qxakr4n8DWkBKLgxAJQOn0bUe
         0lkoBE3Zwp033MmFA4OcErDRebeG0japNzSAKsPL3PxlyuiRE7sAr3X12ZVkyM0LGy/r
         sJJMadZff1sIeru0pwXVE5R+hdB5yRh/p160rtJsRaOlplQJnP+NMPH07X7+/PJ2RaoZ
         KClJtiJDHTb3mX7OHTi4o1nfNAKcdXSKTq1Yq5ZqjgsoU9E27imYq8QoY1smS7dWhU57
         4Tors63nFPFjaYtS2xLcVOlKMwxv2utz7Yea6vtAeywNzJRmQ4nmQDN3IcvH5BGAY208
         Mw9w==
X-Gm-Message-State: ACrzQf2KKBQM7Usckz+0gV6Wip/3bu1SLV2GoteMLiD+w6YV8LrlCWHA
        HE8MRipcxQjo24AjAVhItlYAdRyZR6dj7t21gTc=
X-Google-Smtp-Source: AMsMyM7yVoSkrE4F3B0rWm2IIEKC4BFe3t2vzAqxjv7XXaXqik7GdvLrqF8ZfyK3Bu0xQiadrwoPzQB+cVJvecc9sIY=
X-Received: by 2002:a05:6402:14c9:b0:459:1a5b:6c47 with SMTP id
 f9-20020a05640214c900b004591a5b6c47mr4132818edx.426.1665876413682; Sat, 15
 Oct 2022 16:26:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:8b06:0:0:0:0:0 with HTTP; Sat, 15 Oct 2022 16:26:52
 -0700 (PDT)
Reply-To: richardwahl9035@gmail.com
From:   Richard Wahl <awinokotieno@gmail.com>
Date:   Sun, 16 Oct 2022 02:26:52 +0300
Message-ID: <CAHRfjSBmgVQqxeOhEdxWFi09gju+fhytZJ=dVwkhUEAb37zsBQ@mail.gmail.com>
Subject: Re,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM_LOOSE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:532 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [richardwahl9035[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [awinokotieno[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.0 REPTO_419_FRAUD_GM_LOOSE Ends-in-digits Reply-To is similar to
        *      known advance fee fraud collector mailbox
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Sch=C3=B6nen Tag,

Ich bin Herr Richard Wahl, Sie haben eine Spende von 700.000,00 =E2=82=AC. =
Ich
habe ein gewonnen
Gl=C3=BCck in der Power-Ball-Lotterie und ich spende einen Teil davon an Te=
n
Lucky People und Ten Charity Organisation. Ihre E-Mail kam heraus
siegreich, also antworte mir dringend f=C3=BCr weitere Informationen unter:
richardwahl9035@gmail.com
Aufrichtig,
Herr Richard Wah7
