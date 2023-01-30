Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83D0680680
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjA3HbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjA3HbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:31:10 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B931E29E2D;
        Sun, 29 Jan 2023 23:30:42 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 88so10290780pjo.3;
        Sun, 29 Jan 2023 23:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVlWo6u1p89wap9W+ipQ8fUx1Vacew9bUJaou2PxDvg=;
        b=N408ybB9/oGNwvZkfrpWGakepaRvofn1N1NuQPO/CFfbL+NLw2VYGRDAZYgTUavhSm
         Ebz7iUhb7wlCd5wPWVkZJ4FAiQBpNJVqK7YKQrsoPlojL+ZKhbbUirsCrQ72cPk9Uf39
         FWNZygmgvigZI0/pLOT6CNHUq3udrqAjGqRPR59xwJqYhKeRnXhDnocwuRlAuT5lwTm1
         b8VrRPibRxY40OXofD2NJGl9P2AJwOzyxNieUsYHHl3j70R5MDfFvnZhLy99djpJRYsv
         mz3je9szkxcJOwpC96HfRGHLuV5yTTR4UaXeKFPG9rFpPo0X8+bX/0QO/drK5uUAh5O6
         y8Mg==
X-Gm-Message-State: AO0yUKWeirgiNlrbbJ8OK1r1nssFv93t5P5BixcUMvU60UxwC//eJahI
        bm8TuSJpV1C5f7ohVTz/3SRGt14ZuCE6hG2H
X-Google-Smtp-Source: AK7set8mjzmkyFT5SLNYJIMmvvrh1serBnCYYSPlxi5jR5tRR+oVCe9xBL71WpNcg/Bbw2rtHWUfxw==
X-Received: by 2002:a17:902:ce82:b0:196:4328:a02c with SMTP id f2-20020a170902ce8200b001964328a02cmr18162441plg.69.1675063842013;
        Sun, 29 Jan 2023 23:30:42 -0800 (PST)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id h132-20020a636c8a000000b004e613cc1f58sm2347509pgc.57.2023.01.29.23.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 23:30:41 -0800 (PST)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Report a compile err
Date:   Mon, 30 Jan 2023 15:30:12 +0800
Message-Id: <20230130073012.374172-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130165442.29f65a51@canb.auug.org.au>
References: <20230130165442.29f65a51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

source code:
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
base:
  ae0c77e1bc6963c67c6c09e8c72959fcb1ed8d5f
config tested:
  x86_64_defconfig
  defconfig(arm64)
toolchain:
  gcc version 10.4.0 (Ubuntu 10.4.0-4ubuntu1~22.04)
cross compile toolchain:
  gcc version 10.4.0 (Ubuntu 10.4.0-4ubuntu1~22.04)

reproduce compile err:
  CONFIG_WERROR=y && CONFIG_PRINTK=n && CONFIG_UBSAN_ALIGNMENT=y &&
  CONFIG_UBSAN_SANITIZE_ALL=y

compile err log:
kernel/printk/printk.c: In function ‘console_flush_all’:
kernel/printk/printk.c:2845:17: error: array subscript 0 is outside array
bounds of ‘char[0]’ [-Werror=array-bounds]
 2845 |  char *outbuf = &pbufs.outbuf[0];
      |                 ^~~~~~~~~~~~~~~~
In file included from kernel/printk/printk.c:61:
kernel/printk/internal.h:87:7: note: while referencing ‘outbuf’
   87 |  char outbuf[PRINTK_MESSAGE_MAX];
      |       ^~~~~~
kernel/printk/printk.c:2842:31: note: defined here ‘pbufs’
 2842 |  static struct printk_buffers pbufs;
      |                               ^~~~~

I applied the way 5a41237ad1d4 in mainline did for gcc 10, problem goes
away. I'm guessing this is a gcc bug.
