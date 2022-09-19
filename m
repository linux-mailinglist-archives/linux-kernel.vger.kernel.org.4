Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EC75BD5BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiISUb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiISUbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:31:23 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04828402FB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:31:22 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b23so557856iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=wERC1dAKO5PL7pICmuBQieROEUKf+Gdl0m2+8GmdLMc=;
        b=k+bIQw1gv3n1q1gP34j3JVHb5/2ROiVNrtkcgimiMv5liSirAH20R2T2hVBpeQUTtH
         hRxTKqutv7n1iDDc/0Eap1MdociUhaThwbtk+zXpW5ti5PLZW3brOG9PioUABvOalx5A
         5Cxb6J1eoO58JN6l2UgfOIn80R2Uf5VOnrhcy0xzwGs0MCvtZbfOr4ZB5MYVKtBB1VK4
         4FZLXae+vqlJAN021xzDwDxDXL7PEyGwHRLVLK3NL1jzewK//925hPmFl7Y0yN8fKq+1
         WZxKyd++7PUbdFL1G0OzUnpIHwR4YzB46zU/CWQVQH5MSGz/XS6kL1V3vIsz7HrmHsce
         aIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wERC1dAKO5PL7pICmuBQieROEUKf+Gdl0m2+8GmdLMc=;
        b=sV3/46iIPH3H9N3PLjQRaVC2D23+TitzCDEaNQrcMot7Tnv4O2b2WvV/q15plYoFOx
         yR/vje9nPb5FVdsSMVPJxIisg/Iu/rcn4TVmHdQ9mdKYhBzHhlRmie6Qslc2oPEPsLhV
         I/tUENBqOMY0BEJOt9doqQInYyutZGLVkjvprwcVuDQ6f5mNLCHNgIG7/9vozY3jXIwi
         ZULsQgZoYWGvtSia/fYgAi214Qz/aDBbuMmMiDuWSKU+akQPOBLD372+YB84A0z9+TRo
         +BA3TglKRCrcg6KqxL/NOFsIdcHer7SLZqf5vQ62o2IQJQtpVo0NCxXoMsPMDiUzxEzj
         ey8w==
X-Gm-Message-State: ACrzQf0xX3aPXGvndIBAXpwFdENJpbMQw8Ze7G2B9ucEUlt5e7WZ1cEi
        yrDfHroZJZ1Q7tZAAeZwVG21vs5p4cffGWB6U04=
X-Google-Smtp-Source: AMsMyM4uyTE9TWEVfG7fRfwaInCsHV2uU4TPylCF8V5vznGyN44L9Ifo47Xfh1hEIvqrjq7JRJqAkUYWfqpL6p0bOrY=
X-Received: by 2002:a05:6638:2103:b0:35a:75b6:9992 with SMTP id
 n3-20020a056638210300b0035a75b69992mr8540054jaj.244.1663619481260; Mon, 19
 Sep 2022 13:31:21 -0700 (PDT)
MIME-Version: 1.0
Reply-To: honbarristermatthias@gmail.com
Sender: michealscaparrottis5@gmail.com
Received: by 2002:a6b:fc0a:0:0:0:0:0 with HTTP; Mon, 19 Sep 2022 13:31:20
 -0700 (PDT)
From:   "Hon. Barrister Matthias" <honbarristermatthias@gmail.com>
Date:   Mon, 19 Sep 2022 13:31:20 -0700
X-Google-Sender-Auth: zLhptStW6mUIuX9eps8gJ4W7lKs
Message-ID: <CAKDDtC3DfGJ59o0=XTRPsOHsbp4_aXFt0QYbXtAXG+xqQjGQ1w@mail.gmail.com>
Subject: My Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNCLAIMED_MONEY,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5239]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michealscaparrottis5[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michealscaparrottis5[at]gmail.com]
        *  2.4 UNCLAIMED_MONEY BODY: People just leave money laying around
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Greetings,

My name's Hon. Barrister Matthias, I am sending this brief letter to
solicit your support. I had a client who is an Indian and his name is
Mr. Gurbhagat Singh Bhatti , he was a dealer in magnesite minerals
here in Austria and also a Gas dealer in Russia.  He died six years
ago in Russia after a Gas explosion in one of his dealing offices
which led to the death of both him and his wife.

He deposited the sum of 4.5 million euro in one of the legendary banks
here in Austria. I have tried all I could to get in touch with any of
his friends or family members but, no way because he had no child. And
the recent death of Covid 19 killed his only brothers in India last
year.

So I want you to apply to the bank as his Business partner so that the
bank can release Mr. Gurbhagat Singh Bhatti funds into your bank
account. I will provide you the guidelines on how to contact the bank
and we have to do this with trust, because I don't want the bank to
transfer the fund into Government treasury account as an unclaimed
fund, so i need your response

Warm Regards,
Hon. Barrister Matthias
