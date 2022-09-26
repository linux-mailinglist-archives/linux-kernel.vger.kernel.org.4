Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D385E9B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiIZH6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbiIZH5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:57:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F34E3B96C;
        Mon, 26 Sep 2022 00:51:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z13so12240997ejp.6;
        Mon, 26 Sep 2022 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=JTLxaDlZ0s+4KzzKxJ2iMAsNQ8edLuUfFix3kOf4hxE=;
        b=IUYcYkeAKAq3Z9pkfcGCw7GFVb5ytx/L103zWixWaVGGHUW4qaqsi7qFcQb8U9ylb+
         ZH86Rft2dsUKJJPRUWtJ5SbNWB4vsOoMJNFE+RdK2CQvW8sUrWj7ZCHcXFtyYAbTbzre
         05ZZb0uTlCJrtnHgUYE3Xmren2i+EwAw2RU0lcC0cs3q9HG0Ad8Uv35WTJuvWm79HW5P
         K9F9i3i+Ol/SXFaX85xP+/7swtxTbQVL4rKPAMc8iyX8adFMUbWloN1UPCTGZq2Il07D
         +TiUZOOKWEghMgGbQMmJULxQ0z/4vUcpXar06SX6FjLR2L+k5eC9evSI2aDdcl09Dz7X
         ZLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=JTLxaDlZ0s+4KzzKxJ2iMAsNQ8edLuUfFix3kOf4hxE=;
        b=KmgHMocMQ9Y6YJbWL5ftrssp3VgQoHZN2LND2utvLdy049Mg7UcrnNgu0sMK0kamD/
         uyDfLCrDk3JbWyeUchI5irO1sB2GGWd8eglzOHjomg74TvTWHDtI4XRq9tG1MBLpSZmN
         cOqz9QAse/FO6g5DQfDhFORiuiwccz4t2lbGoHpSBLut+FR+OysWnKjo3fDrgUwYflsG
         FEmKXhSrfLg3HLSoY4Xsp/ct6dBTykil6ZEPnNzDrmOzf/8WkAHPU/qAZXN5rfsJUC3X
         3OIKUzFLqGxuKv5tkCBP0ZJnn90rp8ZmmMNBzRsCvWvl8AgjmU5dDuHiFGAGwjj6C88N
         wCUQ==
X-Gm-Message-State: ACrzQf0sib6u/u7WsDnNp570DeSc9GQFHvH1Gmvt4Jb19kA6b55HKwsc
        BsxsAljRsmyVNDpcCWWZmYHtcRa+EIN8TK+ApzM=
X-Google-Smtp-Source: AMsMyM54PjI7r9RBNywo7Vr4XI825HD15QzPS4xTM54XWF4bEobGfMMFwon7099h/YE9taKhiPm8G8gbvIN0ntLE4AA=
X-Received: by 2002:a17:906:9c83:b0:779:c14c:55e4 with SMTP id
 fj3-20020a1709069c8300b00779c14c55e4mr16698857ejc.619.1664178690895; Mon, 26
 Sep 2022 00:51:30 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
Date:   Mon, 26 Sep 2022 00:51:19 -0700
Message-ID: <CAH7mPvj64Scp6_Nbaj8KOfkoV5f7_N5L=Tv5Z9zGyn5SS+gsUw@mail.gmail.com>
Subject: Any interest in building the Linux kernel from a MacOS host?
To:     torvalds@linux-foundation.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        "marcan@marcan.st" <marcan@marcan.st>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this is potentially interesting to anyone but I was able
to get the kernel building from MacOS my M2 Air with a small amount of
effort (read: duct tape and bailing wire).  If this might seem helpful
to anyone's workflow, I wouldn't mind pursuing this (with some
cleanup, sending a more formal patch set).  Maybe this helps us
bootstrap or get Linux up and running sooner on these machines?

Take a look at the commit message linked below for the trials & tribulations:
https://github.com/ClangBuiltLinux/linux/commit/f06333e29addbc3d714adb340355f471c1dfe95a

Thanks,
~Nick Desaulniers
