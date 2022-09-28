Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE9D5EE942
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiI1WQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiI1WQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:16:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D5BE21DE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664403410; x=1695939410;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S1kBXVF6e4wfy5SyE7/rKWHprj/L93m5IFKvhHOGMZo=;
  b=BJ/7jovvjFyrSiZn2mW/dgmRLAdgVt0XsZSk4vOQWk43GLnPlnGTYGIQ
   n1J9K78DiBza1BMvJilTMx4IbQhdN9C2XHMEdWxN/c/ItpEDGGjasGPNc
   rTk+BuufZpkGwoAuU6mZ8nSX7nxdF/yD+xBDEkw2q+f2syDhh7lN4YD5V
   VYSuPP0LU87Be4GHF4MgJSVj3aDbuMD8fcFL0j4Lg4ffp/BOSZ7/n59yw
   lPXEry6VX/K+ukfdOWpXe/3Na48JOm3IFBLUFX26/WkOO9watcN/IkZIP
   7wOWs+SX77DPWrpvyWjZTrVo14BkMkDmJVR92xZJlYrcH90fIBnXl79Ec
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="299328834"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="299328834"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 15:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="747588302"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="747588302"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 28 Sep 2022 15:16:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 15:16:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 28 Sep 2022 15:16:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 28 Sep 2022 15:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtRQdYTL9Vf+la4u0Rl33XM90kgCFrGQrfk2Y+cIWUfIcEnWizRe+3mlTERRYV2v3eUFYRt/jB3NRhQc+1cwlcc8XaIH6/rXDTeyPXHfMQwxnsdJbLhWb8iMBMev9nKGDH06fKR7zT4/KBX7LKAJvWclXGuLC/7KTKY1qCTL0VVTKL6obmF0I7kPdIwHcBeL9yxC8gKlS++GAMxAw30JF/dO9ccmn6Wlx0TD76wmshbWjluk3APsjelRNXaQcAa0NGud53By2gD58kYPlzIFO53T02OT1ECOkfqaa34P5aix9Kkn99MS7TlyVFtFLdMhJ5G564PiqSeW2r92K4bwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wASU51dN8r0nYhpbjqD7ffIK2uvcnbbVjZUUKs3gBo=;
 b=mSuWGBNQ5rneeAWOEzd1Nu2efApDvj1TXTGTAL7VdEeJU87Myldqn/Lx4KbMAiMDLzQPGjkkd66qa/5YSQCmIEJvrplhaIGcrce/ef6VJtsgCmPNhnO0KupVgM3GWEHJFFFwbGAYQIUge+zxKRt3ERBVeJ21mXW5R0nhbwpz/tWChD3uKL6SrhwIgTty4/u8sfBO7LI7fGj4r2or5KuPp3Uib9I3c2Ves26VCm3KxUbcb/KJ5IaWllYPUGstIK1fL+Jqkh5Kh9EzT1uAmNMurFIBEP6NTBGIv1NJJPfMjIuwNY6Az2+fbWyk3NKBuCpJe9793dzYEbYj7IarosVdIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Wed, 28 Sep
 2022 22:16:45 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%7]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 22:16:45 +0000
Message-ID: <16abaac3-d73f-2d00-f785-a16ec32139f1@intel.com>
Date:   Wed, 28 Sep 2022 15:16:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 4/4] x86/fpu: Correct the legacy state offset and size
 information
Content-Language: en-CA
To:     Sean Christopherson <seanjc@google.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <avagin@gmail.com>
References: <20220922200034.23759-1-chang.seok.bae@intel.com>
 <20220922200034.23759-5-chang.seok.bae@intel.com>
 <YzS3SXVxJOrC/k5X@google.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <YzS3SXVxJOrC/k5X@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::18) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|CY8PR11MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: a70fc982-8f7e-4b49-607d-08daa19f2144
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oj/8S2zvnbVGp844T7i4hEbdQtWCAK2A+23RaDfy1xryLMZUYn10ITeTeXlMm99YWSnL/xsZR+8pSenYmNZo89qD1+WB2o1o4t14J37fX8yfKHjKIydtyrfJYl7jUnTHO87Nmy2Azx4nPYg4xKxowEGBvqf10xpSqXFXol8qcdiX/AcH9j5a4mCEZz3aztJKHaGEjrE27bAqlVPJNgrE/o1Rb81uS/iQgFHB82Dj1moOy2PzjcKO0pT91ZUjTerTyUNfXu9yuFiyIS9znvSYL8XJQqeXA4tjxQNCJ19eTaG4eudaeMSyahi6SvM2IruvgOgqP89Vi4MPuUHSIkOY5Uuk1TTw8Gk4ToXEwwM9ssb8rh/qkhFQlTAu1IZTFjy76+fYTkcriFugI0CM1NbzkpXIgnSehX9T89E+wYtU9S4d34vktiVnu4T38YfSxdgOltLoMAm1bHyNQ1jsjDXd4Lp+HcNtC1PBCncuLc9SC2suOup3hcxwbsiI7AUEEYeifxHhyIIjokhKly5kOEew/gM5MaFE8D1O1xg6M5sBUgLvrAcmWYGYAq+k5KcjnT0eZ1quSnuHkKhk2oX4Yl/PgObgK+fFr9DQnkZ4PfmFoiQMpkaxQE6fUOmkSynsSE4Cp5rYtsGdVr+Mju/V3PaY1KxSZcqJGkr7aM6QDj0VGr5gLQW53G2YGWjwbg2/dzRITomm+g0CiIOamL3H5EC1NwYp900CAJUO0EFKTEQBSvmBxZysxDpZuaZA9aKA5UTK2fO15rlx7ff1gsB0GrBma+dXnC7sklbtYPr4zcdvJVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(53546011)(6486002)(2906002)(6666004)(6506007)(38100700002)(36756003)(478600001)(316002)(82960400001)(66556008)(8676002)(4326008)(66946007)(86362001)(31696002)(41300700001)(6916009)(8936002)(5660300002)(31686004)(2616005)(186003)(66476007)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzRnZjYyMUQwTGduOVpWOTd2WGh2dm5mVlpFNENmN1J6dHVvRmZ3WHBBaGZX?=
 =?utf-8?B?dlhmRnlhSXY3YTc0ZzFOUFdNNE51YjJIK3BpaUJjQmZYeEVxdHdVMFpGT3Mw?=
 =?utf-8?B?ZlV2NVRzMldRbk0yN2xOb1ozZWlmMDlEcXB6bWE2VGtYY01aV3B3dkIwZ0tv?=
 =?utf-8?B?NTFIQmJNM21uZkF1U3VFWTJ3S2djU3lyYUhaRWJUZHVMci9GWUt2d0hlTUcr?=
 =?utf-8?B?eGU1K0Z4aDFZV09UYkpCUDYyNGhaTkxHaWRkN3VRbzhDOVRBQlRMMk9QamZW?=
 =?utf-8?B?Zlp0TVRxR01ROGJ1K0JwYkZtK3c2QW9qUHRlcUNOSnBlNkNvR09GVFBCZmZL?=
 =?utf-8?B?aW11UjRDUStSYjlkY2dzSlFTVHV1bnBqaTFWd2xsbFpGanB2L3EyanBub3Bm?=
 =?utf-8?B?SGdFa1RXUjFJWFJNVDArTHdvTjBVbElPdE9JSmRvT2p0QWtuOEdITk5tMEwr?=
 =?utf-8?B?Z1hORmJuUUpPVzlVcFF6WkUvSkEwTnVxMzVXTDd6TG1STWZZTGw5TXBSQzYy?=
 =?utf-8?B?S2dYdEVGUm9RdjJUMHRIMTQ1ZnhMUU1FK0RFRVpkK1Q0MXovRi9UYVhqdHlq?=
 =?utf-8?B?UzZsSE5yZitFZHl1dEhDVTFRUGpmazlLWTFZQ2JKN2NOUEJEUnpQMjk5aGxP?=
 =?utf-8?B?ejEyQ0duR050bE1qd0pvWGlpK3A5WUlkV3NPRUxvUTBNUTZZQXYzaE92T3Zw?=
 =?utf-8?B?dW1hRUJZWm4ycm1NSlV2Zlg5cVZnUTNMUytCMXRLZ3JuelFIQTFtNUh6em1E?=
 =?utf-8?B?elppQWh5TzM4dDYwV2dEcTNaMXEwbjJTWHZtK1dJTFJiU3E4NmJPUm53YU1J?=
 =?utf-8?B?SUhUZjN0MXBHRENEQjZSUHhoL0VMSmdXK3JYMzd1MEp6M0JXMmxuZnBpMC80?=
 =?utf-8?B?MXhwMWhYY1BKZ2hpZjZKQ2tjTjdwN001MFFDbjMwZVdrdGhGQW4vREtoTmE4?=
 =?utf-8?B?RWhxYWJaQ3k0TlZTTUM0TmFUSzc0NnpqVi80RkZZT0l5ZGRFZk1qc1NyUE1w?=
 =?utf-8?B?dm82a3o2ZlFiRG1nczhvOGI3TU9VSUtzSUlrUWJjNGp0WGVIdURJb3B3Znl4?=
 =?utf-8?B?cGQ4S1hIVlJFNDhjblVPREdkRTVYRko0cUhrSWdDK1hwZTVxZXZsWFgzQ3hP?=
 =?utf-8?B?S3pJYU9ERHlyclpWaVd1ZlBWUkxGeTdHSGozRnJRREZEMDYwVFlpdEpXckJV?=
 =?utf-8?B?SnIxZU9kY1NiT3lDRVZRZlBMT3J4Z3h6alFUa2JJNWdETUh3Tm1SZjRodG5K?=
 =?utf-8?B?THMyNmdJYk5TL2NVNnJxUHFIczZUZnhROHdWMDBjbmtCY2IwRVJrTCt5NjZW?=
 =?utf-8?B?TFh4TnEwSDVrd2xXYVBlVVJMRXNRR1NjTndmc3Rzak51cFhnRWVmdUFQaTM4?=
 =?utf-8?B?ZHhjSGVTZXQ5S2h2RjhmTnptTktPNWZRTm5rSG5yZHdOT3dFOXJCZlZic2xr?=
 =?utf-8?B?VmdqZzVGdmRvZG1iWmF1R0MvNkxMNFVtankzOCtyRVdLZFFQc1FSbUhzNnRT?=
 =?utf-8?B?SWUxb0JvU251Um1xSlh6a2VLM1dxdlBUSFhFMlQwVXRWVFhGQ2ZObHN2ZE9T?=
 =?utf-8?B?alg5YTFtWThsaUptTlZXb3FBem92VGdveXdkZFBpaTRjT3psSkFROElPbWgx?=
 =?utf-8?B?Q1RidTYrcTJrRVNiY0RKOXNLN1V6T2JGWHA3VGViYXZrdGc3WGlFckQ4aEFW?=
 =?utf-8?B?dnlDYmxGbHNta2p1SU5ORW5McTVkKzFTRVk0Nm50NVBFNXRQMFBOMytHLyt6?=
 =?utf-8?B?eUVNWXdaYitlTHFhTDUyTVEvZDh1ZHZ6STBmV2xPeEZEZzVNY01VSjc0SStT?=
 =?utf-8?B?OW1VYkdUbGt0bWJJL2k3UCtiMUJyZnFpN1dWMW9QUmJMNUFXQzVWRXhsNVFu?=
 =?utf-8?B?ZUR0ZHIrQU9wL0d3Tzhjb1ZGN0t1VnJxVmhPeExCUFhKRDJSZkVOb1B1djJZ?=
 =?utf-8?B?aDJIYUpMUGdqY20yYnRDZDBvdEhRTzZMQ25KRGl0aWxuajREcDcwUUIxWjRt?=
 =?utf-8?B?N3V4UnNFemxqOFlvcTJqbExBK2VIRjVZN3dMN1AzMHdZS3c1RzJPYnJhTEVL?=
 =?utf-8?B?cS9JaG1XZmR4Qy82RjE4c1JjMDVGT2h1R2w5eHlrL0lFbEJsK3E4V1liZjVN?=
 =?utf-8?B?elh6VDh2bk5WTHVEYU5KRXVPVlJiOTFKL3hTNlljN2xVNXV1RkE0ZUJualdB?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a70fc982-8f7e-4b49-607d-08daa19f2144
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 22:16:45.7753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+2g9RcQHFLRAW1D00o6pEUy6ufTptrAb37ETCMC8YDJf/qgHQu358gdhgIscIatA9xdTzwtZ7OfxmKtQZpAZJrXXMvAcF0YrEgoVfEaLVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/2022 2:06 PM, Sean Christopherson wrote:
> On Thu, Sep 22, 2022, Chang S. Bae wrote:
>>
>> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>> index a3f7045d1f8e..ac2ec5d6e7e4 100644
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
>> @@ -143,8 +143,13 @@ static unsigned int xfeature_get_offset(u64 xcomp_bv, int xfeature)
>>   	 * offsets.
>>   	 */
>>   	if (!cpu_feature_enabled(X86_FEATURE_XCOMPACTED) ||
>> -	    xfeature <= XFEATURE_SSE)
>> +	    xfeature <= XFEATURE_SSE) {
>> +		if (xfeature <= XFEATURE_SSE)
>> +			pr_warn("The legacy state (%d) is discontiguously located.\n",
>> +				xfeature);
> 
> pr_warn() here isn't warranted.  copy_uabi_to_xstate() calls this with non-extended
> features, 

I think patch1 makes changes not to call this for legacy features anymore.

> which is perfectly fine since it manually handles MXCSR.  And that helper
> is directly reachable by userspace, i.e. userspace can spam the pr_warn().

I don't think I get your point. I assume that helper is 
__raw_xsave_addr(). But then I'm missing how it can be directly reached 
by userspace.

Thanks,
Chang
