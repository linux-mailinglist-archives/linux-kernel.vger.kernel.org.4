Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADA6083AB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 04:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJVCku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 22:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJVCkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 22:40:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5439E1B2332;
        Fri, 21 Oct 2022 19:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666406446; x=1697942446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F2EHR+886Fkx6oIBJ7t6GLz64cS0vgAI77lAZDY05+M=;
  b=gS2/q1WNTktEhsINf0+jZFKUR3NiIm2sWgwBpkqHRaWs3unGkTOfLB+V
   xeNeuMInuwhqXTudPJui0gXfkh65eRWUneUyVDdfVkdoZWtiQ3nrybbAV
   YBtPIuJMp6aKkyk8htpfDwpZIS9HIGW5tcXzAGcF6iY4C9XRiKjQX8kmg
   ajBi0UI6FAuSStpMQ18+UGzoL1t/puMPhU2HhKqAQ/2mYAje9JLBYrwlF
   kqpHKnx/cvhtQZo98exjwB/UeTE09drWiChC8AJaAV+BqA4KDzwqid8+i
   Ro5tHxxtZhOVRoiv+Sxub9VJvOYU4YQJF21ar5lm7kslYPXueZWNne55I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="393461686"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="393461686"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 19:40:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="773273980"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="773273980"
Received: from kerendel-mobl1.amr.corp.intel.com (HELO [10.212.96.240]) ([10.212.96.240])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 19:40:45 -0700
Message-ID: <35f55696-c4c5-1f00-dc7e-b5c7dcf0a091@linux.intel.com>
Date:   Fri, 21 Oct 2022 12:09:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/9] ASoC: qdsp6: audioreach: topology use
 idr_alloc_u32
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        tiwai@suse.com, lgirdwood@gmail.com, bgoswami@quicinc.com,
        linux-kernel@vger.kernel.org
References: <20221021165207.13220-1-srinivas.kandagatla@linaro.org>
 <20221021165207.13220-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221021165207.13220-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/22 11:51, Srinivas Kandagatla wrote:
> SubGraph and Module Instance ids take 32 bits, so use idr_alloc_u32
> instead of idr_alloc to able to accomdate valid ranges.

typo: accommodate.

Also worth checking https://www.kernel.org/doc/html/latest/core-api/idr.html
"The IDR interface is deprecated; please use the XArray instead."


