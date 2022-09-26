Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DE15EA7D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiIZOCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbiIZOBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:01:50 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9836C861C3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:15:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c9so8112628ybf.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=IRMvjWD71cG7GPIFc0vYJedzSDxUYjr8lfictCDyhMM=;
        b=j8w9SFWXyPx9nMFZlSrBGbCzlGFuaHhz4CJj589Amd5Y/E7ILLnX2I8y44pU31h0Xg
         epxkFGfBtZAHrmTI66ZF+UbOR8IYgDd4eUuLAmIF0oZ7aamFQJ9FC6Eqgx/WCp129Iy7
         asnkmFMGJsm7RENyaO4WODWSKWCvvUlmPPwHixSmNRh6o3IlYKTSYw9qT7f9CYwvMwEU
         gRk6QUcCYa/hbx0tuhdiGI8DvXJNWGux2FLcfzzts3GhDRDT7rg6YQ+gHcbdxgjpIeTo
         CCqRBMemk6cIn2yH7U9vbpqRfx0dFc3QWYkMaDk1OFJgzudUy7io1iu+h0uetg8YH6u5
         oZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IRMvjWD71cG7GPIFc0vYJedzSDxUYjr8lfictCDyhMM=;
        b=nqKfI/iP5nvDHa8roSBELcfSmLx+RIwfUfBsnvzBg8ONwSQJztgCTGxblRQJQqqxzv
         DpfAy3CiuDWbMlZZas2cccyZp9lVUmpsuMbPzkPWf0IYbqkqsSo82tf6T53tOexRHKo0
         ad6BBQJb6WKofnZbWjr0p/H1IQS/xRrTk193XDYI+Epl+pSj0iwstj5atI4JqGJDQueu
         E7zBU/6ZreE7iytJdZbbsDT5fy2jWWXN8paPn5DdSboF02aIhLH6W3kH6R5UvAA7jXR6
         ZM7kouH4dWJnsQdl1+eFpIbs3yLfkuvNu1eddcUEckcJEi3GxDVQGsNkb0AgO/yyxaFq
         5Tiw==
X-Gm-Message-State: ACrzQf1cfnRwf0m56x1cLlxJli8Qc0yWwMndjfpw9QjCIKscy2O79aAC
        0HzWYtDIOXFryiqkBhMo6pzB3fvIGoqGh82ekuL2f9sNSXY=
X-Google-Smtp-Source: AMsMyM6nPtC8AhGacE4wH50tD3s5wshf8hF+i2L7goWt/EXimtD1G/BMn0wPgP3buWWmuHCKxCUYUvumdyMlunxkzdQ=
X-Received: by 2002:a25:8889:0:b0:6b2:9b26:73e8 with SMTP id
 d9-20020a258889000000b006b29b2673e8mr19801265ybl.46.1664194493054; Mon, 26
 Sep 2022 05:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220627064024.771037-1-appana.durga.rao@xilinx.com>
In-Reply-To: <20220627064024.771037-1-appana.durga.rao@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 26 Sep 2022 14:14:42 +0200
Message-ID: <CAHTX3d+Fa9Np9gEA8HNSLFJC0MRbV0KDkmCdwbQtS48XM8Z5RA@mail.gmail.com>
Subject: Re: [PATCH 0/3] microblaze: Add support for TMR Subsystem
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc:     arnd@arndb.de, shorne@gmail.com, ebiederm@xmission.com,
        appanad@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sam@ravnborg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

po 27. 6. 2022 v 8:40 odes=C3=ADlatel Appana Durga Kedareswara rao
<appana.durga.rao@xilinx.com> napsal:
>
> This patch series adds support for Triple Modular Redundancy Subsystem,
> Triple Modular Redundancy (TMR) Microblaze solution provides soft error
> detection, correction and recovery for Microblaze cores in the system.
> The Xilinx/AMD Triple Modular Redundancy (TMR) solution in Vivado provide=
s
> all the necessary building blocks to implement a redundant triplicated
> MicroBlaze subsystem. This processing subsystem is fault-tolerant and
> continues to operate nominally after encountering an error. Together
> with the capability to detect and recover from errors, the implementation
> ensures the reliability of the entire subsystem, for more details about
> IP please refer PG268[1].
>
> [1]: https://docs.xilinx.com/r/en-US/pg268-tmr/Triple-Modular-Redundancy-=
TMR-v1.0-LogiCORE-IP-Product-Guide-PG268
>
> Appana Durga Kedareswara rao (3):
>   microblaze: Add xmb_manager_register function
>   microblaze: Add custom break vector handler for mb manager
>   microblaze: Add support for error injection
>
>  arch/microblaze/Kconfig                       |  10 +
>  .../include/asm/xilinx_mb_manager.h           |  29 ++
>  arch/microblaze/kernel/asm-offsets.c          |   7 +
>  arch/microblaze/kernel/entry.S                | 302 +++++++++++++++++-
>  4 files changed, 347 insertions(+), 1 deletion(-)
>  create mode 100644 arch/microblaze/include/asm/xilinx_mb_manager.h
>
> --
> 2.25.1
>

Applied.
M


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
