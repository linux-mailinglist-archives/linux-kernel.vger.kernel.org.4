Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B795626317
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiKKUll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKKUlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:41:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6695685470;
        Fri, 11 Nov 2022 12:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668199298; x=1699735298;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h7tPJ62auIUdtIA5wRiROjIdSrpSKLBVVMjuL1NEWXM=;
  b=f6IrU2yyYxAH9OBrgOh1MubPUGoB/1HqGajCvgnQqo8bBW53WCsKsVyI
   3kvTYwpqPhRX/F5yRKoKUW7hujVu1PpyXV5iDJERs1zI5ZZpALDxt28pU
   DrTZhXpUx+cSIQVv6sQtJYcKD0PDVK2kShlP5IY7XrpyCcei3/nSQnasI
   27oSIi++Xq/CshaEAUQwJ9syCSb1N7wdu2AcLdmlGGFh1z+2BCO4k8VKM
   +Lf6plwdJU5s2uJxQA9c3Q52c8/yjWS45O+glogImEK92rzrrjaM4dIYS
   pwBQ9tChOsQnSEU+ANG+ldiCVyc3mMmp44bX6xX6suKYIL1PaOZYPIfmS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292064983"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292064983"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 12:41:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="637685785"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="637685785"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2022 12:41:37 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 12:41:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 12:41:37 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 12:41:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqW0YS8IgX9HlOKOEDUUWhNOlwIXByJ7rE00OPQZj2Dc95XynnsqxKbuPhkSnu97njgh6FCfDPnKl/61YdwuUoZzcnyzlbi15Wn+U8zizld/lUQqm6LElzQ4D3UQdSqAR67BszO1ix2aXpPoDDqnLXPL7YC7je4/RjGXtA8rwfdxX0WWgzwgP9zZ0hui/W0kMCOwd+Y5xjHXVQzTRpC4J1i3IwG4vEcHAV74grWSUBZzDTQ0ShaYEekl3JNjqcNUeYpjks0TK8PSpeVVgF2BkT7MqwPX68kM++nnIrLl5f9JuRN6wKwKhYidKKWzUXol6fQ4LGv7Q8FU/xAp72yL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yOPejRcJ868YKxug14SB6mV6UDOhRgWxLD9+ggmJZ8=;
 b=mr6zBqBHy0iHPyt61fb/BsL5s+ReCAfiamWtHXIt8IAqDeAR9GnosrCA7ANZbQ1OkcoWmL7ajIT5kqUvhFLRLXe458bk/JnUzQTUFj4+QAbeaL9tlVaET1HpkOlYcjsvCmwiW5vFz+Ff3WyTDUwdgkJjFsxZUzaVJUURJnmcufZcE82j1PcM7ATRID8mk0wNlFM3BFOxvWAhLbcG8VO0LAFoQNTdyCuuUOPEF471Q8w8+2DmvrKPdi6FMVfySmYaqT7+jhuQGUdTHVmTFt2ocI7aysaYr3HMy0BiKq07PiJyEox0sG34t9Q8jiQQk6SOXCn/gToPZWI79IZL8cDx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 20:41:32 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 20:41:32 +0000
Message-ID: <4862f68d-090c-c73d-0711-2677a20ef874@intel.com>
Date:   Fri, 11 Nov 2022 12:41:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 09/14] platform/x86/intel/ifs: Use generic microcode
 headers and functions
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-10-jithu.joseph@intel.com> <Y253FKtLnmV3r7Kj@zn.tnic>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <Y253FKtLnmV3r7Kj@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:a03:100::41) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|CO1PR11MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: c1846a18-e26b-43a8-c728-08dac4251dee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcBUyCJQtn1pgaTA8mK3UR9ehmHVBgrVtsCdkhjFtwontAlDuuCM/d7mKn9guzXyo3p4bBKm/UmgRtpoaEWuKPOmS0Tgjf1YFheU7Kvdru1Q1oxJ3R+rFYxtonlzSoyKokPAzKX+oDe0LXl8GQwVZKvVKiQWlHuqKC6OXvoYQcdK9N7y06y0hoRw4r+e4QxTsBejQsc62CrObF2InQUymZSzCTkrO4ZDYHmit4OWfT0nUKIRF6ekuF6QHNImNgrXsooM6+XCAbIH3Yc1bREeLvuqJaoevZngwlarUGOJnHBS73ohVms5PyR3SbG4vMFUg63FlozLG+c61WbHZUpl44u4uyUKAJUyf3/kY+BsCCoOsaPT9StZDGpcoTXURFaA/N2kzZhbotS9xvIBjR93640uQJ/fl+2tyIX+f0PeK9j331OalvNt+QyypX0SaCTQu+5uaIS4dBWodKwmLwt8pUeRMA1zdyHqm/V/6/YHf+ejcqzknqi3eZxnOuviLt9WKs0tThKwsj+dXZq72oPurTW7PSnr2AY91MJf8QXAlUNqenHQM+sitNAFgj3NcQwbJuGt5bMtld3eOFOCDk/xT0dFfHGIqKiK1+GH6W0eJtd7Y+sunItLCbtHCxEYa+MD1QQOcvmrAKZ8Tkryv3xi3U3q7ERsREYXkEVf+e8jFFWRJyyWeSgtnmphdEqJNRkeE+tzx4IWk1fu+UVb4xg/5+EucB+BCuc1VxHdaYlOJvV9mFwFLNcXf6chTCohN3JBa9w59aVLKBHo0O6UJk5ObG+a1C9P4LZcs44j63fJ2YQs5KWZtawb4/+CICZJ73bi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(83380400001)(6916009)(316002)(2906002)(86362001)(186003)(2616005)(31696002)(6666004)(53546011)(6506007)(26005)(6512007)(82960400001)(6486002)(38100700002)(478600001)(31686004)(41300700001)(36756003)(7416002)(8936002)(5660300002)(4326008)(66946007)(8676002)(66476007)(66556008)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHNiYVhrME5tMlRUTWVROXphZHFSU3Z2aG9RUnRUSGUwTlAwNjM3UHgxLzB2?=
 =?utf-8?B?K1hkSVF6RjFXSk45UkpQNmxvWnVQZ3dXbjByNm5iVW1BZmo2a3ZmN0FsQUJV?=
 =?utf-8?B?dXJ1RDV5bTdsUkJPV3oxYlV1R3lZdTVjMldlYWlQb0U0Y0FVM3JPaWprNXB0?=
 =?utf-8?B?dk9FYzJzejNuTHNyQmx4OUl4dVZJNTdEL3BoQi95TG9kNWhua0l1MEVMRDRv?=
 =?utf-8?B?K2NBcm5hWnNCaEhLakdtTUN1MDlENVI3QnhTdm1xNjRNa3lGZnBkM2hVQmg2?=
 =?utf-8?B?bDJHWFVYU2ZxRjl6cDluLzBlT2tCb3JyT054VFpUTytZakgxRll3Vm9YSXVU?=
 =?utf-8?B?UE4rYnJxYWdqZFA5bXBXOURmditxcGcxaEhVb0lIQ3R6ZXQxUEVuWWZCVk00?=
 =?utf-8?B?anVKY3dHcXZiQVJTc0R0VURqb3djWDBQTkpxNVZmRDVOaGVPdUZuTDBEUmcx?=
 =?utf-8?B?OGZRd0krQjd4UWpGNmR1L0phYVZQaDlTM0xwYmkzc2lBVjRZUVF6dkRDdFFV?=
 =?utf-8?B?RGZpVndUcExpa3lqMXRTSUtpUGF0eE1SaitoWkVHRGMxbXlrYkxWekE2MDcv?=
 =?utf-8?B?aGpqU0I3NTBmNHNlUHlhVEFzaVBTWHpKMGtYSkdmZWd2Sko4Si8zSnZNY2Qx?=
 =?utf-8?B?RDZQUzQ2alNzcjM2OExjVm4vQVlnNER3NmgrbHVJb0RpU1czOHZJWC9TWEhx?=
 =?utf-8?B?aGl3eGZEeEhDSHN6RGlQVEZBR1dkZDJsYVUzK2VJMk92QXVqY3lEdk1RTVBi?=
 =?utf-8?B?cG1BOUZSVDlGWUw0bjhYS0dRbmVzdTR1Z00wa3pVY0p0M0FTdXlaSWNMZ3Vo?=
 =?utf-8?B?TEJ3bVdValZlclc0ZjBhejE0cVhtcjgxK2k0cHdabzBLY25kb2xJeEFGUjRa?=
 =?utf-8?B?UDViSkJldUZZdktMREd6bDZyb0lVOWErVVlZMnVsellPbG4xOXdvcUZQMHli?=
 =?utf-8?B?UHo5VVhLUDYwRjYzN1Jqa1AyeVZWWkp1SlBNcVpwZklpbWh2R0wvalYvR2Jq?=
 =?utf-8?B?K0o4c2J2cklkd3gzNFFjWjVPMDF2eGh1UWYxY1dBNmlGSmlaS0FQKzBqYTVx?=
 =?utf-8?B?OEVGZDFPeXZTc3BjOGMrN2hiZ296aDZiVjgrUUNybkkvcGJMRFp5eit5clFN?=
 =?utf-8?B?d3M3RC9seXhhMWgyY3IzZFRaR0c3c0s0ckZxbngrSEI5L3V3RjVVcWJzbHI3?=
 =?utf-8?B?L2NacnhSblk5QWk2VDBHQnpFdmN1MndXemgwQ0JBZnhGWktrU09GNHo2a3BW?=
 =?utf-8?B?d01kVGFvY2VWM3VDOWdOd2UrSlBHd3E4MTZZTzRpVEZJelJjOGl0OUVSRDdH?=
 =?utf-8?B?a282ZHpSby9zYkVtUWtnZ2p2cjRQc0dINkdlSXBUY0s2eFFZRTlEenBQalJ4?=
 =?utf-8?B?WGFEN1NmS3k2bXVheTlRSHlZd2JNT0RXT0RKSTFCL1hna2tlWVE0RXA1dGtW?=
 =?utf-8?B?SkZPaU5DUFBwang5ckRWT0YxeTczcjNxWEVubzJ1Qm1xMFluT0l3OGM1RjJi?=
 =?utf-8?B?bUN0bzlRL05HMnpDdGJYS1pYZkNQaitPR2o1NU0rZkxuMlNYR1VHR1dBMGdP?=
 =?utf-8?B?cUxJK1hLcEZBa3pHWXNpdGIzaUlmS0NPRWdNdHJqWkhYOGtIRWhTOTF0bFhh?=
 =?utf-8?B?bUhmVy9wTkkwV1h2c1RGQ1BVMmxiZGQ5T2Vwd0Jzby96QjA3UG01dkh4UExC?=
 =?utf-8?B?MXRlWUE3ajh0TGUvM3Y0MjROUStsNFNEeUNUVzJZRE9JV2NWY2w1czNzTjFU?=
 =?utf-8?B?YVpEeWViNGJWS0tGdVd4dFIrcXpUMDRxUTFaQ3dqdUlUQkp1OEp6c3Y2RGlY?=
 =?utf-8?B?WDQyUzVUVnpsbVpaeGJVVThNMGhMNFBWU1ZlaWNjcFgzdE5jRFlaa1Q4eE5x?=
 =?utf-8?B?aDhJUzEyL28zWFRHQndIMEhJSkNmU2lZdkNDQVJNWFRzV1pQdVB6T3d6dzRC?=
 =?utf-8?B?c2ZJSkRkWWpDemZTSWFFOEN5bVpwQzNnRjJqV1ltOGpuTm1zWTg0SEFrMTRW?=
 =?utf-8?B?bm1IQi8vdDF2eDc2QnpYNGhyYmlnY3ExdjVsdjZ0VEhBZjl3NExaTXZWK3Nr?=
 =?utf-8?B?ODdKcjVjaE9oVUVVek43ZVJsZzN2N2pkeGV1YmVYL3V5dWc1S1BaSVhJTEFE?=
 =?utf-8?B?N09YWDJpcWcweTNYclRtRGFldVgzNk1KcWJCaThQcnBzbE9yV3FZOThUYUY0?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1846a18-e26b-43a8-c728-08dac4251dee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 20:41:32.2462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5arR2lba8uSiA2CPxfnVkjeLNveb+9DMriDdjnhQiLdYbqmMobczsoZI17qTM34BrSCGSKc9msj66epTa/LFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
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



On 11/11/2022 8:23 AM, Borislav Petkov wrote:
> On Mon, Nov 07, 2022 at 02:53:18PM -0800, Jithu Joseph wrote:
>>  static int scan_chunks_sanity_check(struct device *dev)
>>  {
>> -	int metadata_size, curr_pkg, cpu, ret = -ENOMEM;
>>  	struct ifs_data *ifsd = ifs_get_data(dev);
>> +	int curr_pkg, cpu, ret = -ENOMEM;
>>  	bool *package_authenticated;
>>  	struct ifs_work local_work;
>> -	char *test_ptr;
>>  
>>  	package_authenticated = kcalloc(topology_max_packages(), sizeof(bool), GFP_KERNEL);
>>  	if (!package_authenticated)
>>  		return ret;
> 
> Bah, how big is that thing so that you can't simply do a bitfield on the
> stack here instead of kcalloc-ing?

Will modify it to use individual bits from a u32 to store package authentication status.

> 
>> @@ -203,67 +174,33 @@ static int scan_chunks_sanity_check(struct device *dev)
>>  	return ret;
>>  }
>>  
>> -static int ifs_sanity_check(struct device *dev,
>> -			    const struct microcode_header_intel *mc_header)
>> +static int ifs_image_sanity_check(struct device *dev, const struct microcode_header_intel *data)
> 
> Yet another static function - no need for the ifs_ prefix.

Noted ... will change


Jithu
