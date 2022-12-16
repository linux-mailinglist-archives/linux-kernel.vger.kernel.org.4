Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C703264EE8D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiLPQHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiLPQHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:07:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40723264AF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671206763; x=1702742763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l7H2yfCs/IMIVq+B/pOD2NdX6bHZs2ePX/ftqWatWlY=;
  b=bui6Ly9JlJtVDx9t0XIDBp/yGOfSDPGlcPu0+9Nvf9z1sNwkThH3iuAi
   uQ9qnHFarqLM3VCaL1BheriQ4OiSfqGj8yIZ20UiEpM++/ObQ+wuuNWK7
   KIMgYAzye3QAa50NoooKWrX8mwXc6XD0im4GXoJONOTGNAUxTcy60e5Wc
   wiyJhaGcTq3CVO/R8TM9bI7xr4OXGPWqhkDWB1hj48Z548sgntaP36P41
   PQBQQaXJEiJJeq2uFI+70nKUHLqHgxY3FXmj7hngiN125U2tq59QPkIA3
   yEtdbfXBsUVNbL7mr2XXcLcPOhL3GfOqJ+gPpGBzLUWZjbX6T8dgbvAkl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="319049000"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="319049000"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 08:05:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="627594959"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="627594959"
Received: from krojasle-mobl.amr.corp.intel.com (HELO [10.209.187.31]) ([10.209.187.31])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 08:05:47 -0800
Message-ID: <f479858c-b7dd-5af6-c0f1-c119737a7cc0@linux.intel.com>
Date:   Fri, 16 Dec 2022 10:05:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2] ASoC: Intel: sof_nau8825: add variant with nau8318
 amplifier.
Content-Language: en-US
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-kernel@vger.kernel.org
Cc:     Libin Yang <libin.yang@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        David Lin <CTLIN0@nuvoton.com>, alsa-devel@alsa-project.org,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, Yong Zhi <yong.zhi@intel.com>
References: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
 <CALprXBYwNaHCe+EO9G_SvWg2HNVAz62KzaaxGCb1PssJshXUzQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CALprXBYwNaHCe+EO9G_SvWg2HNVAz62KzaaxGCb1PssJshXUzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> The v2 includes:
> changes from v1->v2:
> * Modify title and add explanations in commit messages .
> * Use new topology file "sof-adl-nau8318-nau8825.tplg" instead of
> sof-adl-max98360a-nau8825.tplg.

You can add those directly in the patch, below the --- marker, e.g.


Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---

changes from v1->v2:
* Modify title and add explanations in commit messages .
* Use new topology file "sof-adl-nau8318-nau8825.tplg" instead of
sof-adl-max98360a-nau8825.tplg.

 sound/soc/intel/boards/Kconfig                |  1 +
 sound/soc/intel/boards/sof_nau8825.c          | 23 +++++++++++++++++++
 .../intel/common/soc-acpi-intel-adl-match.c   | 12 ++++++++++
 3 files changed, 36 insertions(+)
