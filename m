Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1365AB79
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 21:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjAAUHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 15:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjAAUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 15:06:58 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17883273C
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 12:06:57 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 17so27501361pll.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 12:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1kEiydM5yX9mGNKZNo9VbGZ3GJG1b/7455PknoIlaOY=;
        b=A+Gvn529sQZPGyhUNrTQFOuM6yvKC+bWeSG0esm3BIpXCybQQhhYHUBC5vWBUzRz5I
         HUFiqTpp9IPEsBmx4RKv91kHbiFvs1c4lzTfqo9iylIEtXw3gZF4di08c4xM8PNm7U5y
         0A1g0KDb6y6Af+BQY22f/jFm4EmOpegnXPIibIkWnpoCGUk2BjCMgmMG6hfCq+iW3nf3
         POifhRz4h6DF4hZa++Sez/HqT80V/1DFhlGbvLR2PH6qVhhjGJ1Rmls1TqI1A4zqRqOc
         IyFYt3IuIR9vyWO++KULqAO/AFN2okDHWGO7qJt9EVXPXChIYtPBlH0l6LH+KRuA5Dk0
         eoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kEiydM5yX9mGNKZNo9VbGZ3GJG1b/7455PknoIlaOY=;
        b=S0WmgABCj0zy//0xfZgPNzWre/+4T+GiG1Q1JLmJcg7Kh2EcnunXiEYF5d7GJ+i1WO
         67uYLw2tvMf0E9at6v296gmDS+goREm2yv0AAWrXjBecExjJrXO70eW5X97v3Wz9lt37
         FKfxj8/5RX3ZqwjgLgZfB+D2d7DyuRf6xyOdug1eSjel4TkzWLZAcbAzxL/kvvfid8lg
         gWchUU57MnfKmyWZPpbZNBfUWivCaFkQj4c+Ydb2fKAGM0mLol2U9zArt5PlwS6FzE8o
         ksGQV/H5VYoIz3Z6uLyxvucZBJ+k0QgESgxtn0UosRfghrGJXKBtiQw0w3LiCwveJc5U
         I/Pg==
X-Gm-Message-State: AFqh2kpWCj6gHeoTxH/We17uAdKhTVz1AzLbm75Jj9YK/PfSth02tRt+
        wiCBrAuuf5H963LjxYi+7WpMSpc3hOQ=
X-Google-Smtp-Source: AMrXdXsvlsSdlGip6cO7305mZ5+UpDE8482lu1/S/pkqKJAS8Erxaj0nZguamoc8GDHxpakoQej/Qw==
X-Received: by 2002:a17:902:ec89:b0:18b:ed3f:c6ca with SMTP id x9-20020a170902ec8900b0018bed3fc6camr56857397plg.12.1672603615895;
        Sun, 01 Jan 2023 12:06:55 -0800 (PST)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b00186e34524e3sm18554059plg.136.2023.01.01.12.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 12:06:55 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1pC4bd-0006kp-GB ; Mon, 02 Jan 2023 05:06:53 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
To:     masahiroy@kernel.org, mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: how to build a single module
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25965.1672603613.1@jrobl>
Date:   Mon, 02 Jan 2023 05:06:53 +0900
Message-ID: <25966.1672603613@jrobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In linux-v6.2-rc1, "make brabra/module.ko" to build a single module
doesn't work. It compiles the C source files and produces .o, but the
final 'modpost' returns an error.

$ make fs/aufs/aufs.ko
	:::
  LD [M]  fs/aufs/aufs.o
  MODPOST Module.symvers
ERROR: modpost: fs/aufs/aufs.ko: filename must be suffixed with .o
make[2]: *** [/proj/aufs/aufs6-linux.git/scripts/Makefile.modpost:137: Module.symvers] Error 1
make[1]: *** [/proj/aufs/aufs6-linux.git/Makefile:1996: single_modules] Error 2
make: *** [/proj/aufs/aufs6-linux.git/Makefile:373: __build_one_by_one] Error 2
Command exited with non-zero status 2


Is it related to this commit?
	f65a486821cf 2022-12-14 kbuild: change module.order to list *.o instead of *.ko


J. R. Okajima
