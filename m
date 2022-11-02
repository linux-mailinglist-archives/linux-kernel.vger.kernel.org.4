Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B0F617065
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiKBWLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiKBWLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:11:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99995BC3A;
        Wed,  2 Nov 2022 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667427044; x=1698963044;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xMbHAdmJUtGW1fSUnnGwCmDWcCgurHME16ULXruNptw=;
  b=DhmEVn/ACJiTQ0GqFYqBJt4VhOyHvTnqdWJF0WbKKxaKvvJmWS2h+HYs
   Ne9Pb9J/qkKnONGh0qgmaeMtNdPl0HT07aXKglfXOwz/H+eDm4KUYpVAc
   btCNnwfwCb4sIovzhjh7ryETRpcDFamVF13hcu3kuH09PaekGfN8DQYuG
   69JxlpSwhX7FjcLNdSEtQVbXq7IIRwQVjxGzMhWlLiuOsweegC6GY2Bom
   4uz4BVkIvAUevdo6EUOO27pMYe/2QK+VUpw6fzUaubyLjsooR2fM2/WG1
   jQfHHRA6mvkIz2Mm9nYtknwra+zy9hZ5BSrX2Pr8AoyrI4LvOL6XNdxBD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="373756750"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="373756750"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 15:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="665721780"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="665721780"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 02 Nov 2022 15:10:44 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 15:10:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 15:10:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 15:10:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1wLIHwwApFbO2Oo+kfVD90z2cTl0Pu7S8Uz0TsjFvaga/ugp4kvMTei4XPd0sp8OAjkn65/OdiVhMcbu/AEAlObBJ93AvOrbI7Sk0+FAl5nFc+AVcm18VLJGkWhNpZNveTgvbblPHHVPEhqlK2WGX73xNuZedASm+8DsV/JB/IbdRTfOuMqbF6UneLSEjYJ0Mcm3z9Y/n8j8qe4m8xmfFfoN4FB8aUDHvzSVqAojv8mD5cVGzaBVA2iWdsa1IrlJwfmL7Gq8Wrk8kdyJGMSehEUN+NyNFOkcEt68VxhPoK4+/rDNMz8RGkONNMB412ruxupV83WcDfWEx0zQbgcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Hza4pnRRLsx7WwHOxD0f7HcrXrujejwcKnbT4M3UQY=;
 b=m+mIy9x1/H0XqcT105dnrMXvmH1w5qCBPqhX5Yk7xita21zoHtX4XQ1JcS1JYlxHAXjZTPrs+oLrZ5q7bB/INir2Gsk0UB5ZNfhvFhwDgEQWYDWbgPIImPT81ksXiVMB6Y3VPT1YScy0NzOS5JHApqlFl8inVdsbo6d//gJ6W70R2muawzvviuEp9naPXYvVP3lSuw6E6dI3yeE02JlRSm6ieH4ftFdtcjtQnusYp/A+Jg0sjkpLDRTdxQoanefRya+QiZXhlxgveXfM+YHxvcyMwuYARBaV58r3lqBhBR3MdvD4lZu7Lk/A/NppCZeJeZCdjNvibCGdgri/c2/dOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by SJ1PR11MB6202.namprd11.prod.outlook.com (2603:10b6:a03:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 2 Nov
 2022 22:10:34 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 22:10:34 +0000
Message-ID: <e11f09fb-4037-1869-65f5-a83786f513e8@intel.com>
Date:   Wed, 2 Nov 2022 15:10:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 13/14] Documentation/ABI: Update IFS ABI doc
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-14-jithu.joseph@intel.com>
 <0722deb9-797b-c8b6-ac15-a6d9a7d50a67@intel.com>
 <511d9020-04d2-0deb-5f92-a7b2d6b9830e@intel.com>
 <d8f3fda0-5c2d-f19c-23b7-7df6ac38ee41@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <d8f3fda0-5c2d-f19c-23b7-7df6ac38ee41@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|SJ1PR11MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e86363-3c4a-4683-91ac-08dabd1f1084
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvImE8vhYklrfdcqLayS0Nry/DaVrwrYgm7tfF8+IlUcRNMjC+Hhu3NPUH+kZzaJOzEGz3OJQd8WYE/C3fAkaXMXwaZTRBhmuyS9FP6NS6ITocEFxE3qp0yUru7Bji1fOPjbJrBoP34hpnemu54iWqh+ct54KcUto+C1TiP6cXTihbdhjhTap25TTq9AnsZei8kg4krM7FqiTDB3kqk7DmID1gtfJowyc4O2SXcLP/ZOFB2uPsNSsTRnnlEX9t3qx4titLTWty8iY/hiszMeGflnTA3JgAuL7i2KomF56axOhwHTa97c/VswLZh/rAuzGktpDuzTDP978yEmFtnRQFS0BITe9CAnnegQL04mnp6P82aXzHplKRS0tI8VcsrHV6f3vlx0QY972VUnJEBkwkm8EsyKCdxBfp9odTm8kOtvUcMIAv1vSBBv1qqkR9lLA3e+fIWAKq1VvIbDr0gU0Tc3LAIM5327J/8XXAwbij3hlx+wJNsJiJV0EteO8zpBKCXISVQyN5IieJM1jnHH734OmOed+ndYJ0hZUs1h9b6kIOyqVJGDOi7ym+RQxWpR6PonqOhRDxzXVAH68CC1RfdDW9XoiaMYWNECERWuDVV+LbFd/4+X2i46QerGSgsHC7hXC8O6vMUq3O1VcYXJaAbNi/cNB7hK8oJksD7kxUPs4oHeCU+mpHcJUuFkuM/U7TX64TVGyJLcHmEoVodNoKRCpLP8bURXB9pS1cQlOSs6eN44jC/LwPxEl1vVQj1DbX9TDDE5jQvnWo9hkeDx2nN0BzwBQ4ZGAS/0NsCpvmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(31696002)(36756003)(86362001)(66946007)(6512007)(41300700001)(4326008)(66476007)(8676002)(66556008)(26005)(2616005)(6506007)(478600001)(7416002)(186003)(5660300002)(8936002)(6486002)(53546011)(316002)(38100700002)(82960400001)(6666004)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTlRU05FSHVwNUVLWWl3U1BPRFNxeXVwWEUvTXh2MUlMZnh5UVc1enZZSHdH?=
 =?utf-8?B?cVdiN0Vob1VhY2ZMczhHa0VMVWNMc1pranp2NkpjU0g0N0dNajhUaTBPeFNa?=
 =?utf-8?B?Z3FGWm5rU3pnUTE3U3JqQW8yTFMydmxTZitmUmFadXJrTFQ2ZlZHM0VrR0lI?=
 =?utf-8?B?cVhrd2E5VFgxN1l5RWFPa3JRaC9FbnFOK0xaMjZsWTEzOGZSUGtlRXk1Ti95?=
 =?utf-8?B?L2NLOS9GbXkySEJzZ1Q5emoxZWxFeTZhRS9sOGtBL0FnZ2hvL05RYTErSTBL?=
 =?utf-8?B?YmdCVkpTZng5TUxjSEYxL21oTy9wZ0NMUXJsL1U1bmF2TEFFdm43U05scFZh?=
 =?utf-8?B?TmxVRzFtVDdxWW8zNUtSL2hORThmcFMrNUFBQXJsczB0VkhOMmJlaUZwOFNG?=
 =?utf-8?B?dit6WUhDSDZ2RnNsK0FvanEzb3NXQUdjOEdNZ0tZc0hLS0wvRjFQYWxOVldH?=
 =?utf-8?B?cC9jL0hCVWdrWk9DbEt5ZC8vTFZ3SEkxS3NGU1Fkb0RQQzQ1QU1BR2NOOUVS?=
 =?utf-8?B?WU9OQ3cyek5ZUERJWTdBazJPeG9vbmp4U2F3YUpmYnM5SEVoMXVEbjBabms5?=
 =?utf-8?B?QWsrZmJycDU1enA5dTNmZHpXN29haGp5MHM2RW1LUElHN2o1eVkvTE1OY2tY?=
 =?utf-8?B?WFM3cTI1VmZyQlVmR0hseExBS21LOWlzMnZBUGJDSktSdXNaWFRBYndIWndV?=
 =?utf-8?B?MTlCTFJuNkx6QVRvdWtoU09IMEk2OEthalpud1JOZUhyM0wzVXROejhNYnVR?=
 =?utf-8?B?SnJTOGxnbGVXRXArZm8rbUQ3bldXbE0zN0Nmc2NFaG5rWHQ4SFArWWhScXR4?=
 =?utf-8?B?TnVQUWNNWnpkeEhub0YxVkZ1bVRQY3Y0Rlo3UGRNSDhKWjd4S3Y4Qy9LZGtR?=
 =?utf-8?B?ZVZ3cE9kWmhQci9pUGZTMDRZdmx4U2JFSngvVUh3eGcyS3dXdjdMWlgxeHp3?=
 =?utf-8?B?VFdEdHl0clNrUmNrdFI5RU4rNUlmemRvWHRJRFNvcTdEVHZXakNTVExMNERm?=
 =?utf-8?B?d09ZT0kyd0cvcTFhQUVuNnluL3RTa2tJcmloVkdMV1Vja25sQ0NjZVNjQVRS?=
 =?utf-8?B?bjIzQldnMFMxNUl5SG9qa1AvOFJTU1FGRWxGeTdyeitjdDRHcGtoNURrL0lo?=
 =?utf-8?B?aWE1cnF5MDl2QUxFWXZkU2xHai83akRKZGpDYnhnUWxuN2VFWFljcEFKVkZW?=
 =?utf-8?B?eDM2WDk5WDBYMDBVVWlQbDFhcEtRb1lYMS9YcTJsN2pRV2ZoVVJRd3BueVA3?=
 =?utf-8?B?a0l5Q1pReWtaVXZncDdZSUx0dHAzcy8xM3VrY29OL05YT1BoaTBlNTRsbUZO?=
 =?utf-8?B?MEhGRVJ0VVNrMXJ1MUk4Qitwd3UwTUVueS9zZ00yRDdBMjd5bDVEby80b241?=
 =?utf-8?B?WFpUQXErdmZjZGt1elViTGFDYm4wWVdNZDV4aTFtRVlPTXhEaFdhZkx2VEZp?=
 =?utf-8?B?RXprTW82WHU3Umg4MWhXaUswWU40cE9WRmQ2YVY0MUV0ZW5sMGtkamhtNEkx?=
 =?utf-8?B?SkJDb1BINTRWZitpeGFUVEthQ3p0ekJuY3NrSFNJeW5kc2Z4UExRRkJXUWNK?=
 =?utf-8?B?NVNVaEJrcXJncWI0UyszUVc2bGVndWdzYjQrNlJka3BaUHFpbjhUdFp4UDk3?=
 =?utf-8?B?ZXlIREo2aHIvRUo4Y1FMa3JSZW80Q2J0d0VWN3lLemNSWHluMERZK2RaL1hl?=
 =?utf-8?B?bmt0dys0SnhaTkthVlR2OUxUc0ZkVEw0cVh6YXdoTDdpZGVaeDFqSHNqWmx5?=
 =?utf-8?B?ZkthS0hqVVRjQlBFc04va2xtUDJwcVo0MWF0SFFFMXNqL2RyZG9HYmUxUURi?=
 =?utf-8?B?Z2ZVS0J6QjRwNmxlRWYrUUhHR3JSUkRZc1dqMGRFYjhVa0x5RHg2aCtrdDlG?=
 =?utf-8?B?cW1nQ250aVRub0Y5MEFYbkVpbmhXZ2Npbmg3OWhwUDIxUW1hL2J2dGVUSGlq?=
 =?utf-8?B?RWl1eG5YMFpRVXNLc3lRanRJT3pwMktOZVFlNnl5SlNrTmhVdXRXdUhERjBh?=
 =?utf-8?B?MnBEMVFMeUkyZ0JmVU5Zd0VoaGpmMHErL2lSVEw3ZGo5ekprZVlJQnlCczI1?=
 =?utf-8?B?L2FhakttNjdtTEFJcHN1eWNyVXlNZngzdktaUlR0QUVsYlJvcmJoWUgyMWtR?=
 =?utf-8?B?RGVaVVgvM3hHT2VRWHJEUFlaM3p4RGVWWEI5ekJ1KzdkTytac28va0Z1SUFL?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e86363-3c4a-4683-91ac-08dabd1f1084
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 22:10:34.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DsVGTNic0Y7uQig7nvyR9ggXukbdWukDCxU9ehy1/Vbmf2eonwG08u+cgOVAIgYqgcq3FAUszJQxs0jjGqRzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2022 3:59 PM, Sohil Mehta wrote:
> On 11/1/2022 3:48 PM, Joseph, Jithu wrote:
>> The testname would be inferred based the sysfs file context (the<N> in /sys/devices/virtual/misc/intel_ifs_<N>/current_batch) from which the operation is triggered.
>>
>> Meaning if the user writes to /sys/devices/virtual/misc/intel_ifs_0/current_batch it would look for ff-mm-ss.scan and if they write to
>> /sys/devices/virtual/misc/intel_ifs_2/current_batch  it would look for ff-mm-ss.<test_type_2>
>>
> 
> So intel_ifs_<N> corresponds to <test_type> i.e. intel_ifs_0 maps to .scan
> 
> Is the N to test_type mapping visible to the user somewhere? If not, how would the user infer that?
> 
> Would it be useful to name the misc device as intel_ifs_<test_type>?
> 

There is a mapping based on the device number, for e.g if the user tries to use the below sysfs file for loading
/sys/devices/virtual/misc/intel_ifs_<N>/current_batch

The driver will look for the below test image for loading
/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.<test_type>

The number<N> is same in both the above path.
Prior to issuing the load command, user has to simply copy the supplied test image to the corresponding /lib/firmware path

Jithu
