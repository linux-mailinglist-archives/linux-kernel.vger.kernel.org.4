Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A646B514B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCJUA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjCJUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:00:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B8E125DBC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678478444; x=1710014444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tModmEfSiQRcAHlAa4mlsrls1W6DYxX+tD8gO7OnzRI=;
  b=RM6mjFs7R3MSlzpFH320KtAQys3zE6A9mfti3lENGbCjbeQYjlqf7C25
   w+aJguaLN7V7jbMmqebalGAm9ifVtoDHNdlazyZzjj5ArkAVy9Nj1QQ1r
   1aVRQxtpVIaU1Lin2GsI9huqv3uGb0P70N/mn/sp4XwqgcygUICx2mhEz
   9qQVC2h1Q9Oo/GLkVjmNedj7a9+gDIs+FGctWhC1B4cX7Q2Xor/alQKXj
   R5+DwQws7img78IAA30O5oF3/APlNYuR0JmFVNSDd4oty1AvM5HprIsPq
   OGKDQrYpr0tvNq3+0RRMjjDLh36nBywURqRIIZVrVC6AYnT762d6IZ+Bo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="364472859"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="364472859"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 12:00:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="627926980"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="627926980"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2023 12:00:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 12:00:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 12:00:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 12:00:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiFpg09WD7z4gOYt6zmBs+P7Hm8pr2TTBrl7RDeZ024Dj+yAagbcQzHUxySXrsJV3p++VNArg49M1kwy/5NdiMjHXTGQzHNA7ld9lwXXJbygSBEYlWjPrQJw8isLMNJLMkPM5Ty/ltobBtEfYxAPw5XWRjEH1rim2YdIFodrHZtoKHTRXmNeOJUJezgYkMm9BDgtVH1CMn5f64Xajfr1eeM6qGlRJOdiskeEmceItg0GPrUYflPLcqvrTN/0/Ot/fdpoplIVn1eqRKpRbu4HWfLW55mmurXp18Mj+/WPKT1KHASBuL3/1z0Yoa5T30101yKL1SfknshaIZiGZs3Nfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iat+vPbWPf1KnddUHE5WWbPSMlkCVh8J0RQ+fnITM8o=;
 b=oMGoKH47qihhqncWob8PiNA1AI3XqsIrLPRCo7YX9tqGxiVT3t/WCRSVtNEX3Fr2PX5VIwTIfBXdWbPflEytYrS5rdt2/ZsrP15UFi3wlQ/q9uVrqDu9rm9pSGpiKoPIXJ1CfuMy8r00raLarPHRHBWu0Q38Aizf64R4o+fnRHK3CBXT17J9FXdOrSiW8ucQvmyqFVLinUDJtJU1ZIfoUY1ON6jSuwPCFLK545Tw3czBWFmaEsspXGrx2fSElwLikUBl0nF2uys8AY5Ga+JutpyVOqGqlvHvBs0zWgGFQmEeVSUk7HMav8lzbauv8455t2cFRtuM6qY2Eh/aK1CKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 20:00:38 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.019; Fri, 10 Mar
 2023 20:00:37 +0000
Message-ID: <7c9a8ba2-f671-fb31-8146-58e972f1cd5a@intel.com>
Date:   Fri, 10 Mar 2023 12:00:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH v2 08/18] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
Content-Language: en-US
To:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-9-james.morse@arm.com>
 <IA1PR11MB6097ED9919B408116EFE161E9BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
 <ab8c7a00-8c7e-97ab-25db-92053c7b45cc@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ab8c7a00-8c7e-97ab-25db-92053c7b45cc@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0176.namprd05.prod.outlook.com
 (2603:10b6:a03:339::31) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 6837faad-8957-4af2-a718-08db21a21ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dokPK1qqRy1mUmPFNEdMg9nsd3Iekl11tCguIKCKFf+DCyFmhRD5g0pm1GNHKq7/jtIau8X48miQkp5iSfpf5redoCru/ByI4Lhm2Nt0sCWxaW+Mmt/BagrHRaZ+cv2jRZmpA3ER+sbyHr+wH4i4cebCqEL3Vvd5jbKtzOqIeuCfzkqwkH0Os8qapsyWhP/Pga2K4k9sX76e6pNRLhduuSOlMIAXUurPaqPwFUjiEcFY1QpkA7PsSDG7838rZ+earDU1anPp+JZa5XtQUnLX1zckqyRtzxQS1iRxQearnUU4/woOUl9BfjKg6ajqIx6D6Es0aikmdW/m4D0Jg1PWgUV3wcL7p4JeORZUNqkZMyzoF70tALesXBqpPOR1mKmYIx2DLhsBpJE/GBYJ8WYQpYpmi+DdENSYL7GS1rO0kJ4w3S9VmDhDsg9oN5v+AxL/EUKBUYOh2T3Ogu3cDfMmJ2RrXH3NLw9LzT6l87KyqRp3ElLprSHx7PCa/8IiLBe4/PoPKUH2qWc7yo43gE4pdGn1PFt2WuTh6ezXYaKB6Gafedxb2dg901KHZI/rcV9PoMh8oZF6pNKLvDKiWTZmNPGRXz3EatNlnoQRmfwyKepTP2NUij5grR2ZzCp87BXegnpyYtZCh1WqASECpfhOvPcsYmojBgKWHLwGB8CTdvTWxIEK8HnfOywPgRPf2E50dtiwL7zqNPoVRiU3sBI5WzJ22MCy78S6RSf6hgMGruQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199018)(186003)(38100700002)(66476007)(5660300002)(7416002)(8676002)(66946007)(66556008)(6486002)(4326008)(31696002)(478600001)(54906003)(8936002)(86362001)(316002)(110136005)(53546011)(41300700001)(26005)(6506007)(36756003)(6666004)(82960400001)(6512007)(2906002)(31686004)(83380400001)(44832011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUtyYW1pT2g0dkx4V05vKzYreWg4eU8ybHJkY1JHa055TVhHci84UWNSbEpU?=
 =?utf-8?B?OVJsTGxtVThXdGU4Q0VBTzBVa0ZFVkZRVDN3OVR6YVZBNENlSGdsMTFqaENS?=
 =?utf-8?B?eStFTFhZaERCOHVHRHRQbGd4TUhQaUFDZGsxZ1dLYXh4ZWRXUDRBVGpwVElH?=
 =?utf-8?B?QmJCL2U3N2Zza0ZtY1d2Y1ZST1dCd3NxUEE5Sjl4R2NidmhrRlVXczV3eDlv?=
 =?utf-8?B?WDBWRk1SajU0eXJnUHRxRk1xMXdtalNkNEs5VHcxYXlCajdESEQzQnRMdWFm?=
 =?utf-8?B?Kyt3OTBkS3QwaHdhc2lFVjBDRUVKRS9rM3JLanZwTG5QVDRDRWNjdVBJbXMy?=
 =?utf-8?B?enkrSkR3SDZRMWxjcUVmTlg4eXltZGpIOEdkb0RHanJwZjVlSmVDL01MSGJq?=
 =?utf-8?B?VUxXMmY2clJPMXZ2QVlvNUFBMWp3NVdDR3BQU1NmMERYY1c5N09sZjE2Y050?=
 =?utf-8?B?UVNXYlpDTHBWYVhwSnNoaUc1eWNSTkVhZlZIaEFVaElEUWNjbk5nMG5ld1Fq?=
 =?utf-8?B?YUF1bWUreFovZ1Z5aWhEem9xYXl1N253ODdac3Q2enpwREhibDZXaXY3ZXJQ?=
 =?utf-8?B?WGdzcllaVm04dFRZLzVjZS9OMzlUdVZjbUxEVFd3aGNoU0pnb0xyWkIzUnor?=
 =?utf-8?B?L0FrNnU4V2VMbkR0RjNzbTlaMmUvSWJlenV4TTY3Uzg0WEE1aTlUczV1OW5H?=
 =?utf-8?B?dkxCWU9McjRGRDZMMWZ6b3dtMk9vVnAvSTg2dldSRDEvcG5oZjBDbUE4UUFi?=
 =?utf-8?B?bktzMlF4cVVHVGt0QzlVbERCU1IvMGo1bVY4QVdhY01KUUpIQkhlckxGVDRs?=
 =?utf-8?B?NVVCWmlFY1A1a3FXcEVCcVNZRjVjNDMyWngvT2Z0VjVwR2ViMUVESHA3NU9J?=
 =?utf-8?B?eEN3akVTM3VHUEhteDZzTkRRcnRvWWpTcldYNGU5ckZpeTN6Z3RGclk1V05P?=
 =?utf-8?B?RmdyM1VuazdUajNuQm1rcXFuRWM3V1ljSWJFbDR1NEM1WTBDRnluMWloN0ZD?=
 =?utf-8?B?d0t0TDdiTHRJMTFYUDRma25aaWFYMTZubzl1NHN2Q0llS0hmWndYMUFEN1Y5?=
 =?utf-8?B?aWN5S0UzYXljbkU0SmpQRVU2UEcvcDYwNEk0eUlXUlAwR2x6RkVqWk5DMmhH?=
 =?utf-8?B?aVJFVUFZMytOWG1aTE9EV1J5bTkyeWRNSzJlYnRpckRTdW9VaUxNZndEVDdi?=
 =?utf-8?B?WHdZM3BIaVhkazl5MTZDaXkyLzNKdjJSR3o1cWxzMTRhWDN2Rk0zQ3hlTWdZ?=
 =?utf-8?B?TEY4cHBHYlcyTkVRa1VDR3pQY3J6dGNJNWoxa3lrVUVnK2UyYWlPMWUxcGx0?=
 =?utf-8?B?VkFsMG1HbTVSUVgrM3RKUVpzM2JxZFp6YXl2Nm9pMSs2SUlrMDRqTUYwWGpH?=
 =?utf-8?B?b1RFcmhxN2F6OTF1UTdpeFRuamF6NVkwZGNEdERVR01HemorUjE2amQxWTZE?=
 =?utf-8?B?SHAwUS9JQUVXOTB4RXB3b0puZnZLNkxUZUhNbUt2TlhRTlR5QUZQNElGMVVY?=
 =?utf-8?B?M1doMU5KTVZramZ4V1Z4YnhLRnRIelZTS2luQmQrRXp6dHVDVEZhdzYyYzk4?=
 =?utf-8?B?N3p6M0QzMzRLcWxHK25weGV2R2lRS2tSVTNQNjVWVnZMTjNyR2MwNndIbHZm?=
 =?utf-8?B?NlBBQkxzRmU1bSt6ZDliZjhiRlg3VW8yYU5Ob1JIeVp1ZEVxK0FoUE5BREFG?=
 =?utf-8?B?WFQvRjd6U2pNYk9mVlVtRkZKakY4Z1dmSS9wNUU4dnpCTjRqbnNPd05EOEJE?=
 =?utf-8?B?S0IwZ093OVkxSzgvNjd2RzA5ZFBzRUd6TDR6R3pKQXFTRFJaS2JQaS8zVHlv?=
 =?utf-8?B?N0VyYlZ2djBlenpnTDJzWmlrOHNkSlFnZzg0bjlMTWxlbUlQNGFYY29wNVNz?=
 =?utf-8?B?SEVjMmQrSnZ6R1lqUEF4ZmVMWTJPMHN3OUtHSGgydE5hRmc2dDBXL0VYNnNO?=
 =?utf-8?B?U1VjTzBudWdtUFV2N3R0eGVsSUx6dTNSYkZ1Z0wzTFRibTJHQjRDVjAyRVY0?=
 =?utf-8?B?WnRTU2QwNHlQTytianlTQzhnM015b2kvOHBMSEFiRE5GWTRZUVZQbWd6ZzZr?=
 =?utf-8?B?dGh1WTVPVE5waXlIYTh0dHNWR2p5cWgxZ0hVaG8vWStBYnl2OXVVdTJJTUds?=
 =?utf-8?B?cVA3RlVQZEYrUEJIZGNuOFNDUUFBeU9OaEZZbUJ6eElMN3BUQVM0TS9BYUI1?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6837faad-8957-4af2-a718-08db21a21ddf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 20:00:37.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEqu4FUoVUIEWtopcnwvPW6b0h/lYBLOeWbVyHYfIx+z1jxXJtRrE1+K6/gB24PPbxRtYjZOIDPPaEl0Yb4LCXC+W8xYhS90PY22twmmBNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6353
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James and Fenghua,

On 3/6/2023 3:32 AM, James Morse wrote:
> On 17/01/2023 18:29, Yu, Fenghua wrote:
>>> x86 is blessed with an abundance of monitors, one per RMID, that can be read
>>> from any CPU in the domain. MPAMs monitors reside in the MMIO MSC, the
>>> number implemented is up to the manufacturer. This means when there are
>>> fewer monitors than needed, they need to be allocated and freed.
>>>
>>> Worse, the domain may be broken up into slices, and the MMIO accesses for
>>> each slice may need performing from different CPUs.
>>>
>>> These two details mean MPAMs monitor code needs to be able to sleep, and IPI
>>> another CPU in the domain to read from a resource that has been sliced.
>>>
>>> mon_event_read() already invokes mon_event_count() via IPI, which means this
>>> isn't possible.
>>>
>>> Change mon_event_read() to schedule mon_event_count() on a remote CPU
>>> and wait, instead of sending an IPI. This function is only used in response to a
>>> user-space filesystem request (not the timing sensitive overflow code).
> 
>> But mkdir mon group needs mon_event_count() to reset RMID state.
>> If mon_event_count() is called much later, the RMID state may be used
>> before it's reset. E.g. prev_msr might be non-0 value. That will cause
>> overflow code failure.
>>
>> Seems this may happen on both x86 and arm64. At least need to make sure
>> RMID state reset happens before it's used.
> 
> On the architecture side, there is a patch from Peter that records the MSR value on the
> architecture side when an RMID is reset/re-allocated. 2a81160d29d6 ("x86/resctrl: Fix
> event counts regression in reused RMIDs")
> 
> For the filesystem, the 'first' value is passed through and handled by the CPU that reads
> the MSR. I don't see what problem any extra delay due to scheduling would cause.
> 

Both the monitor directory creation and the overflow handler rely on the
rdtgroup mutex so I do not see how an overflow code failure could sneak in here.

Reinette
