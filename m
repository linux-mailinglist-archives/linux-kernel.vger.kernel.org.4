Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D20066A2E5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjAMT2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjAMT1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:27:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2959385CA5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673638071; x=1705174071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z3ekLWY5ObJLmIVZrmrckQLOgVzWCWpMqm4KtCSrWtI=;
  b=AuYw1VS3TEuSWwCJc0nWn4Ch67/gVTLWdLb5z6AmohLmnFn62hh+zXTr
   lqSPZLexbEcxpoJDwFutGa3b8n8oS+BB1BKte8mw76rX+GrZy3OZqbTiv
   b/RS3zIEupmwSZNr94ZM5iVpsV76JQpY1T4elaD/MHp6dpbZnR/N+y6Do
   GTtWI3sCHjcsGJP4YuNgweOQDBLIcu23gfPnsxnaoZEdmAgzOdWqrpP+x
   2KBeT+Sdj7CU27XsneSCG9G9CsFHmmHPQInug1mYWVRjR8lN1zY/B3Fhb
   77bUG4T4e9vKT4hSqXPy54L4S8lbnuyufzhUMUaZnX/aWDpd7aEEg2Zfx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322777233"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="322777233"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:27:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608257464"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608257464"
Received: from rerayess-mobl.amr.corp.intel.com (HELO [10.212.13.223]) ([10.212.13.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:27:49 -0800
Message-ID: <68b22ad4-1da0-48e4-a3aa-2b55e5553c01@linux.intel.com>
Date:   Fri, 13 Jan 2023 11:13:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 03/19] soundwire: amd: register sdw controller dai ops
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-4-Vijendar.Mukunda@amd.com>
 <ad052efb-286e-4716-7608-d284782011cd@linux.intel.com>
 <abf07f9a-d34e-850f-1ed1-54b373960ce2@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <abf07f9a-d34e-850f-1ed1-54b373960ce2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>> +static int amd_sdwc_hw_params(struct snd_pcm_substream *substream,
>>> +			      struct snd_pcm_hw_params *params,
>>> +			      struct snd_soc_dai *dai)
>>> +{
>>> +	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
>>> +	struct sdw_amd_dma_data *dma;
>>> +	struct sdw_stream_config sconfig;
>>> +	struct sdw_port_config *pconfig;
>>> +	int ch, dir;
>>> +	int ret;
>>> +
>>> +	dma = snd_soc_dai_get_dma_data(dai, substream);
>>> +	if (!dma)
>>> +		return -EIO;
>>> +
>>> +	ch = params_channels(params);
>>> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
>>> +		dir = SDW_DATA_DIR_RX;
>>> +	else
>>> +		dir = SDW_DATA_DIR_TX;
>>> +	dev_dbg(ctrl->dev, "%s: dir:%d dai->id:0x%x\n", __func__, dir, dai->id);
>>> +	dma->hw_params = params;
>>> +
>>> +	sconfig.direction = dir;
>>> +	sconfig.ch_count = ch;
>>> +	sconfig.frame_rate = params_rate(params);
>>> +	sconfig.type = dma->stream_type;
>>> +
>>> +	sconfig.bps = snd_pcm_format_width(params_format(params));
>>> +
>>> +	/* Port configuration */
>>> +	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
>>> +	if (!pconfig) {
>>> +		ret =  -ENOMEM;
>>> +		goto error;
>>> +	}
>>> +
>>> +	pconfig->num = dai->id;
>>> +	pconfig->ch_mask = (1 << ch) - 1;
>>> +	ret = sdw_stream_add_master(&ctrl->bus, &sconfig,
>>> +				    pconfig, 1, dma->stream);
>>> +	if (ret)
>>> +		dev_err(ctrl->dev, "add master to stream failed:%d\n", ret);
>>> +
>>> +	kfree(pconfig);
>>> +error:
>>> +	return ret;
>>> +}
>> This looks inspired from intel.c, but you are not programming ANY
>> registers here. is this intentional?
> We don't have any additional registers to be programmed like intel.

ok, this is worthy of a comment.


>>> +static const struct snd_soc_dai_ops amd_sdwc_dai_ops = {
>>> +	.hw_params = amd_sdwc_hw_params,
>>> +	.hw_free = amd_sdwc_hw_free,
>>> +	.set_stream = amd_pcm_set_sdw_stream,
>> In the first patch there was support for PDM exposed, but here it's PDM
>> only?
> Didn't get your question.
> First patch talks about creating dev nodes for Soundwire managers and
> ACP PDM controller based on ACP pin config.

Sorry, my comment has a typo.

I meant that the first patch exposed PDM support but here you only have PCM?
