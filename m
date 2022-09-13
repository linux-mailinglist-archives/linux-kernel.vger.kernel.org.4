Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D480A5B6782
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiIMFxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIMFxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:53:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13EC43611;
        Mon, 12 Sep 2022 22:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663048400; x=1694584400;
  h=from:to:cc:subject:date:message-id;
  bh=eU2J0ZjEAt8/QRcmzeXzVNLD9baR09siYH77WuivdGM=;
  b=i5tDYNnpus/D6yx5P02m4XljL66+sU9znNxu0Porza5DSU2DPibEVdC7
   gmeeUyt8BW4HgPDCFTH4GuyOz2+CTBOf1zcee0KY9i+mLaamHPv+0W/XY
   QrXfp+HTNnU+jaDsvfWsM5czUqOmeMLojts72hAEwcJYQokcJ8vLZoaTV
   QZj+VMVBJ3Kah0/Ou9YGfVXKkeKycU6j7+B9nNN/xwEpPGlJvXrLUceB0
   KAy0NtibP8hpuobF/QrtMDMyE8fjf+rlta6JGqjPhufhuGHQYWyEQMMbU
   gw0XeAf13QELD1TIatpXyF7YP9YYXBSDI1na4PfYnXVlG/DvrK4O4EWIu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="361995437"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="361995437"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 22:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="646781548"
Received: from inlubt0246.iind.intel.com ([10.67.198.165])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2022 22:53:17 -0700
From:   shruthi.sanil@intel.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, srikanth.thokala@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH 0/2] Update the PCIe device ID's for USB device controllers on Alder Lake platforms
Date:   Tue, 13 Sep 2022 11:23:14 +0530
Message-Id: <20220913055316.23050-1-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

Alder Lake has split die architecture for the USB device controllers.
The USB2 controller resides in the PCH sub system and the USB3 controller
resides in the CPU sub system. Hence we need to update both the device ID's
for the device to be enumerated correctly.

Shruthi Sanil (2):
  usb: dwc3: pci: Update the macro names for USB PCIe device ID's for
    Alder Lake platforms
  usb: dwc3: pci: Add PCIe device ID for USB3 controller on CPU
    sub-system for Alder Lake P

 drivers/usb/dwc3/dwc3-pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)


base-commit: e839a756012b6cad7a4eeb67b0598ac3f349f863
-- 
2.17.1

