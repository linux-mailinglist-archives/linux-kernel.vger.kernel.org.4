Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CCB6F16DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjD1Lfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjD1Lf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:35:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2401A5FDF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682681717; x=1714217717;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=SyqBF1wuHeMEmc4+oscukp8iRk3ac8QUI3nKBf9MKVc=;
  b=E557iQmY758nuWqtczTlwNucH1da/+9KgfHJIXEohTo82Doj+y/r14+O
   f+PMRMJ9qxXO+6aTzrZe0AJOKi302HyK18iF+YRXqybK8ABaM426dEz9g
   WWCKinW3AOCLDK6IIwhar7sO6QW4FxAMj2m5GngU791ewXWxsmExWMZ9e
   nluYqNwolER8bslbuEWCaoLn8vV6Ks6UF8Zke6LIH+8/nRNqsBBoPmFiq
   imCkqGE7H4Io2uDAbvIPKTc1Roz11q9812yVX0UkshefqE/L6iJlwhAkf
   CubujbyIBNyhjgsZ5jwfpKl40549RnyVLcDRMTnvLBCR835lRsV9sDmW8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="346489242"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="346489242"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 04:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024572331"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="1024572331"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.9.173]) ([10.213.9.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 04:35:15 -0700
Message-ID: <3e4b6143-d8f0-e182-1824-85fe92bd66e7@intel.com>
Date:   Fri, 28 Apr 2023 13:35:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [Intel-gfx] [PATCH v8 0/2] drm/i915: Hugepage manager and test
 for MTL
Content-Language: en-US
To:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>
References: <20230425-hugepage-migrate-v8-0-7868d54eaa27@intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230425-hugepage-migrate-v8-0-7868d54eaa27@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.2023 23:28, Andrzej Hajda wrote:
> This patchset patches sent by Jonathan and Andi, with
> addressed CI failures:
> 1. Fixed checking alignment of 64K pages on both Pre-Gen12 and Gen12.
> 2. Fixed start alignment of 2M pages.
> 
> Regards
> Andrzej
> 
> Jonathan Cavitt (2):
>    drm/i915: Migrate platform-dependent mock hugepage selftests to live
>    drm/i915: Use correct huge page manager for MTL
> 
> .../gpu/drm/i915/gem/selftests/huge_pages.c   | 88 +++++++++++++++----
>   drivers/gpu/drm/i915/gt/gen8_ppgtt.c          |  3 +-
>   2 files changed, 71 insertions(+), 20 deletions(-)
> 
> Cc: intel-gfx@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>

Thx for comments, pushed.

Regards
Andrzej

