Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F5C610395
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbiJ0U7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiJ0U6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:58:46 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78847BB390
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:51:00 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id l5so3853015oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a/RXZrnyXMZnlvEbv/57lMhjH53DEG43L7XPPMRhNYw=;
        b=YK+y8DUf+1F7+Hx2tExzpOAFepFQzEpBuz33Bm7dHiPre37Wq+CstT5H6gl9W9S14S
         GsUjTUYFlzi7ASZ+agfdxm0hhrcnrTCH85XNZr/QhrNsdXVcJaINdP7F1xc3vviDUh6g
         CSDKfczLsJ0dekIiB4N3IDgEP9v6QuWKUpODJw4MWLWwF6nHxXXsbcliZwBiaKZ1DyMi
         GTLT7laLArMx+soPdzyOXVyn/KLkhRNh8MhQU5ambLLhYM+SG8m7RO6v3V/uvQ3Q6+EC
         0cEU9ksGfoMel7OZcrRx1oha6wCn9/JL/DyXzjnW+NR3Fs4r0/VcrMP8KvyumN5QSqms
         HieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/RXZrnyXMZnlvEbv/57lMhjH53DEG43L7XPPMRhNYw=;
        b=Wy9Jq9lgrLboxq0O3C6/T1WlwKPT+0FQkGfU0tk4v5LY8UeRxGVKtSeLp5fC09WeZk
         5dcM/dW0WwNOeBDEIoVHM6LFIRINIYwtUxf0/KVnUBkZb207OffkujMsExmeyhHhvNLA
         5D/29+RBAd3MKxY0amxAjQ0djs2eOZPsnkqUAjPjcOcw9LTkEijbI/4/3yknNMSK+oNX
         z/ei1b8w+darrODxGhtOca7LcisGnVVpvBW4PWpbNt79D32D6gIN/kPVsX++YRMXzSH7
         67gvjmLaHeiZ72IcffwTx4iu0ITcS6t7keOPX9X6PVlTiwiExzDU4Ow//Z8bdR8EZmuU
         WFNw==
X-Gm-Message-State: ACrzQf28e1O7ecRRRNMYLmX6N6Iyhed/BvykuvcUVCFFdnd/gOVDdjck
        NpARlORxYLzr9eBiVEJpO7TkpdoORQGzBaT21VQ=
X-Google-Smtp-Source: AMsMyM6q5QKHZWk2Q74ziTsW0ZuV8/HJjb0OZSYBzcXVAPQWPp0/8EX98CPYBczqOFglNNMlHMJDyCIx2QSifWCs9GQ=
X-Received: by 2002:aca:1b0a:0:b0:359:b400:6385 with SMTP id
 b10-20020aca1b0a000000b00359b4006385mr4897915oib.11.1666903859337; Thu, 27
 Oct 2022 13:50:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6850:7f87:b0:378:74e3:5749 with HTTP; Thu, 27 Oct 2022
 13:50:58 -0700 (PDT)
From:   "Ms. Ella Vinegar" <ellavan212@gmail.com>
Date:   Thu, 27 Oct 2022 21:50:58 +0100
Message-ID: <CAGNBo7DqwQxXHiprA8jVKphOC4=bjvq7x+ekq39=NFC6mgYD6A@mail.gmail.com>
Subject: GOOD DAY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_99,
        BAYES_999,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:234 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9999]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9999]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ellavan212[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ellavan212[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  1.0 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day to you, my dear friend,

How are you doing today?

Please I would want you to read my message very well,

My name is Mrs. Ella Vinegar, 56yrs old, I am originally from
Switzerland. But my late husband is from Burkina Faso. I am someone
suffering from (cancer) before my late husband died.

I contacted you personally because the doctors told me few days ago,
that I have few months to live before I die.  I've decided to contact
you to help me develop divine mission projects in your country.
(Charity projects)

I have funds that my late husband left in the bank, and we have no
child before my husband's death. I want you to use the fund to develop
charity projects for the betterment of lives of orphan children,
widows, homeless people, church project or schools and any other way
that you know to help people that need help in order to make the world
better. I am confident to contact you today as I wish you can
understand me.

I want to know if we can collaborate to help the orphans, the needy
people and disability who are suffering. Can I trust you with the
funds? I'm currently going through some difficulties due to unforeseen
life circumstances. Please get back to me if we can collaborate to
help the less privileged, and if you can be trusted with the funds and
the charity projects.

I want you to respond for more details about the charity project.

Your sister in the Lord,
Mrs. Ella Vinegar
