Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9A2746026
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGCPy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGCPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:54:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62BBC2;
        Mon,  3 Jul 2023 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688399694; x=1719935694;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L2s+JiTOb2i/E/xb+zWD/DsZgP+uo82oEBOdP7tL9ac=;
  b=jP+MTIU9yxVmYcxSwFltW+9VzGj0Td7ycAuJKnMi4wUbSXQiMYdSiDSV
   /imZ4JOBNgO8+gNHhtXDQ5Ay0aG70iRC8LR/5vjHjMn1j8SINf1TN50WW
   DPe1boqLTum5GkUIA7GAqHtLJXPvkpSCoCjuEesb6rj6sLOsrWHwDS0JU
   awaCdaeiVjgJJPDEqTPr6g7Ae4LGqtrlay/ssIIC6oBJmAc0l1kcoWjYP
   tnuv5OV7qNvKzTpy8FyJG/f9VyiVlf/1RWiwFEjGqQ2VIGK3Myt+kcFW2
   hOU7hiTxgOxjQ4A/IuMk7UCcQdkOIjIZUp2aGtU+2bwVKeo0DuH2mYfDZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="362953011"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="362953011"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 08:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="695852118"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="695852118"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2023 08:54:53 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 08:54:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 08:54:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 08:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO3UPHYIWTwXaiqrA0QHSmzMw4VIFGO18H8jZ3gh3ZzMHKCkbUqiukNT/GXR7KuoqVLsIXzhr/cAdlxiUd6DnvEBW9wLQH2aAUfX7gDCTSielSSXyOGM5ItlKGFHH201Fp5dkzIrAUazLenBICcOGTHSpjTrbYztLpxJhuiTfshRKSphhuPbiwoUU0VRzyk0cv9e/JQrQdkFZssuWVs8J5dDbFTDEZIEF5HfKw9zzs+vz32UutgNgEjQjrV9yhAcfB77W+7fi9H9SUQvlDO9hK1zzFV7BggjIWYxTscwjbMFhek4+g+t8xPp8EvYn/DWzD+QYjQppozKDwwJiX0WwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qn1OCWoxho6ZIiOYr/G4WSQ9zf0K3vPbN20p8Xz5Zs0=;
 b=a79D1hwNAlOoE1qKWt9Tru7UhqKRJZ13/QrVB+fQALxqPKFKqD0dSx9VgAjVnFuDOAQemo/ruKDCfveqqu4nXPaJUZJwXhzdRlysiTI33U2pcI37tKMZmVEY8oxSmFPCqA0LwkLS3JqHGY8yPMPBrSvBpjDAX7wzUyp6Tw44j391uN/eu1yzIMK0KfYoroc21q681grgbVgFUZvLf+jRLJxBkEuWNDj2QucXY2HgKho5CPWyok+kLJFUI5MAcCnB6F/SWSpUSOEggqw5nlXVlUhDSzrdxy3KyFfDOX39GDaavclOkbejTjq76SICGsP8Z+fF+orYZaHqgJSvHFin4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:54:50 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 15:54:50 +0000
Message-ID: <6ab3242b-32b1-11a6-2399-f3b566393a58@intel.com>
Date:   Mon, 3 Jul 2023 17:53:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [net PATCH] octeontx2-af: Install TC filter rules in hardware
 based on priority
Content-Language: en-US
To:     Suman Ghosh <sumang@marvell.com>
References: <20230703120536.2148918-1-sumang@marvell.com>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230703120536.2148918-1-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY8PR11MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc5391d-0006-4a23-b79d-08db7bddd590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDjbevIGX3IAgo1wOz09KE8KpXIU5GAXoWPTGeIekVnvbDy+GAuGy0HFzJDe8pa6JaNBsKwqIzYhijLhaFe5oqAM761u/FVOs6D4ife5SQnni62pIB/NejnASzp1cToufiFBqOyBJQJVL1nQWLuKBLU/9E+3naWoo731AXZAv6ONNUrPpjwk2gYfSe1hoRDR5E915G4nPLnoiTvIFgJLGit5ps0wGFrd9TNhTbNdR5s2LSPn1Xctabv0yJi514aro5qFbKPXW3elYbQNwm0zdM862cfYBvS82KVze9/m/bUg6dBwfe6zEJbH7jLSYTMR8vO/83fHrW4EhizT6TWLLCB0ib8u6I7cK2imB1ZsDJZ/nAcZ4FL/NZk8cedVnsmLgnY/jy5JXcIVxB8cFGG721rOe/GED0RwQd8BCluUAYFbAhCrAmT3nng4mB/9axCjIZorahVgnccTQOtoEMjQVshmjSNSg/X2GF8rqGN/bgXHA95UrgN8fwmDWO4lk7joUFlUnhX8Sgaat17+RZOzrRr0pDlkgDBAukbd3P4xyMuDVXDk9puDjyTkn0PnqcFd3XSGd/gbTuG1i1gZV3+Xhk0Riyva1wKL8IbehbPD31VOra6oWlCqOn3VGwxMD9ny0WaJwK82MCTxmXkBFdmo2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(31696002)(41300700001)(86362001)(38100700002)(4744005)(6486002)(6666004)(2616005)(83380400001)(82960400001)(26005)(186003)(6506007)(6512007)(478600001)(2906002)(316002)(36756003)(66476007)(6916009)(4326008)(66556008)(66946007)(8936002)(8676002)(31686004)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVZiUGdvS3JDM0VDU0E3SEoyVWhxMzluT2pneERXMzhvUUY5MDRDcGpVRTRa?=
 =?utf-8?B?MHBBcG56ZHI4WkZPYkpUQzNxa215YlQvVVBXaHVyT291QVFESndFQlAyOEIy?=
 =?utf-8?B?UmZHdmdUVFhGQk1CL2ZRU25jLzFrcnBGbmNsQm8rYWFJVklCZmpYU3lMRmhK?=
 =?utf-8?B?d3o0NncyZkV4dm9qUFdjWitWSEVibkNrZCs1eTFCc1poT29nUVBsUFE0bldM?=
 =?utf-8?B?Tk9hcXFUVkRDZnhHVHNKZ1Blc21KS1FNRDdZeDZvRDd5VjJlZmt1bTJGdzhx?=
 =?utf-8?B?RXA5dmozOFowZ3FENDh4cm5FVFNjQU54c3Y4ZWk4K0ptbUhNa0hSaTFodUVV?=
 =?utf-8?B?bDlzUURya0ZzZnJWSkROekZFRVg3ZGN1OWJqRDBiU1ZXZkN6Q3JQRjhrbjNl?=
 =?utf-8?B?M3huNldoRnJlWS9jaGxwSWJ1SEcrTVZJSkx3Kys3VjN6T1VSc1l1emF1S3NO?=
 =?utf-8?B?R2g3TlF2LzdlQ0ZJOU9EbDF3RXREV0FudFdBRGJKbmpBeGFFcC9KTVZIU09a?=
 =?utf-8?B?ZHNBbWlTamg4L0lxWGhuTXFZVHV0NGZxQ28rWDdPN0hJaGE1cjA1ZUw3RWU2?=
 =?utf-8?B?M0F0aUx1MzRHcFJLb0dPTyt6aXJGcmtvYXdsUjc2cmZiK282TlJaNVp6UnFk?=
 =?utf-8?B?UGlrRURCSS9pczI3VXdzQXZvaGgvakpWS1pnS29TZE9GRTdtNmVYbUJWa3hM?=
 =?utf-8?B?a2plMERZeXI0L21aeDdtaUhvT0plaStkWmFFanlwQ1h1cHhhbDVPUHdjRS9G?=
 =?utf-8?B?dm1mSkg1QW40Mm1KQ2RBRkI2UGNNVEM1TnFreHJpUmpOYzAzQ3FYMFMrTDVt?=
 =?utf-8?B?REJTdDAzdU9vQTlBZ3pmTGI4SnNtelNkRGhjWWh4NURFTWhHSVFIanhCeXQ3?=
 =?utf-8?B?Z2lsT3FNWUc5UlB0cDIrMytKT3A4b3BqTlI5cCttUGI0dnJJU2dadzBjRlUw?=
 =?utf-8?B?RUhLT1h5c2pNWldqTURSRE5qamtmVXBWa2FLRzVmcldFUWJZWEQ3cUtrdno3?=
 =?utf-8?B?V2g4S3ZFcFFSNUVkckhyQlNNWHZEd3VDWTRiSTFrWG9ucWJreWhVMGRGZVRJ?=
 =?utf-8?B?blcxMHpHbXBTZ3ZRRm51ciszVDMrYkFFNHU1SUdBS2hVcnE1RlcxY0Z6MC9R?=
 =?utf-8?B?MFIrQjJiNVZOLzVONXEvT1l0cnh4TGNxalpINHBUVkdiOENGZ2JxWUlHczVy?=
 =?utf-8?B?NTRQSG5vdjNsY1NzaVZoaGh0Ri8ySTZIRVlOVkhWcEhpa0NOZEdrTGdNSllk?=
 =?utf-8?B?cENZV0V4b0J5elFhVkxWWW1uZnhtSTNLZngwYUNaVUV2Y25IQ3NZM1E3d3kw?=
 =?utf-8?B?ejNVQmtWYzMzSVdWWG0wTVpmRzVyYW43azlTMnJEQkd4My9XYUJENmFzWUda?=
 =?utf-8?B?bVJwUXA0UFpHQ1dtdElYOWNjQjR2UFhBRmR2L0NlOEYza3lZYlJzYnJTczVV?=
 =?utf-8?B?dGZlTCt6ZjBFMFMzS205RVAwNGpoNlRwZ3B6QWJmU1NRanpsMDcrd1h4K0RN?=
 =?utf-8?B?SWJaeTZVb1ZyemhQYnVIeFczblZRVWdNalg2N2dHWGxnNTkyMHI5SFZHQVU1?=
 =?utf-8?B?WUlOTTNzdmxDV3dSOWMxSjg5L1lrVGRiWmljTWJjWlBkT0dycmQyVjcyQzAz?=
 =?utf-8?B?RFFhcEtqOXNMMkFpY1RNMm5PdDVDRTJNYS9Hdm1PRXhFRHlZOUh1Q0F2V2Zo?=
 =?utf-8?B?dllDRUFBVlF6d1d4V0lYTWdOV3paOVdjcFJiME9uQ0JxdFJ3eG5mTlZ0UW44?=
 =?utf-8?B?TUZGOENkbG50MHpJaUwxblQzQ3BFVEZqRDh6MG1tSWR4R0EzeTlOZ0QwQ3Ux?=
 =?utf-8?B?MTBkemd0VlJ4ZnRYZzN4N3FpaWVySzFXSklqeU12bTlRQkRxaWpqREdyK2Za?=
 =?utf-8?B?WkFzNG9FaEsrVGM4VHJUQkoxOXhYUEpOYzBOVUdoNStXMStnQjJ4clF0TVZk?=
 =?utf-8?B?dGp2QVhmNloyUGhjdEIyUFE4cnEvcnMvRXl3VHIvRGpHdkgyYnlwU1lheWtp?=
 =?utf-8?B?VUIzb2ZvMEo0ZE1TM0gweFlNQkFIMUhsdHc0U0NoNGtJSGdHd2NlTW1sMFI3?=
 =?utf-8?B?c1haQXZpb09lQ3FBR254bTZnMHFCQUE3UVkrTzFkejFPcFR0UmlHMDltVGhK?=
 =?utf-8?B?M1pEVzhzUHhvYVR4SXdwT2dBZnl4NDdaaXZxUWZwcjBrWE55bHFkWFpLUlZF?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc5391d-0006-4a23-b79d-08db7bddd590
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 15:54:50.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdR0+yn/OZlKJqrqcS1IuoPfjaKcqOmMCdfWxVH+Hnstd68FjXX3BUVQLQz6DvKGgAkLQXJ0mVdLEtSqYyb8xJXBT2dNqBOVDod5oAO027Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
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
Date: Mon, 3 Jul 2023 17:35:36 +0530

> As of today, hardware does not support installing tc filter
> rules based on priority. This patch fixes the issue and install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
1. Targeted net (fixes), but no "Fixes:" tag.
2. 350 locs of changes in a single commit. Is it so atomic, so that
   even can't be split logically?
   Esp. given that it's claimed as a fix, not a feature. Single 350-locs
   fixes do happen, but *very* rarely.

Thanks,
Olek
