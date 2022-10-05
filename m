Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311105F4F66
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJEFON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJEFOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:14:10 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0605F65;
        Tue,  4 Oct 2022 22:14:09 -0700 (PDT)
Date:   Wed, 5 Oct 2022 13:13:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664946847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=UYSsNCGDyBNr//V5DcrgDWn8j6jpwzzv0/Roq6dRt+E=;
        b=Cj+7cAAIOSCc/WeYgbk9jAiFaZ5wl4BzpMMjcWnRiHgpfJEIkjwjwyl4ov3lDHVTTDHj1N
        jU1SlzQZBmRa7Jz1fFjTsRhC788NqooJ2QzOyrkHyhS8OejDp5gvwZQnRUz6CfFWGAf3x3
        PbzNE0Py+y3tq4M8k5WNF02IXkP1Tjs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, chenhuacai@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] docs/zh_CN: Rewrite the zh_CN/index.rst
Message-ID: <cover.1664945550.git.bobwxc@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow Jonathan's steps[1], rewrite the entry point of kernel's Chinese
translation documentation.

Thanks,

[1]: https://lore.kernel.org/linux-doc/20220927160559.97154-1-corbet@lwn.net/T

Wu XiangCheng (4):
  docs/zh_CN: promote the title of zh_CN/process/index.rst
  docs/zh_CN: add zh_CN/arch.rst
  docs/zh_CN: Rewrite the Chinsese translation front page
  docs/zh_CN: add a man-pages link to zh_CN/index.rst

 Documentation/translations/zh_CN/arch.rst     |  30 ++++
 Documentation/translations/zh_CN/index.rst    | 169 ++++++------------
 .../translations/zh_CN/process/index.rst      |   1 +
 3 files changed, 83 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/arch.rst


base-commit: 05fff6ba04eef8b88bb94734b66731bef3d8d34b
-- 
2.30.2


-- 
Wu XiangCheng	0x32684A40BCA7AEA7

