Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F1F5BBC2F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 08:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIRGhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 02:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRGhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 02:37:52 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35D823BD5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 23:37:51 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e81so18954852ybb.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 23:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=WtWJsU6NZYJIgqgJJirhPk1ESg8pzmFDlf9rSDuSpIOVaz9eqn45jtXSITSrsyUH+b
         RcnhDkn3o58G5w78oVO17mQkBnH6vOU4NcFhFRfBfwTgS2cXRwVroWoUQVCFLofx3H/o
         v3ZuLhxzFuorm/uuRm/xoIHvkDcjD2zWI63o9xOpQg3yh6y5HMNUByP/RYVO6ZUEdzJl
         KkLGb5x9/gmNp/jHMaTffcBzRQdogmXTOpwZECADKuY7bbacxaUwI4Qdocgx7djCuulM
         OBMuEIpV2RYZAOdH8E1FcUvZ3deJ5lji5RD1K9vv1BTMBckpAzBJHMTuadMZTlFLk4xo
         /pqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=zCQTZ+BT0yBZ146MefZz813Bky1+vKaC136uKF2KzxChCYmOE6+3X7WL6/TUZVsl/X
         krlSFL2l0kIeQsYWWczyIqnFlkJyDyzHpLOjH0Z7gMHoMsmOk16tbraQ7aKevRglkEgE
         ro00UEp2dRmJ233/BDCa6hCzVMaP2ydmwSoENy30r3OVmKgmakBe4kMQ//ZRunG136Rd
         S5Oe8v7MZQsBtV88CnpqQvjWzSWrr7S47ckOygWAWFs2YgPbvm3KFUDnVE3WNc4HrMX8
         a+l+ZANTeLKiPEYBoKwMConwHQXOKzjBQqEeMRdAQW4YA2Gd4E/NOv+Ky6qvOt1uXsC2
         K4hw==
X-Gm-Message-State: ACrzQf1uvqinsj287Ivi5wv0p0UjH/SgbSWT83XFQkE6vpR61nHlgEqC
        AxvLY5HEbkDevq0+a5Q3koSWqOaEjLhfwMpFee8=
X-Google-Smtp-Source: AMsMyM62bAadOY4NL8KCh4MdrCMDqayG2kX86h0/K/23latRnAYHbMaox4oy/IksDQthdYJDU88KjjJAXyFqeFglWdE=
X-Received: by 2002:a25:2342:0:b0:6ae:b056:17fd with SMTP id
 j63-20020a252342000000b006aeb05617fdmr9335874ybj.582.1663483071285; Sat, 17
 Sep 2022 23:37:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:9092:0:0:0:0 with HTTP; Sat, 17 Sep 2022 23:37:50
 -0700 (PDT)
Reply-To: maryalbertt00045@gmail.com
From:   Mary Albert <mawussikoff@gmail.com>
Date:   Sun, 18 Sep 2022 07:37:50 +0100
Message-ID: <CAHVeZEdWDYOxy5f91RBMTuD-C0wb4qbrKDfFyH0AUOQWhpLtwg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mawussikoff[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maryalbertt00045[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?
