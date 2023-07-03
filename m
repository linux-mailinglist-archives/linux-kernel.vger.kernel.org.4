Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7691C745451
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjGCDxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCDxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:53:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45BA9D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688356387; x=1719892387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5LQjnRgqkUJtNN7flomJqN7mwpPvKcxoouKjGeU15l8=;
  b=DI8tpEhd+QRNPy1V1K0dtC6naVkZsAE4X5NXYOupDpYJiYkWt4R2zsKl
   8x4E+uLtLOXinF4aU4ZminhA+HHF8s+Ggc5kNIObo4llVFb0XUx8E8w+y
   bZwU8LVwN7oEoMKf2ENQU2YCnw8O0idIV2grDmfuzVDUg9aqZeGehO+12
   XIlrRl3we0mkHpOeXVM1IoG4e2J3TiG5FDO9i7ifgEpuxQMMK/D+wT0wU
   Ubawtx2Oddq7ASjFNigSk3HnI+XDcIsjaiaJjofFCqS7Bx4XN4egmTiRm
   6x39aD1qfllbTWAYOEeNQrczOt0BlPbkUhX4KNstwW3qCWYxSrez4ixJP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="426464650"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="426464650"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 20:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="965011202"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="965011202"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2023 20:53:05 -0700
From:   kah.jing.lee@intel.com
To:     kah.jing.lee@intel.com, Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com
Subject: Re: [PATCH 2/2] firmware: stratix10-rsu: query spt addresses
Date:   Mon,  3 Jul 2023 11:48:58 +0800
Message-Id: <20230703034857.1334884-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908020526.2745662-1-kah.jing.lee@intel.com>
References: <20220908020526.2745662-1-kah.jing.lee@intel.com>
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
