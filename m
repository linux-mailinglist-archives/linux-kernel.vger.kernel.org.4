Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062C06562B2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiLZMzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLZMzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:55:09 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5EE24A;
        Mon, 26 Dec 2022 04:55:08 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so1687011wmk.4;
        Mon, 26 Dec 2022 04:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=go4tve/Op9RygAUFtopjfFh/CZKE0zEfnvvG7nESATk=;
        b=c8ZvrltCQdzj8L4d54KkYOebmwCkj1586jCOfO9hZkUf2+Eo2iKLi7TcSwjiY9g0w+
         SaQVW27TnlmNMgeKpsqSpOrjcviIE70e5HNvsdxmLZOlCsBA2Ddb6KojCeDi8iT1QvI9
         JzAdySj0a8tWBW/tuaxBfLBD2OmzesZ8f7o1tcvb0vrkdjB8mWXTkxlN8ZIeG7E7r4Mp
         LNAvpLcZfCXB56RSpubURKVi5wPjj39C6ml2zAxVaiXmnPHGKGjvrheK7tn4d0iQSa3/
         VbcaODCA6OEZCoR3kkZSUPEEcy1eGqaUrc3WkXyjzj/ABr9ZOXbLAWptx0J6hIPlAt2+
         j3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=go4tve/Op9RygAUFtopjfFh/CZKE0zEfnvvG7nESATk=;
        b=tUw96IBXxnnYMJKRjI44jUjfTFBTLIOY3UNVoqPGMIwNKjac22KpBly36xj28psQ36
         6xb0GbcrhXpzIZm0mqexY1C1WGnpguh2qcY6mOlNFIWbo0BN9jn6U00W7wxZc3eS0BQt
         u/OWpDAVxLgqYBaEb/jjlWy3ffRhq7s8sPulsa1poln9fOy5TzZYipHGxE5SNqctImz9
         r5hD5B9DpqfIFoNUKZd2xhdhSgkGCYGmjv37gzILCNKEJETNgk44BzXcQeVbE3o0Wxu/
         Rmorp5j1qaCj7pmuSQJyiSRdnYxw55jk/Hj/RmQCa0pwr6PrczIeRoI5q4uclizUh9NX
         KECQ==
X-Gm-Message-State: AFqh2krZcwj32RRAoI5TUvD4RnxqmGI8MMvn/MuI1HnBqhRvDxN6JScI
        Ylc27ict/PdyT478UbjcUhI=
X-Google-Smtp-Source: AMrXdXtjEVEFZLzSyoStT9Kj6tBwQJE4D7bQ2cUpq8U38CgZHYINOKjoo5N1ROeqxyLB0k2BxlMIug==
X-Received: by 2002:a05:600c:2112:b0:3d3:396e:5e36 with SMTP id u18-20020a05600c211200b003d3396e5e36mr12856292wml.0.1672059307214;
        Mon, 26 Dec 2022 04:55:07 -0800 (PST)
Received: from localhost.localdomain ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003cf894dbc4fsm13684497wmq.25.2022.12.26.04.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 04:55:06 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/6] HID: uclogic: Add support for XP-PEN Deco PRO SW and MW
Date:   Mon, 26 Dec 2022 13:54:48 +0100
Message-Id: <20221226125454.16106-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series add support for the XP-PEN Deco PRO SW and MW drawing
tablets.

Both tablets are similar, the only difference between them is their
size and their IDs. I own one of them and Andreas helped me test the
other one, so thanks a lot!

Please note that this series might cause conflicts with [1], but they
should be really easy to fix/I can rebase once it is merged.

About the patches:

 - The first patch introduces a quirks to be able to fix the frame type
   reported by these devices.
 - The second patch adds another quirks to know whether a tablet has
   battery or not. I didn't find any difference in the information
   reported by the firmware nor in the Windows driver to obtain this
   information, so I added a manual flag.
 - The fourth patch adds a generic mechanism to schedule jobs when an
   event is received, in this case, to reconnect the tablet.
 - The last two patches add support for the tablets.

Best wishes,
José Expósito

[1] [PATCH] HID: uclogic: Add support for XP-PEN Deco 01 V2
    https://lore.kernel.org/linux-input/20221226123456.14822-1-jose.exposito89@gmail.com/T/

José Expósito (6):
  HID: uclogic: Add frame type quirk
  HID: uclogic: Add battery quirk
  HID: uclogic: Refactor UGEEv2 probe magic data
  HID: uclogic: Handle wireless device reconnection
  HID: uclogic: Add support for XP-PEN Deco Pro SW
  HID: uclogic: Add support for XP-PEN Deco Pro MW

 drivers/hid/hid-ids.h                 |   2 +
 drivers/hid/hid-input.c               |   4 +
 drivers/hid/hid-uclogic-core-test.c   | 105 ++++++++++++++++++++++
 drivers/hid/hid-uclogic-core.c        |  61 +++++++++----
 drivers/hid/hid-uclogic-params-test.c |  16 ++++
 drivers/hid/hid-uclogic-params.c      | 124 ++++++++++++++++++++++++--
 drivers/hid/hid-uclogic-params.h      |  40 +++++++++
 drivers/hid/hid-uclogic-rdesc.c       |   6 ++
 drivers/hid/hid-uclogic-rdesc.h       |   5 ++
 9 files changed, 338 insertions(+), 25 deletions(-)
 create mode 100644 drivers/hid/hid-uclogic-core-test.c

-- 
2.38.1

