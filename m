Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F36A5C056A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiIURnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIURm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:42:57 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F1495ADD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:42:56 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-324ec5a9e97so72364167b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=r6nAK3W+I+VFvNUOaty/0AZ4wcBWGoMVhHCdoCYUFIE=;
        b=SbRQAW/ejflGEMmw89PEkZKZlDqRO4IuCvu+gVTLURQe5RIA0akJESEkJ+HdOA1BSB
         +wY7eCbDwwxWqUhoRPVG4+FzczoQzG72JRfThDefEjYhX16H3x4R5JwJbBA4nLYfLZ9f
         Lyt/0dxyFkkgjQnv/7VuT41kAxJpOXB5Ifxl4t9RPn2fXtLcV/5rZaVq/VjNLKf5o7S9
         cmIcUSLup/tv4ir8H6t7EZKh0LIa43qOMR5UGVUsNB2Kh2nxTgkJW4B0UFxryXD3SNOj
         70dcaP91eBAYRdCX/h2Ei+jae9mC9Go2fldnsigZcVtu2Gx8W29nMqQNyMulUGFiA/VP
         MyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=r6nAK3W+I+VFvNUOaty/0AZ4wcBWGoMVhHCdoCYUFIE=;
        b=Ra1s+sGllvbkNC0ArzId+cDsGF/sxVdLzL7sIowtSTZDb86Q7vXEvn04ZZykNRJoWm
         Ff+f1387sDtuXZb3sflfZD6+6Y2K84mkiVB+faV++1FZ+EAxLfzLgQYasdFbM+pWPMjo
         fYY2WcgTjFUrPQutiw2MDHsYJ6Ni5LB4DK5gnaAQqUR1Ppnkp/Ym2JEMKdW/DM1erJhA
         6degmjPB5gzVii6gDIyzjfGIqcHtrpEZ2OpsBfyPfSS/MkX5SAwllHZr57Lf5kyvPWjy
         Ek4N+wqEfrHLCdHVleJobTlKkEW10q1MzaxxA+2ulj7qApbjS/RUWQX3gC4lXHnPLB6h
         sRIw==
X-Gm-Message-State: ACrzQf2jpeYgT4FEab8DyOa6e4BaBDtKO8Z/UN4L7M/KXltRp7TXQ4BM
        Z4KVCWfvds1CL9+95YQ0qale/kYkGRrWFD3NVEI=
X-Google-Smtp-Source: AMsMyM7zqQUisPXjuTssYy0nA6o30WVwg3FtCkanZ5WRXRPAjIiJy+azMQTGNTMrV8IsMUMhtanPJ6OMvfV6meywbRs=
X-Received: by 2002:a81:a48:0:b0:345:439:3444 with SMTP id 69-20020a810a48000000b0034504393444mr26140295ywk.78.1663782175229;
 Wed, 21 Sep 2022 10:42:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3704:b0:305:8311:e0ae with HTTP; Wed, 21 Sep 2022
 10:42:54 -0700 (PDT)
Reply-To: mrs.suzarawanmaling@gmail.com
From:   Mrs Suzara Maling Wan <mrs.susaramalingwan@gmail.com>
Date:   Wed, 21 Sep 2022 10:42:54 -0700
Message-ID: <CAACzCP3iinHShwwqwd2zQPUk4XuPCF57X6nSoFtt8g=CabdsOA@mail.gmail.com>
Subject: Mrs Suzara Malin Wan..!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.susaramalingwan[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mrs Suzara but based in West Africa Country since eight years as
a business woman dealing with gold exportation, I have a dream and
desire of building an orphanage home in your country, and i have a
deposit fund to the project, but

presently my health condition we not allow me to carry out the project
my self, now my doctor has already told me that I have just few period
of time to leave because of my ovarian cancer disease, can you help
fulfill this project.


If you have the mind to help me in this project, contact me privet
email address  for more details on the way forward

With kind Regards,

Mrs Suzara Maling Wan
