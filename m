Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7D0606360
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJTOm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJTOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:42:24 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B95B8050E;
        Thu, 20 Oct 2022 07:42:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666276940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z/iSlv3vCDY/LuUj111gTd0QbnGmIW//KkgjFhZEcrk=;
        b=KYevtNxG8LNAUTmPNQy7flggBFfO53H+oLsF9bsXw9N4LA9KnMeSj6cubgFO2eQTd23+Bb
        YfVpiGFKAXg8nNQIDJ58t8RD56p1QXENCp5NjsqI9K7RI75VlVHeciJpllQRHRai+uBVW8
        p4NMlktZmjqr65MJ+4aOVaus4UYkEXcPzfBO/fMZUoH34oEaqoGBS97N8pbNJAUkoE3h9J
        /Q/hhEtFq0NyO1d9NBFKXVIc/VpsJvx9oah8B8ApnJt8F1xMI5JZykdUEOUsP8ld5KXoBb
        DpOxjl50kKKaCRVwF9OgRONUtf77LwA3MDsLidnRz5mL12/WesU1k9hz5UlASw==
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Li <me@lirui.org>
Subject: [PATCH v3 0/2] docs/zh_CN: Add staging/index and xz Chinese translation
Date:   Thu, 20 Oct 2022 22:42:12 +0800
Message-Id: <cover.1666275798.git.me@lirui.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate the following files into Chinese:

- Documentation/staging/index.rst
- Documentation/staging/xz.rst

Add staging/index into the menu of zh_CN/index. Also fix one
translation in the zh_CN/index file.

Rui Li (2):
  docs/zh_CN: Add staging/index Chinese translation
  docs/zh_CN: Add staging/xz Chinese translation

 Documentation/translations/zh_CN/index.rst    |   8 +-
 .../translations/zh_CN/staging/index.rst      |  26 +++++
 .../translations/zh_CN/staging/xz.rst         | 100 ++++++++++++++++++
 3 files changed, 130 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/staging/index.rst
 create mode 100644 Documentation/translations/zh_CN/staging/xz.rst

-- 
2.30.2

