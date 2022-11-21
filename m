Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AF76325D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiKUOap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKUOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:30:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA8659853;
        Mon, 21 Nov 2022 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669041041; x=1700577041;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fgsfp1QjL5Ij2uQspSK/Kx91E8c4lvJ8zhkiN0CY/Pc=;
  b=MAGqII5YU+mYZ/3mSlA9VQUp/6V1fNyHwXbhEd5BaoYWbVFTkIf9mn0g
   QoVZ9nijuXyotq7DdJXFID7gmVQ4q9xqs2QLlnioT5P005A8Fcg5zYBUt
   49N5YaERWsBpeHb1RuQ8wDLdQf9CPnjdj/z/KKYu/JYBiVhbxUtJfuOlg
   vHDNGPVkinGfDAOSnuNPWr0k0DeLhGPBLXN19kGbgJ+SA5SaJ48IBkLsz
   DMhMw/9uHXDCgf54nHn9Ts6I5DJsKzdvPwWeDUwY7mDOOAqApv5bb4j8s
   uapbHsVmnbyC5aMDb9Qbqbkpg2mdKArlbaUHvuDCRFevhvhEVnOfsHxtB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315389680"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="315389680"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 06:30:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="815730077"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="815730077"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2022 06:30:40 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 06:30:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 06:30:39 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 06:30:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FO3orFWlgX4PE8RVCs6uX6sSI+kNkf8VyAciTz53cYqGSFBAhzGXwg6O10DuvKoafyi4aQDl3gjsuAQN0lub5Lhs22U1yxSAYgyyyDrSEe0ga4vtwL1DFgesuSJ55/myJvtTFLHGenPJFdNsIcPrV/Wn1zwKGJKTACw7un2zUQz4l39CVh5V6D+ydNSOMK/yFYTGrf5LWxjutOeLWFtTODrJg5dWjX678LGsH+KgvhehZUScdiwDWnyEuUQPm34Z6OD1am9ldLsneEs2DSd0e1MSCoasAz72oX/7R7XwY+DU+OwSYAko6rEnVoOSq0nilO//OGia4zV6Q2Yowl9Lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3oFw6Q0la0jIv0d3g+xne+kiXz9wQItBCX4t9pVAlY=;
 b=lPVrKZKqsED79AArxWQIiLOi6wjBYn8TNt9g6VZwyUNQyZJzuUEkP3wyZop06+4XzpQJR1cOHYX+iEk3eOx+qFQkbITppoIR3iEDFZkoj+7uDXrLA26ppr8lSmidAoWWeq8ZbK2QKaPFkFj/mLxinGq/cudfeEVmaCGatOv+zC/jXwh8BuHCtznCvo+IeLsBbCpuJ10DHcjVBWHqDkLP5X4mfHMWv8qEZcTSc7xU1zy201K8ux3VHcbAoMDTpi5MXTQIiBh46seMkJuJ7dJ9+IpqK+fO+ojy17D4yDyGkuz1ZA9bJSBqmiQeqGHlVLCB+TUu4ldaxg1592cFczXAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 SN7PR11MB6828.namprd11.prod.outlook.com (2603:10b6:806:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 14:30:38 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::1821:24fc:fe2f:16d7]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::1821:24fc:fe2f:16d7%4]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 14:30:38 +0000
Message-ID: <bbaa53e9-dd83-38f8-6f55-4d87ff76556b@intel.com>
Date:   Mon, 21 Nov 2022 15:30:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ASoC: soc-pcm.c: Add NULL check in BE reparenting
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <1669035895-12036-1-git-send-email-quic_srivasam@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <1669035895-12036-1-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|SN7PR11MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 609bc04c-a814-4554-8bf8-08dacbccf580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWVILqW9uuJguB+cKFpXmXKUAw8Za8rHl59cD6JPiXkBCLDEZvzqSilrcM+mnhb6InneTWmCZ8LzEp7opj+j0yOmbBWdySG4QQ6/u7yH3eoYLuQOdyVt4r+VmFcAqGr16D8b5lyesC1gtIf/izd9/H3Yf3pdM9i3q9+B50EYxuRygZXuR5OXEnHVGxuf3uzx4W9PnI1SHmJebwWdtUnJAqgIOSGaanLpxK2w6/SBRF2xNHVdovmiTsYSyLo9kS3pyzKMvgd1OoUUcp91boWJf+IGF5+yZ4oyus+4gFv2UjkpbN9976nRJmyGhWz7JtLq8WDdUWKs/NBexotmXaEfbBr9JjjqHflLigZup97KmJrhMUqLF9hgl7C2ODTsbXme0klEsuDRzTg9dMgSEqTvWfaaU87vZCrKwKhtn4tcWqToGCpKUR0Pt9KPBnTgHSdcpRks/1z+XJO+mGu+CYVpW840ekUpOfxy0cAbK7Ku3ZJZUnid8CYmxyDosCPR4Vrn57N7c070jkHiJfytfG4jYJ5LrzRqqMzR6xOoVwxrWLPcxoGW2+ZjZSneCawQCK1YdLKrztFT043wFmXsjvCI3ekKqvkgtjefr4LN2Pz0jj/ddLBB8oLCtHyIKjLWd2tO75JiEE+6ZupdLCc3xumg9L4M0ExOXdsQIZs8e/8mUKB/mrPrCUoQiZReFXwnBfq0CxYUZPaL22Bq0nBoSvTmKTbj5bAT2DN7hjIYKv2WWp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(36756003)(82960400001)(31696002)(86362001)(6486002)(316002)(6916009)(6666004)(478600001)(5660300002)(7416002)(8936002)(2906002)(4001150100001)(66946007)(4744005)(66476007)(44832011)(8676002)(4326008)(66556008)(41300700001)(38100700002)(26005)(6512007)(2616005)(53546011)(6506007)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGxWRnhDeTlXWVIrRDdZRTkrMzErcEkvb0J3dFNja3QwUnB6OFdUTFU2L3pR?=
 =?utf-8?B?WmRtU3FhaVRKU2h6dERhLy90Y1dSQVk5eVJGQUVkaFhMMzYvNWh6ZXZRbVBy?=
 =?utf-8?B?am5xNTgyRzhlaUY4VTVsWXRrR3pDVWFmK21BdERoZytibjhoZk5Fd3RsZW5L?=
 =?utf-8?B?R004SllwRjVxWlBVRmhGMDBDY0VnWG51MGRJcTZzZHVmdlBTWC9CZ1Z3dGQz?=
 =?utf-8?B?Q1ZjZlMzVDBjN2V0N1ZVckJQbWNJVytxSS9CZm90bVhUaTJRYnVYaGpuSEh0?=
 =?utf-8?B?eDdlWjNFaC9nZHBoRFpuVFN0QWU1T0l4cXdGWDZQd1NBSmVyTWc0cjFhM1lY?=
 =?utf-8?B?TnhRdDlHTUxsQWJEZStjNG9OTHN6SmpZT3hRbm9ZeWVWZUtNdGliZmZBZmFi?=
 =?utf-8?B?WGkyRTBrUEdJQjU5K2NxS3VoZi81K3AvR012aExhTzdBRzdzeDM4QnRyb1dQ?=
 =?utf-8?B?Y0tXK3NYM014cXRiV1VON2hsMGRUNHFZUXVKenl2Mml4YlNTMzFTNE41bUY1?=
 =?utf-8?B?Qk9Ha3dxRjJnaDlvUGZkNFFnVE9zOVNmYW5aTkJrTzBmamVUTTZxV08yZk9t?=
 =?utf-8?B?bEYxczVFTnVtaUpQTzQveGRnc0RTbEVKSzVoUisvcjJKTUYvV0tXY0cvS0Jl?=
 =?utf-8?B?MjF4UmRMQ0N3TlJHQjNrS3lWczJXSTV5OVA2clFFQ1hnb2hOSG01c001VEQv?=
 =?utf-8?B?VGRtWkdtckpraUtQVHV0V3FUWDVXVmUxMzFqWWxJRE1zYmhZeFhqdDR1dDRx?=
 =?utf-8?B?SkpoaGwrWE5lWGpwNUYxTksvenpnUzFTZUZWQXJES3NMVlpLNndjNUo0S01s?=
 =?utf-8?B?UFc5dW5uLzJ2eEZvc3NMQm0wNHVuWGhIcStrN0d3SWxsZmpuTG95VDI3UkEw?=
 =?utf-8?B?aGpRZnAyK1ZDdlNnM2VIVkdxUWxZNkZnY2E3ckt1WVB0R2E3TFFaaHRGVW8v?=
 =?utf-8?B?REp6RGNlUU41NGhWWCtmNDdsTFFUWEcreHliekRBT216YjdwVldXSFFTcEp6?=
 =?utf-8?B?dzdEM0VqK0lIRmE3UmdtYnZZd0UxU2V4RVI0UEtNcThkaTB2UHRiZ1N6VmJK?=
 =?utf-8?B?azFUOWMyMVZrdDJOc2JXYzdBV3JXWTIzUEVaUWw4aWd6Y1Y2RlljdFRBem1y?=
 =?utf-8?B?WXhwZVhBZzc4YkRlRGlRNHkxWEFqS0ZSUzdubTNhUHNxRnRSOHZHc0EyNE5T?=
 =?utf-8?B?QWQvTEZnWlE0VE1sYkM0WFNKMndpQVFRUjFNUmJ4SHE3U0FBWVM0M3FDeklS?=
 =?utf-8?B?TmdBWXBWUmtvQWo2RjZpa291ckZoNkROaWM4dGQ4TnhtbHNnMG5hcGhrSTNj?=
 =?utf-8?B?QjFPSzZPZ2lTam4yTWJTbHpCMjU2RnArekdsQldnY2hMRGZxMFpKUzlNaTFV?=
 =?utf-8?B?N1NCZ0dZK1B1cTNBRzVpQllIK2xTanNpT3JYeXJXTHlYTmJkRUxUczZoclo1?=
 =?utf-8?B?TUZlMlpSWFp6R2ZjOXRUOUFONDVPVllRb1F2bFZ2ckFHT1NwL0V2OVVGeVFr?=
 =?utf-8?B?R0tnMHdxbTdFRGVHK3N4eThtNUROdlMrR0w4U095RUR1WWEyTVdScFBUK29Q?=
 =?utf-8?B?QzJlMlBNL3JBWUl2WjZFVTRMMzFJWmJYemxwMXdEMHVuRS9aSjU3RnNnTEhX?=
 =?utf-8?B?dnJzbFB5bW1Vcm9hUTVCSGltVURyMDhEeWF0ZVM4R1hEQkRWK05DVk11b0Rn?=
 =?utf-8?B?SFB2a0UvNHFSNnhJQUtLREM1dS9YOUhrY2ZBUUdTbjh0OGxMcUdiNmhVc0lW?=
 =?utf-8?B?K2M2ZUV1Y09Nb2VxSWRkeURLUTBkUnl3dnRiVEpGSUora1ZKQTFweGNLTUND?=
 =?utf-8?B?TkJheDEwNk9pSnJEdnVtSm82UzhrRi92bld0dmNYSlRzMGRiWTlVcUxic2U5?=
 =?utf-8?B?SC9kTkdwS0w0WmNUcldvL2ZaNkFvOHJyaHZwSGFER2h5eWxMamZsa0JpQW9a?=
 =?utf-8?B?RFRlOHZtdzhoeGtGeEtleXBNV1l4QUZrSm5WVHExNUdOSFZwMG43aXRvdFRq?=
 =?utf-8?B?MldHL2UxRWFxVUh6b2xtbnlBYm51YVJaeWdDYU51cmNiZE4xNXZDQnlsNkpO?=
 =?utf-8?B?cDJyWW5UdVgreXJPR3RueVEwWEwwOEZwa0w1ZUliWERXdldNWEQxaE9BY1dI?=
 =?utf-8?B?NTJNN2xjdGUvcEJWenM3Qm5PM3A5TFcvd1QrWXBXODg1cFdlNmZuUVBvS2xP?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 609bc04c-a814-4554-8bf8-08dacbccf580
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 14:30:38.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: up/NuFH4UPdl8sY0QL8qrYqkt2yjzNazYyBKn44ninAYjQ3VHil9NGlJe8rVjNZ69w1v496nNYAM7WUwQaAWNI37+b/7n/pbAr1tNL4Q0zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-21 2:04 PM, Srinivasa Rao Mandadapu wrote:
> Add NULL check in dpcm_be_reparent API, to handle
> kernel NULL pointer dereference error.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>   sound/soc/soc-pcm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 493f003..a7810c7 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1247,6 +1247,8 @@ static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
>   		return;
>   
>   	be_substream = snd_soc_dpcm_get_substream(be, stream);
> +	if (!be_substream)
> +		return;
>   
>   	for_each_dpcm_fe(be, stream, dpcm) {
>   		if (dpcm->fe == fe)


Hello,

Could you provide reproduction steps that lead to null-ptr-deref popping 
up? Also, please drop '.c' in commit title.


Regards,
Czarek
