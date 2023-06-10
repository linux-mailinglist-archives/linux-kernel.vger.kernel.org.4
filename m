Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE6772AD21
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjFJQRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFJQQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:16:54 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DAF3A86
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:16:27 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba818eb96dcso2564546276.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686413784; x=1689005784;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txGjIaM3LfmxDV9bWB1cnjV5M3E57yF3rztzp8u5Chw=;
        b=I7GHrL0NSbVXhJHd2O53g1s0VGCWl4UX7NDHYvPr5aXjxaCYaIT/NcUcXhy+ivBtR3
         fLd+ACI0vCEQsDcWuru4h9+DmIyuc1L+2C6uHZSnohwUtCwly7TELsaSFo7KZjC7mYYg
         Uv4Z6NJtmyIvjy2YO3xHzI3FFGAp6e8E43CxAIcvEduxT66Jv0NmNwV+jrspKrMuSxqf
         u5OJjnix342MIw09cb7aw6QvDvMHGhEzxleeOVkscLU2HLCfr6BS5yBV55l6QjYxFaE7
         D08+8Uc1OKCa02HSvihkuNWfcSfao8FU2zLFLB9jkuuPYIB6uSiMEkzyztmfNQvkq76B
         mA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413784; x=1689005784;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txGjIaM3LfmxDV9bWB1cnjV5M3E57yF3rztzp8u5Chw=;
        b=Mpqb7Cf4pTH5eDNu2e0yYRHac5WEskWCJmUMIp1CrDwuoeW67Iz5EyMAuZzh9iuJ7w
         T7DsWMSSniIFjB/lqO4XfDY84cGYIhWawvz8KPoRYguZgULzhaDJl2yXVS3DHcdZDYRR
         U0+0z/CvEFlR9pZqzThgOs2kBggAku++TzxEeRT6K5GZpeGQNecqdZX/xF3EtAM7htis
         HvVj653pTorDGFXZUb+DjmUJKpRyKatSKetUin9BqinAuWThpZ7M1dF1+9bi9+DI4kgs
         k5HfbqJyZu5t2nI8sEkW+VyzIEiAIHmKPFYrSQzwuYJEt1BH990rpIObH8kM8cDPn1rm
         2z+A==
X-Gm-Message-State: AC+VfDyh3twCmsBqosEPjP1nrOSwb8anZETbR2txdkz9StCUQWDJvspD
        Zn3IYQ9Y4W9bUoe7wrhPBbyPEDgjw4aZtIqnomo=
X-Google-Smtp-Source: ACHHUZ66/WfEKCPYQpligvAJB/N6ziGUVjl8hSsuIDmtlRhps0eKtGx6/CVEFvwAA7lYyGn2MgwpoJksEcX4ayEuRIU=
X-Received: by 2002:a25:7c41:0:b0:bac:854f:abbd with SMTP id
 x62-20020a257c41000000b00bac854fabbdmr3447846ybc.64.1686413784290; Sat, 10
 Jun 2023 09:16:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:a78f:b0:35e:3174:a199 with HTTP; Sat, 10 Jun 2023
 09:16:23 -0700 (PDT)
Reply-To: werinammawussi@gmail.com
From:   Werinam Mawussi <wedemmawussi@gmail.com>
Date:   Sat, 10 Jun 2023 18:16:23 +0200
Message-ID: <CAJHkjaBdb+z8_LveHx-HdWJmoM44+crm3VeL-ERt9xYHrvrU4Q@mail.gmail.com>
Subject: Important Notification
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: you.contact]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5007]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wedemmawussi[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am bringing this notice to your attention in respect of the death of
a client of mine that has the same surname as you and his fund valued
at $19.9M to be paid to you.contact me at werinammawussi@gmail.com for
more details.

Yours Sincerely,
Werinam Mawussi,
Attorney At Law.
