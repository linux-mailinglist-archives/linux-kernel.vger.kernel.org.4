Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955FC5F8981
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 07:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJIFrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 01:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIFrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 01:47:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B412ABF;
        Sat,  8 Oct 2022 22:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665294462; x=1696830462;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4DbYdKx/7/r8T4OsTUrWdD0rlreYGUqtL/iPM3lhRE8=;
  b=ang6V84QZMqhPixAdlnUWBPkfdoy1RBnz1D1wDloLDokLl5CRuzNdw58
   l26ts1vVp4S4BGZOqdiwJvWrDWavJ35J2SbqAEmuK3UDYxLafy7vDuKMY
   xtL99jYEEAVhcUoNxZ0AVnOJMySAzs+EqSAmcPn63ldir9ZIeYkuUcI+d
   bubH+OJmqT/Fty22fjeFNGmtTzCv/V2lTngwUuDhIDr5sNzhuJRbd7lsU
   G7/fmFnOHGKW/3gLPd5rDNvgPhJ+QQLvW3PBDR2fTJopeIw01cjH3/snq
   HBWCCW65nsdJtKutZbh8FHe9PqzAbVCYaDcqZhxD/m4CNXAgzEuS9LQTd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="330483479"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="330483479"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 22:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="603351242"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="603351242"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 08 Oct 2022 22:47:40 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 22:47:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 8 Oct 2022 22:47:40 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 8 Oct 2022 22:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD5HWD1Z5yyEeTjgu411vqGaGJsMlUzJZk4rCNk6JpS4HZJ0Hheqw+vzlZCRbqUHymqhxPvHO/ZaH9wawSuU/Y7LQagsFjPrgNoq8Xm2cw9mqadlmEUPPekVPJQkSwGjXdiWDC7dgqMOwt/royDmtP1xrLSJRDZYhtAIbpXSMIAwwTiokuKiFnc0xMj6pzHYA4TNvfAUlGuB8ZLpUKLzNmLz7lYS2HtssS+QG+0wfDtO9keDJ+rfBjPZShsUr1sEHWDZKZwtF64TklDHdU0FVjrEJLktSY/BhaZ+ys8grjmEWVpKdCDbAiidwqDe554nGS7jRn9SNfSTIh6Lf8jmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvQzx53U3ygPruLYUxVBhRERSUuvvTsvMCuqdi7lrLs=;
 b=JyDCL96BLZXkGYFrQr08ChUJPdwjpC4tcGiQEtSiJKtf5Bh4G6S4m4W2bkvnggfNV0cmf4BOXtZRWeocdZ5flcPCAsNrT30pusr2llO2EkmmJZPonfS9D8RtiFIs2iLTQxHE7A3mE28rVewoU9aCDRYd3JAKUnAg9UPp4Gwha76RnzqNxS3fXAUw1VLLXSpN5liGqnsGCOZKEjhM4ZJbnlBgqx9vSrXXPQCg5DXiKaVfnXxEbShQ908gtGkZnS/8c7jKrfkASPCYFzMR8xguym5LHXjfwrrskA8ytayZhbBXi0Cfie+xo5PRNiMeRKmxAbc/X/iD/8H8wrjcpC8FNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH8PR11MB7047.namprd11.prod.outlook.com (2603:10b6:510:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 9 Oct
 2022 05:47:38 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::4cf0:b24a:9b33:d8f0]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::4cf0:b24a:9b33:d8f0%9]) with mapi id 15.20.5676.038; Sun, 9 Oct 2022
 05:47:38 +0000
Message-ID: <de2cc259-727a-3707-6738-1c5ab41075a2@intel.com>
Date:   Sun, 9 Oct 2022 13:47:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [LKP] Re: [blk] 8c5035dfbb: fio.read_iops -10.6% regression
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        kernel test robot <yujie.liu@intel.com>
CC:     <lkp@lists.01.org>, <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <202210081045.77ddf59b-yujie.liu@intel.com>
 <d5279fc2-38b3-6d20-4404-604d5c7277e2@huaweicloud.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <d5279fc2-38b3-6d20-4404-604d5c7277e2@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0036.apcprd04.prod.outlook.com
 (2603:1096:820:e::23) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH8PR11MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ccdcfc-fcda-4dd6-74b7-08daa9b9c5c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vObeBMds2Un4TveTOz85Qjtq4HQC6v57/zn35pCndwFC0YICxX5KXSJTQW8Zny5qW60aLHw2qZCIqnfCPHtiZuygqkfOOJwgVR1QJYen+Q95HVF3ASN1Op5tRkF0l9Dhm9nn4bKWLB4p9aeTFb/xOsJ+X7wx/dqahlqXQn+0MXPpz6S9S2PnQNKSt+inby28Qk2e3a7Wtu4qwZ2Uwr6cGujd4GwZxiNSlMcrmFwTgYTcTKD++OSyMAffeHQqo6FSYBPqk+fpdCqP83Ppr0LIyUyuCFsZ3WiyRuhL6rhW43Ms9DB55uhPly/33xnTGUCUwG/K6+t+Skw30ucZaXB83yxl80EMKm/XJxOHkIS8drs1owjUuUH79oGY3Ml3LjsM6TnlauyRpErp23V3nRgmnnkjRuYgkzXfPjwvS5/K1pI1BC3+HROEf6LG/Ap5AKrHh7ESTgNHuvzCpEfm+1dmRNNEolYSkGW2B4vGHZfiNpqie5OtK9Gqn/dD5TwnktXmNDO4jFTPvLcdUCxMJgqXTURt4tEJQkylkV+Nc48ZupECBJdR3MwnrV/i60latP5o2xea7l6BWMl7sRSdG7jCBCYli4gyO+h78DGg6HBhR/+LNV60WxkwL7H12GAc4pGdQN8xqe5XbkPFQ/2wCI7HLAcKfMBxVeSYAFGjiBMeRdG0S0dvr1ss2Vd4VDeqeWfNNDjhixhqW5z1819OAxO3pNX6jEahKOtBfMogy0CTJHBgfA5m/67Yf+EWUT174ydi1zhcKfGnnvYx2n7z/zAYyLAbWD+uPLTVYgGR22FCqs4hqhtX+zOhQqLloqM5IBwlckJjCksev9gzeHVpSQDVCRLnmLT7itcIgzUTCHh3ubPN1G8Ynwj+0Ph3PW0TUl2m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(110136005)(6636002)(82960400001)(316002)(38100700002)(66476007)(19627235002)(41300700001)(8676002)(66946007)(6666004)(4326008)(31696002)(2616005)(966005)(36756003)(83380400001)(478600001)(86362001)(186003)(66556008)(6486002)(26005)(6506007)(53546011)(6512007)(31686004)(66899015)(54906003)(2906002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVVyZW52T1IwQkRNajVXZ3hiNkJRN0xhQ3NDZDI3d0JFZzFjK1N5dG1YQ0Z1?=
 =?utf-8?B?Zk93ZWhRd2hKOUxXa2xYeHc1RkFqdzBGUXJZNWN3U0JaRnZmcTVPMk5QY2RX?=
 =?utf-8?B?NTVPeXIrRmdRRjJRaWxEOHZORVhMek9wc3lyc3lpNHFIRFFqdzhLQ2FQY1FR?=
 =?utf-8?B?Um1GSU5nNVlMWlNrRDhUQ0RrdlFWTDlWUjYxbmVwaEZaT092V1F1SEMwL1JZ?=
 =?utf-8?B?bnRSQjFIQlJySTJXKy8rYm0zRGtra1ZWNW9ERlZHZFpmRzFCNTAvUzVtdnRC?=
 =?utf-8?B?VnVRa0ZjZW5wdkxXd0t4NEFFRVo2MWczOWFLakd6TFdaa2VucWYwMWY2RW9T?=
 =?utf-8?B?ZnJYb0FmZ1d2N2xXaHczSmtLOWpsb01GMVpha2lHeDJhVyt6ZE5jY1NjZWF2?=
 =?utf-8?B?dGZRUXlQTzBtUDR6Z0FKVUdZNFpseUNpci9tdFhnSllTUE9IeU5WUWk1Umc5?=
 =?utf-8?B?d0lSNWdKODNYMHg1Nzl2VjJzdjVPaC9nODd1NzhWR0gwLzJuNHMvdGpVaGsy?=
 =?utf-8?B?MHFVSkdDYitFdnJUVHZlTy8wOTFkeHlrVnVNMU8zeEhheGV6dXVKT1lwK0NV?=
 =?utf-8?B?ZEhNZWhDWTM2bjY5c283M3ZFbCtNUjZZdXVsWSswcDZsekNJUE8yNDhjaDdP?=
 =?utf-8?B?SGJ2RGFzT3h2dmN5TzQzM3Evd2lLYVhRQzNnSW5yWDR2NUdVMTJVcnh6V2dx?=
 =?utf-8?B?djVGMSsxQXY3UEVmMTVVWlZQWVBxWkd0ek96c2swYmhla1BaSG41VmNEaFJG?=
 =?utf-8?B?c0h6aG9OeGdwYWp4c1VpYy9CTllCUUJocjNZQ3YzK3pEdi9OWGdXWnJRc1hU?=
 =?utf-8?B?dWtKS25rYVNuanRlb200MXY5Y2dTZzNRR1JiZTlDYnJJcjc0Y1FieTNtRGp0?=
 =?utf-8?B?Tmo5ZnpobGwzOUEzVWNFeUplR3hEQWYzMEE4NmFCUVlKY0MyM3VJeEVrMGNO?=
 =?utf-8?B?QzF6TGxvakpsN0RkYmFnbjVNbmlnZ1JuQ0EyTTVjbEJQVFNObHpSbHdtMnhy?=
 =?utf-8?B?MDJ5MUVONWdBdzNBamRsbFdFa3FGdGNnVndiTnc5RDlKLzlBemI3bGxVUm1P?=
 =?utf-8?B?NE9xdDZCU1NWb2RGVjJpdjZ3QWcva0dsaitHQWJtTC9Xdk5NZ0luZEdvcllY?=
 =?utf-8?B?M0FDRk54TXRSR0grdTJ5a0ZGREpxSDFzVmJCMjV0N2hyNEFJcUhiYXBlanlM?=
 =?utf-8?B?azBCV2JCMXhzR0V1d0NsTS9nbjFqVmZLbjRMS0lHZ2Y5eEJoUXAwbXRSMzZM?=
 =?utf-8?B?TnZDclpGcTBLZ1FZWUFXT3RUelVaOUM1MTJ5aUU4Q01GN3BTODRteUhacDBs?=
 =?utf-8?B?ZDdiWEJHb3ROdjlEOTRyMzBNV2d0R2l6TmdzZHBrTmx0SVpqTDlYTVVIVmdB?=
 =?utf-8?B?MTdNemZFZmN0N3V2TUZlUG4zdFJuTmFUcVFrdEVFK0lXUlFhR3Vib2Y0b2Ez?=
 =?utf-8?B?bHgxVEUwZ2tjQzBjYUppaG1KeXJNa3VJNGt3aGY2Sk4yVzdNU3VXdjNmQnQ1?=
 =?utf-8?B?MFFVZlY1VE1VSk9SZmtORktqUWxZdytROW5pZUwrRGp3ZmFqVzhYUTdCOVVi?=
 =?utf-8?B?a1dkNFNlT2pkL2k1Vks2WWRXVDJ5bEtDcS94aGVWN1J5L0hVT1IvdjlrK1Z2?=
 =?utf-8?B?VzVnYks4SWFpcU81Y0ovbW9TckNKQ1ZKdG53ckxHQUpwVlEvRkIwM3FLQXhP?=
 =?utf-8?B?NmNOOEZQRSsyQTEweEdlN0xGZWZMQnA4U0xPcUwxS2tsK0ZiV0xEMmtCUEN1?=
 =?utf-8?B?eUF1aTdWUjExZ0JCc0RnZ3BsZnJTNUlrZTczZEJGMlExRnE1TFBsL09NeWc3?=
 =?utf-8?B?bFE2alV4Y0tjdUk3Y0x3amcvMmF6UHJoZWxUaU5BL2xxT2xGdHlMSnc5VTdL?=
 =?utf-8?B?SFFzNmFyaTVLVXp6RXBBMG9md1YzMGo1Ui8xbC9oNU0wT3VjdkZWbE5oU0J0?=
 =?utf-8?B?Z1ZPazVla0RkK0Z2RFl1cHZIRFJPVTErbjRNdS80UXRSUGM3ZGluSlF6azht?=
 =?utf-8?B?bk9WbnpxVkR6UXZpQ2RwdjkzcjdFZzJ3d0Q0MUlWSTNiQVVFVDdmZURWWjdo?=
 =?utf-8?B?ZnZVRzc1Z1daWFJiS3huYTY0Sm4rWnNsWitpWS8waHRLbVViTkJGS0IzbnhN?=
 =?utf-8?B?b1EwRUJlVEtZMjNYb2hreUt6TWdCYWZmTmsyNFR6d0JCOThSYW1WdnF1bXY2?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ccdcfc-fcda-4dd6-74b7-08daa9b9c5c8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 05:47:38.1140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbr9pVEk/tTOKOX2E8flHnRy9ZjtsDcfcCqOkNEmRUquLJ7uGcd3yKq82LYATi3nWMG/Agnb2EaBS7PRa8C8uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7047
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuai,

On 10/8/22 16:00, Yu Kuai wrote:
> Hi,
> 
> 在 2022/10/08 10:50, kernel test robot 写道:
>> Greeting,
>>
>> FYI, we noticed a -10.6% regression of fio.read_iops due to commit:
> 
> I don't know how this is working but I'm *sure* this commit won't affect
> performance. Please take a look at the commit, only wbt initialization
> is touched, which is done while creating the device:
> 
> device_add_disk
>  blk_register_queue
>   wbt_enable_default
>    wbt_init
> 
> And io path is the same with or without this commit.
> 
> By the way, wbt should only work for write.
Some information here:
It looks like the line
    wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
matters.

If move only this line to original position based on 8c5035dfbb,
the regression is gone.

If move only this line before ret = rq_qos_add() (just like your patch
did, but only with this line) based on 8c5035dfbb, the regression can
be reproduced.


Regards
Yin, Fengwei

> 
> Thanks,
> Kuai
>>
>> commit: 8c5035dfbb9475b67c82b3fdb7351236525bf52b ("blk-wbt: call rq_qos_add() after wb_normal is initialized")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: fio-basic
>> on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 192G memory
>> with following parameters:
>>
>>     runtime: 300s
>>     nr_task: 8t
>>     disk: 1SSD
>>     fs: btrfs
>>     rw: randread
>>     bs: 2M
>>     ioengine: sync
>>     test_size: 256g
>>     cpufreq_governor: performance
>>
>> test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
>> test-url: https://github.com/axboe/fio
>>
>>
>> Details are as below:
>>
>> =========================================================================================
>> bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase:
>>    2M/gcc-11/performance/1SSD/btrfs/sync/x86_64-rhel-8.3/8t/debian-11.1-x86_64-20220510.cgz/300s/randread/lkp-csl-2ap4/256g/fio-basic
>>
>> commit:
>>    f7de4886fe ("rnbd-srv: remove struct rnbd_dev")
>>    8c5035dfbb ("blk-wbt: call rq_qos_add() after wb_normal is initialized")
>>
>> f7de4886fe8f008a 8c5035dfbb9475b67c82b3fdb73
>> ---------------- ---------------------------
>>           %stddev     %change         %stddev
>>               \          |                \
>>        0.03 ±106%      +0.2        0.22 ± 80%  fio.latency_20ms%
>>        0.02 ± 33%      -0.0        0.01 ± 12%  fio.latency_4ms%
>>        2508           -10.6%       2243        fio.read_bw_MBps
>>     6717440           +17.6%    7897088        fio.read_clat_90%_us
>>     6892202           +19.0%    8202922        fio.read_clat_95%_us
>>     7602176 ±  4%     +18.4%    9000277 ±  3%  fio.read_clat_99%_us
>>     6374238           +11.8%    7127450        fio.read_clat_mean_us
>>      363825 ± 10%     +74.9%     636378 ±  5%  fio.read_clat_stddev
>>        1254           -10.6%       1121        fio.read_iops
>>      104.97           +11.8%     117.32        fio.time.elapsed_time
>>      104.97           +11.8%     117.32        fio.time.elapsed_time.max
>>       13731            +5.6%      14498 ±  4%  fio.time.maximum_resident_set_size
>>      116.00            -8.2%     106.50        fio.time.percent_of_cpu_this_job_got
>>   1.998e+10           +11.4%  2.226e+10        cpuidle..time
>>        3.27 ±  3%      +4.6%       3.42        iostat.cpu.iowait
>>        4.49 ± 68%      -2.1        2.38 ±152%  perf-profile.children.cycles-pp.number
>>        4.49 ± 68%      -2.5        1.98 ±175%  perf-profile.self.cycles-pp.number
>>      557763            +5.4%     587781        proc-vmstat.pgfault
>>       25488            +3.1%      26274        proc-vmstat.pgreuse
>>     2459048           -10.1%    2209482        vmstat.io.bi
>>      184649 ±  5%     -10.4%     165526 ±  7%  vmstat.system.cs
>>      111733 ± 30%     +61.8%     180770 ± 21%  numa-meminfo.node0.AnonPages
>>      113221 ± 30%     +60.2%     181416 ± 21%  numa-meminfo.node0.Inactive(anon)
>>       11301 ± 24%    +164.5%      29888 ±117%  numa-meminfo.node2.Active(file)
>>      104911 ± 39%     -80.5%      20456 ±100%  numa-meminfo.node3.AnonHugePages
>>      131666 ± 27%     -67.9%      42297 ± 82%  numa-meminfo.node3.AnonPages
>>      132698 ± 26%     -67.5%      43158 ± 81%  numa-meminfo.node3.Inactive(anon)
>>       27934 ± 30%     +61.8%      45196 ± 21%  numa-vmstat.node0.nr_anon_pages
>>       28306 ± 30%     +60.2%      45358 ± 21%  numa-vmstat.node0.nr_inactive_anon
>>       28305 ± 30%     +60.2%      45357 ± 21%  numa-vmstat.node0.nr_zone_inactive_anon
>>        6291 ± 24%     +68.0%      10567 ± 26%  numa-vmstat.node2.workingset_nodes
>>       32925 ± 27%     -67.9%      10571 ± 82%  numa-vmstat.node3.nr_anon_pages
>>       33182 ± 26%     -67.5%      10786 ± 81%  numa-vmstat.node3.nr_inactive_anon
>>       33182 ± 26%     -67.5%      10786 ± 81%  numa-vmstat.node3.nr_zone_inactive_anon
>>      161.78 ±  4%     -28.2%     116.10 ± 30%  sched_debug.cfs_rq:/.runnable_avg.avg
>>      161.46 ±  4%     -28.2%     115.85 ± 30%  sched_debug.cfs_rq:/.util_avg.avg
>>      426382           +11.0%     473345 ±  6%  sched_debug.cpu.clock.avg
>>      426394           +11.0%     473357 ±  6%  sched_debug.cpu.clock.max
>>      426370           +11.0%     473331 ±  6%  sched_debug.cpu.clock.min
>>      426139           +10.9%     472586 ±  6%  sched_debug.cpu.clock_task.avg
>>      426368           +11.0%     473130 ±  6%  sched_debug.cpu.clock_task.max
>>      416196           +11.1%     462228 ±  6%  sched_debug.cpu.clock_task.min
>>        1156 ±  7%     -10.8%       1031 ±  6%  sched_debug.cpu.curr->pid.stddev
>>      426372           +11.0%     473334 ±  6%  sched_debug.cpu_clk
>>      425355           +11.0%     472318 ±  6%  sched_debug.ktime
>>      426826           +11.0%     473787 ±  6%  sched_debug.sched_clk
>>   1.263e+09            -7.9%  1.164e+09 ±  3%  perf-stat.i.branch-instructions
>>      190886 ±  5%     -10.8%     170290 ±  7%  perf-stat.i.context-switches
>>   1.979e+09            -8.8%  1.804e+09 ±  2%  perf-stat.i.dTLB-loads
>>   8.998e+08            -8.2%  8.257e+08 ±  2%  perf-stat.i.dTLB-stores
>>   6.455e+09            -8.0%  5.938e+09 ±  3%  perf-stat.i.instructions
>>       21.78            -8.4%      19.95        perf-stat.i.metric.M/sec
>>     7045315 ±  4%     -14.0%    6057863 ±  6%  perf-stat.i.node-load-misses
>>     2658563 ±  7%     -21.9%    2077647 ± 12%  perf-stat.i.node-loads
>>      414822 ±  4%     -12.9%     361455 ±  3%  perf-stat.i.node-store-misses
>>   1.251e+09            -7.8%  1.154e+09 ±  3%  perf-stat.ps.branch-instructions
>>      189082 ±  5%     -10.7%     168849 ±  7%  perf-stat.ps.context-switches
>>    1.96e+09            -8.8%  1.789e+09 ±  2%  perf-stat.ps.dTLB-loads
>>   8.912e+08            -8.1%  8.187e+08 ±  2%  perf-stat.ps.dTLB-stores
>>   6.393e+09            -7.9%  5.888e+09 ±  3%  perf-stat.ps.instructions
>>     6978485 ±  4%     -13.9%    6006510 ±  6%  perf-stat.ps.node-load-misses
>>     2633627 ±  7%     -21.8%    2060033 ± 12%  perf-stat.ps.node-loads
>>      410822 ±  4%     -12.8%     358289 ±  3%  perf-stat.ps.node-store-misses
>>
>>
>> If you fix the issue, kindly add following tag
>> | Reported-by: kernel test robot <yujie.liu@intel.com>
>> | Link: https://lore.kernel.org/r/202210081045.77ddf59b-yujie.liu@intel.com
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          sudo bin/lkp install job.yaml           # job file is attached in this email
>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>          sudo bin/lkp run generated-yaml-file
>>
>>          # if come across any failure that blocks the test,
>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
>>
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are provided
>> for informational purposes only. Any difference in system hardware or software
>> design or configuration may affect actual performance.
>>
>>
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
