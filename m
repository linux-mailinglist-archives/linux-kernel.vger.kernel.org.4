Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6096816C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbjA3Qpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbjA3Qpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:45:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498BCEC59
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675097151; x=1706633151;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZNo5beOaUadZ2tazWeCBl6DwhKG8ILjEke78TBRLIZY=;
  b=Ambb4gB390SpvV/8J35Qbyv+27Un4u9jTBeFU6cCnZgjirczI54EhHmf
   zmaLAU5aM2aVfHd4DlfCAkipAbaaUUDkvR1SN5dNVahh9pBf1JvgP4XSv
   fzziXlMrx0Tro22a3ikbyYR3JNFozuOgzyZAI3/pz2WK/Aik9wyPEJs+R
   iqfibO0mzrF+lkUwfyBA4wwiiWH8Baxj+9pV92PBdt64NvEqaNygt7OiQ
   SRQXiVP9CnIvOl2sBNK7L7FmTcZKE0gTBBsCy/+TULzmwkoIPZLitmusX
   cSf22vl8bsTvgYmnbgiZ3zwixgWAIrT7R3rGFG6CroEbqN3ljV3K+/gKh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="307260842"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="307260842"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="732763623"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="732763623"
Received: from inuber-mobl5.amr.corp.intel.com (HELO [10.212.58.60]) ([10.212.58.60])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:50 -0800
Message-ID: <8768fdaa-9c86-389c-aa49-e5aee221f570@linux.intel.com>
Date:   Mon, 30 Jan 2023 10:33:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v3 5/8] ASoC: cs42l42: Export some functions for SoundWire
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
 <20230127165111.3010960-6-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230127165111.3010960-6-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/23 10:51, Stefan Binding wrote:
> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> Export functions that will be needed by a SoundWire module.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

