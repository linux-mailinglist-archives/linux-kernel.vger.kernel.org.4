Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A46C7771
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCXFj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXFjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:39:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E4F23675;
        Thu, 23 Mar 2023 22:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679636363; x=1711172363;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=uJa2o2BVQMly7uQ56uR1eznTBd2ar+CaBcf1HOTUhzc=;
  b=OS67BHB5iNk1BdV5WdJaDCZkTpF/rkmUkvXNvIgedXf3v0V6GBiSMf3k
   nZoSBMzC0qvsC7WPwQsg8bWcAI/YG2JHAxR+/X/KVR/Plv4ReJkD2ICTy
   0ZGyR3yRhjl0tRWKZ3sIHgrh95caOtIKUUQ/HRDrzocyEd4sj/kdEskab
   elZMMvSPNiBMOgFVs5lkCmmuDAQYkG3mm+2l/0VElQRk1gSW5UlaQnnvp
   nKraI3kCxkScyJWU1twzULskPSjL4yAUnJuRRDMq7d2c1GfurdoeKx658
   B+yH/DZ5YF8Xb2LFXx6jagGG64rGgdEF+yshjxZf0b0gESfC8YOc/yMuu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="367439380"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="txt'?scan'208";a="367439380"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 22:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="715097556"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="txt'?scan'208";a="715097556"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2023 22:39:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 22:39:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 22:39:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 22:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvTdUEai1SeP3xd0XDVQZ3UoH+0v9I6e3sBB6CB4k1UC/94BqH7l7EJBNZsP3wZoJWdpRrgTGvNfXEne2yYIWoqT53NGkatlJU6ozXvqWUcHkBm9IceGHIJiuTbmYeClFFt/p3HVAF1HX3oDYmxGp5DwsqJOPr7Y4P5hXn0NeTduikHBzteUGxG/H5dBGJacCUfgXTanCPc+eZi5XqqdhH2BNwV5psricxtvz1LIH2loz0+ECYVxrAQnnsIbHQjeV8u4SIC6CDAsKCFWX9ThiHvWBgtL+p32W0fJdjODQcAP8xwvBdfFyr0SdHhg6B7zmZF4KtsTrtuhwJVn8DmGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/uOFgdgw/FHkTwBA5koofg23hrqpGC9cXRzR+jZLYM=;
 b=evkGlS3Ax0QtLLwLxbyPxkU8Hnh8PcsSLVMIfX/WPZSDPRpO9dSilGedLrPIKH+liMUlDIA+xAEqyAw5lSzUoGwENdJ6aFCjqB7oUgHoAF4UMesCd6Sz4MSNKTI27Jfshs3GSsAgU8Lx1cSn0ZIYrx9MRJeQvFK3vPxe9evvSMYQWIzB5/seMLfAoB7TZMiE7v4Sgo2XGxGit+1Ih6NAT1yDZ9iuz5ES+N6JUTrqZFMl1krO/qsJaVTsH294K3tWpGWdXwWVKpDyLYmvr6yAmgNIyqXxEYGsZIj9BDiD03lNXnt2fCWS1luzs+2lqa68P8R5Br7bXwTPL5S7DK0+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH8PR11MB8105.namprd11.prod.outlook.com (2603:10b6:510:254::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 05:39:18 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 05:39:18 +0000
Content-Type: multipart/mixed;
        boundary="------------wRW660TsR6Xsi0boYADeyBuk"
Message-ID: <5c3d13d7-7b5b-62cd-4437-e24a129d5bed@intel.com>
Date:   Fri, 24 Mar 2023 13:39:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [smb3] 5efdd9122e: filebench.sum_operations/s -50.0% regression
Content-Language: en-US
To:     Steve French <smfrench@gmail.com>
CC:     kernel test robot <yujie.liu@intel.com>,
        Steve French <stfrench@microsoft.com>, <lkp@lists.01.org>,
        <lkp@intel.com>, Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        <linux-kernel@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        <regressions@lists.linux.dev>
References: <20220826022031.GA76590@inn2.lkp.intel.com>
 <c8310cba-36ef-2940-b2c2-07573e015185@intel.com>
 <95e604ff-516a-4f7c-7f2c-8ff3d2cc66fa@intel.com>
 <CAH2r5msk7R4qZ-GQT2mKnCWzZ_MzYPUyJwWXuLRUMtt2XtApoA@mail.gmail.com>
 <997614df-10d4-af53-9571-edec36b0e2f3@intel.com>
 <CAH2r5mt8krLwUomWBb28rw6uRZgAhqCSjphrsUzWueGrd+VgGw@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAH2r5mt8krLwUomWBb28rw6uRZgAhqCSjphrsUzWueGrd+VgGw@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH8PR11MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3e4cff-b3ad-4b2d-cb96-08db2c2a1c3a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKA0/bH9vUKFsZJmiN29fXObpHkylrNPZtvGxHLfkELt/bJMIoXiAtoUPihzThpunzNQUUaVnmLXssS7c4ofX/cUCTHKC8ACoMKO2O9Sv3jYGLk9m7mW5u/aOgTaAWKdreR3uY1M9sidNtBotz+qkJOMo8hcaptf4EewUDqKwySDk2LpaxhE30lazGqZJtc7Rri1JnwvKpdIFyAImOwtRVEGa5pImodRy+ghY1wUVm9dZlNEMw41iA8n22X/WoEyQJ/8uk1Ua1f7jKHzqlqxAkBzJKWipnKPYjGiQUchJcXq9HxkivcrYy23Rdo62bSb+JP3T+mSUbTabWyd1w/CdoLfjvxNLkJIJz3/ojKd8gGanUJSKOC35Z5rjNiylKWcwfUmFBUN4ovUd/o7EZ59IZ1QiAG/DbTYPTXrovcf5b2FEmGTrXwAqxlRK9GjGBpJKY+MaC5Z3uApXvjrc/OVsomhvcvnkCezshzq9legQu1hDs5QnNCcODPGD0Oapl76qVjHmnguKBjo+IN+NDDpUL5YVP9m/a/MVa9aIRR+fZQVlgmHFnNXJEYch5tKGjqO+7pXZEHj/G7tYfY3gSxpfG3tTCPLzT0f0f/EeoNgtMfIRGakhbWRAFLHSLrdroxNPQaRHUvqALr16dL5fog7qpHQfgylLy6iCqk5To+HmZRtWQpHGimoPtgfPyXLYhga4GKY78PgeMGse5W7peskSuRhDGYs1Ijjex2gQjfYvrlVX/ikRwX2y4f8X3jLugUfo3jMRSTcCbqzyCnet+c4fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199018)(31696002)(86362001)(66476007)(82960400001)(36756003)(38100700002)(41300700001)(5660300002)(7416002)(8676002)(235185007)(2906002)(6916009)(4326008)(66556008)(30864003)(8936002)(6512007)(2616005)(21480400003)(186003)(33964004)(53546011)(6506007)(54906003)(26005)(83380400001)(66946007)(316002)(6486002)(966005)(6666004)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1dvSDRvbTl6bWZUWmZyOG5zTEMzelVOaTNISFBWd0xNNGdOZWoxcXRIZXJu?=
 =?utf-8?B?a04raWJPeUlBZERYTWRhcGowSXc5c0ZCZTRYNStQVWxDUlhrMmNXYklYUU5y?=
 =?utf-8?B?R28vSHFPYWFxaGNSYkV3WnNUMjB2OGV4TXplT1FySlR0TUQ2aXBoNlhHZmQy?=
 =?utf-8?B?YlV6anVHMnU5Q08xOUYvUFU5K2R2RHJxWllRUGRheFBETmozWVV6NDRhVG52?=
 =?utf-8?B?SzhIL2cvd3pxZ0NuY3BiQlNLTW1ZN2pMeTZrekY4WlFUY0lOQ3pXV2FUd1lu?=
 =?utf-8?B?d3RYN2VCUjlWNUQyMC9GMXBLOWV4Y210bVZBOStjUVJiSXp6TzA5RlpUUEJR?=
 =?utf-8?B?VGxoZHcyWFpUUDdGdEg4ZWVwUHpoVExpQ2lUTWl2cnBmaE5NQkd6eEdVSkVD?=
 =?utf-8?B?aUlMQ1JuK0locHVRZ21uR1R4QzdXUmU1TkFDU3p3TndZMEc0TVhKZVJzbVFD?=
 =?utf-8?B?QkZ5Yzg3OGUxQVRrcWVGc1dwSENtdE5Ba2ZoRWhodzgwZGdLQlRlTzhJRnd1?=
 =?utf-8?B?UVNpUzErdUZBc1c1bnVUOURYUFdOT3lGNU5odVBGNlhtNDI5NnJCc0JzZXcv?=
 =?utf-8?B?OVBXdm1Rb2U2S0s3NzBuaExWL2JZQzhiTVhiY1hsTWhFd2FtM2NrWjNDRXg0?=
 =?utf-8?B?UndVRktNbkt0L1lBWUt0OXB4KysxOXJwRHN3cnA4bXpjUFFyaHh1NXcwakVp?=
 =?utf-8?B?a3RrM0xwcUZnRlJSOUkvOW1ZaUQrWXdITGxZeDdkZFhRbjFwekxka2J0ZWdo?=
 =?utf-8?B?NHRMNTM5c1VLQk93T0NQc0w0Zmh2QTJ1eFdFRm42amNieXB0RFBLbVA0ZS9B?=
 =?utf-8?B?MTZqbUR5aVB3RytEZU5reSsvWjJ5QkdVVE5Ld04xMlBwYWVmdjdtd1NKUm5u?=
 =?utf-8?B?eXJKeEdOUU91YlV3SzZWd1NCU05mNEtMeGZNZXN2aWNkZG8rMlBlZ3cxZkNw?=
 =?utf-8?B?Yi9yYnI5TW9LcitzWGszc3BwWjIvRmh1bnZ1SnJYVGxrczBxdGlZM0JxaDhC?=
 =?utf-8?B?eFNwaHI0WDhMem10R01MWlRpNzhqQy9iQVhoT1pESlJZb1M5V0FwYUdud042?=
 =?utf-8?B?cHYydHN2eW5zcTFOejVMZ1o1Z2ZTeFY2aW9PVm9uZ0d2OWhOWk9GTjNZdElO?=
 =?utf-8?B?YkdhQnFpbTVHemc0RVc0bFdwRy92T3IvR1B1cndTUXVPdnNEOE0xMHRpdG5w?=
 =?utf-8?B?NGJrdDFZRjkvdm1GaVdRZ0tCeFNKRnFEZEI5dzE2M3pya1h1dHAySDEyNURX?=
 =?utf-8?B?TW5tSk90Z2NoRW92aW96dVhUeG1mMjkvOHprdFFiZnZjOENGQk1WWEsrU2N2?=
 =?utf-8?B?M1NnYnpua2xTdUpnRkxLTHoyWjJiV3VmcjNoQ1puUFE4QnU5M1VKL24wTFJw?=
 =?utf-8?B?VVhOUTdwd0Y4elVXRkJ5U0x6ZERmNkRxMG54b2F2VnAzcGVQa0hPZ2t3TFUx?=
 =?utf-8?B?QnB5L2RIVmJ2cmNEbGVwSzNOZ2lqbDJ0QnV3U2t6bG5najBEM1NHTEpSUW4x?=
 =?utf-8?B?ZDJLdXNscjJhNWJRK3IwMWNCbUVkdXdNSk8rUytMY1lRZ3prd2dPL1F6SUxv?=
 =?utf-8?B?RVJIdmk0eGxubjRjTHRTS3UyYkIvNzdQb2FYU091RVB3VWJQbmFzSCtzYzJJ?=
 =?utf-8?B?Z3BTbzhlUllldkxwZHpjY2NrcmtoMGZsbEJHaHNGT2ZMWkxFcmJkRGF5elpu?=
 =?utf-8?B?Z0pLT1lIbG1aa3RWQkZTK3Rnb3FPaktEUkloWlozSTFvSTAwOFdBS2RIVGdn?=
 =?utf-8?B?Umtsdkp2SXBqTFEvSHRXQlNML2VZbWg1anMvaDg3eFRPclNxSHREdUJSbzIx?=
 =?utf-8?B?QzRmODNnTThtbFJzRE9HRWZWbkI1dmpQQmhKTzNPZ0xCLzZ0NjF3S1lzbnpX?=
 =?utf-8?B?bjRtZGljcG5ITG5EdFQyU3lOd0RrQmp4Znl2Qis0TjZrU3JySzRUdGtiK09a?=
 =?utf-8?B?UnR1UlNnVHliYTZXVk5iS1U2eHBaYmw4VVNLQXZCaHgvQ3RsVW1lZ2VKVitF?=
 =?utf-8?B?OFNEK1hZZzFjMmdvZkpHTGdmY1EvaWt6UElUVTM2TVM3WUUxUzR4ckRGejdW?=
 =?utf-8?B?VllsU2tLMWk5QUh2Zktob2FPTzJzR2hJbS93eGZMcVowOVlaL1R6WDNPSWVi?=
 =?utf-8?B?RUNIdVA3RUVOcUk3TnF1dU9EWUV6Rzk4cVpKRldFN0ErOHIvNkQyVHFTSFo5?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3e4cff-b3ad-4b2d-cb96-08db2c2a1c3a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 05:39:17.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URx1Ul4lb5G+lTWFNNSj6tlwQbbeSP0W9hvl1lZ/9rh0fnSc/3m8XB492663Rf0hklOHSunN/kcm6ryDNmbDYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8105
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------wRW660TsR6Xsi0boYADeyBuk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit


On 3/24/2023 4:00 AM, Steve French wrote:
> This is VERY useful data.  Thank you.   It show the SMB3 CLOSE
> operation on the wire takes twice as long to complete with
> closetimeo=5 rather than 1.  Can you do the same stats for
> closetimeo=0
Please find in attached file for /proc/fs/cifs/Stats dumping with closetimeo=0.
BTW, there is no regression with closetimeo=0.

Regards
Yin, Fengwei

> 
> On Thu, Mar 23, 2023 at 2:48 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> On 3/15/23 22:26, Steve French wrote:
>>> Can you verify what this perf looks like with "closetime=0" and "closetime=1"
>>>
>>> Are there differences in /proc/fs/cifs/Stats when you run the same
>>> steps with "closetimeo=1" vs. the more recent default (5 seconds)?
>> The dump of /proc/fs/cifs/Stats are attached. You can tell which
>> closetimeo is used from the file name. Thanks.
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>> On Wed, Mar 15, 2023 at 2:46 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/26/2022 10:41 AM, kernel test robot wrote:
>>>>> Greeting,
>>>>>
>>>>> FYI, we noticed a -50.0% regression of filebench.sum_operations/s due to commit:
>>>>>
>>>>>
>>>>> commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3 ("smb3: allow deferred close timeout to be configurable")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>>
>>>>> in testcase: filebench
>>>>> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory
>>>>> with following parameters:
>>>>>
>>>>>      disk: 1HDD
>>>>>      fs: ext4
>>>>>      fs2: cifs
>>>>>      test: filemicro_delete.f
>>>>>      cpufreq_governor: performance
>>>>>      ucode: 0x5003302
>>>> Please note, we still could see this regresion on v6.3-rc2. And the regression is related with
>>>> the commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3. This commit changed the default timeout
>>>> value from 1s to 5s. If change the timeout back to 1s as following:
>>>>
>>>> diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
>>>> index 6d13f8207e96..6b930fb0c4bd 100644
>>>> --- a/fs/cifs/fs_context.c
>>>> +++ b/fs/cifs/fs_context.c
>>>> @@ -1537,7 +1537,7 @@ int smb3_init_fs_context(struct fs_context *fc)
>>>>
>>>>          ctx->acregmax = CIFS_DEF_ACTIMEO;
>>>>          ctx->acdirmax = CIFS_DEF_ACTIMEO;
>>>> -       ctx->closetimeo = SMB3_DEF_DCLOSETIMEO;
>>>> +       ctx->closetimeo = CIFS_DEF_ACTIMEO;
>>>>
>>>>          /* Most clients set timeout to 0, allows server to use its default */
>>>>          ctx->handle_timeout = 0; /* See MS-SMB2 spec section 2.2.14.2.12 */
>>>>
>>>> The regression is gone:
>>>> dcb45fd7f501f864                    v6.3-rc2 32715af441411a5a266606be08f
>>>> ---------------- --------------------------- ---------------------------
>>>>         fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>>>>             |             |             |             |             |
>>>>             :25           0%            :3           33%           1:3     last_state.booting
>>>>             :25           0%            :3           33%           1:3     last_state.is_incomplete_run
>>>>           %stddev     %change         %stddev     %change         %stddev
>>>>               \          |                \          |                \
>>>>      515.95           -50.0%     257.98            -0.0%     515.92        filebench.sum_operations/s
>>>>        5.04 ±  7%    +833.7%      47.09 ±  2%      -2.9%       4.90 ±  2%  filebench.sum_time_ms/op
>>>>       10438          -100.0%       0.33 ±141%    -100.0%       0.50 ±100%  filebench.time.major_page_faults
>>>>      167575            -4.1%     160660            -4.4%     160140        filebench.time.maximum_resident_set_size
>>>>        7138 ± 11%    +141.4%      17235 ±  3%    +147.6%      17677        filebench.time.minor_page_faults
>>>>       28.68 ±  9%    +199.9%      86.00 ±  7%      -2.4%      28.00        filebench.time.percent_of_cpu_this_job_got
>>>>     2453485 ± 54%     -63.0%     907380           -66.2%     830273 ±  6%  cpuidle..usage
>>>>        0.61 ± 38%      +0.8        1.41 ±  3%      +0.2        0.80 ±  4%  mpstat.cpu.all.sys%
>>>>      142984 ± 13%     -45.6%      77725           -47.5%      75106        vmstat.system.in
>>>>       34.23 ±  7%     +27.9%      43.79           +27.8%      43.74        boot-time.boot
>>>>       17.09 ± 11%     +66.0%      28.38           +65.5%      28.28        boot-time.dhcp
>>>>        2661 ±  7%     +37.5%       3659           +37.2%       3651        boot-time.idle
>>>>      104737 ±185%     -87.8%      12762 ± 10%     -89.8%      10631 ±  4%  turbostat.C1
>>>>
>>>>
>>>> 32715af441411a5a266606be08f is v6.3-rc2 with the change to restore the timeout to 1s. Thanks.
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>
>>>>>
>>>>>
>>>>> =========================================================================================
>>>>> compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase/ucode:
>>>>>    gcc-11/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp9/filemicro_delete.f/filebench/0x5003302
>>>>>
>>>>> commit:
>>>>>    dcb45fd7f5 ("cifs: Do not use tcon->cfid directly, use the cfid we get from open_cached_dir")
>>>>>    5efdd9122e ("smb3: allow deferred close timeout to be configurable")
>>>>>
>>>>> dcb45fd7f501f864 5efdd9122eff772eae2feae9f0f
>>>>> ---------------- ---------------------------
>>>>>           %stddev     %change         %stddev
>>>>>               \          |                \
>>>>>      515.95           -50.0%     257.98        filebench.sum_operations/s
>>>>>        4.81 ±  2%   +1038.4%      54.78 ±  6%  filebench.sum_time_ms/op
>>>>>       29.00 ±  8%    +212.1%      90.50 ±  3%  filebench.time.percent_of_cpu_this_job_got
>>>>>       24629            +2.7%      25297        filebench.time.voluntary_context_switches
>>>>>   7.685e+08           +19.3%  9.169e+08 ±  4%  cpuidle..time
>>>>>        2.53 ±  6%     -20.6%       2.00 ±  3%  iostat.cpu.iowait
>>>>>     1506141 ±  8%     +22.4%    1843256 ±  3%  turbostat.IRQ
>>>>>        2.00           -50.0%       1.00        vmstat.procs.b
>>>>>       21969 ±  2%      -9.5%      19885 ±  2%  vmstat.system.cs
>>>>>        3.06 ±  7%      -0.7        2.35 ±  4%  mpstat.cpu.all.iowait%
>>>>>        0.79 ±  5%      +0.5        1.27 ±  2%  mpstat.cpu.all.sys%
>>>>>        0.89 ±  3%      -0.1        0.79 ±  3%  mpstat.cpu.all.usr%
>>>>>       34.55 ± 14%     -34.8%      22.51 ± 27%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>>>>>      119.64 ±  3%     -20.0%      95.69 ± 17%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>>>>>       34.55 ± 14%     -34.8%      22.51 ± 27%  sched_debug.cfs_rq:/.removed.util_avg.avg
>>>>>      119.64 ±  3%     -20.0%      95.69 ± 17%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>>>>>        5249           +15.8%       6076        meminfo.Active
>>>>>        3866 ±  2%     +17.7%       4552        meminfo.Active(anon)
>>>>>        1382 ±  4%     +10.3%       1524 ±  4%  meminfo.Active(file)
>>>>>       69791 ± 14%     +39.8%      97553 ±  6%  meminfo.AnonHugePages
>>>>>       72709 ±  2%     +12.5%      81779 ±  3%  meminfo.Inactive(file)
>>>>>       23219           +13.5%      26352 ±  3%  meminfo.KernelStack
>>>>>      966.50 ±  2%     +17.7%       1137        proc-vmstat.nr_active_anon
>>>>>       74302            +6.3%      78977 ±  2%  proc-vmstat.nr_anon_pages
>>>>>       81133            +6.0%      85973        proc-vmstat.nr_inactive_anon
>>>>>       18172 ±  2%     +12.5%      20442 ±  3%  proc-vmstat.nr_inactive_file
>>>>>       23213           +13.5%      26348 ±  3%  proc-vmstat.nr_kernel_stack
>>>>>       17983            +2.3%      18400        proc-vmstat.nr_mapped
>>>>>        7446 ±  2%      +5.5%       7853 ±  3%  proc-vmstat.nr_shmem
>>>>>       26888            +1.6%      27306        proc-vmstat.nr_slab_reclaimable
>>>>>       47220            +3.4%      48803        proc-vmstat.nr_slab_unreclaimable
>>>>>      966.50 ±  2%     +17.7%       1137        proc-vmstat.nr_zone_active_anon
>>>>>       81133            +6.0%      85973        proc-vmstat.nr_zone_inactive_anon
>>>>>       18172 ±  2%     +12.5%      20442 ±  3%  proc-vmstat.nr_zone_inactive_file
>>>>>      361460            +2.5%     370454        proc-vmstat.numa_hit
>>>>>      946.67           +18.6%       1122        proc-vmstat.pgactivate
>>>>>      361562            +2.5%     370553        proc-vmstat.pgalloc_normal
>>>>>      187906            +4.7%     196761        proc-vmstat.pgfault
>>>>>        8189            +2.5%       8395        proc-vmstat.pgreuse
>>>>>   1.097e+09           +15.5%  1.267e+09 ±  7%  perf-stat.i.branch-instructions
>>>>>    39079265 ±  6%     -20.9%   30915354 ±  4%  perf-stat.i.branch-misses
>>>>>     5093263 ±  4%     -23.7%    3884752 ±  9%  perf-stat.i.cache-misses
>>>>>       29213           -18.7%      23764 ±  5%  perf-stat.i.context-switches
>>>>>   7.666e+09 ±  4%      +5.7%  8.106e+09 ±  2%  perf-stat.i.cpu-cycles
>>>>>        1877 ± 15%     +75.1%       3287 ± 12%  perf-stat.i.cycles-between-cache-misses
>>>>>     1735450 ±  3%     -12.9%    1512060 ±  3%  perf-stat.i.iTLB-load-misses
>>>>>        2898 ±  3%     +34.4%       3895 ±  7%  perf-stat.i.instructions-per-iTLB-miss
>>>>>        1493           -20.3%       1190 ±  7%  perf-stat.i.major-faults
>>>>>        0.09 ±  3%      +5.8%       0.09 ±  2%  perf-stat.i.metric.GHz
>>>>>       48.47 ± 11%      +8.4       56.83 ±  7%  perf-stat.i.node-store-miss-rate%
>>>>>      283426 ±  4%     -21.6%     222190 ± 10%  perf-stat.i.node-stores
>>>>>        3.57 ±  7%      -1.1        2.44 ±  6%  perf-stat.overall.branch-miss-rate%
>>>>>        1508 ±  3%     +39.8%       2108 ±  9%  perf-stat.overall.cycles-between-cache-misses
>>>>>        3022 ±  3%     +23.6%       3736 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
>>>>>   9.585e+08           +18.8%  1.138e+09 ±  6%  perf-stat.ps.branch-instructions
>>>>>    34151514 ±  6%     -18.8%   27725316 ±  4%  perf-stat.ps.branch-misses
>>>>>     4450329 ±  5%     -21.7%    3486409 ±  9%  perf-stat.ps.cache-misses
>>>>>       25524           -16.4%      21333 ±  4%  perf-stat.ps.context-switches
>>>>>       77139            +2.5%      79105        perf-stat.ps.cpu-clock
>>>>>   6.704e+09 ±  4%      +8.7%  7.287e+09        perf-stat.ps.cpu-cycles
>>>>>    1.06e+09           +11.3%   1.18e+09 ±  5%  perf-stat.ps.dTLB-loads
>>>>>     1517349 ±  3%     -10.5%    1357716 ±  2%  perf-stat.ps.iTLB-load-misses
>>>>>   4.582e+09           +10.8%  5.075e+09 ±  6%  perf-stat.ps.instructions
>>>>>        1296           -18.1%       1061 ±  6%  perf-stat.ps.major-faults
>>>>>      247613 ±  4%     -19.5%     199283 ±  9%  perf-stat.ps.node-stores
>>>>>       77139            +2.5%      79105        perf-stat.ps.task-clock
>>>>>   3.697e+10           +35.3%  5.003e+10        perf-stat.total.instructions
>>>>>        8.51 ± 91%      -6.9        1.59 ±223%  perf-profile.calltrace.cycles-pp.getdents64
>>>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>>>        6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>>>>>        6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>>>>>        6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.open64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>>>        6.26 ±115%      -5.4        0.88 ±223%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>>>        6.26 ±115%      -5.4        0.88 ±223%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>>>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record
>>>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist
>>>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push
>>>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.exit_mm.do_exit
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exit_mm
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
>>>>>        8.51 ± 91%      -6.9        1.59 ±223%  perf-profile.children.cycles-pp.getdents64
>>>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>>>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>>>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>>>>>        6.25 ±107%      -6.2        0.00        perf-profile.children.cycles-pp.open64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.children.cycles-pp.__x64_sys_getdents64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.children.cycles-pp.iterate_dir
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.children.cycles-pp.get_signal
>>>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.children.cycles-pp.perf_mmap__read_head
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.unmap_vmas
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.unmap_page_range
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.zap_pmd_range
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.zap_pte_range
>>>>>        8.54 ± 43%      +8.6       17.19 ± 38%  perf-profile.children.cycles-pp.asm_exc_page_fault
>>>>>
>>>>>
>>>>> If you fix the issue, kindly add following tag
>>>>> Reported-by: kernel test robot <yujie.liu@intel.com>
>>>>>
>>>>>
>>>>> To reproduce:
>>>>>
>>>>>          git clone https://github.com/intel/lkp-tests.git
>>>>>          cd lkp-tests
>>>>>          sudo bin/lkp install job.yaml           # job file is attached in this email
>>>>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>>>>          sudo bin/lkp run generated-yaml-file
>>>>>
>>>>>          # if come across any failure that blocks the test,
>>>>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>>>>
>>>>>
>>>>> Disclaimer:
>>>>> Results have been estimated based on internal Intel analysis and are provided
>>>>> for informational purposes only. Any difference in system hardware or software
>>>>> design or configuration may affect actual performance.
>>>>>
>>>>>
>>>>> #regzbot introduced: 5efdd9122e
>>>>>
>>>>>
>>>
>>>
>>>
> 
> 
> 
--------------wRW660TsR6Xsi0boYADeyBuk
Content-Type: text/plain; charset="UTF-8"; name="cifs_stats_timeout0s.txt"
Content-Disposition: attachment; filename="cifs_stats_timeout0s.txt"
Content-Transfer-Encoding: base64

UmVzb3VyY2VzIGluIHVzZQpDSUZTIFNlc3Npb246IDEKU2hhcmUgKHVuaXF1ZSBtb3VudCB0YXJn
ZXRzKTogMgpTTUIgUmVxdWVzdC9SZXNwb25zZSBCdWZmZXI6IDEgUG9vbCBzaXplOiA1ClNNQiBT
bWFsbCBSZXEvUmVzcCBCdWZmZXI6IDEgUG9vbCBzaXplOiAzMApUb3RhbCBMYXJnZSAxNzcgU21h
bGwgNTk2NjUgQWxsb2NhdGlvbnMKT3BlcmF0aW9ucyAoTUlEcyk6IDAKCjAgc2Vzc2lvbiAwIHNo
YXJlIHJlY29ubmVjdHMKVG90YWwgdmZzIG9wZXJhdGlvbnM6IDIxNzYxIG1heGltdW0gYXQgb25l
IHRpbWU6IDQ2CgpNYXggcmVxdWVzdHMgaW4gZmxpZ2h0OiA2OApUb3RhbCB0aW1lIHNwZW50IHBy
b2Nlc3NpbmcgYnkgY29tbWFuZC4gVGltZSB1bml0cyBhcmUgamlmZmllcyAoMTAwMCBwZXIgc2Vj
b25kKQogIFNNQjMgQ01ECU51bWJlcglUb3RhbCBUaW1lCUZhc3Rlc3QJU2xvd2VzdAogIC0tLS0t
LS0tCS0tLS0tLQktLS0tLS0tLS0tCS0tLS0tLS0JLS0tLS0tLQogIDAJCTEJMjQJCTI0CTI0CiAg
MQkJMgkyCQkxCTEKICAyCQkwCTAJCTAJMAogIDMJCTIJMQkJMAkxCiAgNAkJMAkwCQkwCTAKICA1
CQkxMTYzNQkyMzA0NQkJMAk2NAogIDYJCTExNjM1CTIyMDQ5CQkwCTY0CiAgNwkJMAkwCQkwCTAK
ICA4CQkwCTAJCTAJMAogIDkJCTUwMDAJMjExMTQJCTAJNDAKICAxMAkJMAkwCQkwCTAKICAxMQkJ
MgkwCQkwCTAKICAxMgkJMAkwCQkwCTAKICAxMwkJMAkwCQkwCTAKICAxNAkJMTg3CTcyCQkwCTIK
ICAxNQkJMAkwCQkwCTAKICAxNgkJMTM5NAk2ODIJCTAJNgogIDE3CQk2MgkyMwkJMAkxMwogIDE4
CQkwCTAJCTAJMAoKMSkgXFxsb2NhbGhvc3RcZnMKU01CczogMjk5MTUKQnl0ZXMgcmVhZDogMCAg
Qnl0ZXMgd3JpdHRlbjogODE5MjAwMDAKT3BlbiBmaWxlczogMCB0b3RhbCAobG9jYWwpLCAwIG9w
ZW4gb24gc2VydmVyClRyZWVDb25uZWN0czogMSB0b3RhbCAwIGZhaWxlZApUcmVlRGlzY29ubmVj
dHM6IDAgdG90YWwgMCBmYWlsZWQKQ3JlYXRlczogMTE2MzUgdG90YWwgMCBmYWlsZWQKQ2xvc2Vz
OiAxMTYzNSB0b3RhbCAwIGZhaWxlZApGbHVzaGVzOiAwIHRvdGFsIDAgZmFpbGVkClJlYWRzOiAw
IHRvdGFsIDAgZmFpbGVkCldyaXRlczogNTAwMCB0b3RhbCAwIGZhaWxlZApMb2NrczogMCB0b3Rh
bCAwIGZhaWxlZApJT0NUTHM6IDEgdG90YWwgMSBmYWlsZWQKUXVlcnlEaXJlY3RvcmllczogMTg3
IHRvdGFsIDAgZmFpbGVkCkNoYW5nZU5vdGlmaWVzOiAwIHRvdGFsIDAgZmFpbGVkClF1ZXJ5SW5m
b3M6IDEzOTQgdG90YWwgMCBmYWlsZWQKU2V0SW5mb3M6IDYyIHRvdGFsIDAgZmFpbGVkCk9wbG9j
a0JyZWFrczogMCBzZW50IDAgZmFpbGVkCg==

--------------wRW660TsR6Xsi0boYADeyBuk--
