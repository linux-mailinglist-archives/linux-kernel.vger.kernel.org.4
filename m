Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64046703183
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbjEOP2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbjEOP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:28:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F41619B1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684164484; x=1715700484;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o4d3wchS2hGWpfF31kHfxYcLQGLrdY5jEIsaF69ZRNA=;
  b=DoOrfgqmGNbElU9v9A3vWUwxfcvVxJBUBxXHoMGWvuNsiZCfewgg1cTx
   qMDBBEUi89B1SuW66JvkgcI71r5XSzZ903YvsPA/khWWPKO0YNwTmATAU
   +qMzXhVZp93w4qp32L9QkI/FX/qJ67yrXx2ZZYOqIz3T6RPcwHLy/Qt8T
   AshkU9oM9T7jdFCyOZZj38oTpVoPQLprvdTuUiAELySQLtjsKkkSTMW49
   ndHCYQ2Ecq1aFroaLokkwnyqatZ91JT6drE5+RGAHy5TqDy3+hQyBu12B
   1dy2VE4H9l1P2HWcZb74O4E921zlPFmW/+rW0/qEB0yGHERhzBd50p6TG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="340583191"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="340583191"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 08:28:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="947452467"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="947452467"
Received: from molivas-mobl.amr.corp.intel.com (HELO [10.251.17.233]) ([10.251.17.233])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 08:28:01 -0700
Message-ID: <8f57c62f-c427-f5df-d517-d4025fe7c65d@linux.intel.com>
Date:   Mon, 15 May 2023 10:28:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] ASoC: SOF: mediatek: add mt8188 audio support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Trevor Wu <trevor.wu@mediatek.com>, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, yc.hung@mediatek.com,
        tinghan.shen@mediatek.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230515052540.9037-1-trevor.wu@mediatek.com>
 <20230515052540.9037-2-trevor.wu@mediatek.com>
 <7c784932-951a-65c0-c48f-bfa4c098b2e1@collabora.com>
 <ZGJKPuf1FX4AYLXl@finisterre.sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZGJKPuf1FX4AYLXl@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/15/23 10:05, Mark Brown wrote:
> On Mon, May 15, 2023 at 01:25:44PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 15/05/23 07:25, Trevor Wu ha scritto:
> 
>>> +{
>>> +	/* common defaults */
>>> +	memcpy(&sof_mt8188_ops, &sof_mt8186_ops, sizeof(struct snd_sof_dsp_ops));
> 
>> Never use sizeof(type), always use destination var size! Anyway, there's more.
>>
>> I don't think we need to perform this memcpy: we'll never see an instance of
>> both mt8186 and mt8188 drivers on the same machine, so you can safely just use
>> sof_mt8186_ops for mt8188...
> 
>>> +	sof_mt8188_ops.drv = mt8188_dai;
> 
>> ...which obviously means that this becomes
> 
>> 	sof_mt8186_ops.drv = mt8188_dai;
> 
> This does have the issue that it then means the ops struct isn't const
> which isn't ideal.  It's also not the end of the world though so I don't
> have super strong feelings.

We do the same for Intel devices, we have a common structure which is
copied and only the members that differ in specific SOCs are updated.
You're right that it's not constant, but it avoids copy-paste of a
rather large structure just to change a couple of lines.
