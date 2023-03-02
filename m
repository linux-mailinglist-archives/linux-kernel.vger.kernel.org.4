Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A596A7C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCBHt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCBHtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:49:55 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AF115556
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:49:49 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id y10so12493853qtj.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 23:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Stk+hX3OuWDNaHgh5OMlTcRkR8tppWAbqwoblN4Dzs=;
        b=mNrkphPivEPis5jLPpO+Zh8kUwmVrfU6MSrqFS2nWItos1CyrrLas/GoS94o4UUvJZ
         OWC0zxwFySOpr7pbptjc3eXNXB7/VZERgsHv2AdXiyKBDM1ubw4nL8GZSLwFAugKzbCl
         szEq8XKg/OpPmN9LvErzQTy/lCmcB0I93AZZyzXw1bCQh9kOkgR+iSvLqZQGg2i00Bw2
         rz/SNnvE9EfezbZkbisvj64gzZ1g0bpxaC4HM71xsNMZB5qYRhme3gs0JYRn0DjgkJpI
         d7/mzPRNwOxcavjIPaGP7VxMZkaBcvpd3ZL7O0pG9XGy6eBMZatrdo5sr/PzeEm4Q3vN
         B5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Stk+hX3OuWDNaHgh5OMlTcRkR8tppWAbqwoblN4Dzs=;
        b=rLY0/l6f4t/Y1vMrAFuVA/6zEHuXzUWJYGp68XqVtm9yRuCuyg8FGyW40J1w1Ge+dQ
         Pp5dZVWyGfA0agIymqlvOHfxtrefM3Ez1puT+KlcHbSpXPUvQ/im8FhggC98dNoC7g/2
         XNY4xRg092qcUgYCdpwelJRTkWH3ggOm24SHO7xxvjvgNSwMJybLAz64ZCmHjxhUNxau
         VRCVH7jX9j2Y9n6xCfLsuj10vmdOu7gV8VYOAGdEzdGW8XiavUKzFxaQsG1AwpApNtfQ
         FadMzdI7E0zVz/r5a2coWngxuwzt3mdM3Z2zuoZfXrMre34Lrk5ZUxXmUCVpuiwqjbGW
         0jGA==
X-Gm-Message-State: AO0yUKUkPzwxZZjKICdUGjkrG5h/JsadXShoWhTUbAEfTkvM2MBW1mQi
        MrPOBoQyhqhNnqptzbDWlYK0uNsetE3g717C/6g=
X-Google-Smtp-Source: AK7set9+kUPMfVLX4ByJB6DJDpMeMGNdXbypeNBOQ8j2We6RXcr7GCyd6QZuUfKVrQvXgpp4NnFy4WgG4ouqBncDYB4=
X-Received: by 2002:ac8:4148:0:b0:3bf:d520:1d57 with SMTP id
 e8-20020ac84148000000b003bfd5201d57mr2430806qtm.2.1677743388525; Wed, 01 Mar
 2023 23:49:48 -0800 (PST)
MIME-Version: 1.0
Sender: okoinemarry@gmail.com
Received: by 2002:ac8:6b9a:0:b0:3bc:db05:c801 with HTTP; Wed, 1 Mar 2023
 23:49:47 -0800 (PST)
From:   Mrs Aisha Al-Qaddafi <aishaalqaddafi3@gmail.com>
Date:   Thu, 2 Mar 2023 08:49:47 +0100
X-Google-Sender-Auth: XU2KHbFOze3tdUrNMvaD5ZuRWcg
Message-ID: <CALDqwgBLrof9uxdTy75FveqjzDPj8m_wNq0dsHQot0-47F83+A@mail.gmail.com>
Subject: Assalamu alaikum,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:842 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9874]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [okoinemarry[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assalamu alaikum,


I came across your e-mail contact prior to a private search while in
need of a trusted person. My name is Mrs. Aisha Gaddafi, a single
Mother and a Widow with three Children. I am the only biological
Daughter of the late Libyan President ( Late Colonel Muammar Gaddafi
). I have a business Proposal for you worth $27.5Million dollars and I
need mutual respect, trust, honesty, transparency, adequate support
and assistance, Hope to hear from you for more details.

Warmest regards
Mrs Aisha. Gaddafi.
