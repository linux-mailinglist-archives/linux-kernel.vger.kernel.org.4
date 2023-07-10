Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7DC74D5E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGJMlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGJMlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:41:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1060E99
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:40:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so51620345e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688992857; x=1691584857;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6540cLNfoRbAtg4vA9lk8oUTbSbe1006pfKkyagjqpE=;
        b=PdLzhmWm3DEjaCNWQp9QGgBju70BNyV+GIggwzQrxuqz3jVwrz2fzwpRyrZ8IOLbuJ
         drmBKJzupO8GypCza2cZw6u1ttsRrJaj/I6KOtkuEY7l+MTEVQJZ4Vd2qUIMZkdEnQ+k
         BHhJNeuFLYsodJG/GcV/Pch9IqcTJO/sUbomhj6Yt1rq53F0u0FCYb72Kh2iFEKUf7qo
         MFFdrFsD5H0FIdgiCgphQ+XjH6KJqRaA4HJIxt5IbEKP0q+Lz3s6PtfKiuwbdr1CZQVC
         wISikuLCV0s5sadFdb/9fuKQsTFgPsgxiuu8MedOHN9KlQMQgLVWb84QRCoEH6YK53Rl
         Sw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688992857; x=1691584857;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6540cLNfoRbAtg4vA9lk8oUTbSbe1006pfKkyagjqpE=;
        b=QFkd/iGcU41k6UWk4AVW9xOU1VCDPBPmumkNvQ7xJ472UE1jQW0WwFZVgVkrexs1VJ
         XTB5lU004VAhCaAsepbo2YdMpzw870KXXsXxfeJhnTXY0t5xLsIA8X6/1xAGfD+EKA2D
         SoVCyE6lba+XbLSm3RQdCdxnOvekjq8sVfoq6C6G1XCgtDObiRqjkuok6X332C3EXa4C
         VkZbMBH3eLZJMHKtWqwFMQIP8DLifmcI5Qw5vQodbumSRItXDhjcAW5u1icOs/E7Cegj
         dK+fhcd/b+imel2dDAtt0iKMVqXsfRt45Kv3R9lD4wOVbeYVyjkBrcBdlhs01buSmGEk
         +yVQ==
X-Gm-Message-State: ABy/qLah5mZ4tOBsbFqcDSlBjJ21mv1ckQwR3q6EN1mVRIyZI5oqJj6G
        bP10ujruwij1lUJd0VyoDZA=
X-Google-Smtp-Source: APBJJlHD0tWeYBfIVQdQZvg5aphVZDdKZ8HLLaBchGgbsAm4KzHy1FJGAQOwgJvAzr6CdXE1CShgGg==
X-Received: by 2002:a7b:cc9a:0:b0:3fb:40ff:1cba with SMTP id p26-20020a7bcc9a000000b003fb40ff1cbamr13506149wma.6.1688992857263;
        Mon, 10 Jul 2023 05:40:57 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id y23-20020a1c4b17000000b003fbd0c50ba2sm10197336wma.32.2023.07.10.05.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:40:56 -0700 (PDT)
Message-ID: <08f694df-4c1d-f059-43fd-f1aee678062c@gmail.com>
Date:   Mon, 10 Jul 2023 14:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 0/3] Fixes for Rockchip NAND controller driver
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie contains various fixes for the Rockchip NAND controller
driver that showed up while testing boot block writing.

Fixed are:
  Always copy hwecc PA data to/from oob_poi buffer in order to be able
  to read/write the various boot block layouts.
  Add option to safely probe the driver on a NAND with unknown data layout.
  Fix oobfree layout.

Changed V4:
  Reduce subject size
  Add 'Fixes:' tag
  Reword

Changed V3:
  Change patch order, layout fixes first
  Change prefixes
  Reword
  State that patches break all existing jffs2 users

Changed V2:
  Add tag
  Add manufacturer ops
  Reword

Johan Jonker (3):
  mtd: rawnand: rockchip: fix oobfree offset and description
  mtd: rawnand: rockchip: copy hwecc PA data to oob_poi buffer
  mtd: rawnand: rockchip: add skipbbt option

 .../mtd/nand/raw/rockchip-nand-controller.c   | 52 ++++++++++++-------
 1 file changed, 32 insertions(+), 20 deletions(-)

--
2.30.2

