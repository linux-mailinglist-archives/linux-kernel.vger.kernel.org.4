Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D996780C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjAWQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjAWQD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:03:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27D0CC2E;
        Mon, 23 Jan 2023 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674489804; x=1706025804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GFijjW7lR2HML5rXSl3aNY/6L0A+D+DedtGWDxxyrn8=;
  b=ioc4TiKQITJ3utTScveFeskqCHwl45LPCoriVStLLGQJLO7DBvHJy910
   gjsiSYb541H6n1WyQ16kQr841dWgrp8AuvzOlg80t3cT7MMg93LaDDevT
   /OGR6jgaABCUiEzy7OowcTmYOgo7JUGr8bON780oA0z+CbH2NaiQv5BFw
   zWwkYzTOUg42qMGwp/b1gOosTLDZxtZcFH55KBDb9cYgVxQ/o3UL6e2Az
   jc8n44BbpMq7UFqp2DmLaFsUdtPr3Mt3rwIxyPCI8xI7EP7qqQNuLnUfl
   0IFUjOMUoxn+s4KVjc7sUTs2KFUmYWjunp6g/LTGULOyNr4jrLNEtdoLo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="305732219"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="305732219"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 08:02:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="804235055"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="804235055"
Received: from rgrachek-mobl.amr.corp.intel.com (HELO [10.212.113.123]) ([10.212.113.123])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 08:02:43 -0800
Message-ID: <268823a3-f453-a38b-3fd7-500306675890@linux.intel.com>
Date:   Mon, 23 Jan 2023 10:02:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 8/8] Docs/sound/index: Add missing SPDX License
 Identifier
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, SeongJae Park <sj@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
References: <20230122213650.187710-1-sj@kernel.org>
 <20230122213650.187710-9-sj@kernel.org> <875ycxr7qv.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <875ycxr7qv.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/23 02:10, Takashi Iwai wrote:
> On Sun, 22 Jan 2023 22:36:50 +0100,
> SeongJae Park wrote:
>>
>> Add missing SPDX License Identifier for sound documentation index file.
>>
>> Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> Acked-by: Takashi Iwai <tiwai@suse.de>

Isn't GPL-2.0 deprecated? It should be GPL-2.0-only, no?

https://spdx.org/licenses/GPL-2.0.html

https://spdx.org/licenses/GPL-2.0-only.html

> 
> 
> thanks,
> 
> Takashi
> 
>> ---
>>  Documentation/sound/index.rst | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/sound/index.rst b/Documentation/sound/index.rst
>> index 5abed5fc6485..7e67e12730d3 100644
>> --- a/Documentation/sound/index.rst
>> +++ b/Documentation/sound/index.rst
>> @@ -1,3 +1,5 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>>  =============================
>>  Sound Subsystem Documentation
>>  =============================
>> -- 
>> 2.25.1
>>
