Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712EC642511
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiLEIw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiLEItk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:49:40 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF556330
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:47:48 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id a7so12672905ljq.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/9KhjDhwpzVfwJmk8owTMTn5ZR3PMrLWiYt5zlM5F/0=;
        b=O3CtGR6VtitqSLsmiUi+f+GcOKCO8TlT0ZZwMLjgvNUmhl7WQsrEWyKesH6tbG0+3f
         xqgm7mZAp9eFntv3udW3fMrHoxCwYKelU7VzHBmdr0j41jOMV0tSHXsP8ayCNd8PRtIY
         ZcggmdY0NLA5drFbUt0a7lOQVnFfGxvqxA213j38Op1NCQJCRQqk5NJZ4w/FMb01fWsm
         0ozlaFpAgr0ayDrnB8EPAMc0EwK9qd5HZ8blB+13GgVcag9VjIiyfEh2QM3hG0IocjSG
         k/B7K4xayeXuY7x2/70UnyvfDuUEwk/FJq22L6WU3cEgkBE+VTMYvTBEjXBmzU3ptjt9
         BxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9KhjDhwpzVfwJmk8owTMTn5ZR3PMrLWiYt5zlM5F/0=;
        b=bc3TKKn5Q+4HIM3b+tmnMGka4VaMa6GpKbDmdznD8p8CStEeGYwUC4TIemGAHvy1ol
         pKg+a6XvUAtph1aiWwtKkop50p8OZrIY0CuyME9EdUnE93WnMW6c4W28qlhMTfQ2++2v
         NOcsojssb7sroNDK5WhNBA0HPYsiIMc6D8B9tgXjGU8FQ21C1/39HP3oEpz4ux9+m7hF
         yiaP5xhMZtbsyCrnH5UIY1Ymnux6aPjLJMZCakPKA+iUknIU6x4NuJumVHOqbMWpF7Um
         11kirQlFDPrb2WMviAJw53U0noC8eND7g4O1Oa82wK/2W8HMlJI162nIVnqEYbRvheng
         aJmg==
X-Gm-Message-State: ANoB5pk3KWrZH0KfkYEnYDoL624OTUCCmdK3h1DXAAh8ZbxhjeMJAoL6
        HtVpauuMU7z4HlYlEIYZZl4tM6JZj6ZftTSo31c=
X-Google-Smtp-Source: AA0mqf4cdYkMAb00AOtah3ECLHEou5VsYmwZURrRQriNBXMOG/eGBQirxLEwGkQ4CYihK89wrXYuz0bHEfmIsvFIGSM=
X-Received: by 2002:a2e:9cd1:0:b0:279:d461:8528 with SMTP id
 g17-20020a2e9cd1000000b00279d4618528mr4971543ljj.389.1670230066729; Mon, 05
 Dec 2022 00:47:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:883:b0:200:61cf:e7ad with HTTP; Mon, 5 Dec 2022
 00:47:45 -0800 (PST)
From:   secretary inf <bfbsecretary224@gmail.com>
Date:   Mon, 5 Dec 2022 09:47:45 +0100
Message-ID: <CAESrDo4Rs7EVWdovVGEMnhwj6xsp+wJnp-YRYuNiS8OxvZuKxg@mail.gmail.com>
Subject: Hello and congratulations!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY,
        XFER_LOTSA_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:243 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5040]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bfbsecretary224[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bfbsecretary224[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 XFER_LOTSA_MONEY Transfer a lot of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fairdesk Bitcoin Exchange Cryptocurrency Exchange.
Dear email owner!
Hello and congratulations!

During our visit to introduce Bitcoin Trade (BTC) to the people of
Burkina Faso, we pulled the emails only for Burkina Faso, but since
Google search cannot be accurate,
your email came out with 5 points of BTC, which was converted to =
$95,304.00 USD (Ninety-five thousand three hundred and four United
States dollars) as of September 21, 2022.

Note / this money is payable through BCB Bank
from Burkina Faso!

Your Wallet (BTC)
Bank check (BCB)
Bank transfer (VB)

Cash payment is only available in Burkina Faso where this
program took place.

Please send your claim number (C00005 BTC) to the agent
of complaint: Mr. Mohammed SY!

Email: agentbfb@post.com
Cell / .

Payment Valid: 14 days.

Thanks
Ms SIANA Ahmed.
Bitcoin Trading

Promoter Mr. Jacky Choi - Co-Founder - Fairdesk Technology Limited
Singapore Co-Founder Fairdesk Technology Limited. Contact date 26
September 2022.
