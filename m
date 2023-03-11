Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9DA6B6180
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 23:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCKWgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 17:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKWgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 17:36:53 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3B5ADE1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 14:36:52 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x7so5675816pff.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 14:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678574212;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87dcZszEk8ij6lSi/CqcaBS8yPG/kXnAghqk+AMY8Rc=;
        b=NA1KOuvy8lbUIzd0XTBW8JbkmmsiE+Sav7+fB2sKtAB18mopC1/a169xUgswMwL+zA
         vQHlKc/AVqwH60gEhvy2wFISclmGkeiagu+tedz969bBNn6spndkgsHFVhrPIg2nXUba
         12h4XvPt1dg14RUhRuhejVaM1jUaHlJcCTT46+oNp5edD7PMtAUtdJWGiTTNubMEOIx6
         aqcMfl1G+Te8j5HQbWsweRsPVMUqkfvQ6OhZA9PiREpwhZR6PYmrv8nYV8tKw8WIVe3D
         Wu+P+kf7RB+tX3+klAAWga2jTAmOIb9T9CkkhrSSianLpFjpLP2xCgevzGd1RDZp0zWe
         sIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678574212;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87dcZszEk8ij6lSi/CqcaBS8yPG/kXnAghqk+AMY8Rc=;
        b=ZpvFJZ0AMG+Cj0UC82pGt5pPclSurB0bfb/woTQ8spSe73nXm1pGG13t1ic9aTdYUJ
         sM6D3Cn3VkMIeJDVt0qsYzoVKch/xUg/eE4j8LKRqR9qNoB/iGdxp8ObmWq62WvhK++w
         YO/Vuixf1kWlYpL5Eri0TzC4cg70UGA+4G/5553fyAHa3ZwtXiPi+uT/bUrnqDvua2Vn
         9LCbSVSl5wPlas+paMwK16T4n+HmlhEiZwMFXaMgP99KtLT/kwJFPQMldtTVdCIzhyUL
         NYQ5XydDglxkkD8jKDBJxAesXrU508US47XZFWUxxMTAScVxObkYfcQrLOur4rLNBXid
         kDQA==
X-Gm-Message-State: AO0yUKWEYdwhfF6N1dhcYy6kjLP1pLqWowrhkusXoosD96LEuA9D0X8w
        55tWe2YTJ86WSBa90/T5aLegCtsrJXTWT18789Y=
X-Google-Smtp-Source: AK7set/BwWqO1cH+mQ7CHSuJPa9wA7rLoHh+Ygo2RvdHMPmpI/ifajWHTaq/mP2flocoxlbtxBvljXZ1IWHDBowdzZs=
X-Received: by 2002:a62:1b14:0:b0:622:aa8e:f659 with SMTP id
 b20-20020a621b14000000b00622aa8ef659mr616708pfb.2.1678574211708; Sat, 11 Mar
 2023 14:36:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a20:e617:b0:cd:f3b6:e0da with HTTP; Sat, 11 Mar 2023
 14:36:51 -0800 (PST)
Reply-To: enocvendor6777@gmail.com
From:   "Emirates National Oil Company (ENOC)" <variouskovalyov@gmail.com>
Date:   Sat, 11 Mar 2023 14:36:51 -0800
Message-ID: <CABknKLkdYJ7MD8RBtF8TiWatZgnCLZ9r5v8-j2BYRmW-thCvCw@mail.gmail.com>
Subject: Emirates National Oil Company (ENOC)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:436 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7342]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [variouskovalyov[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [enocvendor6777[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings of the day,
We are inviting your esteemed company for vendor registration and
intending partners for Emirates National Oil Company (ENOC)
2023/2024 projects.
These projects are open for all companies around the world, if you
have intention to participate in the process,
please confirm your interest by contacting us through our official
email address  project-ae@enocvendor-ea.com
We appreciate your interest in this invitation, and look forward to
your early response.
MR. Nasir Khalid
Senior Project Manager
Emirates National Oil Company (ENOC)
