Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912466385D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiKYJFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:05:11 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31021CFD4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:05:10 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-142306beb9aso4445616fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=lk/c6uH30vw6rJT4WC9VzOHwmdAYh2CZWHWbkcQlwV9OPXNIEbaDiFEoY1vM1QkD7A
         A8I2dyDocYmmvy7IpGc1pw69Dkgfn9roov3XQvErt4v3Jg0t0gvMzPDJas5vXOZRV83m
         e4KKT2hSK82hAqjEku6Od18ccsBCxl4LgPRNnCDietPju49LPMBmgiESu7eUTzS8V9nV
         bvcmle0N26vm/EXpb7KTFixIMZQbKAoq8al/FYk6XNTmcA2Xb1inZlUExQXnnvg5/TQ8
         hwKJMvpDi0/JXHQJOHxHVbexrO8oAXwlcwan2sk6uZzEs7uXYATyYjyxx4bD6RYhlqyM
         xK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=xXUva6EBBVOF4WYje/g8wrcN3FF/9DTurZHSSfm16297gxeun6A+TKXbRPZxJFSSkU
         4GkH7H198J4MzsKSzH5bwOv2RmExDUTtYfm3F47h8Yrjntcjql8EDAKFy5WWi9ogtop2
         ALUkvAO0B6TVrNsMDWmKGcdfKgyq304cPC6JB1uaEyfB939UvrTLGmn0Um7Cx9hzNpyr
         mnLQoh7BdqWApohKJWJSLzsTl+rAgvGfDAnTU+IjtkTQdA9d2ITT4oja6rURFg0KBmJW
         1j9oH5TaL/x0+7M9g4h3jREMnkx+CTKrE76oHBErcFeA+qC6smLR/QXAC1FSyFuSI1Lx
         24cA==
X-Gm-Message-State: ANoB5pkOqLxz7qnyCIGNqUYpBrWfwr+K2k6fWKClA4zzNqeEzCXTebIo
        t3Fx8cCmoAu+CYrDXIlQaqJ8IUD+CQTOBw/j+TM=
X-Google-Smtp-Source: AA0mqf5WjewCqS9jsNBFgHZVCaMQQuIgoiBIJ3ingWxOASV343zT+hotxlxkJb6nopxvM2k3jBx58wcEU9HSCpwDAZM=
X-Received: by 2002:a05:6870:9d8b:b0:143:cbc:ac46 with SMTP id
 pv11-20020a0568709d8b00b001430cbcac46mr8879603oab.271.1669367110060; Fri, 25
 Nov 2022 01:05:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6850:3886:b0:384:9340:1cbf with HTTP; Fri, 25 Nov 2022
 01:05:09 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <susanbkrm@gmail.com>
Date:   Fri, 25 Nov 2022 01:05:09 -0800
Message-ID: <CAHU_H-wcen-f0o=NZF3bOZY7UrpNLeErb5PGR-L+3d3zMehZWw@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  1.0 HK_RANDOM_FROM From username looks random
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [subik7633[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [susanbkrm[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
