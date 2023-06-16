Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022267334D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346003AbjFPPbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbjFPPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:31:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BC1270B;
        Fri, 16 Jun 2023 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686929467; x=1718465467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jw1uAEnhhbelQs94ukdbB6V5nNRwnjxGhT9SWU4hAFg=;
  b=KShYfrDICuiAo7PQXwOMHj4rxnlSYQI2RB2ETNGxgaZLzKRvO2dg4zt9
   3D/668FEVlYwdXk8SJhEKSZxJn6s/AH/QEFo6/TZ+HqqqaTrO5VvN2Bj6
   Ym/+w0lqCQJekyZNXHdZdEdEzPWldnkeLKdmW+M3OkuZrGKr2jAO81xip
   V1yoyeVa12bgap3tnBCuA3bPcvfhZPsEo/Z2lhy/mGNc2s82cnGHOUeTa
   44vEGbPKO/SM95vpbm0+f5Vj/D+4oGzoycn8E0s+72GlZyLk1Cdaxy4DN
   1DV8Z4/0zZ55Epgndaws9h3+eJCEHeXm19Phzh1iDcnZJSRKXyexWHfvC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387989365"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="387989365"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 08:30:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="690283987"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="690283987"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.23.53]) ([10.213.23.53])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 08:30:35 -0700
Message-ID: <696fe4db-81d0-dc8e-4fc7-0e39d477a934@intel.com>
Date:   Fri, 16 Jun 2023 17:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] media: s5k5baf: Add MODULE_FIRMWARE macro
Content-Language: en-US
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        s.nawrocki@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230616120136.1026390-1-juerg.haefliger@canonical.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230616120136.1026390-1-juerg.haefliger@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.06.2023 14:01, Juerg Haefliger wrote:
> The module loads firmware so add a MODULE_FIRMWARE macro to provide that
> information via modinfo.
>
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

Acked-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej
> ---
>   drivers/media/i2c/s5k5baf.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/i2c/s5k5baf.c b/drivers/media/i2c/s5k5baf.c
> index 960fbf6428ea..69a3bad54530 100644
> --- a/drivers/media/i2c/s5k5baf.c
> +++ b/drivers/media/i2c/s5k5baf.c
> @@ -2031,3 +2031,5 @@ module_i2c_driver(s5k5baf_i2c_driver);
>   MODULE_DESCRIPTION("Samsung S5K5BAF(X) UXGA camera driver");
>   MODULE_AUTHOR("Andrzej Hajda <a.hajda@samsung.com>");
>   MODULE_LICENSE("GPL v2");
> +
> +MODULE_FIRMWARE(S5K5BAF_FW_FILENAME);

