Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091FA65A2C3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 06:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiLaFUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 00:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiLaFUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 00:20:34 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509EF14D02
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:20:33 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fc4so55402455ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g0fwp/1dRrfu0peS245FaVJCgMkFwHN9i+GNg2CO1KA=;
        b=nbPio/74ReqykLw+aKKuac5Mbxhr/fsvIdi6kD41Za+AFq/HDZfrc+xvVs4AU08EVm
         2FPDF2yuTJxNbPH5JfCaiTbmPelzaWPMcApfz3vQZKUPvMWYVl7ODmsFrgcINBaFrJ9o
         duLnhS1DYnLyOyNhbM12OIbvviCt6YbmNIfxeetJgeNQj8zhB4t2rdo+6ZDwmi11BzhX
         Lu6tZJnWoxg2p9CMnTxwkyhjO9H3dThqnWOG93vHGzTN1CrSwWi2+U1x3aTNuTOM+JCF
         iEA80T0g3vlsi8ZU0/lUOvs58oZdPEyiX40dhOiO7K6IFqME5/gRjyrVVcgrvZ5tgq3J
         C6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0fwp/1dRrfu0peS245FaVJCgMkFwHN9i+GNg2CO1KA=;
        b=iAV/Cz2IZJWVcPeHvFKvVkFIgTZM0BLXRFXOiTPP731MpBdCirbMUUXdztM45kVHSm
         LMdQqAIOm/waI8S97UHSlvIT7/+FKvqORx4f4/jKIPUpWHLJDOuTq4fnx0JCzUB7CAcT
         QZdXrHU5ELT6CVhIsFwIdgjaKZuvIv9KMQdrbFL4FnmQ0vV08uh8jQsF1Braar8GkWgb
         Mvdx+EsmtfnS+ooa6rD+EhHUPGYwxEtVxKtEWOkysl2AOoF9tAi3xhXWPhH2fhZ343P4
         Xm7lRWHxeTKMdyqBMYBf9ywPosOaV5icUk+GJIMDXhIVtYg68IQpL3AJf2qhR4p4oRPd
         5KpA==
X-Gm-Message-State: AFqh2kripcrog7dVFiiIfuCKsON42VAokG4WkWXS5a67YUmasRh/y8Ri
        Fk25wj1mhGLC/khit4CNFdodZlNt4hv8nt1XB4I=
X-Google-Smtp-Source: AMrXdXvHclCcwzUuTFVQ4paYw4JhZ4tt7AstLkROap1ktXZBjcqQdB3faliGjsGgPemKkHRfQCeydjAcMXok4tb5Pd8=
X-Received: by 2002:a17:907:d48a:b0:7c1:10b6:3ea0 with SMTP id
 vj10-20020a170907d48a00b007c110b63ea0mr2970547ejc.132.1672464031760; Fri, 30
 Dec 2022 21:20:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a98:a10f:0:b0:19d:fbb9:be5c with HTTP; Fri, 30 Dec 2022
 21:20:31 -0800 (PST)
From:   ryan johnson <bosranjo670@gmail.com>
Date:   Fri, 30 Dec 2022 21:20:31 -0800
Message-ID: <CAL-LBhBvQ72eehYVpoYSnRUkHUHK8HhDdMOd6CPXjsevMjaGmQ@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:629 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bosranjo670[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bosranjo670[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.4 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am Mr.Alfa Nuru I have investment project of $58.7Million Us Dollars
which I will like you to support me so that the fund will be transfer
into your bank  account.

Please if you are capable and willing , kindly reply back to me so
that i will give more details about this project. my private e-mail at
(mr.alfanuru01@gmail.com)

Sorry if you received this letter in your spam or junk Email, is due to
recent  connection error here in the country.

further details of the Project will be forwarded to you as soon as I
receive your wiliness to join hand with me.

Am awaiting your urgent response with this information


Have a nice day!!

Mr.Alfa Nuru
