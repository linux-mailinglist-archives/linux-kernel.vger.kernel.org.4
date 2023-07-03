Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4334E7460BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGCQdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:33:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE4EE42;
        Mon,  3 Jul 2023 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688402016; x=1719938016;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=42J2/+XnPzPOz/j0aV1Z28B9IF4iNCgxeeKMyARJLK0=;
  b=QFJKpxeTS2uQf7rgj10Ib7/zhVOOZz8Ik7O0T0iS2JOAv5edyIhAeP8M
   aNWlp5ZRUljlY5Gl72/30jltiYkp4rC4Zc97TBK6xLS8bzjZNdlCPXMjS
   oB9GecWH86zT2gI8dhk9ticnZz3jnDv3hsgrOfQzEHKkItM1/A4M8O69R
   syExaHiSJTXgPmdaRvTmjZAlrO3qQgthnd/XhxPChg9TWOGjQpVAySnOH
   AcNCQXIbQCy6qySmIBiHiHiH9gbL0tUEP6v0ZWYN/ER1glW7FsKszPPwA
   iQc5wRNgz0F4X1AVQCKhFhCil7n5nxPuNSsGHyHoswRWo5Q3hWWs1iEGB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="428964173"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="428964173"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 09:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="788581711"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="788581711"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2023 09:33:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 09:33:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 09:33:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 09:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO8UNSC0ZLozNizFipv9v0FE0nU8Yk/tt2Xw7dufpVNIaJjBo2lWnIdOfxzGCT2ERRO1xqC7Fx35Fgw+1oILIk+LHGVUrUDdYph/4f2wh4wxvjEsgLIgVDvg0jytV0qHzDxWHZrMdut4aVLTAOUv+pHs/229zYkTyUbK7Hh4TVjjwxr3EzTrm5miEXi1E7HZFzRXKD0/559ZV6CNfpVHPM0r4cVckT/JyHtoxv1W2ovqVi9N0fe32/OgXMlIN6zdtPMIJPIF/O9wjJl3XI5CbGugjAD8b1LXIxWUm+M0B8RRpFN8kLj0PFzjq8YlZgQuEyc80r5ynonoT3Iw9vSjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qso28H1PwRjYkFkA1Jdd4fyZBcVEyj0CR8p1SOd+NKQ=;
 b=BMzawAxG2VhbpdnbowjqITNZ2wZwsvbDxCQIExlVh5QMbkLOCNCYerlPVusn0jBtidA+nb+kxETUVKrUZpnwK9keCBgaDQWfzsliMy4+ihQRP5iNBSDxJL3xoIiBvh+wM7XdXbnnRyErVmHNdi+wlHVinYV1e7fqfuFZgnUKoOFyUliFKxIUaKM6+tnaaPX0KCaLcKc+GVt1sF3ws2UlLZZWT1hUN9d726rmovBpJtDzG+AobysLsiWHI2bwXNvfs0DEwO/9oAemB/7/fFuuLHeUiVFKcKIMP4gbE8//wGuUhtQav9sotMs56flADuDSeo1mo43FykzLHoDroFiL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by LV8PR11MB8605.namprd11.prod.outlook.com (2603:10b6:408:1e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 16:33:27 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 16:33:27 +0000
Message-ID: <b6501c25-e40a-ba84-734a-577da0c2ab7a@intel.com>
Date:   Mon, 3 Jul 2023 18:32:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [net PATCH V2] octeontx2-pf: Add additional check for MCAM rules.
Content-Language: en-US
To:     Suman Ghosh <sumang@marvell.com>
References: <20230703095600.2048397-1-sumang@marvell.com>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230703095600.2048397-1-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::16) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|LV8PR11MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: a0274878-c4df-427f-7ada-08db7be33a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ROJ1VjpRuS7HpA7ypiV6PST3t6tkfzBVUOfl9X937tYwBrM+P+1zVuFPmVOq5TzGOOEjAPDpxphZ2BaHF9HESd1UKRa9JtKsE+IJw+5jrhbPy3zWR4oQ9fIglICGQ+dPxkuATlRLtj/u90ZS3MTXM2R/hallYJkC3ZGVILTEsuoOXjgXqWGN7YAG47uXn3o9ggg+betmq1TvvD659lDUQE4GvLYHlfGxnt9fd60of//g0W0G/EYm8V7R1RUr7DrBj0ASzhByZlCKUJTQwr8OBzYIWp9DXRQshNpyPio+XqYLvq4LGq5uceM8ad7CxNY32vWP86o40R5ORMYm5JNFY1AIS97qmQfa5OoI9pOA/sJLGBZgocRpq39l/BwtEHucD8n63D2bwXDhcwCJp++VPEd8OpbkEB905SPIbtT5g8tOK3NXVznBetRTErVthBNKHV7d/GA4bntiNQGWCm/5395tES15sXb99lwxr3ALSIlfDG4P3yBgdoJktq2yKAIIfQnN6NGZEWPnKKwo30qYk1D38hmcKkWAuLu1SjWBS71jJ1ukRgYMQfw4C+AQ+cs7xkOVe61TJwZ0nzPNSq6mPE3F44LQT+MWJTVsVuxGUr+E/IOSS+bAWQh3aix2UEQn4SOKrxbVH844X4YqtirnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(41300700001)(4744005)(38100700002)(6666004)(2616005)(83380400001)(82960400001)(6506007)(26005)(186003)(6486002)(6512007)(86362001)(31696002)(478600001)(316002)(36756003)(2906002)(66476007)(6916009)(4326008)(66556008)(66946007)(8936002)(8676002)(31686004)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJFWjVjQ3d5NU91alROcmwvc1Z4YkdRdk9tUDl2MjBMSHlSMUE5UVZjRlVh?=
 =?utf-8?B?V09DbXRXN1pDRmc5SVl0UC80YVRtNHIxR1dyMXI1dFdSQTdxUitlZ1REQ1V5?=
 =?utf-8?B?dmdjVWI5OHFSVEZoaW14bHZlMGhqSm05SGlDdXJkZmJHR1l2Q2NwenNlN3NZ?=
 =?utf-8?B?MWRHQVNKYkdQTXRmZVJjMEpZNkk3QWxHWlZYdUlIMnBqNm4wak9uRGR1Wktv?=
 =?utf-8?B?ZHlVSTVMYU9velFoRTYyRjhqdjc4Y1JZU1JidUFsRTJtT2tldkxRVEltaklr?=
 =?utf-8?B?Ty92bElqN21VcDdNb2RUWE8xL3ZSeWhrM1hvcmtnVUN5ckFmNWVaSTJZMWJV?=
 =?utf-8?B?QkMyNW5MTWt5WmVScWdEOWVkNXYrR0dqTkxXUkdSMlhEWit0NXVDWWVaSzY1?=
 =?utf-8?B?eW44eWtGNjBLOHRERnlPb2pVS2MrVytiU1VCRTk2OEZ0SXk5bG9vMmROMDJE?=
 =?utf-8?B?QUtSbm5mWlFRNTNqVkl4OU54NWJPajhNLzROa0U4MkdDdE5KSml1MTlCNlJw?=
 =?utf-8?B?bVRYeVF2NVdxbXp5cXJaYXFxV1ZxOGFoSWFGUUFxOHEvbFNkSFFDNHlMWmhs?=
 =?utf-8?B?VGtSZzNPa0tpVjZqNVJKM0Fyc3QzdG1vekdKWis0dDNadCtqd2lIejBkWFRn?=
 =?utf-8?B?SVBuc1o2Q1pYN05KL3BSaC9xaDBITGhYWnpWeXVBdDIxSTUxQnpScmVEcHZk?=
 =?utf-8?B?MmtQOFlXcUdYRDRvSC84dEtBVkJTQkt3Um5Ga2gwRUhYWVVmR2NWcms4V1pP?=
 =?utf-8?B?S1VHbDlpbGFuaVEwWFhHa00vYWhaOWRKY1hKUFEwQWdTUzFXSitMR1ZWUURr?=
 =?utf-8?B?UWlEeVBpYzYwT1UyTXVSS3hNa0ZJdHRRZDhIU0IweDlISW53TldrMEp4WUhI?=
 =?utf-8?B?RGxYR0swbG9CVHVnL0RGcWorTWtxT29YUnJ0NzQrTTY4NjNuL0NVOWtObVRa?=
 =?utf-8?B?Nk1YSmlSS3d4alZRay9qdVc3bkdRMjVZSitKd05aZ0MvL1VCNWNGazBtZnJk?=
 =?utf-8?B?T2xPS29wNDlRbnFYVXl5Y0xBUWxlNDBiYlFVTVowWmJuTkZ3SXVPeTlpL2s2?=
 =?utf-8?B?clJJODVQUkpkRnVEUGV2c1doYVNBVGhOdVk3eU9HNkp0QnhoOGx1YVhteXNm?=
 =?utf-8?B?YWlodzJlVFpXK0FRNC9ad3pORmM2Wko4SnNoWk9qT1NNU2Z1ZTNGRjRuUzlY?=
 =?utf-8?B?ekhLaEhjWFdoQ250Qk8xRFhHNE42WFhPQU1kbm96V0lsQUx4Uyt4SmxxOVkr?=
 =?utf-8?B?OFNidFp5cWVKV1lmQ01vdk1wOE9rMXJ4RkZaNDNjTGRuQTdvZ0IwbXIrOVlu?=
 =?utf-8?B?MDZGbmttUCtCUjJFTHJQL291UGcvemYvWUg4aERsQ0N6NC9LaFlpMFJNamIz?=
 =?utf-8?B?L0F2NEpudFAyc201VGdBdlRXQ2hsYzRMUlJSUVcwczJNeG4wWmsrdUxEWS84?=
 =?utf-8?B?SE1LSEZ6cS9PeVZjT3AxeTAzQW5QSVRiVCtiMVQxYkxIVU1zMEdJamNRSi82?=
 =?utf-8?B?d1BRMXQ1RWwwOVo5K0lodE01STNScUwwZHpFbnA3NWluNDZjVFVxQXJkUjBr?=
 =?utf-8?B?dEF2eC8zUStSRFZzWURYV0dhdy9DbVhKbUk0bVlxM3ZQTlZkSk9tUkc5ODVl?=
 =?utf-8?B?TStveEJ0eEFhVEk5SUJ4UGhkb294MGV0eHp4RGRkQU8vR0pXM0pvaTkyaHdH?=
 =?utf-8?B?QmRIczllQm9ReDhYQUdjaU51TlB6Njd1SkFpamQ0QVRINktwakFNbDg3Wm9R?=
 =?utf-8?B?d29lRnR5SWVYRlFzTmtiR2tPcnpsNEt1MTE2MkxmWXNOSE5iT0ErbmNxUzd6?=
 =?utf-8?B?MUE3SDR2aHJuVm82KytPamhYN3JmRUdFWmNQbzAwSGZLNndiczVub3FMUjNV?=
 =?utf-8?B?OGRRd01TVUlFalVmQmxwenl1NUZVTnNCTjg5Rk9nTkdmcUE5V3plVkg5eU5N?=
 =?utf-8?B?clZRdCtadGJscVRQTlg0bnkyYlpQa2tVN3RJZFlMdVhlTm5ia3JNVzZ2eHh4?=
 =?utf-8?B?emJsbmhkazE5L01VL0c5YzdkazVEMGUvSDkvZ3VaWjg1K250Z1hQRU1uUm42?=
 =?utf-8?B?OXNWUUxtV2VaRkRTMng3NTlIOU9MWGZMWS9ERmhKS2R4RmU3OTYxU3RBemkw?=
 =?utf-8?B?bjNCRmNqMEZZQmZFbEJqQjFKSWFxaHN6d2RHT0NtRlYybWVGcU56bWoxZHFC?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0274878-c4df-427f-7ada-08db7be33a4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 16:33:27.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTYQD+W2YBdKfxSHcGsGDaKgQL1x/WtFL8OOj4Ihqs0Kj3vpBZEXG2xMe1AmxhYHiB5o4TwF0PqgObbuwH6bOcSik5kQK67CGIr1d4bxw14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8605
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Ghosh <sumang@marvell.com>
Date: Mon, 3 Jul 2023 15:26:00 +0530

> Re: [net PATCH V2] octeontx2-pf: Add additional check for MCAM rules.

Please no periods at the end of commit messages.

> Due to hardware limitation, MCAM drop rule with
> ether_type == 802.1Q and vlan_id == 0 is not supported. Hence rejecting
> such rules.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Targeted to net/fixes with no "Fixes:" tagging the blamed commit.

> ---
> Changes since v1:
> - Updated commit message
> 
>  .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c |  7 +++++++
>  .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c    | 13 +++++++++++++
>  2 files changed, 20 insertions(+)

[...]

Thanks,
Olek
