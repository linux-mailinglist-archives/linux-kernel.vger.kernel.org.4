Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453815E6B46
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiIVSxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIVSxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:53:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64212E9FB;
        Thu, 22 Sep 2022 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663872822; x=1695408822;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l0SFrv35Yog7AcCl+muyzRnBuzQwchOHkXugmxKZk2g=;
  b=hjyNA+WzJeG2uD93/gh/2f6ROfPqzbjpxAwAYuszhQv/9KxubThGXczo
   1B+Mhn9lIi0xA+rQjiPT54vRZ1A4+gycDYo+wIDVzyZ01RWKMTNqTCjQX
   nMMoQQPv0tqiP5asXluXIROQ+HvGjmgtgRwzcpAoLnuzuxk1X0UVQc4dr
   NztAaodcLOX0UQMa0QamKFQ5D0T+hR4roUX/wFJIyl/FcxTMoApKLcMYf
   VfoFjh/5mIBAOITz7vZNQfDhZCp5YRl9f966Aw+tboyDCC9In9uq3a2FU
   g+iENlZM/2x77LNnDp35fsXC0ntl+tyeiaeQwaQqcJ+qP0CZVZ25w38D4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="297996854"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="297996854"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 11:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="948726348"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 22 Sep 2022 11:53:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 11:53:41 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 11:53:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 11:53:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 11:53:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJypxzIDbUoe8DQEItuLNJtt2PcaSQxrmn0UozPZ/I//KPgRtHLq6FKhak8GsNmzHMLGVNcZFDEw07SxNbHqD++WKUp0yvbOj5zwArnOyGOPduYBPfT+pB+Tvboz83ZLOn2aJBTKwXU2qELcgb4TuHqFYWdzPODOFlgzsVSxgyeZa8VIljBdRLbEPXiKH+xTJZNlV38wMyUW5UezfmCoaJqWwqwltzyNqx3IvT4OBSZOcUtcPzmgYobepLm2fBeCT/HvBoOavo6k4u5vjkQ9EeFdDOI/o++l3yxeqYAbV7yRyE0X5UH4MxmHi1ctXT3JlKsH9lWm/TOHWpUF4BMCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfX4kbYUO2D2P0UIE9nnF9n4mqUQCrVB7cwcgg5N9OU=;
 b=Y96HM1PECtGWQDRAeDS8NFNZ+xdmfC6gCAvJs47M5OhLQuhao2M25/LgtOSGuMLbgevDZO9dzPBEraa2e+zZvDEvnPfCJ6hPYP1ZQBayUyKqYPOQZxA3OYQmR3vjL23IUmDbcRnE3RF1jRlBxoEutWbEv0ikRsn1Khu0LOKhuGr2jlDeGZuaY2sb7wliPwv2EIerZhV04e87hLXDKhBDLG4+za/S6QlJnJpuD1gLcNoFXi+bIEG7wNkhZIX6DQNxM50qhltxYOul8ngIzLXAKKCqiJLQMlU2PbLnOO28I+2NTnU8rVhP9t85qS9Rcv2LGdWUVnIsjg3R6kFoWiKh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MW5PR11MB5857.namprd11.prod.outlook.com (2603:10b6:303:19d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 22 Sep
 2022 18:53:39 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::6262:c42:ea50:926e]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::6262:c42:ea50:926e%5]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 18:53:39 +0000
Message-ID: <78d13a19-2806-c8af-573e-7f2625edfab8@intel.com>
Date:   Thu, 22 Sep 2022 20:53:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH] ACPI: processor idle: Practically limit "Dummy wait"
 workaround to old Intel systems
To:     Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <20220922184745.3252932-1-dave.hansen@intel.com>
Content-Language: en-US
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220922184745.3252932-1-dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::13) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|MW5PR11MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a48d300-efc5-45bf-4feb-08da9ccbc353
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjyynXE3XS1fsGK3kv4DtS2n4wkHbqt+vtHQPWL95qhtbYsPfF3N8jsKYJ2lRiFhHyNYv2ss03DfCXRpPzKJ+RR19dab4HIVakXDFc79+F1LxVz8scbvOCX1al1nXtU/Ddn/4LSmgsccNZptnfVaGmn/YtK2bnKuDgmCo4Ltx8XpSCLuCnaNwFRMw43Js0Vs77kmWGzVFkVhl0sMyWZrt2//f/J+bwUPaBqf6mvt/OsiHoCOP7yUVBrg99jVuXprILGUqKOHjA1W+kW9jsNkqnkePiJhSp9XFxO9GoPLq09aT6ZzTmfGzwDCENKa+XseGp6MIm7BN74dAU50AEoEWq9un+72cAiV1C0w5wFA1mVW62lIslF6n8ER/2obsXjY6PyAgfETCTabZw4RgxK3byZ3UNVMOOf/FcCU1hhKojsusjV3NfTvdhNahHSJ0T154iiSYYBs0M3zz+KE249YIADqhHUk/XOSBRdyG5ghSv77yMo8E2sdBHClLiZfQSwcr7uxfTlVtVBj0BI9FDOzSz4ScHTZ70d+dMIbulu3KLqo2IqGh8oELLQKkBMEJDTi1I2sgoOAyjbI+2Oqp9vbTxZ8Df57KvVRK0rJE2MbSSqrtVJXwbizdu/yD7dNUKGIrYtHSJXE2223A+acHVYhn+TCoUrt0JFIEIKwDpvRAOn5PXEkJZyceHXEr6cC0nvWrEVbvO9G3h+nQn5N+G3qRMFedGPPyoZvAYAoV0/BNmvd6YDtpWDVpYTyhTtyADc9STdk/6vBvQf+uXhD+GAqLq9WfProUXP2TqIFgW3EUfL6A60mUXLP+U1egA+gnyOtqHLD93QZI9jZltkGksphciZHVf9qSQNbKVgkFihf9zbVHLSrGbFRSjg4hdbicAWU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(2906002)(54906003)(31686004)(316002)(478600001)(6486002)(966005)(5660300002)(2616005)(6666004)(38100700002)(41300700001)(66946007)(8676002)(8936002)(6506007)(31696002)(82960400001)(86362001)(66556008)(186003)(26005)(66476007)(36916002)(83380400001)(53546011)(36756003)(4326008)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZDQzEyVmY4YlJoZDBDUE9TQ2JkNHk0RFA0dy9keDFabTFLQXcwS05JbTJp?=
 =?utf-8?B?MnU0NDdadHNORVZIbDJWRFJIaE9nN3gvbk9vTGVNMGtocHNTc2pUeTcyZXBN?=
 =?utf-8?B?VkVaclJKaUVyTyttMTE4RWY3aU1zcnF6M24yeTdCTGJnSWVjaVExWHBHMnpa?=
 =?utf-8?B?SWk3cW1kWVg3WERoSTlUNGIrODB3dE84c0p3anNqb2s3MUV3L3Z4S1dOMGpR?=
 =?utf-8?B?L0NHYzhtSThZWUl4QkNudTlpa0FiVUlzNnMwT2xyKzdTRnRXVk1rN29MZXYw?=
 =?utf-8?B?ZlEwOThadDE1UzFtazZCUkQvRno5ZlNjcjJITjBCcmJBRTdHakg2bExsQzNi?=
 =?utf-8?B?a0dpY1RTcEJuWjVnam95UXJ3Q2Z3U0dKNm5tT1Qyck1lTXhkTUtjbUFzTzNB?=
 =?utf-8?B?SzBEVzA5eUhDZnNYTlVIdFdEdjNlQ2xDQjdsZ29hSy96WUZWaHVWV0xab3Fj?=
 =?utf-8?B?TEdvbW4rcTZvaDNNVVYveG5SdnBJQTdUaTFjaWxHY3pnSE95NDI1bFl0NXBn?=
 =?utf-8?B?WGNqOG50ZndRUjY4Tm0xM0Y5RXptZHVJNDFMWDdTUHN6UTR4cE5rWjVDb2ZC?=
 =?utf-8?B?MlFxL2lGWEl4eS9CRmdBQkRtb1JONFVkbkRxb0VzSjdJNStZZFd1RnNFRnBx?=
 =?utf-8?B?U3MwZGpHYmVOZWRBczBjSjFIK2xBelArQ1pKNjM3NkJJMlZpMHl1NDYrbW1D?=
 =?utf-8?B?aUcyd2tNVFAxZ3NhdG5lazJ2UE9GY3VQRmxWWUd0SU9mT0N2NUJLYkxsVXFp?=
 =?utf-8?B?OUE5dEdIYXZHNmg2UXhsaFNibzF1dnpDN3ByVm16aDMwWU5ZVGxEVkpXQisx?=
 =?utf-8?B?blVPVnZZOEhKU3Z0cTFBQzBBN3JqWjNaRUtGNDlPVncvcGtZSGdaRDVLSlpW?=
 =?utf-8?B?RW1GNUtjY25Id1BMbDhvSGsrbGxNVDNjRG5kV2pCYzlPL0lWWERrNHpiSHEz?=
 =?utf-8?B?WGRGaHdqTDJQUDUxK2EvVENHSEJReHQ1R0t2RWdJRC94N3ZLckRPNCtYT0tZ?=
 =?utf-8?B?WnROWDBTZ28rTld1SlJEbWZsYXpTZGhPQjNNbXg5WEx4NVRDMEtya1N4K29R?=
 =?utf-8?B?Smd2S1k4a0pCb1Bnc1ZiTy9rV2NBVSs5WFB2UTNYdjdLZ1VaNFVxVVc1VmlW?=
 =?utf-8?B?azRRNW1pRncrRy83Y2RTSGx1WTcvZ05WbDBBUTBVUml0c2hTczcyalA0a09K?=
 =?utf-8?B?d0Q5ZVcwUjZZVktlUWVHUVJELzN2TXU2UnEwbll5QlphRUxhYlEwbFNpc2w3?=
 =?utf-8?B?ZnY4NTc5K2JzYUlhbW5wYWFNNWxZUThkcmhpSGp1aHNBK2RRVkU0YnRGVWRi?=
 =?utf-8?B?bHd6NGFBSHNOYVE0b0pzdndDb0I3cVF5OUpVTXpqaWxzWG8zdUs3a3k4Tnky?=
 =?utf-8?B?YTdScUF6QXd2Q3Z3Y0M0VEZKSnJDcTgrRm9jaXVUeEtYYVBVTGFkb0grZlJu?=
 =?utf-8?B?TUUrejIvelNBNndJQzU5UU5oSDlZUHR6NzVwSnVseXVzN1hzTzJ2WnhBOXFz?=
 =?utf-8?B?c0lsajNRaDVSZERldHQyempKK1dES093bVJYUmcrb3JMbmhVVkZVOGllcytt?=
 =?utf-8?B?Nm93bjRCSjBBOTA5emxmbS9JdEt5bmtjQnUwdGYxNnVMRzVaUHdiTlJiSXFo?=
 =?utf-8?B?WkUzeHI4RW94S0pZM1dDUzA3L0RFSWtxRWJaUlc0c3g3b0hmT2JiSkFRSlZa?=
 =?utf-8?B?RFBpSWtwRjZJLytZZ1NIdExWSGM1Zm1vUVA4ZEU2U055VFFrNXdOYUlITll2?=
 =?utf-8?B?TlNvaG5BYTJjcjZYbzNhS0xZNG1GSElzS3pRSFpIUHpNWU5ucEwrQjI5c0c2?=
 =?utf-8?B?R0Y0ajdRcnZ6akhyYUZ2cFdFNUdIcE9aTUFLMmZHK2ZUL3pwY1BsMlpvQnJ5?=
 =?utf-8?B?M1o4enNKZml0U09ydFBXUW43WjJkaGFaNjVQRnkwSlJaN1JCTkdWYU1HMTM2?=
 =?utf-8?B?TFdsVk5qV21ySnBjQVBybGdyNEtFaEN4T2xwQ0JZN2hOYjZ5MDNwUlRKM3Zh?=
 =?utf-8?B?azBzeEd1RjZhcTcrZTB3R21maitUYkdBRnpNQ0lyWFAwRVZKZDdBb3QvQ3dC?=
 =?utf-8?B?aHk0OFlxUmZJdjYwRHh5Tk1sV2ZPU1M5QmhuZmxqRDE2Uk0wZW5sbFJLbndy?=
 =?utf-8?B?NGZIV1RGK1NOZTNWTXRycVVIYjMwRkxUMGRwM0N1RzhOTWw5bmVocWVleFpV?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a48d300-efc5-45bf-4feb-08da9ccbc353
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 18:53:39.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjXP+ftJKx/jIvW/gTsJOBNAY79msSiWFvkXFqt5HkJZj8HKGbGpUtntbUVooW9IwWYbEcxVSCoQadPjiw/IIqVrEWasYbIhjX4adWzHduA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5857
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2022 8:47 PM, Dave Hansen wrote:
> Old, circa 2002 chipsets have a bug: they don't go idle when they are
> supposed to.  So, a workaround was added to slow the CPU down and
> ensure that the CPU waits a bit for the chipset to actually go idle.
> This workaround is ancient and has been in place in some form since
> the original kernel ACPI implementation.
>
> But, this workaround is very painful on modern systems.  The "inl()"
> can take thousands of cycles (see Link: for some more detailed
> numbers and some fun kernel archaeology).
>
> First and foremost, modern systems should not be using this code.
> Typical Intel systems have not used it in over a decade because it is
> horribly inferior to MWAIT-based idle.
>
> Despite this, people do seem to be tripping over this workaround on
> AMD system today.
>
> Limit the "dummy wait" workaround to Intel systems.  Keep Modern AMD
> systems from tripping over the workaround.  Remotely modern Intel
> systems use intel_idle instead of this code and will, in practice,
> remain unaffected by the dummy wait.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Mario Limonciello <Mario.Limonciello@amd.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Link: https://lore.kernel.org/all/20220921063638.2489-1-kprateek.nayak@amd.com/

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or do you want me to pick this up?


> ---
>   drivers/acpi/processor_idle.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 16a1663d02d4..9f40917c49ef 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -531,10 +531,27 @@ static void wait_for_freeze(void)
>   	/* No delay is needed if we are in guest */
>   	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>   		return;
> +	/*
> +	 * Modern (>=Nehalem) Intel systems use ACPI via intel_idle,
> +	 * not this code.  Assume that any Intel systems using this
> +	 * are ancient and may need the dummy wait.  This also assumes
> +	 * that the motivating chipset issue was Intel-only.
> +	 */
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> +		return;
>   #endif
> -	/* Dummy wait op - must do something useless after P_LVL2 read
> -	   because chipsets cannot guarantee that STPCLK# signal
> -	   gets asserted in time to freeze execution properly. */
> +	/*
> +	 * Dummy wait op - must do something useless after P_LVL2 read
> +	 * because chipsets cannot guarantee that STPCLK# signal gets
> +	 * asserted in time to freeze execution properly
> +	 *
> +	 * This workaround has been in place since the original ACPI
> +	 * implementation was merged, circa 2002.
> +	 *
> +	 * If a profile is pointing to this instruction, please first
> +	 * consider moving your system to a more modern idle
> +	 * mechanism.
> +	 */
>   	inl(acpi_gbl_FADT.xpm_timer_block.address);
>   }
>   


