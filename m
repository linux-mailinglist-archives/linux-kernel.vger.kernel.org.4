Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3667623759
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKIXPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIXPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:15:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2283355A8;
        Wed,  9 Nov 2022 15:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668035745; x=1699571745;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hhv4xesrVdcHSEXga4dIlN9gGPIOecroNBloSVL1Y70=;
  b=SBiDv/8SZdxPK3SYKvwtqz/UOtAoJ1IVE1K8pWgybzZtHRWzIHddVTSr
   WaJpDS/kSKDNc9bPycAVx+QWTR+L+blb8dWy0278tgxlUtzU6trCDKoP8
   4ypQBXBP8mJUBqdCIMIoD48lAb+Ybltoa/T/CpfahG0VmbQMwrW8UWu/Z
   BS43sCYkH6A3lhBSUiz9IwChiGgsnqNX7Eftr8T7f96vwFteb59zNiAC+
   6NaBmrJ7CMwBCm6AARoOBJROeBVwN//bELgvp+CeGxU4Mem1q+0Xy8I6W
   37UmGAVPsGI+LXMhEzD+EHn3feO8PJfrMbatnkd2oo1r9mXiOOVu/Eh2Z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="298639348"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="298639348"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 15:15:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="614868770"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="614868770"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 09 Nov 2022 15:15:44 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 15:15:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 15:15:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 15:15:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHqYZMLayZUY4CAZGWFdfxGLIgFElxgNBsOyS/9B8kpOw76dtGZo40ukNxzWsIGYwB1QQEBWdGUmI2568nB+1GDUvnU+fsqiSpk3IEQ0vrB2NmfR2ZrpX/M7Xevbm5tqgrykj2XyDq1r5ZLgZ2Seifhjp/rKSMi4ioXf3ij1YJQ+r/TQXOIoSuhu48ogxzWTYMYVcFXu5galAQi8fkNGBMNDQzMaAcSPc1vNl3rN218s+Sb3mwZfqMhMBJ88WTyDqjVu1hZx/GcGBN1AHRyOU4sIZNO/AG9OPq97ZUUCKLUwrorP6gHsVeyKUPYBOJ3dMoa6lb70m42EuXYeUj3Lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITDbg/8LhINn4VAObRvVn8hQeg8hp1FGv/hSzAGoq0A=;
 b=UIbA3BA7BFqF/64d+yfQpRUxRUQSW0ytP47vwYPhCkacQLNwZs5xXhxFPtydlgPcURR61AzP8wCM9rsgAASWuV7x/AAgoG5LH3PfpeH/h34iQvqRbXqMGCxdnwkmmhAFkYI3DlmKpt+CPvetloZVQOb5FkfRMsILn/J/9zPKAKMRR3foD8kbi+yZe9Db1qkt9eevHNvAOgLoRMuwMv+BsyiUCyxvkLqHl6SGX8/tJNHzvqdhGZyqgGEIWlVvnugJOtpEBshVvcKt+0AY5udpMGFn8SASIprDkaEiWremw2pncwxbeML1HaM+jgGtPe86i+Z+dqaLeyOaBzWPVhlVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 23:15:39 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 23:15:39 +0000
Message-ID: <a0f6723b-ecfa-ba5b-5779-c7326cd31a86@intel.com>
Date:   Wed, 9 Nov 2022 15:15:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 10/14] platform/x86/intel/ifs: Add metadata validation
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-11-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-11-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW3PR11MB4652:EE_
X-MS-Office365-Filtering-Correlation-Id: 714b2e5d-0e2a-4587-711d-08dac2a850a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ug2tp2cGY2rbahMs+F28RTRKtJUtEQyIVl7dIIrmVPb7o9YKOzzsS6oWsvqfLyna9xCyICQKhbTI2B8bM8u4lde93hjUMsqgxrAvA73QIN7TuqkopPxRhbAEWyi8lFsJXKXpQl7C/lTkHKWN+EdRNkKsB/PGoeKnjhhwBBaGsPs6b5STXJz1IUqN74J+XjWaKh8QsREAldq/12kuweIhPl0Ow9rWh8qRAncOJEcCpmfDE0q9Gue2Fi/9RD9mqhkPsCQo3fgl8zemhlUbmfhFIchT46B2JJ96hvKAsL5TXrdphmPwfjmes0Q+CCci3iNlKpFU52aoAFCSCml7YTU4C2jaiP2uRiaC4SO6wDpmAUCtL32mqzW1jMct8pQ35ayX2IBnAAr22EokGPFchLLItjNWRm2CjcX0LXa4M+iDGV2utGnsmViUGo0yRR31AihTEXb9m107zXE9/o4snM+xOZOxuKD9yaBM2y8KUjhDrJnu8o9UKA8ZiOnmziHTi4Zy0j6vsNgDg++5kN2XmH2lQQDUGLOkFAJGv4deuOTVhrNmR9qsMgD00tNcAF7XyV5OhYO4AYQGa2rW0OZ+r9z/p+ESkdHycqyH7TA02sf7nQIhJeYw8EoDtOUDa4GjVB/vx0mcyB0ts2+7pudn+bXHyfYHg3zD+Y7tq1t4wfqTfCT3x5biVzjKDKfWiUXGY6Usw6TEMPF+FUytDHnTquHv+ynt/zhQqj5/WXWNfAGhsC6QgxWJ3uOBIolJbXAC8qYdnLylvlkPaAVoaFO2QOsLPkpPMjTnDqnu9x4MKgtG0LQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(8936002)(478600001)(5660300002)(186003)(4744005)(6486002)(2906002)(83380400001)(31686004)(7416002)(44832011)(2616005)(36756003)(53546011)(6506007)(41300700001)(26005)(38100700002)(82960400001)(6512007)(66556008)(66476007)(66946007)(8676002)(4326008)(316002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2Rid2l4TmlQUFR6dUxVcUgxQ2tFaTYzVXl2OEZ0Q3hFMndMQjhPRWVPKzdu?=
 =?utf-8?B?ZVNzQXVEY0xtSlJqbEVNVVhpSUZSOEljMjYzZXpJaDQ0cjBlVmltTlJKRWFR?=
 =?utf-8?B?OU9jZ2lqMWZhVE83UzVhR1Z1OUpFc2F4YjM5Ky9zT1MwQkNOYkVLMG43RzJs?=
 =?utf-8?B?ZE05ZGZ6YjVvOHNwMFFDell0Z3huUEV2WVdxWE01ZlNHa05FVlAzTnhxaW15?=
 =?utf-8?B?K1V5VWxFdnpvWFFQclViVjdkdTJEaDh5WW43eHJXVmJQV3ZTWldBSFdLN2xW?=
 =?utf-8?B?OFV1RDRaYlhZUXlpOHN4czd0SjBlMWt1SXhpQnN6Z3luOUU0bWxINlRxSHpL?=
 =?utf-8?B?ZlNqa20zYUkwalk1SkFCK29Vek83NlgzUzVKUHFqU1dPWWRwTHVYc29jUWpy?=
 =?utf-8?B?WFI3Q0pZeUhIM21xUUhEMjdaSE1zQ1NVa2IzYitVc1c1VmVTVWRKNGgzM0ZY?=
 =?utf-8?B?T0lTdkEyT3FoeG9vUmxMMkE1U1d4WkFtTWVRMi9TL0xITVVpSTczc1FrWW9Q?=
 =?utf-8?B?UitoUnF6WDZ3aU1nY3B1NUZBUkJaSmVkUDNmOWhxcnJ2VW1GOU84bGhUZjN5?=
 =?utf-8?B?UDB0RFI3cjVQWGQvdmRjZjBBUzRxajNmMkRsL01IS050NnYvMS9tQ3VVSnRK?=
 =?utf-8?B?c3FzcWVvZzJDcFllS3F1VTFObWhmN0t2VE1BREs1UEFJYzk3Nm1FMFBlMXVy?=
 =?utf-8?B?M1NkcURNZWtuazlpZWtodWlhQk9mckJQN0QxM3l5QllQZGFjOFVldzVQQThK?=
 =?utf-8?B?TUpPWkttZkNJTTFJWHVRb0E2N082SXhhOUFsZXVqUGtEVU80SVNOTWxXWjZO?=
 =?utf-8?B?aGJQdm4raEZPaGhIczRNV002STdOWHl6RG1ncXJBK1RQMFIzY2tLSjYxcEJB?=
 =?utf-8?B?RTM3ai9YZ003R3M5QndVMmI0Q25zZmRJb2JESHZLbFpMUENTdTFlUkRGRUpl?=
 =?utf-8?B?cmhOaHJkVmJWZzBzQ2ZUR1NCUVg4a1JDTXJWdkN0Z3hpMU9XSXhEaGpEZHVT?=
 =?utf-8?B?SUFXV1J3SkV1ZXJEdEhISVN5MlcxNDV0cy9TbUVFSSt3aUxkS3p1eFlGMnp4?=
 =?utf-8?B?cVVDbWdGZkRCUWhYaHFpRUhxTTdXNFQrSEdnb3V5UGoyQ09IQ05pSk1vYm9n?=
 =?utf-8?B?ZTBwd1FQQVFyQmFwQ2xjMmF0RG1sVEwvU1B0UzZHdnZJSlRIVVFOWjg4LzNP?=
 =?utf-8?B?TVFSZ2ZEMWRkL2l4U011Vk1qSjBmaS8vRC8xSW5HODRlUFdGR1ptdys4UTBC?=
 =?utf-8?B?eXZlMFdzUnVjV3JPSmR5WVJhQjN3dUxINXNqSzY1ditROHNkY0NzK095eDdF?=
 =?utf-8?B?RGo1Mk1PU1RlVTlsdjhvSkxLcmg3T1FwN0NBTU9ldWxxVFl6bEJ5ay9RdVVU?=
 =?utf-8?B?cm5JSzI3bm1LUmpKdHM5MXJPU2ZINmp3eE1DOVYwQ2djZ3poeGZoZHFraW91?=
 =?utf-8?B?ejFrY3RJVnc1Znk4VGlSSlRBY1hFS1VZWmhGNE1Sa1dHOG8rcTFqazZrR3Y2?=
 =?utf-8?B?cmxWQ0t4ekpka0NGSmgxOXBrZDNjZlBtTUd0Sk1rS25mUlZzUzlzSlNkNGRB?=
 =?utf-8?B?NUJicVprYndTcVRra0x2OHU4a2twald6TUhZZ0NHUEVqYWRFYXZhUzhHVHBF?=
 =?utf-8?B?bldZNEJLOWFCNUxWYWVLQWtrczdzbUVPN2VzUTkvaVljN3BValpyMDFVdmJs?=
 =?utf-8?B?YVpmZlBNbE9qaHB2MWlWclZJQlh0MkxwTFVhSGdxQ1U5OXJnRVR3YUxOZElN?=
 =?utf-8?B?MW5CZjZlOUx0cVF6cUYreUx3RHFqR0NIRktnUGJMZ0UvZlZHVCtsdG4rTDBy?=
 =?utf-8?B?bXpnNm1RMlQ5WXlsOUlOeWZ3RjZZY2NXZUZGUDYrb05HVUMrY0FlNGpUamxn?=
 =?utf-8?B?SW5vRnEvazdDQTZtUkFRUUhwaFBqQVYyNjZVRko1RlhvWWkrNGgwdDZ1V3Ju?=
 =?utf-8?B?VHZmZUpyTC8zVEdUS2xiZGZtek1PM0cwQlZZWkxMMVkwM3JvVS9xNjFqTzlR?=
 =?utf-8?B?RS9hQVhCYit0UTV3VXZVTEE0azZvVEtsb1ZOa05PMVJVWTNpQjlnVjFSaW5G?=
 =?utf-8?B?RjI1ZHFzRkJ4RlZ3WVVTaGE2SnhwcVpkSTVLLy9hZWcxbjR1Wm5tbWRydERk?=
 =?utf-8?B?dEtpclBZcURBU1ZJRTZzT1hxUnVuKzJsSStFKzI0YW9aVUhrRzB5cFp6TjJo?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 714b2e5d-0e2a-4587-711d-08dac2a850a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 23:15:39.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7kCJWShXJUQQfzER9sXnipKNLonQL8kkDT193HKXPeQMc8XHlo+jTc2dnNX03t3em5d/6/rH9KgmFVuZiSd3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jithu, I replied to the prior version of the series by mistake. 
Duplicating that comment over here.

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> The data portion of IFS test image file contains a metadata
> region containing possibly multiple metadata structures in
> addition to test data and hashes.
> 
> Introduce the layout of this meta_data structure and validate
> the sanity of certain fields of the new image before loading.
> 
> Tweak references to IFS test image chunks to reflect the updated
> layout of the test image.
> 

Can you provide some more information on the updated layout of the 
metadata structure?

Some parts of validate_ifs_metadata() like the ifs_test_image_ptr 
calculation would be easier to follow with that.
