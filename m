Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576DC616B12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiKBRlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiKBRlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:41:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE75414004
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:41:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y6so12652568iof.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRmrlRPMYwszAcJulOTnZfSODdA48jDXLgPFI/7cr9Y=;
        b=fA/71zEu7kcV2h1O674guMNUlqyvo2YT8+hIyBfZbSW+iGDibDCkJCsrgNFkr93gN9
         qn2TrMh/GT2bt2Z918P+mspMFMGQZrUmDWdJhUeqJoW/6qlLc1xbSTjjTlWhsdIGIgiR
         QiCc8nTU4Ug9bRgWwYq0kNiU+k+odhP2kbrhIph8YXNHHyBA/opCOUHPaexEKqrSqn2K
         WevC8zLTfrsPBcvFpdd8mkBihINI8qNZsNbCrgoJ2oQ75P4JqnVd6/zieOpls0VheMkw
         ZkIsHzbGb/+UIoXW0+uZBG0R/Mng8wytB1aDXvGX1jcG943CyUxTY5e9oLCjlWvoVuNB
         QTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRmrlRPMYwszAcJulOTnZfSODdA48jDXLgPFI/7cr9Y=;
        b=wC3ON0NroIAtigchQAS+mQix+PPbONLMLCfrHqIHAPdaQCLO2hXWxyQ7vkKDup0PBc
         L85v/lFk+TgYomXwwVRVKL6wsJv9YDxB5BasIt/VBSh5tXCvIdaaSKyTqPhcd7lAkveV
         ac63EVEz765M7KnNtY9zL7HQeMWZDeSutWxI2feISl1aEJJK6VdIATen/vpw5fwFIDEm
         ph+TpXtJ6E1zFzSP7PX5cnh18C653b7dTO/cY/kEJ+KGo6JN4k7z4WDAwqcu/uBUnLFX
         k0qKjNDFbc1TH7sBIm51AgbgneSIO/iG6z4lwIoqydb3cGeItsnOgKio3aJXO2dUH/P5
         fWqg==
X-Gm-Message-State: ACrzQf3/P1XOtLpmt6ARFPeSOnYcMv5r8Hu1GjGfVrZU2DaZWTm8xrg8
        sNBSsbuw1XWL5QCVhWhxM88gsZk2AFVFy2fYWS4=
X-Google-Smtp-Source: AMsMyM4j0Pbu7sZljrUybiD2qdhlwCMEmdrZKtY4MMidxFxZkefGxhBrUT10Hx82zFwrNUxk+Z7eYED9d/QsnuFMCX4=
X-Received: by 2002:a05:6602:3407:b0:6d0:4fff:4e0b with SMTP id
 n7-20020a056602340700b006d04fff4e0bmr12585383ioz.52.1667410874046; Wed, 02
 Nov 2022 10:41:14 -0700 (PDT)
MIME-Version: 1.0
Sender: jameswiliamsjw682@gmail.com
Received: by 2002:a05:6e02:218e:0:0:0:0 with HTTP; Wed, 2 Nov 2022 10:41:13
 -0700 (PDT)
From:   Aisha Gaddafi <aishagaddafi6604@gmail.com>
Date:   Wed, 2 Nov 2022 17:41:13 +0000
X-Google-Sender-Auth: gaPzAEsGi5jQwa7KcqwlrP757Dk
Message-ID: <CAJMpOnevPs1SsGkqVNSvqGFobL+036XUUnQp9b+=S5Sy2cjqMQ@mail.gmail.com>
Subject: Investment proposal,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d32 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9985]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jameswiliamsjw682[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aishagaddafi6604[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear.,

It=E2=80=99s my pleasure to  contact you through this media as i am in need
of your urgent assistance.  My names are Mrs. Ayesha  Muammar Al-Gaddafi
a single   Mother and a Widow with three Children. I am the only
biological Daughter of late Libyan President(Late Colonel Muammar
Al-Gaddafi ).

I have an investment funds worth Twenty Eight Million  Four Hundred
Thousand United State Dollar ($28.400.000.00) and i need an investment
Partner and because of the asylum status i will authorize you the
ownership of the funds, however,  I am interested in for the
investment project assistance in your country, may be from there, we
can build a business  relationship in the near future.

I am willing to negotiate business profit sharing ratio  with you base
on the future investment earning profits. If you are willing to handle
this project kindly reply  urgently to enable me provide more
information about the investment funds to you. Am waiting for your
urgent response.

Best Regards.
Ms.  Ayesha Al-Gaddafi.
