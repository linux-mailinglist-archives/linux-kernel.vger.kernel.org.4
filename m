Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A14F5B62C4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiILVcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiILVcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:32:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0562D1DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:31:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so11962155wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=eCpgL743uWVZlwnsBcJNLCjxPjqLeWsv80X/liqz0bU=;
        b=m93oTuZvYF3jO0DtHAotW2/kXyQLovZ/Hb2+pC8b4Xi+gHFy59lvVFUqrOrbvsiX1K
         GTPkiUlaBoM1Q6yXH1AGdPytsoEQUb0v6y09Ei2l6GCHwGgtlqk4Mwraha1+BKt6H+iw
         2ae64QdQ4nt/CEJasDfvgrrrqCqos0jd22YRKgb4CcB/7ao8CwGuhm6XNf7+jgjy6Wf+
         reZTUNpwIY9cJ2NiEiMTKjV9WTiQ9huQq8k8brgC27mw+CIw+hiXnBd7GaLnbr6hSVbI
         AKtV4RM2vLu32mLLSGSs1BjjIINO5gWW8uLdg4yte8oDZf0sIr5AB5akrLo5KYClq1jv
         bPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eCpgL743uWVZlwnsBcJNLCjxPjqLeWsv80X/liqz0bU=;
        b=c6C0M97keBvJU7rFvuVGXnVkeHU6vpKxivRLE+PTxyUATOlW0OyCgDqVNfdoo+Dbqi
         vawVguuj4A+GRvLMg83+5UwOjjzhSrH5XfVeKH+NcNPRVKXHoNwQEEcvsWkkls6Su/uI
         9k2OQbYPast0y2hImKGV2QL1TOA8hpwvgs5ifCbMQhByOnEPM0RZYI9ejrDbbS8rzQuN
         2blbgsRVVabzMPC3ZNRUdninKKNOesl6pKbTka2N0ArOmerjKmfZ/9G1yt714ZzNAKfh
         fMfL87disSN6CUdGEkHGfrMKs1X8KQWbWJ+xEYiIXo+SmqV+SFkID/F/jmMPIaG3edfF
         Htlg==
X-Gm-Message-State: ACgBeo3cA8B/r35E2xkKeR7U88kyxLxcMKG1ffRmI4Ptmn/jAxNLFXt5
        CaKc1jbbWAbhxgxLAd+He9aHOiI7tgaK1GPiYiE=
X-Google-Smtp-Source: AA6agR6zrJ8+51QsBc96CAFC9bJkUCapXv2HBvRSqHY5moJDTHA8mPCOrGQeaiY/BLhC3z1o9sGaBPzYt73MEfj1Tl4=
X-Received: by 2002:a05:600c:348d:b0:3a6:b4e:ff6d with SMTP id
 a13-20020a05600c348d00b003a60b4eff6dmr192894wmq.95.1663018318137; Mon, 12 Sep
 2022 14:31:58 -0700 (PDT)
MIME-Version: 1.0
Sender: aboudramane.traore47@gmail.com
Received: by 2002:a05:6000:3cf:0:0:0:0 with HTTP; Mon, 12 Sep 2022 14:31:57
 -0700 (PDT)
From:   "Mr, Mohammed Rafai" <mohammed.rafai01@gmail.com>
Date:   Mon, 12 Sep 2022 14:31:57 -0700
X-Google-Sender-Auth: A422CeWFPQRtDKZYYjttmedX8y0
Message-ID: <CAJ8VP5jjWbfwXdW9RWGzxDbd7UPKm0t58c+Hqea-rhm-adwHUg@mail.gmail.com>
Subject: Good Day.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_95,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32c listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9527]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aboudramane.traore47[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aboudramane.traore47[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

Please accept my apologies for writing you a surprise letter.I am Mr,
Mohammed Rafai with an investment bank here in Burkina Faso.I have a
very important business I want to discuss with you.There is a draft
account opened in my firm by a long-time client of our bank.I have the
opportunity of transferring the left over fund ($15.8)Fiftheen Million
Eight Hundred Thousand United States of American Dollars of one of my
Bank clients who died at the collapsing of the world trade center at
the United States on September 11th 2001.

I want to invest this funds and introduce you to our bank for this
deal.All I require is your honest co-operation and I guarantee you
that this will be executed under a legitimate arrangement that will
protect us from any breach of the law.I agree that 40% of this money
will be for you as my foreign partner,50% for me while 10% is for
establishing of foundation for the less privilleges in your country.If
you are really interested in my proposal further details of the
Transfer will be forwarded unto you as soon as I receive your
willingness mail for a successful transfer.

Yours Sincerely,
Mr, Mohammed Rafai.
