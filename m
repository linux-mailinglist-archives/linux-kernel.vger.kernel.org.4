Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B296B3BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjCJKFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCJKFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:05:07 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0E3108688;
        Fri, 10 Mar 2023 02:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678442703; x=1709978703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ESWaCkXAaeEblso0aAHVmOfH9iSTPLuh8pAb5SDrc8w=;
  b=aGuk8jozdo3X3ZsKbgM3IlhXTzOWWbzc3MWEv23aSEK5m3jACgDaTBnr
   NvPq+IZxKRl2eCwIVXhC6IK/jRfdtYKIuQRQfW7Jf3DRfkyhWpQx1G1Ml
   GVIMqvibOwO8fPjgIk8v4m3WhoRFRRKZWvCdYkWIZ5svN6+VKqJkfHd2R
   NtBpSlnvxIwNPv9TDra4zwBIPazt9DZkWlKoYfqPnV4TBIdiIgLgU19d1
   cwNz1jnTYz06KrhFbxIN8MCQfBtxZK/eQIRwjpYTT+KbpERllnBcJPoAK
   tqcMb1vt9wTMa0mxNuWXcRJaHTUs8EV+4zqO9Ku40HTmqYKyLjRCqcLdL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="399294161"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="399294161"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="923609283"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="923609283"
Received: from fliu-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.32.249])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:05:01 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     rostedt@goodmis.org, bristot@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 0/2] trace/hwlat: Prevent startup of multiple per-cpu threads
Date:   Fri, 10 Mar 2023 12:04:49 +0200
Message-Id: <20230310100451.3948583-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v2 of this series just splits the patch into two, and adds the
reproducer script into the commit of patch #2. Separately, neither of
the patches fix the issue completely, both are needed.

-Tero


