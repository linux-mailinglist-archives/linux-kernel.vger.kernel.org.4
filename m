Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF1A602345
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJREbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJREbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:31:39 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF079E2F3;
        Mon, 17 Oct 2022 21:31:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666067496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=86L+JIh3fg+P1A1DVveV/v2hW3SM8b0TIEUaC6V45UA=;
        b=lCzYkHSgG1Bn2kyFoe+J1aglizu99WDSBNKWkjotxQweUOr0SUhyBEZS4cg94NdZH1uvmX
        6Nsa9CFJg77uxNtQZRmzxYqCLPVQS+HDpCcx7UOx060/dLk4UTx2JY+oKvovrVZ8aUjaUx
        I4jJ5+P/a+GZZYCJK6fs5/DP3TSGh4fRHqtF0SNJx1zdhR2wFoc8SBWdTUfjClfYXscsQO
        Q8eyULHIGU+t+/wOwnK9g8kLkcxrw1Zs8sBF78mZIlgOwZHRTk0cZITAMwbnT6T4izP2FH
        uaXn61cTCbYOyU2qIJWeWBT7QPVQ4nLS8CxNddZIEwHEModmw/ASZb5/Uk3+rQ==
From:   Rui Li <me@lirui.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>, Rui Li <me@lirui.org>
Subject: [PATCH 0/2] Add staging/index and xz Chinese translation
Date:   Tue, 18 Oct 2022 12:31:04 +0800
Message-Id: <cover.1666067195.git.me@lirui.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
  docs/zh_CN: Add staging/xz Chinese translation
  docs/zh_CN: Add staging/index Chinese translation

 Documentation/translations/zh_CN/index.rst    |  8 +-
 .../translations/zh_CN/staging/index.rst      | 27 +++++
 .../translations/zh_CN/staging/xz.rst         | 99 +++++++++++++++++++
 3 files changed, 130 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/staging/index.rst
 create mode 100644 Documentation/translations/zh_CN/staging/xz.rst

-- 
2.30.2

