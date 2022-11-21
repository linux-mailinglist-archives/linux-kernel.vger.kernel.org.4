Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC2C632134
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiKULtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiKULta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:49:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4D521830
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669031369; x=1700567369;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=34EEevpTblP9ayUMx7Py/r/F6a3dUsWad/otXLxsswg=;
  b=YDIDdmyyxzsWMlX2WDCfd/BcS0/2XBEt7vpdExkp8z+2/XKdIR5f0fEK
   3H12sFPURDvF7VBJ6p5nLfTNKoT362apA+kPgfiTOuoW6JmawKVqw+tLM
   IFrI+r3gOpjxtJWxyiQA2pd7u7FlsVhC15iyVw1uadrnHeLX0TGfq/xEN
   fwdzLjm/VBdIQouSb1JEyFIY/jb1p8Ev/adotrRgeww41xdblfhEwNLgq
   VzcriSdu2MTFgau8FbZztJkV+NlX6M2tjPMjyiLq9XazLCaEP0HW0eo+Z
   RdLLcXizI4ZLC3FxLC43PSyNwo8epcLXzGO2IgZLhYEZfMrRRoRQ7ZvI8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="340397236"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="340397236"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 03:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="709778676"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="709778676"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2022 03:49:28 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 03:49:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 03:49:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 03:49:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSyCDzo/MLQGA6UOU5z646US86YPooanIEIyrSbrjLzhCNZJ2E8xkbqwI3j51burIfRFrWv9ejxQYkCusukuv/Qhhk74c0TRQuMYgqisLZOlOyZVz17UwD9IOQyyE8FNyk8QUWOkiZoMtdK1Nbsej4zhDllaiOd3ubQ1xlwVLeEKTL93Dud9uRgj1nOZgRNSkZTJryKc4r1ClTLK1Qoji2foiFq28QazDVslVgbdl5j62EARVnng+7SZX+RW6WlM6eT3ilFzU/IWVfCCzCdEoohYAjF9uVeZenqTorjUKDdALfioK+VVuuqgi5nqeyBpZsqfpLU3N2c8hCnbyZeoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7bF0rsoq2d0c1Lo2XskA0ksMNAtY7OgJfZ/8pUmbsY=;
 b=PPPCD4JEfjdzeoiJ1zlSLYWUrtZ00tKUPd6qtC8kocwF+IpJFfJXQkSqM5CWe5uRaf4XtdSlx2CO/0zWevyL3eOTS27dGs8XXToRnoTZV+xI71JbeAY+7UZoLw1JTecG7A4YTLwDxIuMiYQJ3LScdq20irZYeuZN5Ca/rnzxEEcA5eDyjd1eONoR1oeqf++B8+RWjmBgzjJt59ZDeDmhrhVvL0++iKmH7fd5r+y2XKeYK8VSY/l+keY4UP2SvdpjvRUqLypQS86IORZcCC/E479KRDiLigEFnvi5yV3dpAOTdYbZ1z5UUbK8MAYQ22lZaPSdR/BKCirUHqOE2mQoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 SJ2PR11MB7647.namprd11.prod.outlook.com (2603:10b6:a03:4c3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.11; Mon, 21 Nov 2022 11:49:26 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::1821:24fc:fe2f:16d7]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::1821:24fc:fe2f:16d7%4]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 11:49:26 +0000
Message-ID: <9d01e43f-62da-5413-e76d-f12b72944d08@intel.com>
Date:   Mon, 21 Nov 2022 12:49:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ASoC: Intel: Skylake: Fix Kconfig dependency
Content-Language: en-US
To:     <lili.li@intel.com>
References: <20221121104742.1007486-1-lili.li@intel.com>
CC:     <tiwai@suse.com>, <perex@perex.cz>, <broonie@kernel.org>,
        <kai.vehmanen@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20221121104742.1007486-1-lili.li@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0126.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::23) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|SJ2PR11MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: e37e6ded-8975-4921-d815-08dacbb670ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3G21XrpHVNqk4lgprG7ENUyyKcrYZ7zH+bU4RGkqla31iD+tmtDw4A9A/WkbU6J2Sw7BqybqBes710bVODd72HKBqRdpDKBoscJfscJxJHE1rd/0D4ZzFgfwOiq4oTKExJshqTkj4b73mi8Dn6rCgn8yqh1Mw2oHkOH4lnIqlQoiPCqpA8DKG360al1gv2y4njsCAuFfitxDq6HXlhIjvadw33Ikz1dUL1YFkWRn4efPWzBe8lZ1T0Qhg6VEWC01kkfIp04V1db1AKH0egIwb1sjYvWew0OUbu25QbAzisOCtQ5AlHFjv8NUMC5Q7o5mb4TCC5ivXlbFT4TuByyz2sQpHc402IJHT8mz5uRBnNATR+CB3XGibohgX5ObKUwcDi1XBWGQWO7bJZ5CtDAeBuuO+WUtwKKLjtNBOFj2IyHhhVTbat78Kijhpk0iU+5l4w6S2IYYe9/VYThCuIMGJqyqDymIJOyzng+qIU9OR3OG3UANxnbhkHfSO/LTwgBK5siIltSYGn6YeeZuDwRUnWR6jpZALTnrCMxzq+iwnqMFBRVRXA1phO3UY54Yc+G/+2F/SQmuX89lMPKKtZmO9Djra8bVUWHYcwoaDZaCVXzVT67VJwKlMOY5OVUr/PojZxpITdu3kzywIvk3BnVg5C1vf70O/5a1kA1jttNHo1h+GkuWyCvn9zGGoIfBJdQ2hTuUnxcBQHrh5n0YtFL0QvgSm6NRwkJGTBWm2lDLJyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(86362001)(31696002)(6512007)(66946007)(41300700001)(66476007)(66556008)(36756003)(2616005)(186003)(8936002)(34206002)(4326008)(5660300002)(478600001)(6486002)(316002)(6666004)(26005)(8676002)(44832011)(82960400001)(6636002)(53546011)(38100700002)(6506007)(37006003)(83380400001)(2906002)(4001150100001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRxekpTd0hhdUJJRURuN3FucUIweE5LRWI4NkNUT0kzNHMzQkcvMmhyc1Q3?=
 =?utf-8?B?QkxHalBaQ0VPbEx4UE9XdFd5S3JweCtDWG1XaVBYMVJ4dlM3VzBDbmRCQzcz?=
 =?utf-8?B?a2QwbUpZc1ZESmlzZ0tQZmRCbldEL0NpYzVsNTFBRVZTQnczbTF4ZjFKOWhj?=
 =?utf-8?B?NlJGRTlhQmZmMGk1K1hIamZQaXQwU2xQaHE3UkYrSGVsZVdaV2JTdUtnN3Jy?=
 =?utf-8?B?UmNvNk11SU5vZzZ4RTZ3eDZhM3BweDl3bzE3a0JNY2EySThrZXhUVHNZREZQ?=
 =?utf-8?B?OFlPZlptSzRUdExZbE5UT3VFd3IxdlViOFZVNitpVlF6RkUxK2ZveXhwb3ho?=
 =?utf-8?B?elZPZUQ4NGhDS25KWmp0c2tNbUE3ZVJHdzZ0emtaZmw2bnE4bFZKNE5WK3dw?=
 =?utf-8?B?ZmlXRzN6QkxmMTB0MGVaemxDRGp1V2tzbE9CNnFsanFuSWdqcEdvbHd3Yjdu?=
 =?utf-8?B?bzQzSHAwK0RnSTFkczlLOUhkQ2F3VFZGMG1yUzdrbFV5b0oxWHFSSnhaaHVV?=
 =?utf-8?B?N0hRTW5pdXRmNFdpWUVhV1IxcDFKRmFnVlZEMHRYa1J6VFNWQXE3TTgzSlRR?=
 =?utf-8?B?THVFSHFTYm81aWRYeFpOS2F4N2F6Wi9heUlnbkhXdk1Qb1RBdWYvSXk2NXdJ?=
 =?utf-8?B?bG83bC9sNGhnaWV4QlZUSUE4c3NwMG1sOU9aRjNDQ1JxTkJlYldtYU1yaFpj?=
 =?utf-8?B?ckp5YnhzK1JGZ1cvbU1uaWxVSTE5SFU2ZDQwbFdycm1aUDJOSVpZY29qMlhs?=
 =?utf-8?B?UTB6cGEvYjgzcmFNY3lzVmRyZEduM1gzOVQwUHR3Y1dvdkgreVFrSXZNdmNF?=
 =?utf-8?B?WFNCOUJLcFNMK1pydnh1cVhZUkttK3RpbDAzck1YQUJpOGNoZTE3YW1MZnRl?=
 =?utf-8?B?SE1QVDhqaEFlZWczc3UzK285Mm5nYWVKd0ZOYWhwT3lxTjdFelNwVk9iWGF4?=
 =?utf-8?B?WWQyTS9KSGRmNlFCYkRRWnRsQVlFeklIemdtTW9SUitqRk0rZmJrOGphbDBJ?=
 =?utf-8?B?RFZxZGxIdDAzKzlLVmU3dnN1dExiZHZiQWtGbHJoSUcrempEcHdHUFZ0d3Nz?=
 =?utf-8?B?cDkrVVJTT0VuMzk1Nmw3SFR5ektqNUVlUVlJcXhlS3hBZm10bE80ZUQwdldu?=
 =?utf-8?B?Mmp6RFJFOStqVVFXNE1ncFZDWjhKRHhTRWdMK1lqaXVHRmM4aU84M0FqSkFC?=
 =?utf-8?B?ZVlpS043R2ZJNFFnMjh1TmpVZFZRM2NRMm8zdk9JWTlwdWluZmdOa1IwNVBt?=
 =?utf-8?B?bG9qc0JjUEdLVnBxR2RWVm94VmZnM1ZZM3U3c2tYWDNidCtaQUtoTzN4aEtS?=
 =?utf-8?B?VE9tWDFZRDdPZml0M1hqZStoMVZ0ZXEzL29ISmNkUVIwaW5ySWFyVk9mdW8z?=
 =?utf-8?B?ZE52UG05ZGZwSjB2NTMzK2o1cElkaGloUG9VN1FzOXJpRXUwV0F6S1IyUnlJ?=
 =?utf-8?B?RXZNTTY1U3JkdW1RUEd5ZGtVNlFrb3c2TTlyY0NqeHpoMmoxSUVqelE2Z2ZO?=
 =?utf-8?B?V25pRGdVaW1nRDlHdVBIcUNZYTR0UXpTZU0yNVlmTVVIbVgxdW04MXNaMVVF?=
 =?utf-8?B?OWRoMmNIYUg3V2kzTEp1TStDVUxqVXVTL0hVMFphVUV6dlpLMUoyd2tVbHQ5?=
 =?utf-8?B?QVozRU9jTXQ2Z3lJMFR5UVBzWlYyY2pScXkyei82eWc0bkNwcXJzWWFnRktO?=
 =?utf-8?B?TS9ITHpOMHZhbGhyTk1RSHZkN2t0QVZ5YUNHQkhyVVIxcC92K3Y4WkNiMno4?=
 =?utf-8?B?ZURZNE9iMXg0S2RqNGxqZEIzenBwUnlEVFFPZ0pVeDlYdExGNWxTeTVCL0hE?=
 =?utf-8?B?YU1UYVdMRlpKa1FRSnpWUVI4K09yUkJ0TjRYSXdMS0EwUE5TdmhnemVFOFVH?=
 =?utf-8?B?bm16cmVXTHdsUVVhZVowbUJFLytidTFQaTdCZTgxekhoa1hyTFc0WUlsbzZJ?=
 =?utf-8?B?WFlDOWxxbXRnWmFuMDBNVHZBeExEMVVQN2JnWkNyNE84Q2FNMHM4QzE3WHJK?=
 =?utf-8?B?OXBQNTFQeFU2bXNlaEoxeG82QXE2a2ptS2p6NGhGRHZLMmtmY1U4S1dLdVVU?=
 =?utf-8?B?bGlkbHB3ak96VFpVdCtUOGl1NG5la0VIbWdTKzF2bWg0QkdCL1p6amdjRkVE?=
 =?utf-8?B?OFFEZkh0eGVZVmxxTlo3VzRDOU83dm5VMm5ITDRBL283aklPZE1rak9SZEdP?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e37e6ded-8975-4921-d815-08dacbb670ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 11:49:26.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZ/Z1UnebxYnUDW/T0+LFSYxLyoW6g4CPQ3exlujV1lcURARNa8aRbeJwNf647wkRPfa5I4Z22Kgf7uwdVJmmz5Fj6URabEYyfhD6irZoW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7647
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-21 11:47 AM, lili.li@intel.com wrote:
> From: Lili Li <lili.li@intel.com>
> 
> Commit e4746d94d00c ("ASoC: Intel: Skylake: Introduce HDA codec init and
> exit routines") introduced HDA codec init routine which depends on SND_HDA.
> Select SND_SOC_HDAC_HDA unconditionally to fix following compile error:
> ERROR: modpost: "snd_hda_codec_device_init" [sound/soc/intel/skylake/snd-soc-skl.ko] undefined!
> 
> Fixes: e4746d94d00c ("ASoC: Intel: Skylake: Introduce HDA codec init and exit routines")
> Reviewed-by: Junxiao Chang <junxiao.chang@intel.com>
> Suggested-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Lili Li <lili.li@intel.com>
> ---
>   sound/soc/intel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index d2ca710ac3fa..ac799de4f7fd 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -177,7 +177,7 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
>   	select SND_HDA_DSP_LOADER
>   	select SND_SOC_TOPOLOGY
>   	select SND_SOC_INTEL_SST
> -	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
> +	select SND_SOC_HDAC_HDA
>   	select SND_SOC_ACPI_INTEL_MATCH
>   	select SND_INTEL_DSP_CONFIG
>   	help

Thanks once again your for report and input.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
