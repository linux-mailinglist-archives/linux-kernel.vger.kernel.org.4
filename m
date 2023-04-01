Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740AD6D3128
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDAOAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 09:59:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A838CAF2B
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 06:59:57 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so28365815pjt.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680357597;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbyWSDXAVdLx2ByXwS4vpkctv/9NKptp1niPUI3LhtU=;
        b=FkBknzxlFyiI1tlVERa+QxwDiQvBzx2GxKqlN9fS3Su9qeL2o3zYiUIaaCx8GxYtSs
         PQOJ/VJ9UjndiQymm+Mv1Wnv6k/QSPYlifLhHLk70Uzkc1ZRQsCEcYq6V6sdpUiELuzT
         DeJhQYXjdsSnpQuYk6kzgHQETmnWFoZH5pOup7Eai7lbLY/7NIOOVwIEEvjGCVSQ2OD+
         q6gpoS+erSMYduWPTgDlQTsEXZi8pH+WAYH8qVtl1porHDsHnEOw8K9OYU0anLm4k5r7
         is9ZyGJ9FgfFovnM000A3ns0uzEnjpQFkSy3Q6O0sMlf9/wr7MwqkdVtEloz2kmE7+PP
         EBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680357597;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbyWSDXAVdLx2ByXwS4vpkctv/9NKptp1niPUI3LhtU=;
        b=x70BLZvDfLt2NE+8jukpWHLbH0kC5sHazc8snAxV3MTkoPaEg8bwTGV86O37ZxUn5Y
         TF9rYfrDQhKf1VeJP575ODwUr7nnM80Xcz4KCJtfulsCBMK+nlOcN441XsMZksNRFy8B
         QjIYyCBoiwKamV92u/lvMtrczlALTNkC7vmdPzrf3CZNddL/Wt0cEpchOtisELxEmiLK
         GuI2RG5rmhZoi7rNZODwd/X3bWJvZjkbMu2V40dBEyia6qlHqZAmVCv/YcN+JnhZeIS/
         aTdh/611Df7oHJT/FrcBg4ukmpgULhzjVuJ03zHDWZsemhX1aiSJBBAYV2txvAa+1yeE
         32OA==
X-Gm-Message-State: AAQBX9cHN5hGOeEKtNb9AnOnKckGiU5wto6WC7hXd6bo7EeGHewY7bTI
        DMz8tzQpvZqUoDe0E4tTwnHZ/e6Xm+ZUE130GN0=
X-Google-Smtp-Source: AK7set8GzakgEcD+iew1EvVg16zH7Od5EqId53wZhevHAy41gfnGYW7r+OsVTQUSxIMQ3eKRPs1YVGJIdDvUmEPZVOQ=
X-Received: by 2002:a17:90a:8c93:b0:237:8c94:ada9 with SMTP id
 b19-20020a17090a8c9300b002378c94ada9mr8926945pjo.7.1680357597214; Sat, 01 Apr
 2023 06:59:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:6ba5:b0:60:7e6d:1540 with HTTP; Sat, 1 Apr 2023
 06:59:56 -0700 (PDT)
Reply-To: customsus@hotmail.com
From:   David Carmin <d479933@gmail.com>
Date:   Sat, 1 Apr 2023 14:59:56 +0100
Message-ID: <CAG4H4vgXMYd4jrss957K-hnKraWE7g-m-6mm_7RxWTygs8O=VQ@mail.gmail.com>
Subject: Why continued silence
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,UNDISC_MONEY,YOU_INHERIT autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1041 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [d479933[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [d479933[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.3 YOU_INHERIT Discussing your inheritance
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did you receive my previous email regarding your family inheritance?
Reply strictly through: customsus@hotmail.com

Best Regards,
David Carmin
