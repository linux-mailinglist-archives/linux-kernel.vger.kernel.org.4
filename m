Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951186C3FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCVBhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCVBgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:36:53 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871AC5A907;
        Tue, 21 Mar 2023 18:36:36 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id o12so7822949iow.6;
        Tue, 21 Mar 2023 18:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679448989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlRSaRqbqzhoGg4Jq8gRsfnnZpa65cXo7tlmnX5urfA=;
        b=O+/SJZ+ivzsHj5rlJsSUra77tQb9DLQwIlY7gTF3V4YFvPDUm3qjs/Riaj6tEht9nI
         PrtTFHoHaOc3RBNzdLWMZuX1SJCg6iPrXxVQAsXsWcgX79l9Q7DTwRcuaDYQZdJ0l23P
         XI6ql0AOe6nLzqfJXjfTuEvhBIPFxgrgrf4mP4czYR/sI6xrOs+VUT55eSurjoG+gF1E
         kEQ0FN1mL3zQxTcOJ8XwHq7Gkw0dtjJmq8jZLMefuDBA/lvvAVrlASLQvnBvS/dgRAM7
         aUzTtIWOy+vc0uUl1yYCSavP5q7SwOcRbErwOMixtuGjCET+f/EBa6L+v49Ibji87p2Q
         FawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679448989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlRSaRqbqzhoGg4Jq8gRsfnnZpa65cXo7tlmnX5urfA=;
        b=Uv9mnteWCjD6koDrliB8WENW7B2JbOC3U4ZzIt4zkyDh3Pjw/rdJEpzfsbvAFXMGin
         zPFSKmXy57oocp9lwG2z0r0K4+6Pbn/+Mt0Bwh+e/t3LDPslA01cez8l21/oRPapmyBO
         BuUQK5f8qTrsfEFJg52eiRH489yGEDUZGbR8BP8XDRFa1xZWGMZ4W5TM/cPT7qcHjiAl
         k3urH3SXtq22Z2NEr0nAFIZasOpLsXBiZ2UBiAE1eN2rk5n5tclsrxHoAcZjMR+u1gGp
         0OhY7H7cB6ByR7MmR2m1CvzK2Eu7RUCLs6gQeW7HUyjDCTeTrUCGAPS+Dw4oezDHyt3d
         5Yhw==
X-Gm-Message-State: AO0yUKUoDrEjsoOtFfhI0Jj/lktrjuxJJL7jGkDRhbX09/qN7GEE/6e3
        Fh+5y5I7/hRhSog/ZUXVeZ0sckA9TI4=
X-Google-Smtp-Source: AK7set9Db1WvzoN4PnrAWIIVXIYw5XbzF7FlCM8p1pbuDZ89SMu4djSF4YTHXqh1pGKzZAwc3GjeXA==
X-Received: by 2002:a6b:ee0c:0:b0:74e:6f06:d5f5 with SMTP id i12-20020a6bee0c000000b0074e6f06d5f5mr2921702ioh.8.1679448989429;
        Tue, 21 Mar 2023 18:36:29 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id a22-20020a6b6616000000b007530bbfa577sm3925058ioc.18.2023.03.21.18.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:36:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/4] cosmetic fixes to module pr_debugs
Date:   Tue, 21 Mar 2023 19:36:19 -0600
Message-Id: <20230322013623.251401-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

These 4 patches alter pr_debug() messages for more info, and less
log-spam.

* add "for $modname:" to banners
  helpful for finding one of many

[   40.885922] main:layout_sections: Core section allocation order for test_dynamic_debug:
    	       ~20 lines of output
[   40.885967] main:move_module: Final section addresses for test_dynamic_debug:
    	       ~2 lines - .init.text/data

* add symbol name to "Absolute symbol: <value>"
  val ~== 0 - less interesting than name

[   40.886006] main:simplify_symbols: Absolute symbol: 0x00000000 test_dynamic_debug.c
[   40.886008] main:simplify_symbols: Absolute symbol: 0x00000000 test_dynamic_debug.mod.c

* add size to section report. gives more info.

[   40.885968] main:move_module: 	0xffffffffc0249000 0x0000035d .text
[   40.885971] main:move_module: 	0xffffffffc0252000 0x0000003c .init.text

* drop already_uses: pr_debug("$ uses $b!") messages

  echo module main +pmf >/proc/dynamic_debug/control
  modprobe i915

before:
  dmesg | grep already_uses | cut -c15- | wc
    673    2722   28641
  dmesg | grep already_uses | cut -c15- | sort -u | wc
     26     134    1237

after:
  dmesg | grep already_uses | cut -c15- | wc
     15      90     756
  dmesg | grep already_uses | cut -c15- | sort -u | wc
     15      90     756


Jim Cromie (4):
  module: in layout_sections, move_module: add the modname
  module: add symbol-name to pr_debug Absolute symbol
  module: add section-size to move_module pr_debug
  module: already_uses() - reduce pr_debug output volume

 kernel/module/main.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.39.2

