Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B261F512
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiKGOPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiKGOPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:15:49 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A206C19C2A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667830548; x=1699366548;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zp9d5lmlEwYQNB/2LUwcFa0f7+iSm6v+/s/K1TzfYyg=;
  b=NpMklCXeviOjTnFPQ5IoCw9wVBORj45ztcNz7LHJv0s/YPDYsRIJg9pZ
   gYlhOCt/zdFzDJFxiMJ8Dz8yCZ7m401nXMqbdIXEO5UJfeQaEy6hbdFJ1
   k683onLBS7UqpYh8CWbAE6jaPEJ9JfPqjUS6osKn5lHg/o4g9e5f8i9d5
   8XM0oF4ZNhmIBdvXDvnyCOfsaDxoMlD8vpn8DBiETV7PQwd+pU7cpP4vs
   iAK8UKErilt7SOS9/1cjQTREQuPAQwlZE1CgLf2xCKqiJPYRNjGnSbK9f
   DpCaoJCTkVfx+FfO/NMSdwsEfQNukGq504vvno+FvPVpGeATQHsSpTJXi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="297911313"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="297911313"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 06:15:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="965162794"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="965162794"
Received: from seanabue-mobl.amr.corp.intel.com (HELO [10.212.82.80]) ([10.212.82.80])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 06:15:46 -0800
Message-ID: <dff6e7af-6a07-587e-79d0-706fe7ec6504@linux.intel.com>
Date:   Mon, 7 Nov 2022 08:14:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH] CHROMIUM: ASoC: amd: acp: Add tdm support for codecs in
 machine driver
Content-Language: en-US
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
        ssabakar@amd.com, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Venkata Prasad Potturu 
        <venkataprasad.potturu@amd.corp-partner.google.com>,
        Vijendar.Mukunda@amd.com, vsujithkumar.reddy@amd.com,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20221028103443.30375-1-venkataprasad.potturu@amd.corp-partner.google.com>
 <Y1u1vj0K3m33wCTd@sirena.org.uk>
 <b384e012-31c5-8412-8b05-cd026c5d6a0f@amd.com>
 <Y2EttkwUvMReQcqg@sirena.org.uk>
 <ca006546-9b0c-34df-2a33-a4f10b68f815@amd.com>
 <Y2JVWmJsprt0xnKH@sirena.org.uk>
 <7b97682d-5cf1-8be1-9c62-41c9fbd89018@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <7b97682d-5cf1-8be1-9c62-41c9fbd89018@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/22 04:34, Venkata Prasad Potturu wrote:
> 
> On 11/2/22 17:02, Mark Brown wrote:
>>> On 11/1/22 20:01, Mark Brown wrote:
>>>> On Tue, Nov 01, 2022 at 03:15:08PM +0530, Venkata Prasad Potturu wrote:
>>>> Right, that's what the code does but why is this something that should
>>>> be controlled in this fashion?
>>> This machine driver is common for TDM mode and I2S mode, user can
>>> select TDM
>>> mode or I2S mode.
>> Why would the user choose one value or the other, and why would this
>> choice be something that only changes at module load time?  If this is
>> user controllable I'd really expect it to be runtime controllable.
>> You're not explaining why this is a module parameter.
> 
> Different vendors/OEM's use the same hardware as one need I2S mode and
> other need TDM mode, using common driver  to support  I2S and TDM mode
> with this parameter.
> 
> 
> static int tdm_mode = 0;
> module_param_named(tdm_mode, tdm_mode, int, 0444);
> 
> And this can be runtime controllable by setting permissions as 0644, we
> will change and send next version patch.

kernel parameters are difficult to manage for distributions using a
single-build. Either all platforms use the kernel parameter or none of
them do. That would not allow a per-platform choice of parameters.
Using DMI quirks or ACPI identifiers would be a lot less problematic, no?
