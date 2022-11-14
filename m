Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA916289CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiKNTuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiKNTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:50:04 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF2261A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668455403; x=1699991403;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wZt9InWzReahnr27Mlt/Qcpn+Zg9yddk1dMtUG170O0=;
  b=Ktl6lE6oys9fqRgHA9BcUKIoZtaby9xJwz/2dMMJyXlE50wQMuV/NY5+
   FrRA/SyBMvYF1rKkcfAj9/jROZKdJf1Fzg1dG/3qotfVBHd29VgVqVlFj
   9HJnQBsiDyEGS2ptHRVDmFq2K1O4kqk1YekZe19SW8233TUv2zqOSPEkD
   fN7aPHC84EzjvDHvvompcvQlM+FMP6SwPiqBCqsQigXQnATaOWiofFh1T
   tRP880JN/5Bo+dvIH37QqfehFUYDkVk5X+y1K68VfN0xxQmxL8tl8nbPn
   6bBWSZGI2UiKaceMJI6b2lnSrOPvKBRWxYJftQhdzKzVwJ8+8VZY7N9Gz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313214891"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313214891"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 11:50:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638628455"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="638628455"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 14 Nov 2022 11:50:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 11:50:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 11:50:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 11:50:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZS1R1RO6EdexRL3xmlBC0Nyn44sJTSpPIY+KkZH5R9YnAELK4n2I+eGepBde9LCWmx1XKZi5XDEIGdVRNFr2A4v17QFDL7+7nwYnUX2hmCZzsyq6BGK71j5aUAB/G79qGxa62IYSCyxf6Gei6P+NU2CNPSDpezEcod4kRHjhEpyiePlWzczMqW0bD8U9TqUl6uEHa0HvBG7wIh3FDUk5+2RgzNK8Y0FKeJFik6clLk7Jx2ozvmLmhWmM/YA2JYuY2kLKUmTF5SNGT5gZvcoeZJNCcOrqV17EeRlpcOB8nCq0P6RSVK/G0eNc6krrYKFzK+I1jF95RUe5uhTxXlMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93c9Hi+JAx3FQFpvmuXFEctHiD1dkXhONuYJl3aFmIo=;
 b=b7dUTgYIkikYFuDujEcWGfNdo/yUf8Vfv4gFsjU7vEzmpPZP6Ne+Tqa5yzakBV0crZSzvNDZDEVp5VTfU65dlq8IakLlK/sP8dRHVsPsLEwxFV6433BbFrKy0j5Q/3DeLSk8kkcA2co5og7IYXtbDgYEjZodHDNBN/8KNQ4DnzaxUqKltQYQ354VNojwMpdhVPOS+8NmTtqPGIpOjDR5xTAGY41KEp0zI0fuWpDsdDTT4OzXC5+JPKUyyzPJIU8rg5+DSvB7Ia9OwYTLEpF6aDkyYQ1JSUKW+IORjDyUQ9lZgkq5Exr+i221gePDFbNgoN8yhlUQiiRAeMJNNluCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by IA0PR11MB7377.namprd11.prod.outlook.com (2603:10b6:208:433::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Mon, 14 Nov
 2022 19:49:58 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::cdc6:8225:35ef:247d]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::cdc6:8225:35ef:247d%9]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 19:49:58 +0000
Message-ID: <baf7adb1-68c4-54f3-c1f6-e5ccf9258719@intel.com>
Date:   Mon, 14 Nov 2022 11:49:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: ld.lld: error: undefined symbol: firmware_upload_register
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Xu Yilun <yilun.xu@intel.com>
References: <202211092004.GI7IL067-lkp@intel.com>
 <d81630d5-756c-4067-fc1b-47e5f56cad33@infradead.org>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <d81630d5-756c-4067-fc1b-47e5f56cad33@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38)
 To DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|IA0PR11MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: e362f517-1932-41bc-f297-08dac6796856
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6vSRwqOEiEqAL+WeHtOzp6T6Bqv9BLKICSUBqO/joYMtzVn7IcRH1la3ajBabJWL5wajCDO2Z8xPJi79UW1wQ4YaryHCFMd+Af3C+uzERxx033jzgONA5JxbCaRK4+uhTl1UnH1yOI8/eG4wo5ysh64Y6JAFuaYIZOOBF1bJE4Z/vQs1ZLAuxmSNQ4yaN1fqsl3JEp8q6zy8MSCW2cR/aRnaUKeuHaD2zKDngwtitshoGusSKZyHf1nKqpPG1I56SxvC5pTfAHNMOhwMSFqYs1YJO0AJ/TYDe/ACB4x4DvaLilKYBjJNOzfBg+uGIkyior9yYYVRGHlejGPLVhM61meISmBWOawf1Al+rv8PXeNkd2Hl8KCU/46qozzOKSL0zd2l8rLjz47a80TSaDHwuu4rWWzZWZz6ixem983PMt42GeawGWATQEJOGlNeb+Fp66CPNxApZbw4Q5ooBPcEgPXGv5KzhUs5hHY+Dubu66GPNhHfRXt9NqfAFbQ6Lo8LQVTXeDNeLmae5eXywg5PWucTzuGEt3H+ZaUP6ViqOIid51bAUz4YI+G+xn8C/ey7vhIr3i1UtEgIq1+q1k7T0LZy2MNpMFXVWA6uzDKX1EXcOpXmjL/NYQIHR59zcuPbbQvC6YOk7e5dVVt2HI9X50tjspltn3vH2gTOb55+O3LTeCtJp1kNXuSKAFxyI+gsgzr8ssU+Qy0H/YFd3IRxn1yhFa/6W5hnRW4ZY5riZWQ8T1V55rUe+KXV/7D0O35csflRIkSrW3DcnzrRVkR3/ZnrLLVOxc0K2hfbPhASJObUaldkkEJFvr1XPdbqBmOj0Ip3oid6cvyOhdopq+6GLPkhXqmLkOkdosLNDfOSQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(6506007)(316002)(8936002)(2616005)(5660300002)(83380400001)(186003)(31696002)(66476007)(86362001)(53546011)(41300700001)(2906002)(8676002)(66946007)(4326008)(66556008)(6512007)(26005)(36756003)(110136005)(38100700002)(966005)(6486002)(82960400001)(107886003)(31686004)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCtJMFAzZzNvRm1DMEthUHdXQ1A4VEUzZmhZTGpML1V1c21lMkhJdHN5OEsx?=
 =?utf-8?B?VmpUMU1CMDUvbDJUeHJKL0RkR3VlcU9iVHBDd1YvZDRHWno4M1NjUDAwb3BQ?=
 =?utf-8?B?VHJ1NnIwTm91RHVkZGVNU2k4WVYwZURFZGJNV2dVdEF1ZVd1NENQL1ZOMlU3?=
 =?utf-8?B?R042WDExY1ViV2IrVE5ncXUzVFZ3NGFPeFlVRTQ2SFBpSkxpTEJsUEhPSWpt?=
 =?utf-8?B?Tk5VYTBBYjlSOWJ2TUhBdklnTnV6UEhxNWRVTnBFemxLTEhhbEVsMk9ic2tv?=
 =?utf-8?B?alRidVhxS2tQemZMUTZhRE1iRHNWaFArM3QrakJYLzlRZThRS0YzaDBpclpq?=
 =?utf-8?B?QzA5bk1CVlRnZWxJMXZzWFVjR0lHekdkMEJiZjQzRm1adXhEUWI2dFlpRmdD?=
 =?utf-8?B?cDhwNkcvQmNBdTFBbS83c1NrYzVUMWh4MC8yN2NvTFE5d3huREttSHI5WGgv?=
 =?utf-8?B?Y292c3pJZmFTeWlhS3BSSTd2bnBuVmlISlhvYXBUd0pUSUFWWFF0enV3WmVL?=
 =?utf-8?B?YVQrQUJwVGx4UThFMWRPYTJ2K2hXT1dDbTF4NCt5Wk9qeDRrZ2xTcDhJVEw1?=
 =?utf-8?B?dUk1MU5ka3RUc2JYM2RKMklKdmZYemdzNEROQ2M0M3hubkR6ZWRDTWdOSWtQ?=
 =?utf-8?B?cEd4UVJGSzRLUTFPNk5KV2Jjay9ydERMRVRMVjUrUmhxOUhEL0x0NFd5ZmtP?=
 =?utf-8?B?TDN3dk9zZmVnSEsrZjlkT0wyMTYzWU9hWmNSTW0vZFV1aWNHVmoyT1pZWnFQ?=
 =?utf-8?B?OHJsTWtQbDEwQ0h4SGhGMTZacHpMcG5TQlpNdWNib0grcngyQnQ0dW9DTFgw?=
 =?utf-8?B?SVIwZUxDdUhvekJPTjgxb0k4NzJ5QTdjaFk4Y0dBbUxTUm41bXBXOFZmWXVq?=
 =?utf-8?B?U1pNS0xCYlZzNU1FQXBqWGZwVGY5Nk9pbndjUmNoOEtXSWVxV2JRVGNkbFJW?=
 =?utf-8?B?NUtLYStwSkx6RjBkNGJwN1RtVDZoZG9PVWh4b1JFSVpoTFUvQkVNNUJRWEFs?=
 =?utf-8?B?c1haTE9ubmxqdVlqNU93RTVEY2FjemJsK0tHcEFsekJRWWlDVzNHYlZhMFFU?=
 =?utf-8?B?NlJPeGVSbXgrVm1HV2x4NzFyRGgrajVud0RVY0RhZ2FGMzkyWGVROFNwVTJL?=
 =?utf-8?B?eXB5UXEzM3FyT2JTaXJoTFVaa2MyL1V5T1JFeEt5dU4wSnlsMU14elNCU1BM?=
 =?utf-8?B?dEdSUmMxRUlZRGRjRFkveXZFYStCby9EQUJyT3pCcHk2dTdHU0pFTFdvcjlZ?=
 =?utf-8?B?bXh1bnRrSmhDTmNISHFHc2gzS1k0VzVOYVhaT2VMYnlBeC9xZktCZEo1a05M?=
 =?utf-8?B?TEdJZStXT1JzYVc3UFF6SHRRM08xd2RQM250WEMxSVFPM0N2K1MyWWhhWUlY?=
 =?utf-8?B?TUQ3SjduMFBKZjFCdU93Y3YrdXBjRFJMWVJyV1gzMzlVR1BRcnZWTFBySGNW?=
 =?utf-8?B?SDgyNWRaRFlZbGNYUVNDVWxEeGZZcFI3Kzl0L0EzWi9haTEwOTNsNFhXbU9V?=
 =?utf-8?B?QmRJVnpEMUhHU3BRN0xxakRCK0J0ZUlvUm1MZ212cmt5Y2Q1WTd3OU5iM2Zx?=
 =?utf-8?B?Y01zUTVvT3dFYVMvdVQ3MFhDTUFTU0ljeWtFMFFxL0FrdmNwL2o5dGduWW02?=
 =?utf-8?B?V2R4MUl4NFFwbXNzd2IrOTNsVHVJOUVmQ3Bwa1IzUkFrWmRLU28zQytYMVR0?=
 =?utf-8?B?TURnL2ljSTMyWHg3SDV6VmJTdzJpMXMzVG5aN3lXcnZIQzZtZEpCM1FZRCtY?=
 =?utf-8?B?MUN5aVBxc0c2c2padGdwOHhjNWNLbDhYdS9BTm93c3hIcHVRSlJjWks4RGFL?=
 =?utf-8?B?TFZ1b3lvQXpMeExOVGFCRW5oQlJKSmdBTVowRUNKaWQxL0dEdXlsZmtMSEpw?=
 =?utf-8?B?THdDN291UnlRbWtDdlBuRXU5Wk51M3NJREVoby9KQUd2K0p2NjFRVUNHVnU0?=
 =?utf-8?B?Yk9ocFljU082THhBSndVbi9Sanl6aGtnT2F6QVIzbDZvRmhyMWNmUEV5MDZO?=
 =?utf-8?B?ci9EMzN3STRTTDJuU0NDL0o4MUpielRlc1ZKMnVJeWNNOHlxaXdmMUFya1ZQ?=
 =?utf-8?B?KzhCdzlMMHF3SkN6anR6RkJkcFVNTnVYVnViOVdRL2ZUd0tBaWJBbXdoN3hv?=
 =?utf-8?B?ZkFYc2dTL1dkd0EwZUxZb21kWERSV2dUcUMrQWxmS2p1a0VTTExjODdKU1JZ?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e362f517-1932-41bc-f297-08dac6796856
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 19:49:58.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irHIP9gOUk29D9F0nczdgeTdTOQTzQ38B/bgxjbOLjj82DdCO+N1yhnsGtI7XNsqW/98grMb6W6HOt+US9vWXTeR0f2Y/uyjVFmrMfXxqeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
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



On 11/11/22 13:59, Randy Dunlap wrote:
> Hi--
>
> On 11/9/22 04:30, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   f141df371335645ce29a87d9683a3f79fba7fd67
>> commit: 5cd339b370e29b04b85fbb83f40496991465318e fpga: m10bmc-sec: add max10 secure update functions
>> date:   5 months ago
>> config: mips-buildonly-randconfig-r004-20221109
>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 463da45892e2d2a262277b91b96f5f8c05dc25d0)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install mips cross compiling tool for clang build
>>         # apt-get install binutils-mips-linux-gnu
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5cd339b370e29b04b85fbb83f40496991465318e
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 5cd339b370e29b04b85fbb83f40496991465318e
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> ld.lld: error: undefined symbol: firmware_upload_register
>>    >>> referenced by intel-m10-bmc-sec-update.c
>>    >>>               fpga/intel-m10-bmc-sec-update.o:(m10bmc_sec_probe) in archive drivers/built-in.a
>> --
>>>> ld.lld: error: undefined symbol: firmware_upload_unregister
>>    >>> referenced by intel-m10-bmc-sec-update.c
>>    >>>               fpga/intel-m10-bmc-sec-update.o:(m10bmc_sec_remove) in archive drivers/built-in.a
>
> This happens when (bool) CONFIG_FW_UPLOAD=y and CONFIG_FW_LOADER=m.
> Ah, it's the old "bool depending on a tristate" problem.
>
> There may be some Makefile fix for this - I don't know.
>
> Or the Kconfig fix works AFAICT (below). Change FW_UPLOAD to a tristate
> and modify 2 header files for exports/inlines.
>
> Luis -- how was FW_LOADER=m and FW_UPLOAD=y supposed to work?

Hi Randy - thanks for chasing this down.

I used FW_LOADER_USER_HELPER as a pattern when I created FW_UPLOAD. It is
also defined as bool. Both of these are defined within "if FW_LOADER" which,
as you pointed out, is defined as tristate. The corresponding Makefile
gives a hint as to how these all play together:

obj-$(CONFIG_FW_LOADER) += firmware_class.o
firmware_class-objs := main.o
firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) += fallback.o
firmware_class-$(CONFIG_EFI_EMBEDDED_FIRMWARE) += fallback_platform.o
firmware_class-$(CONFIG_FW_LOADER_SYSFS) += sysfs.o
firmware_class-$(CONFIG_FW_UPLOAD) += sysfs_upload.o

So FW_LOADER may be selected as a module, but the individual firmware_class
objects are enabled with bool configs.

I think the implementation of FW_UPLOAD config is consistent with the
other config options and that the error is caused by an incorrect
dependency for FPGA_M10_BMC_SEC_UPDATE.

I looked at how FW_LOADER_USER_HELPER is referenced as a dependency in
other Kconfig files and I found two instances, both of which do:

select FW_LOADER
select FW_LOADER_USER_HELPER

So I believe the right fix for this bug is to change the dependency for
FPGA_M10_BMC_SEC_UPDATE from:

depends on MFD_INTEL_M10_BMC_CORE && FW_UPLOAD

to

depends on MFD_INTEL_M10_BMC_CORE
select FW_LOADER
select FW_UPLOAD

I'll prepare and test a patch. Please let me know if you disagree.

Thanks,
- Russ


