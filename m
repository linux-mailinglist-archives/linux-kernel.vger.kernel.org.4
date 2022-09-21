Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E449A5BFDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIUMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIUMav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:30:51 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BCF65836
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:30:51 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id h1so6472629vsr.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=hNjCnErblRwAyAj6FlkKQb2JciLGQqPu0wp0kKsDJDg=;
        b=JzN0se+T70cuWLy4EBUZo8WFcyRieYzz+MX4Bk1rRfN8iPlVIxiNf2oMcqS5e0g42q
         JrVXb13ZBGbqkrRg37Tw7hswVFZ3GduR9FEtOTrz9xtjK/uQ6+HNkCfCZJ37+e6Nk62R
         UdwVgthSM4OYUgBFEGHtGQKJBGRw11mQT/kVkYFFIWM/nv5HhiKQoGvYSpeGa+CebYyB
         NJIrhqKfHNXrkpUsd6jXYGzC9PeF6lkL04I/NxLzuvcX7g33kdJ2SDVMEGwVZ54s208i
         n+d4f0/AkuaSi9fMCd3kOywKk81fYEeuC5smS5KKBX++jrXU89745dExpCPXtCNn5Zya
         I4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hNjCnErblRwAyAj6FlkKQb2JciLGQqPu0wp0kKsDJDg=;
        b=NCbmmQPvPAhjJVnHPg7utfycMaWpLDt1o8AKfwBa34R+Z+rBf7am+CvgDAkttdTpGP
         aj97On4XaV/ulewf4DwoXtiMGgQZfrDVVst78H0ibGWtrdwpN2F3SQCsTgBx+NRFEa5J
         2Rg41tMjQdp/tyjPeYtSmDDeMX5DOvgFHJTvpFFJPryu2HKvI8EpNJYR4YHto1VAXX5j
         vFsDK+D7pmVTcgjdtT0Gjppz9OmTljMITGhcuiwPu1HaCqtVyB3XAAXEaZenmqt2zq9L
         BtYJEpLuawF08zC09ddBwEeGDShxAQJvjWfFjWFDJar2S9h4nw6XarPH3wBCHpqiH6U8
         1kmQ==
X-Gm-Message-State: ACrzQf2JmAIOTmD3v8lygYdjqR3lKuInoVELSzumAiMa11nHkXPD/edw
        pfL6Gcu2dPS9ZMy45KvuztpHQGE/THqEJDk/TrY=
X-Google-Smtp-Source: AMsMyM5rE9Fa3Fd1QY7z/hH3cNZU4223c6aVJVkhKhn06QAJOMiy2Y/KYe7gDVvYSXOV/vH/0/G10xlymzwkZOPoEcw=
X-Received: by 2002:a67:f74c:0:b0:398:2f54:2949 with SMTP id
 w12-20020a67f74c000000b003982f542949mr10067199vso.7.1663763450048; Wed, 21
 Sep 2022 05:30:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:4545:0:0:0:0:0 with HTTP; Wed, 21 Sep 2022 05:30:49
 -0700 (PDT)
Reply-To: michellegoodman035@gmail.com
From:   Michelle Goodman <michellegoodman001@gmail.com>
Date:   Wed, 21 Sep 2022 12:30:49 +0000
Message-ID: <CA+jr58oDvkVaQQciEuAW+Berb7dwTo_yqRz7b9mHvQvE8R3rvw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michellegoodman001[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michellegoodman001[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVyaGFiYSB1bWFyxLFtIG1lc2FqxLFtxLEgYWxtxLHFn3PEsW7EsXpkxLFyLg0KaMSxemzEsSBj
ZXZhcGxhcmEgaWh0aXlhY8SxbSB2YXINCg0Kw4dvayB0ZcWfZWtrw7xybGVyLg0KTWljaGVsbGUN
Cg==
