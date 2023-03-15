Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62AB6BA996
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCOHnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCOHnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:43:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25065D895;
        Wed, 15 Mar 2023 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678866150; x=1710402150;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xet8RXymTHr+i/yXZSvaI6btaj68fWaiuYs1IHGJzdA=;
  b=KaOW6AeDzhho+h4qNhLTwN/yx3yqPHiM3P694ALlTuPhfNEclCIqQSqH
   FlGE4j5JyPDJnkFVigWDNcNUP10qT1Sdj6ZXlAjog39r6hFaUwdhWHPRC
   8P8wxR/Uf9XKHZjnd4iDNpKBr3/rH9A4lD72N8guycPzzK7lIoYpDMgCR
   6qEq7Uq3OOzSl4Az7vinSCJS9lCWs8/pUHnJlR4MKcnEV+o6rmsmrJDPS
   w7YsT0GrVmVJQKuQBJaSOSdUthfMxfGEeXDx4HYy9TdYv0wcPxd4h59/C
   tsYk5zIyy6UGwRjrWCvajvP9V7ZVhyqqXxTfxzpDfIgCB0YTc6GHUSsKj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="335122078"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="335122078"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 00:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768407421"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="768407421"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Mar 2023 00:42:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 00:42:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 00:42:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 00:42:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9ujF1L+SbU/QKlVjZqut+mOPDmdZ1/hw2fG+neuHBFgs8dammIMIFUr3Ej8GRNLtHrciQb81ICYXnb24kThOpw4bEUmVANoDvtxCcXP24+dgdIwiM3nJwAbG2CGscrDkQt5j2PP3aiDnhudaWKt+lRR3CzeAtsxTi8h+2PfqfTbY8OJxqRw+J44+VrpAzAiIZ+uvCn0/O5t5L437DnfPwMM4M4aj7L2G/fY8XZsZnUSsIwiL+B10YVqnKbVgtXZ1XXXRWBVrMwRbEQm7bm/A1Qe/dd1Qc6b6uf6BSDHbFAgAhPOsgesrt0qWIVIz/K29kJwVyVoTcV/AiOKAC3gRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FStSp0oLmXHcGTUaknBnX9IZ/ws4UNoy9WkR3YuGaKc=;
 b=BUDtgUdon4qqc0QfDs+ZuT6Lg5PC69AskuI1bVmK7+A4IvLE+214GxBebTWcVtLUbsi+kb034W2vIe7ITOhZ1Li0+yS29yX1KXl+BP/BCv1X8TYSzd+92S+p4Okd2kaBESAivetPasyd30XGWiawSc+BD5uSXvLx5us/jmLMNIw+JsdlCr+Jswxwr75zcEqjoXL0S67r/ZgVJtwCq2cQKHHOuYBXHbO66okkb9hw0bvxwJJwO2joUuaC2zoP3J8+NVXsT0PfhdeTFhmqJkaVcBF9WIZEb/2SUHeUK/AYXUHvWxDB1w851WRELZhygqCWYYLivh+D9XYv5uL407OkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ0PR11MB6720.namprd11.prod.outlook.com (2603:10b6:a03:479::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 07:42:19 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 07:42:19 +0000
Message-ID: <95e604ff-516a-4f7c-7f2c-8ff3d2cc66fa@intel.com>
Date:   Wed, 15 Mar 2023 15:42:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [smb3] 5efdd9122e: filebench.sum_operations/s -50.0% regression
To:     kernel test robot <yujie.liu@intel.com>,
        Steve French <stfrench@microsoft.com>
CC:     <lkp@lists.01.org>, <lkp@intel.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        <linux-kernel@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        <regressions@lists.linux.dev>
References: <20220826022031.GA76590@inn2.lkp.intel.com>
 <c8310cba-36ef-2940-b2c2-07573e015185@intel.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <c8310cba-36ef-2940-b2c2-07573e015185@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0028.apcprd03.prod.outlook.com
 (2603:1096:802:19::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ0PR11MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f810bd-888a-4a56-b48d-08db2528ce4b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+pqNze2DIz7aAGFNx3jhaEkNVlZ0z5I31cRtEWzBkqQignifp6ZOClcrgkkq+xnhUMwdqnjj7zyrmqT0+n9yRnn9Y2BCdlxh2Hg9H56hm7CD7vwu/A6oNQF6VG0akzBE/pWnvHuoAHv6vlIBsY0MJnM48A4NBwREDsCrSOtmOayQaWDXzBZZXrHYpn4vI4Jv+r25zQplTx8KIkf9O0CuvbmZeN2J0BMyAg30nAU6t5uu6UvPszD0F3R6uTZ45aQk0lHWhp18FMAHVvGKTPYFjgUqicMAtB/02Sm/7w3CvDyyFRlGqaaJf2Xi5Qb/c44ebXWZn5ol/C3zqeUix8FS7xfji7zjm1o0I32DBtBlt4VZZhdA0aaqTnTezlEQSWpxiZ9tK9Vq2MkXiGxFs+mSdoKva4T6NInakajSj9iGi+cnYTSCr1VNntQQeW5yaBnwY6E44wnszTZqS1GtDRicnfKUOQ39IQyzIY+A59m36oL/8rbQina+IGhYweqjrjCrIvOi8XFjqi5GC/oTnTPkYFB27kp1iIpzLpyqKbIyWkRw6BfNVNqMgUDEaYKwfTu5l/2Hx9Yf55ozDi939qoK4WMCQ+f1hilsc91DXaCx44VEXXB/sjQ5Gn322a/qDIAhMoky3LwLXyyw2w4pUpqX+1plmv2Hi04CcG+kSuhf+5UdDkkw6p9X+5LEkabZtnJxBqMChlVxVdMDzZR7rKST0JOdWd3fSavc5ek7kTLSUJRn1xlPBxzCcLtImPc2CuNFgp0Xt/fLuYEKtkCGV7FFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199018)(83380400001)(2616005)(86362001)(31696002)(38100700002)(82960400001)(4326008)(8676002)(66946007)(66476007)(30864003)(41300700001)(8936002)(7416002)(316002)(2906002)(5660300002)(36756003)(66556008)(53546011)(6512007)(26005)(186003)(478600001)(6506007)(54906003)(966005)(6486002)(110136005)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2NvaDBvaFp1UTV2ZXhTWFBlR1pDb3pWbE82MFNYN2JKS3pLWFpWZWNBa2d6?=
 =?utf-8?B?MVB4R2tMNDZ0bFVxZ2RXNktaOGVvNWNZeEpWRmNwS0Z4OHR3NjlkbVRCL0xs?=
 =?utf-8?B?N1FYTTNNZUhDZjQwdW5WN1g3em1KZ1dqNW9ia29xTVJ2OEV2VlhyMkpwQWor?=
 =?utf-8?B?MHBPNGcxeFhqNk9PcWRURTREUGlnYUdTVnlMUXZ4aWhVck43SXBkZncyMitV?=
 =?utf-8?B?OTZDTlcrTEhXL0FKZFJaZzJXZ0ZrRldxZW5nREFoTGN1QnQ0UXFrMEUwaDBM?=
 =?utf-8?B?M0xrcnZ0NVNieTNnSXUvV04yc0M1L1l6aWp0RTRLMWczMTk2THpMWHczZE9Y?=
 =?utf-8?B?SjlPaHpqdXZIK0NxQWg1K0k3TGh4ZlJNbHAyaVR2M1BJRmVES1EvZytaRUhN?=
 =?utf-8?B?WHErMWFhekpUZ05nV2c0aXZuMzMxa2FjL0s3NXFuRzhQMktlUmpJU1o3RXVo?=
 =?utf-8?B?M2dPMTRMUlpHZFN1ajlmK2VrakVTQlVEWUZYYkowQ3BXcDZkWE10OTNBRTNi?=
 =?utf-8?B?OW1ReHJ6QUJkUUNuaWdQTFpyekU2UFFvcU9ZWkwvVXo5b3Z6aE5KRGN5MTRN?=
 =?utf-8?B?SGUxQWNXWHFqUCtMRnBKRUw2OE9PSWNMRU1ONGc1YkdzZ0RvWnRBTzR5WGNv?=
 =?utf-8?B?ZzVKd1hjbjR5M2dVa1BqKzdVZHpWOUdvUFBsWm5lSU9GZ3dveEpkVjArcVpv?=
 =?utf-8?B?T2U1dFM5cVZ5bVZKYlRSdTlSSlNXRjlvN2VwZ2g0RTNCVTNzcXE1Q1FndE5E?=
 =?utf-8?B?OEN5RkNCWnR2UVA4ZTd4ZWZFT0JUZ3B0NUg1amx0c29oWFhJMlZUL3Y2QmpD?=
 =?utf-8?B?L2o0ZnpjSmlBa1BtQloxOCsxbEwwa1NCOTlndndpWGNZVUFnSWcwQ2Ntd3lT?=
 =?utf-8?B?bElBSnVDNUFnZ0xCcjd5QUJaZHhXU3VOU01rZWtBck5XRWRUbkhVVndWcGNO?=
 =?utf-8?B?cWtIMVF5aEFyWno1eVdKaHlaS3ZSYVRpZnNxcTM3cjk4bEQzYmJONU8zUzRo?=
 =?utf-8?B?UU5kT2VuWmFJZ2pUT3lobTJ3d1Rla0lLUTlNRHc3dldBK1VLbWV1NEthbzNJ?=
 =?utf-8?B?UTIxZFRCNHRrcnh2c3gyN1hTUEVkYXJCTjdwZ040TFAxQ3lDVlhVaDJZd0F3?=
 =?utf-8?B?UDhLbFJTbVdFSGJGWEdNYUpJekIrUzRnSUQwazg3cWNtcEpCNGVrWDMweE5v?=
 =?utf-8?B?VEsvV3VoTEx6dEh4ZCtpTzQxUDFKZStDRnZSRWVuTldwaE5NQ1VKYU9WZkdy?=
 =?utf-8?B?U09Pb0ZWWG5IYWg2MldvbTBSTVI1VEhLaUZ3NURMS1RXeEcrUUh6Vk1xc0hn?=
 =?utf-8?B?a0k3RW1DZVZNUFpUWitEaGpsMUtWSnh6aHBnTDVyV1A3RVVIWmZsVUVhbVFj?=
 =?utf-8?B?M0ZYbXJ3Y25MejRjMHoyZXZoZVdaWXptWjc0VmRUbGFWRGtaVlJuY2JJdFJv?=
 =?utf-8?B?YlNQTWhXYzFlNHZzTmk2VXZBV0lycHZ5aU45c3JxdU9nZWNQREtXbHJLVEJw?=
 =?utf-8?B?QjJjQVBJWDE0ckQ4d2svbCtDTjd0cXJTMklGOFFPRmVXanU5QVlnYldtbmpV?=
 =?utf-8?B?MSs2RjVLQ0JNZTdXOGd6R2NIMU91MFJqenVIMUQyYTNRQmhhNUZLOS9pWm9p?=
 =?utf-8?B?OFJVZ0kwM3VCN0JNLzF1SGpUanpCNWVBNWVqOEF4YWJzUWE4TDVHalU3dHlJ?=
 =?utf-8?B?aXd1TmZUblhUNnZicTVCN0VueEtIN2xKc0lkNFUzOHBZL0RCRXBGVzBvTUpH?=
 =?utf-8?B?Z0hhN04zWUg5RHdxdDluMTdPUjJFcG03Uk5YV2dHZkpHajRBakd1YjNrRWV2?=
 =?utf-8?B?ZzJBQjV0KzcySlhWYkRwazVmd3pmcCtyZlNnMi9wb1UvUW9MbW81b1BvVEtG?=
 =?utf-8?B?SjlYZ210cVNMeUQ1Vkx0bE5NdHU2M3pSTTlrT0MyVlNmNjdUaDJ1U1RTc3Vp?=
 =?utf-8?B?K3dsOStvTy9hbS9jdUVuMDJpblZsblR0RWxLYzN1Qi85aVZXTXdac0MzQm5h?=
 =?utf-8?B?bERvMy9MTGF5MDVpcFpBT3BnbERFUTk0WHJCLzNLTTZlQkFoZnRRVmc5SmlP?=
 =?utf-8?B?c0ZkMVRNVGlKZDNjekN0RWQxVlltSlBYOFJCZnFyMzRmVm1tK2wreU5lSDY3?=
 =?utf-8?Q?1/4mPT05BkKPi08V5fwZPtDBO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f810bd-888a-4a56-b48d-08db2528ce4b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 07:42:19.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awltk2WGkN0r+QATigEhBcfTKyTe4ubNjXE99g/3da6rb+dKiry/4+9kAAWP5O0BJOwjY7b5TxfodixBq/uxOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6720
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2022 10:41 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -50.0% regression of filebench.sum_operations/s due to commit:
> 
> 
> commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3 ("smb3: allow deferred close timeout to be configurable")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: filebench
> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory
> with following parameters:
> 
>     disk: 1HDD
>     fs: ext4
>     fs2: cifs
>     test: filemicro_delete.f
>     cpufreq_governor: performance
>     ucode: 0x5003302
Please note, we still could see this regresion on v6.3-rc2. And the regression is related with
the commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3. This commit changed the default timeout
value from 1s to 5s. If change the timeout back to 1s as following:

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 6d13f8207e96..6b930fb0c4bd 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -1537,7 +1537,7 @@ int smb3_init_fs_context(struct fs_context *fc)

        ctx->acregmax = CIFS_DEF_ACTIMEO;
        ctx->acdirmax = CIFS_DEF_ACTIMEO;
-       ctx->closetimeo = SMB3_DEF_DCLOSETIMEO;
+       ctx->closetimeo = CIFS_DEF_ACTIMEO;

        /* Most clients set timeout to 0, allows server to use its default */
        ctx->handle_timeout = 0; /* See MS-SMB2 spec section 2.2.14.2.12 */

The regression is gone:
dcb45fd7f501f864                    v6.3-rc2 32715af441411a5a266606be08f
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :25           0%            :3           33%           1:3     last_state.booting
           :25           0%            :3           33%           1:3     last_state.is_incomplete_run
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    515.95           -50.0%     257.98            -0.0%     515.92        filebench.sum_operations/s
      5.04 ±  7%    +833.7%      47.09 ±  2%      -2.9%       4.90 ±  2%  filebench.sum_time_ms/op
     10438          -100.0%       0.33 ±141%    -100.0%       0.50 ±100%  filebench.time.major_page_faults
    167575            -4.1%     160660            -4.4%     160140        filebench.time.maximum_resident_set_size
      7138 ± 11%    +141.4%      17235 ±  3%    +147.6%      17677        filebench.time.minor_page_faults
     28.68 ±  9%    +199.9%      86.00 ±  7%      -2.4%      28.00        filebench.time.percent_of_cpu_this_job_got
   2453485 ± 54%     -63.0%     907380           -66.2%     830273 ±  6%  cpuidle..usage
      0.61 ± 38%      +0.8        1.41 ±  3%      +0.2        0.80 ±  4%  mpstat.cpu.all.sys%
    142984 ± 13%     -45.6%      77725           -47.5%      75106        vmstat.system.in
     34.23 ±  7%     +27.9%      43.79           +27.8%      43.74        boot-time.boot
     17.09 ± 11%     +66.0%      28.38           +65.5%      28.28        boot-time.dhcp
      2661 ±  7%     +37.5%       3659           +37.2%       3651        boot-time.idle
    104737 ±185%     -87.8%      12762 ± 10%     -89.8%      10631 ±  4%  turbostat.C1


32715af441411a5a266606be08f is v6.3-rc2 with the change to restore the timeout to 1s. Thanks.

Regards
Yin, Fengwei


> 
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase/ucode:
>   gcc-11/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp9/filemicro_delete.f/filebench/0x5003302
> 
> commit:
>   dcb45fd7f5 ("cifs: Do not use tcon->cfid directly, use the cfid we get from open_cached_dir")
>   5efdd9122e ("smb3: allow deferred close timeout to be configurable")
> 
> dcb45fd7f501f864 5efdd9122eff772eae2feae9f0f
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     515.95           -50.0%     257.98        filebench.sum_operations/s
>       4.81 ±  2%   +1038.4%      54.78 ±  6%  filebench.sum_time_ms/op
>      29.00 ±  8%    +212.1%      90.50 ±  3%  filebench.time.percent_of_cpu_this_job_got
>      24629            +2.7%      25297        filebench.time.voluntary_context_switches
>  7.685e+08           +19.3%  9.169e+08 ±  4%  cpuidle..time
>       2.53 ±  6%     -20.6%       2.00 ±  3%  iostat.cpu.iowait
>    1506141 ±  8%     +22.4%    1843256 ±  3%  turbostat.IRQ
>       2.00           -50.0%       1.00        vmstat.procs.b
>      21969 ±  2%      -9.5%      19885 ±  2%  vmstat.system.cs
>       3.06 ±  7%      -0.7        2.35 ±  4%  mpstat.cpu.all.iowait%
>       0.79 ±  5%      +0.5        1.27 ±  2%  mpstat.cpu.all.sys%
>       0.89 ±  3%      -0.1        0.79 ±  3%  mpstat.cpu.all.usr%
>      34.55 ± 14%     -34.8%      22.51 ± 27%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>     119.64 ±  3%     -20.0%      95.69 ± 17%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>      34.55 ± 14%     -34.8%      22.51 ± 27%  sched_debug.cfs_rq:/.removed.util_avg.avg
>     119.64 ±  3%     -20.0%      95.69 ± 17%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>       5249           +15.8%       6076        meminfo.Active
>       3866 ±  2%     +17.7%       4552        meminfo.Active(anon)
>       1382 ±  4%     +10.3%       1524 ±  4%  meminfo.Active(file)
>      69791 ± 14%     +39.8%      97553 ±  6%  meminfo.AnonHugePages
>      72709 ±  2%     +12.5%      81779 ±  3%  meminfo.Inactive(file)
>      23219           +13.5%      26352 ±  3%  meminfo.KernelStack
>     966.50 ±  2%     +17.7%       1137        proc-vmstat.nr_active_anon
>      74302            +6.3%      78977 ±  2%  proc-vmstat.nr_anon_pages
>      81133            +6.0%      85973        proc-vmstat.nr_inactive_anon
>      18172 ±  2%     +12.5%      20442 ±  3%  proc-vmstat.nr_inactive_file
>      23213           +13.5%      26348 ±  3%  proc-vmstat.nr_kernel_stack
>      17983            +2.3%      18400        proc-vmstat.nr_mapped
>       7446 ±  2%      +5.5%       7853 ±  3%  proc-vmstat.nr_shmem
>      26888            +1.6%      27306        proc-vmstat.nr_slab_reclaimable
>      47220            +3.4%      48803        proc-vmstat.nr_slab_unreclaimable
>     966.50 ±  2%     +17.7%       1137        proc-vmstat.nr_zone_active_anon
>      81133            +6.0%      85973        proc-vmstat.nr_zone_inactive_anon
>      18172 ±  2%     +12.5%      20442 ±  3%  proc-vmstat.nr_zone_inactive_file
>     361460            +2.5%     370454        proc-vmstat.numa_hit
>     946.67           +18.6%       1122        proc-vmstat.pgactivate
>     361562            +2.5%     370553        proc-vmstat.pgalloc_normal
>     187906            +4.7%     196761        proc-vmstat.pgfault
>       8189            +2.5%       8395        proc-vmstat.pgreuse
>  1.097e+09           +15.5%  1.267e+09 ±  7%  perf-stat.i.branch-instructions
>   39079265 ±  6%     -20.9%   30915354 ±  4%  perf-stat.i.branch-misses
>    5093263 ±  4%     -23.7%    3884752 ±  9%  perf-stat.i.cache-misses
>      29213           -18.7%      23764 ±  5%  perf-stat.i.context-switches
>  7.666e+09 ±  4%      +5.7%  8.106e+09 ±  2%  perf-stat.i.cpu-cycles
>       1877 ± 15%     +75.1%       3287 ± 12%  perf-stat.i.cycles-between-cache-misses
>    1735450 ±  3%     -12.9%    1512060 ±  3%  perf-stat.i.iTLB-load-misses
>       2898 ±  3%     +34.4%       3895 ±  7%  perf-stat.i.instructions-per-iTLB-miss
>       1493           -20.3%       1190 ±  7%  perf-stat.i.major-faults
>       0.09 ±  3%      +5.8%       0.09 ±  2%  perf-stat.i.metric.GHz
>      48.47 ± 11%      +8.4       56.83 ±  7%  perf-stat.i.node-store-miss-rate%
>     283426 ±  4%     -21.6%     222190 ± 10%  perf-stat.i.node-stores
>       3.57 ±  7%      -1.1        2.44 ±  6%  perf-stat.overall.branch-miss-rate%
>       1508 ±  3%     +39.8%       2108 ±  9%  perf-stat.overall.cycles-between-cache-misses
>       3022 ±  3%     +23.6%       3736 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
>  9.585e+08           +18.8%  1.138e+09 ±  6%  perf-stat.ps.branch-instructions
>   34151514 ±  6%     -18.8%   27725316 ±  4%  perf-stat.ps.branch-misses
>    4450329 ±  5%     -21.7%    3486409 ±  9%  perf-stat.ps.cache-misses
>      25524           -16.4%      21333 ±  4%  perf-stat.ps.context-switches
>      77139            +2.5%      79105        perf-stat.ps.cpu-clock
>  6.704e+09 ±  4%      +8.7%  7.287e+09        perf-stat.ps.cpu-cycles
>   1.06e+09           +11.3%   1.18e+09 ±  5%  perf-stat.ps.dTLB-loads
>    1517349 ±  3%     -10.5%    1357716 ±  2%  perf-stat.ps.iTLB-load-misses
>  4.582e+09           +10.8%  5.075e+09 ±  6%  perf-stat.ps.instructions
>       1296           -18.1%       1061 ±  6%  perf-stat.ps.major-faults
>     247613 ±  4%     -19.5%     199283 ±  9%  perf-stat.ps.node-stores
>      77139            +2.5%      79105        perf-stat.ps.task-clock
>  3.697e+10           +35.3%  5.003e+10        perf-stat.total.instructions
>       8.51 ± 91%      -6.9        1.59 ±223%  perf-profile.calltrace.cycles-pp.getdents64
>       8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>       6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.open64
>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>       6.26 ±115%      -5.4        0.88 ±223%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.26 ±115%      -5.4        0.88 ±223%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>       4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record
>       4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist
>       4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push
>       4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
>       3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.exit_mm.do_exit
>       3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exit_mm
>       3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
>       3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
>       8.51 ± 91%      -6.9        1.59 ±223%  perf-profile.children.cycles-pp.getdents64
>       8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>       8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       6.25 ±107%      -6.2        0.00        perf-profile.children.cycles-pp.open64
>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.children.cycles-pp.__x64_sys_getdents64
>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.children.cycles-pp.iterate_dir
>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.children.cycles-pp.get_signal
>       4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.children.cycles-pp.perf_mmap__read_head
>       3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.unmap_vmas
>       3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.unmap_page_range
>       3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.zap_pmd_range
>       3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.zap_pte_range
>       8.54 ± 43%      +8.6       17.19 ± 38%  perf-profile.children.cycles-pp.asm_exc_page_fault
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <yujie.liu@intel.com>
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> #regzbot introduced: 5efdd9122e
> 
> 
