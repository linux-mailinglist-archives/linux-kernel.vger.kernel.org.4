Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3898A745443
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGCDqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCDqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:46:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B0123
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688356004; x=1719892004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GzJ4tzVN/k2ClXx/HdVUGxMNfKIBKwJjVlzRGUCUtRo=;
  b=EJswaRi1X3SH99Ct9Z62+uAixnIFxkpSQhDCBI8EEmb53AVRZNc9SeCq
   rhVZ0f4IfaFCbE7IW9LYglxu6mIg0O+vYUmFPFbd3yJl8NY3YvyWcEXdC
   vATNo+s72AfsSgwP4FCqajebW1Z+zzOt+g6yJTvaioiDuHEuK/S6qDEhJ
   px2wovwrbPQDMjwK3xQrlUgQqs1ZThN865/UZ3dzgcOIrkdDgIJjmq3OI
   Q1s3dhRORvC04c8XfJ526X+eyy4LUbUX1Q6EAkY5MI5+9i/JEZJ5hp9n2
   RdFmaoLxiQd3y0T3TJunJtCd/eSwkHng9a0bKUDO8zOHLd4Wxf30lmWgx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="343116856"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="343116856"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 20:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="831657807"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="831657807"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jul 2023 20:46:42 -0700
From:   kah.jing.lee@intel.com
To:     kah.jing.lee@intel.com, Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tien.sung.ang@intel.com,
        wen.ping.teh@intel.com
Subject: [PATCH 1/2] firmware: stratix10-svc: Generic Mailbox Command
Date:   Mon,  3 Jul 2023 11:44:51 +0800
Message-Id: <20230703034449.1334571-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908020350.2745506-1-kah.jing.lee@intel.com>
References: <20220908020350.2745506-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh, 
Any feedback on this patch?

Thanks,
KJ
