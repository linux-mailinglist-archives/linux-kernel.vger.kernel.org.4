Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2463594B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiKWKJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbiKWKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:08:48 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9FA7720A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:58:20 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id z9so8285858ilu.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A5Zw4wTof6wwwRVMT2EklD6tpS33zcb3kC2X1CkRqg=;
        b=aGvKunKQ13jmlYKaoY6XWGK9LWbvK/A46KJK+PQPFi34plgYTyLe8h7DDHiwdP3TX1
         z2fiEvNW2iaMh2wwaCndCoUVALmkzv+x7jzx2AYylSB1IAueCF9FSFMFC3N+8Fr8kyJ+
         sx0xLfT5/FZT0wzW1gB7ysw1F9b7QU5pEegF3fWT6MuEgvpIT74Y4DADOb8s5lVwPb0n
         tZCfRyJNwzUJHODu8GgSkInehuEvyN3WMb1lPPn0JM9fxTGBw6w6dAskPHP11c39EnU7
         r69OVabQY5IGeeKMRkDTbCJh3cnT4Hm1yHagQCa/TTHvJjJYIcE2kv2nHcebw3Nf3XkY
         HL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A5Zw4wTof6wwwRVMT2EklD6tpS33zcb3kC2X1CkRqg=;
        b=Ynr9hhZFAhZ+mhD9ASrRY+BW1UGRHJvg4V2ocvGUsFythyUf67FwMOuIXNBu9ClK0j
         jxVW/16MsZgTcks7XtTIMYBBHMiZUF+FIXUwTwN2V0cBz4uZCn2DLP3U2QIW69djqIqU
         0NdGMiLwCJuFR92N8NLZ2J+dMKo1idiGOpb8+MWUEOfCF2nlAwsH897P2AaxSgm9IxHF
         O+ZyH/7ePw7UB5rvwWuJO+31y5R7QyQjVl0nSCNq9PPw1jUy5wezukN2dV57HAWQy4k2
         zsNWpLb8pKXUC8OG2xkQd0CtEtau16vP4ydKBfBRpp2Ffbn6SL5nxDjXL45kxJK38QR7
         UIwg==
X-Gm-Message-State: ANoB5pmp9/5B1BI2a7w0itkujtfYxgeKOpszNaGQxzBmXb+BVYfGz5m9
        PMPPorrPPcdPrIPkfREFJ532G1LckBsm80dr8jE=
X-Google-Smtp-Source: AA0mqf5XHLzsb2OhjgHaEtBea3aUNUA2YnDEvZGjaiecWF4FwxCThJeaNc4DID3d96oDru7AD0iRIxUG7y2KGoZTAAs=
X-Received: by 2002:a92:dd0e:0:b0:300:b9c4:8c1 with SMTP id
 n14-20020a92dd0e000000b00300b9c408c1mr3352304ilm.124.1669197500046; Wed, 23
 Nov 2022 01:58:20 -0800 (PST)
MIME-Version: 1.0
Sender: nicolemarois44@gmail.com
Received: by 2002:a05:6638:2687:b0:383:cab3:74dd with HTTP; Wed, 23 Nov 2022
 01:58:19 -0800 (PST)
From:   "Mrs.Yu  Ging" <yuging9567@gmail.com>
Date:   Wed, 23 Nov 2022 09:58:19 +0000
X-Google-Sender-Auth: d1O1YliHlrP6Bf3VBMzIe_uNytE
Message-ID: <CAL2XLtCXCVHdhHZ2ruuE=Rg3oTPHzWZWXRKzjjq6wxwMFRJNoQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:141 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nicolemarois44[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nicolemarois44[at]gmail.com]
        *  1.5 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China

woman but I base here in France because am married here and I have no
child for my late husband and now am a widow.

My reason of communicating you is that i have $9.2million USD which
was deposited in BNP Paribas Bank here in France by my late husband
which am the next of

kin to and I want you to stand as the beneficiary for the claim now
that am about to end my race according to my doctor.

I will want you to use the fund to build an orphanage home in my name
there in your country, please kindly reply to this message urgently if
willing to handle this project.

Mrs Yu. Ging Yunnan.
