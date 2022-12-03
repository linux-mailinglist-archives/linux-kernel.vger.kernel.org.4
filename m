Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58213641687
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 13:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiLCMH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 07:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiLCMHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 07:07:55 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41693F5A2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 04:07:54 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id e15so8497597qts.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 04:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y78y67RVw2uXG9RJFp2RuKu+RlnDrDe0ymn8WGfSUUs=;
        b=kmTuH1yfWEtEJpbBD/xa9Sg88Cg+XmnHYSSp4e+YtC1cVhidrzviHxzMmKpaDgIooe
         /QYaikhOzBUYSE9wjd/SnehDyLnM751feiz/CRPJZ78MNJ2hTiDqiUpnCdIldtqH3oSe
         jQ9a5UKkFMYsHQqpzuxelLJZ8MALS20HWDxDbtLdOUxnViE97EWzWcaCY4tsc0uJHJGv
         o2IMjYAonyqgbe5FH5WWPV4d6DuOvJoH6frgG9se9ysw55ZTqr1lEym4lQXA0Ka5reKI
         UbbFTpH7PNQFrkgjxQMjTpP3Pxe+ubGpu+dfLD9cQoGrcjgH4tu9laYRw34Nws7HEQlK
         O24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y78y67RVw2uXG9RJFp2RuKu+RlnDrDe0ymn8WGfSUUs=;
        b=b9WoV1Z7112lZB0A/xAeRReQG7qhDuPER0nfMJp998P1s6c8oQyrDb4o1XPnkzaeyV
         x7aznB8Wjksd2cNwe1oFSBd+qxfJSqNBJXsT1CuyiCdDdLF0upe24mcDgAJ3ChnFfclk
         pF0L+D7CI+X+VEtiylD3ki/vW77v69yQUjWx+PnseD6UDLF+UtCyLdcc0Zy38GMQ9QaZ
         fDA+/AN8f1j4Q34l+uvMlfJBO/vkPWnamUcumsjQUx9ko/73GIk+p21TAYVZYfM3yTTg
         ZNrYW0p0Q8kO4S4TOtZ7pY+6Fsa0LBQqhuTRMycz/QKA9NWb4Nya+wZsqwc0xm0/HWd4
         3t6Q==
X-Gm-Message-State: ANoB5pn1H/cSWRNhmwsRE0mQXj5w1bRcSDcfOytdYl+v2xlHj0xGMnMM
        s14LCmNRNjrDXW6wO9jU6XCdoNKdRnHAYgxAsCY=
X-Google-Smtp-Source: AA0mqf7BtUVC0q9YZM2WCqyYbzF7Mu6sJWF4rC/PadsxLe3wJooZo6H5DzLxPWV1kIfpkvNNtV0NFHKakvcXFPEe59Q=
X-Received: by 2002:ac8:4a1a:0:b0:3a6:a61e:8c01 with SMTP id
 x26-20020ac84a1a000000b003a6a61e8c01mr1439549qtq.214.1670069273229; Sat, 03
 Dec 2022 04:07:53 -0800 (PST)
MIME-Version: 1.0
Sender: alimahazem02@gmail.com
Received: by 2002:a05:622a:1041:b0:3a5:252c:1bdc with HTTP; Sat, 3 Dec 2022
 04:07:52 -0800 (PST)
From:   Doris David <mrs.doris.david02@gmail.com>
Date:   Sat, 3 Dec 2022 04:07:52 -0800
X-Google-Sender-Auth: XJ3GLEV6kbOnBEShQJbF-FE0Ja4
Message-ID: <CABBDEbj0RMov=6gWG+0aQhs+ZGhAZfRSkMydWAENvyiJfNBBFQ@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:82e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5030]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [alimahazem02[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alimahazem02[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
Mrs.David Doris, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000,00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very Honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I'making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how
thunder will be transferred to your bank account. I am waiting for
your reply.

May God Bless you,
Mrs.David Doris,
