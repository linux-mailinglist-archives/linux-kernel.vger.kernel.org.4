Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773D668392E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjAaWTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjAaWT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:19:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF95999
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675203568; x=1706739568;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=+4pP4aZIVuYUiorSRqW2o3O3DmDW8pntZFPIjn4fwAI=;
  b=OOv4jM0oZgJOPgOVL8sIfx9eftcf8FhQ+E67IydmhTHscMkdRmpxHti+
   gxZQqfa65eYitLt/VW62oIz17Rlx/HXB1Gg2bkVHom2qPyIC4kqUBNUHD
   Up2bWGkz3ksCJsNLDL8WWXsYkm6lCppXEW/b90HVM44wV7oWEhQrGdCA7
   752SVikMDLnPWY3Wd+IkUn7WEJ+p3etBW/IAfMG6iy0WyyF+Uk/LECHyH
   kmPBCNM1UXkZxvkJpiIhju5kBJYjo+iXZSrAbzB9GoCr07cdTkWE9+ZUh
   Ef0dRIvBV/ZTDtt3z/9xH0GDmpEdurR6aB60lHxxp6VKI3xhbEbRqTqO+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="308318513"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="308318513"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:19:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="788615806"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="788615806"
Received: from ncollins-mobl.amr.corp.intel.com (HELO [10.212.85.244]) ([10.212.85.244])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:19:26 -0800
Message-ID: <fa4cdd91-b430-eb1b-a151-d144f62e827d@linux.intel.com>
Date:   Tue, 31 Jan 2023 10:00:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mario.Limonciello@amd.com, arungopal.kondaveeti@amd.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
 <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
 <257b6f1e-f403-573f-3978-13ffb14342ad@amd.com>
 <2b4c12ce-2586-0277-ede0-560f8317e4e4@linux.intel.com>
 <27eabbf2-eff2-0964-b72b-f9db251c3b57@amd.com>
 <87ddd91b-fb5f-4f27-942b-dc439b32ce20@amd.com>
Content-Language: en-US
In-Reply-To: <87ddd91b-fb5f-4f27-942b-dc439b32ce20@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 07:09, Mukunda,Vijendar wrote:
> On 16/01/23 13:32, Mukunda,Vijendar wrote:
>> On 13/01/23 22:41, Pierre-Louis Bossart wrote:
>>>>>> +		if (is_dmic_dev && is_sdw_dev) {
>>>>>> +			switch (acp_data->sdw_master_count) {
>>>>>> +			case 1:
>>>>>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>>>>>> +				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
>>>>>> +				break;
>>>>>> +			case 2:
>>>>>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>>>>>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
>>>>>> +				break;
>>>>> so the cover letter is indeed wrong and confuses two controllers for two
>>>>> managers.
>>>> ACP IP has two independent manager instances driven by separate controller
>>>> each which are connected in different power domains.
>>>>
>>>> we should create two separate ACPI companion devices for separate
>>>> manager instance.  Currently we have limitations with BIOS.
>>>> we are going with single ACPI companion device.
>>>> We will update the changes later.
>>> Humm, this is tricky. The BIOS interface isn't something that can be
>>> changed at will on the kernel side, you'd have to maintain two solutions
>>> with a means to detect which one to use.
>>>
>>> Or is this is a temporary issue on development devices, then that part
>>> should probably not be upstreamed.
>> It's a temporary issue on development devices.
>> We had discussion with Windows dev team and BIOS team.
>> They have agreed to modify ACPI companion device logic.
>> We will update the two companion devices logic for two manager
>> instances in V2 version.
> After experimenting, two ACPI companion devices approach,
> we got an update from Windows team, there is a limitation
> on windows stack. For current platform, we can't proceed
> with two ACPI companion devices.

so how would the two controllers be declared then in the DSDT used by
Windows? There's a contradiction between having a single companion
device and the ability to set the 'manager-number' to one.

You probably want to give an example of what you have, otherwise we
probably will talk past each other.
> 
> Even on Linux side, if we create two ACPI companion devices
> followed by creating a single soundwire manager instance per
> Soundwire controller, we have observed an issue in a scenario,
> where similar codec parts(UID are also same) are connected on
> both soundwire manager instances.

We've been handling this case of two identical amplifiers on two
different links for the last 3 years. I don't see how this could be a
problem, the codecs are declared in the scope of the companion device
and the _ADR defines in bits [51..48] which link the codec is connected to.

see example below from a TigerLake device with two identical amsp on
link 1 and 2.

   Scope (_SB.PC00.HDAS.SNDW)
    {
       Device (SWD1)
        {
            Name (_ADR, 0x000131025D131601)  // _ADR: Address

	Device (SWD2)
        {
            Name (_ADR, 0x000230025D131601)  // _ADR: Address

> As per MIPI Disco spec, for single link controllers Link ID should
> be set to zero.
> If we use Link ID as zero, for the soundwire manager which is on
> the second soundwire controller ACPI device scope, then soundwire
> framework is not allowing to create peripheral device node as its
> duplicate one.

I still don't see how it's possible. There is an IDA used in the bus
allocation

static int sdw_get_id(struct sdw_bus *bus)
{
	int rc = ida_alloc(&sdw_bus_ida, GFP_KERNEL);

	if (rc < 0)
		return rc;

	bus->id = rc;
	return 0;
}

and that's used for debugfs

	/* create the debugfs master-N */
	snprintf(name, sizeof(name), "master-%d-%d", bus->id, bus->link_id);

as well as in sdw_master_device_add():
	dev_set_name(&md->dev, "sdw-master-%d", bus->id);

can you clarify what part of the 'SoundWire framework' is problematic? I
guess the problem is that you have identical devices with the same _ADR
under the same manager, which is problematic indeed, but that's not a
SoundWire framework issue, just not a supported configuration.

> If we want to support two ACPI companion device approach
> on our future platforms, how to proceed?

Well how about dealing with a single companion device first, cause
that's what you have now and that's already problematic.
