Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F95B6658
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiIMEIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIMEIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:08:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5130852E42
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 21:08:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id go6so5841217pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 21:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uanTL/bnlnJQgtwLSfczwro/TOgawj0bo0VSuHyRExY=;
        b=LQvkqGqqUHSPlHPc845FHWHSftI9v84JIYOknsWb6h6jpm3wGnvNf8yBQTlnTAndwj
         ZdqRWHHbR5dapmKsDAvU+Ds1jZqp2V9bKcs3IWt7HNgSz3Iw7TdlhicIO9FCTk9umyGm
         G0tRPu6EblFFFRbjsjZ37LPTKGRAvYi2ESuuiKQs66Vp4Zw1u1i/0OywhmlVnKnnapG6
         Z4NHaqAjcMjJKbZFentHQHeUa0cJ0EDfoVc62Vg0FO0oesrbgZdvWOBIqvZJJhorqJB3
         H1pnOhffgb4Ihds61EkWxbjJPv86enNZYEajrRampSyWIvdXc7g3utON2EVhyl4w6qCp
         N16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uanTL/bnlnJQgtwLSfczwro/TOgawj0bo0VSuHyRExY=;
        b=y2jDz7NGSdqhW8jQ4GIhQpzJkqGt+UaTorOxe6v6e5P9ADggqlxEy3VMhuti+l7L0V
         N0xohygyZlgatTDJx5R2oYOdGU81RSOz6BTDhBy4eo1lJYAWV26DWeGGQlbq8ny8ntwK
         Gf+TZVppB2JMzXOBrl6stOiYR44tVRLDTfFW92lpOdFdNKOldma1RgC9QNsYR/31/vH/
         MJjpUx1yf17XHfSbowQMT6ggEDgEfZvWInoNLbZH3or2TVDhTdlwDzmW2NOv7ABmyjIN
         eSTrrW9G7o4xDABleif7hV6I9Ir9Pbecf/NPnJvEFBq4qfVma0iuVkNZd6e76oBW/M5v
         qMOA==
X-Gm-Message-State: ACgBeo0GiCgeItL6sl0ldlfsYii177GDbGN1KcltwRnOdbtCuRI1xVLU
        vnkIlRjje9MemEJ+OZPV383o26ZiwFKwXWr7
X-Google-Smtp-Source: AA6agR6cXEZFHwV6pGtOO8vmhiuAq6xxruH6T71pUW6vDO7/gIK2ZCilxUsfGInY1ieI+ZdP6GEOMA==
X-Received: by 2002:a17:903:25d3:b0:176:e9d3:64bc with SMTP id jc19-20020a17090325d300b00176e9d364bcmr28790846plb.45.1663042087464;
        Mon, 12 Sep 2022 21:08:07 -0700 (PDT)
Received: from ubuntu-jammy.. ([61.16.102.77])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b0017691eb7e17sm6877641pln.239.2022.09.12.21.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 21:08:06 -0700 (PDT)
From:   yangxingwu <xingwu.yang@gmail.com>
To:     nathan@kernel.org
Cc:     ndesaulniers@google.com, trix@redhat.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, yangxingwu <xingwu.yang@gmail.com>
Subject: [PATCH] scripts/clang-tools: remove unused module
Date:   Tue, 13 Sep 2022 04:07:53 +0000
Message-Id: <20220913040753.2198-2-xingwu.yang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913040753.2198-1-xingwu.yang@gmail.com>
References: <20220913040753.2198-1-xingwu.yang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused imported 'os' module

Signed-off-by: yangxingwu <xingwu.yang@gmail.com>
---
 scripts/clang-tools/run-clang-tools.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index 1337cedca..bb78c9bde 100755
--- a/scripts/clang-tools/run-clang-tools.py
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -12,7 +12,6 @@ compile_commands.json.
 import argparse
 import json
 import multiprocessing
-import os
 import subprocess
 import sys

--
2.37.2

