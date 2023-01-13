Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1636697C4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbjAMMzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240759AbjAMMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:55:22 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BFE76206
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:42:08 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id bn6so22336320ljb.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bDIwWVCRlNTvDwsFQzlmS++5tBa1uCLSFWFBYXobMg=;
        b=U7FNcxeX7ENbW2naYg7iLVlsfQapVqotNClbPON1ANwn5eTAyNLN5fyvLfYf1VPuRQ
         w0q8RkZI6RfMN4WWT3EiA7ELAwLS6ikloGJ89/eL6nvfh1MWepVRuAL7PIRQdSa+tE4D
         PVDZbygsRQOXoor1Pk1O+aNw5ZHZKgzWfrtSHfdBpwsb50enPr+G0LTZi5Bu+QWI446c
         zwizqwSneIPu6dAPoGCoxQ/yC9rAAh7ShUSruA+ESxliEnKCZfo0mEYhKWJvHIefCp5p
         pSiobhM5yquAOqpfeS96B9wUhPraZEAZBOkbt7dSmkK1JjC7eGIsAVgGJ0HeyhMBmGqc
         V25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bDIwWVCRlNTvDwsFQzlmS++5tBa1uCLSFWFBYXobMg=;
        b=7X7Ni1ONaw5gqgHc+OaapdxEuS10Og2YYGy/gdcPDYgtq/RkZB+9LzzpsfIgIUKpNj
         GAN512VV5JYEjIheeBjKiT8cmjXPNwUchiO0d+NFtAgqldEWkKkbIxIEu+EpkuT1lkHH
         3G1KeX7pX6KvRzBgvMHXb5l3QE3eYWIz9jR5IEMquY1iBT3jKdNBZUFiHtEF92GyM6BJ
         AT761vQ6IAFlepDzqIq4iIP5EFTnwrizQus+fPobYkt2MBkBuwtJa8JipLCi5GVWp3Fl
         aFU3aYHRn052rVYpk6b02EBsvUTsYVA9ZH1Z5Xu7jT0cckXfCdAzEHx1ePGWk88x6Xpx
         oonQ==
X-Gm-Message-State: AFqh2krFtwDpWYzXTZSRCgZRQvDXM6HiQ6gpCChwaAr4Mf7quQRg2piv
        AR8OfJMZAJdB1ShXXhhf5LmxBJfiDvtctdMqii0=
X-Google-Smtp-Source: AMrXdXvawrAjUrqJc+DNIRjS6r4dZRlXVb3OOcKx8iYpG16TpolJtyhs/mTNOJ0Zt1kFid5aR6FzgFyNWWCJnxXmhzk=
X-Received: by 2002:a2e:9e81:0:b0:281:d9b5:9491 with SMTP id
 f1-20020a2e9e81000000b00281d9b59491mr1222143ljk.170.1673613726108; Fri, 13
 Jan 2023 04:42:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:b5b0:0:0:0:0:0 with HTTP; Fri, 13 Jan 2023 04:42:05
 -0800 (PST)
Reply-To: ska.anna794@gmail.com
From:   Anna <jannette71dval@gmail.com>
Date:   Fri, 13 Jan 2023 13:42:05 +0100
Message-ID: <CAFkFQMxBg+uq8nmCSyPYEbEaYw_HgQt5KqFP1Wqx=dFbnKEv7g@mail.gmail.com>
Subject: Hospital
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:229 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5375]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ska.anna794[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jannette71dval[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sincerely,

Dear friend, how are you, I have a charity donation fund that I want
Contribute by helping. Please try to contact me to know more
information. Hereby I will tell you more about myself and my plans
Money when I hear from you.

Waiting for your reply to provide you with more details.
