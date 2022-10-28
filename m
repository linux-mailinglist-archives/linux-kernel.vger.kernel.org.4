Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429FA611970
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJ1RlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJ1RlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:41:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA828733D5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:41:10 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bn35so9249564ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LgIFkJpodLhQ5UNB8CnN3tOTm9odgIidnDRK4X3byAg=;
        b=WA90H9fRil7olR1Vlx/1sOEtZ0T3JsGEo/zahhOQwFUmffec42jXK67bQZGEdVJZ0b
         PYwyVYcokv5NPLfkNsVbXmyXYVR9YLMFNmi7vs9nbz5JgD9VKC+53jP7g/gRZ1JDGVnS
         lPvldw9IbWef9my0YLqiicSNaq6pP14bPdQmhtlOE8M39NmP2qkFpq5LZW2bvOuZXlgs
         FJuJlV3ME0cnhFQpYb8shJ8a49kWaPha38YsKJt5QZD8CqX1kMlX0jFxxpsk2w2jm+jS
         T74nIkCZBAQOf7oX1ItpdaqEDMjPJ4uxp3LxlEaHVO2KSqmva8PqV9VW8ECg0ESXmhia
         DT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgIFkJpodLhQ5UNB8CnN3tOTm9odgIidnDRK4X3byAg=;
        b=nD+Rd4Nq0lniBz3czGUNPsc9z4kUqz+Px8S0KbI2cR6XqWNPPie7T0dBSSmInH2JJD
         7U/SmC+yorNu1wQCF3kAlfPaqpe5ul622u6U4YyFqQzswfK/fAtO4ulonR6GsCEG79P1
         RT44QUANzHkOAyh3KWgGDfrPfhpjJZLretYMpk5yksAPHDUrRwX9tWmZCadYQd95dBbs
         NO+XclDwP/dIj62+jfe0hJB0Js5RsrgxPpVdzvkXTNKumVTkf7v0zUGtUnlXKW3Ee06e
         OpP3z6pOMIurKVqiLp8slVgs69/4uSwS/Pd7QyB9PdfggSDA1HnJf93a4oh9xFXT8gkL
         LF9A==
X-Gm-Message-State: ACrzQf3rTtKLJo7DRP2b7XN18JuapXakpq+ELOrb26pGV9kYWb0+/orS
        1C8ffeMCPP4BPEZ5grPl4Go=
X-Google-Smtp-Source: AMsMyM64brzYPgM+s1MBqIb04al8rRJrwRpHxsRYZxtpixVfUpmsR7RdEF2c8Q9Bz7kscIa7No5C4Q==
X-Received: by 2002:a05:651c:2212:b0:26c:2baf:652e with SMTP id y18-20020a05651c221200b0026c2baf652emr295510ljq.84.1666978868819;
        Fri, 28 Oct 2022 10:41:08 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s2-20020a2eb622000000b0026dfdcbccdasm725322ljn.14.2022.10.28.10.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:41:08 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v8 0/6] staging: vt6655: a series of checkpatch fixes on the file: rxtx.c
Date:   Fri, 28 Oct 2022 17:40:52 +0000
Message-Id: <cover.1666978292.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

The fixes are similar, mostly long lines splitting. I had to make
serveral patches to ease the work of inspectors

v2: fixed a compilation error found by the kernel test robot and
recompiled the code

v3: tends out the error persisted in the second version. this version is
a correction of that

v4: did some corrections as recommended by Greg KH

v5: shortend changelog comments as recommended by Greg KH

v6: did some corrections as recommended by Greg KH

v7: fixed some errors on my changelog comments

v8: fixed some errors pointed out by Philipp Hortmann

Tanjuate Brunostar (6):
  staging: vt6655: fix lines ending in a '('
  staging: vt6655: fix long lines of code in s_uGetRTSCTSDuration
  staging: vt6655: fix long lines of code in s_uFillDataHead
  staging: vt6655: fix long lines of code in s_vGenerateTxParamete
  staging: vt6655: fix long lines of code in the rest of the file
  staging: vt6655: fix lines of code ending in a '('

 drivers/staging/vt6655/rxtx.c | 542 ++++++++++++++++++++--------------
 1 file changed, 324 insertions(+), 218 deletions(-)

-- 
2.34.1

