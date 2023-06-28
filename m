Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2B741750
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjF1RhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:37:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:11724 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231142AbjF1RhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687973823; x=1719509823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A6rhqoGfEF6tMPshjflA36JGZSboRhfXaXYc4HmnUS0=;
  b=ICYzlDmnRhZg0mnstS+fKb5yVFm6bKyxoYbMtJnIb9cgJ4jlPUNnl9sr
   OVIYUPU1VJw4qloHugH3ABoiBSvqpuTNwtEgJUw7eOeJZuSk3CYeXMmMs
   1PgiT4o+UnrGZAtzPu3udc4tDxnYd9Nu99PWZHtL8HRob5iyLPMHBTHW0
   R1Z2j4rxwJ6+UzGcrPp8qqt3zjqBFcQPqGTVEFPaQ/NwXxllTmQbw9OX3
   H/esrdL5qAgs5Ok9QqEUz3CIR7Zvxds0kOdxVV3cK78so5T8pG2DMlZFb
   k3MSFbcIq4Vqf7rr/n/ZnCV7ZzTO/J+a9vhCR0pwDM37JahN3HHB+rCdC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="346679445"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="346679445"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 10:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="1047499360"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="1047499360"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.157])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2023 10:37:00 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 0/2] Add support to configure active retimer cable
Date:   Wed, 28 Jun 2023 10:37:25 -0700
Message-Id: <20230628173727.701140-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds support to configure retimer cable type

Changes in v2:
- Implemented use of cable discover mode vdo.
- Removed adittional changes to host command.

Utkarsh Patel (2):
  platform/chrome: cros_ec_typec: Configure Retimer cable type
  usb: typec: intel_pmc_mux: Configure Active and Retimer Cable type

 drivers/platform/chrome/cros_ec_typec.c | 33 ++++++++++++++++++++++++-
 drivers/usb/typec/mux/intel_pmc_mux.c   | 28 ++++++++++++++++++---
 2 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.25.1

