Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4CC716116
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjE3NIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjE3NID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:08:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B789292
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685452082; x=1716988082;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WOQPz7xirDNGHJkEd2/jtsrDP/yCktfckuUnOzCnaBI=;
  b=bh0iYvqIQvfSg0BNV4S8ZBDQO7YKuBRa6PSGWORIRDBpD3/QGlZdopw+
   vjXK2Ub8JQlL5d4zSyalKA5Rvp7GwYCr+HeGzX0eZYN9eG3wTf6SziEX3
   N8mdTASlhFVusy0CBByQ8fCNUHmxun0+Uf9rukqVFvs0CFmjp+RXJ/3ib
   v3QXKvuSPIFkz+K1eOH2q+dd6wAmDvOqFuycviCQ2wo91Om3Qj6L6tiLV
   EFHI0xcluO/qWVXO398F6u5DpXnUFf0D6XMcZCgKHoz46Z+4GwLBAJGH4
   0gOLtoSgF5qxp/Lvvgz2JfXZTfpua/A+UuHshFofrUZv/SHqlep/ZYEqb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="418393851"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="418393851"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 06:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="656850036"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="656850036"
Received: from unknown (HELO localhost) ([10.237.72.184])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2023 06:07:59 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
Cc:     alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v2 00/12] Enable Linear Address Space Separation support
In-Reply-To: <20230530114247.21821-1-alexander.shishkin@linux.intel.com>
References: <20230530114247.21821-1-alexander.shishkin@linux.intel.com>
Date:   Tue, 30 May 2023 16:07:48 +0300
Message-ID: <875y8aynkr.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Changes from v1[1]:
> - Emulate vsyscall violations in execute mode in the #GP fault handler
> - Use inline memcpy and memset while patching alternatives
> - Remove CONFIG_X86_LASS
> - Make LASS depend on SMAP
> - Dropped the minimal KVM enabling patch

Also, I've unfortunately overlooked adding my SoBs to the patches. This
is a mistake, I'll fix it in the next round.

Regards,
--
Alex
