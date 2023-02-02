Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD719687547
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjBBFhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjBBFhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:37:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308E97D9A;
        Wed,  1 Feb 2023 21:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675315979; x=1706851979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GwnebmjHQ89MtRrk8upaXgyPzmhpEqjlJRC1mNWx4zo=;
  b=c4PXQk5X2xHPeMQ7lpMo/ZYzbJz3AAy9TcNCpa3L67QsbKG2riCi9NhS
   MKeBbAkkDTRecFUhMpynGItNWCxMl1YyyS2G3UhSqu+nj1b69J9nsq3og
   FmCFKhMOAuJZodhJfJBEImP27L3uV2t/5VMe4GQeg9geeS2r/VAtmdcJT
   BDXDjCa+x9BARmhZX7bWVmWodjRIxEGFoUTOXtiW72dda0uqk0yI4ip8K
   Dj9tBnl0w51gfOLhbu1L8QNYCahLH7ML2/QG7qXbPi+MBGJij0tdZV+4f
   2qjryPLcVzBNEXFlJCYd8gsm82ASjjaodGBUSUGbfQMRKTVxFVRPMo0jZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308009823"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="308009823"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 21:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="993944801"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="993944801"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 01 Feb 2023 21:32:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 89B3F210; Thu,  2 Feb 2023 07:33:20 +0200 (EET)
Date:   Thu, 2 Feb 2023 07:33:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     broonie@kernel.org, alok.a.tiwari@oracle.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: intel: Add support for controllers
Message-ID: <Y9tLICPOATpBeu6g@black.fi.intel.com>
References: <20230201205455.550308-1-mauro.lima@eclypsium.com>
 <20230201205455.550308-3-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201205455.550308-3-mauro.lima@eclypsium.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 05:54:55PM -0300, Mauro Lima wrote:
> Add Device IDs to the module table for the following controllers:
> 	- 9da4  Cannon Lake 300 Series On-Package
> 	- a2a4  200 Series/Z370 Chipset Family SPI Controller
> 	- 9d24  Intel® 200 Series Chipset Family (Including Intel® X299),
> 		Intel® Z370 Intel® H310C,B365,
> 		also Intel® B460 and H410 Chipset Platform Controller Hub
> 
> Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
