Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A245B9F65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIOQLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIOQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:11:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFEA915D8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:11:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 78so17707619pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=qabPFsKsVzBs/IAmyQMB7q/BmTmNWLyFuHa1qxS6Sh0=;
        b=qKZ4uhroibyA/kbyJWXPnExJXjgtUGAwIBN9HJmGnAYuFHc9pHofi0mFV6R7LAQa6+
         69Fc5SVxfAgQRJNI8H9DU3S+4ByKwkBcDuTArTdgUrk7xdy0t5tJ0D369UnyNPCRbcmR
         cgCEyq0OfpckdJ5wt1Axz6umAj0yfGG7d6F92tzKjWXNpk2v6AHTX5jP8n9XBS59uc8P
         sa/3823e0flLKONJIPvHIPpJnwv6nk0gnVc3z/GbsXwX/egPY70fjaYF88o3Qo40l1a9
         RZq1hQdKI0+Z5qxMlE51mLHBl4uQUPs21hfCXkmLARaLY1SD3UWKFd8moNekhop6Tng0
         /ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=qabPFsKsVzBs/IAmyQMB7q/BmTmNWLyFuHa1qxS6Sh0=;
        b=8JkLleIKEMOLcmOqd7HgBqiUBTIIO2Y3Lw6IC68Kz+6bVQQcbj4lIXUfzIwDSezkqh
         KHQvrUvKBkOySwIxTxxqZvSLmDaREGaZJf02Vb6GAAJNDULycXS6Xgl65bvOVKpy5UG8
         htoOvYHgTxFgzLBHZScdkZq2rlAJl0bntaQcw0tEOU9j1gclvq+HEsKVWnhYbUZDFzNY
         TzdkPA2AzuKt6iD/QVzsq/Y37MWMLioStKpkJZxtQt3hhfh3K3OGemrOZx8gTdMpmOYy
         7aO7TKVrQPbn/zara42PGlFcPNgHfRPLQ5dPVilD6OXSHoq826nrksnu0WY1uuLCvIv6
         t28Q==
X-Gm-Message-State: ACrzQf0JshibJlRLJVqpwVhOCjEN61pe6nLTAqSnhcdcyGqJKvS1jv/0
        QVQe5hDcjXXayN8/hWi3bH8MPYdSA9+vvZDCBFo=
X-Google-Smtp-Source: AMsMyM6+ZRoMxZaiuT/EK7sOt4bZSW5rcp+f670tgtTFsKu8gQ6/Ns2qfdTeJv4CSbOPUPfIXHZ1DTzV2E14qlpbII4=
X-Received: by 2002:a65:63c3:0:b0:42b:5b03:ce57 with SMTP id
 n3-20020a6563c3000000b0042b5b03ce57mr522542pgv.436.1663258293835; Thu, 15 Sep
 2022 09:11:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:ce8b:b0:177:eb6c:b271 with HTTP; Thu, 15 Sep 2022
 09:11:33 -0700 (PDT)
From:   moonlee park <moonleepark4@gmail.com>
Date:   Thu, 15 Sep 2022 09:11:33 -0700
Message-ID: <CAK1kscZ7rpXdXSVafoHYVO3H8PH3mSgE=73BL-eB5JpzT7Pf5g@mail.gmail.com>
Subject: LOOKING FOWARD TO YOUR RESPOND
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORM_FRAUD_5,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,MILLION_HUNDRED,MILLION_USD,MONEY_FORM_SHORT,
        MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_FILL_THIS_FORM_SHORT,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8153]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [moonleepark4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [moonleepark4[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  1.4 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
        *  0.2 FORM_FRAUD_5 Fill a form and many fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please let me use this medium to create a mutual conversation with you
seeking for your acceptance on investing in your country under your
management as my  business partner, My name is Aisha  Gaddafi and
presently living in Oman, i am a Widow and single Mother with three
Children, the only biological Daughter of late Libyan President (Late
Colonel Muammar Gaddafi) and presently i am under political asylum
protection by the Omani Government.

I have funds worth " Seven Million Five Hundred Thousand United State
Dollars" [$7.500.000.00 US Dollars] which I want to entrust to you for
investment projects in your country. If you are willing to handle this
project on my behalf, kindly reply urgent to enable me provide you
more details to start the transfer process, I will appreciate your
urgent response through my private email address below:

aishagaddafiaisha20@gmail.com

You can know more through the BBC news links below:

http://www.bbc.com/news/world-africa-19966059


Thanks
Yours Truly Aisha
aishagaddafiaisha20@gmail.com
