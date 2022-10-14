Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A75FE7C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJNDyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJNDyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:54:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D13996208
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665719640; x=1697255640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LgkBcGTwAO1vK/dNwk6gKs2Ogvl2xmmX6PsHf7khLPc=;
  b=h956ZCe59hi7g2R8+g0+D4tsYnToakZ8EoIcH+2jOZocDXKBNBoFn+6S
   kRwwWQpC6pGYpInEW6jeLzgw5Q1aWcI80y0XUdBJ/5OpSIyiTtHr5REcc
   IMU+V+AM4l3zFtHO10BUJ0sIfbr2Ws3e63IAg5csi7jlMbmS/bU3nRHQk
   UzYqKRJwaGi7vbPJFmEZzb3Ei9CTF3DnnumW0hOFFjo7FxgNLcMv8/Xko
   zIqWe6iuD+A0BNi4kGMcYpc3deNmUtcDu70aS11j2HpM1OjQIuUbSTro3
   x0xI7d4f+1sV2dPfckYlLoxUrYgtmXi1aLGERmH+Ywx06B8GY8m8L0Nxy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="331781097"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="331781097"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 20:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="627427369"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="627427369"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2022 20:53:59 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 20:53:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 20:53:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 20:53:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWnueP5i5KY8MfQJl7QpbqqvlAtKrDctReQDfoyF0ucEf4YAVPGbT8i7/dxSips6mPzGMZ8dHc1cjsCN7z6gkJnFFvSB5xUbJ7r0EgxSnmUy5IPnODyHPMJEFRKtglY6horwa2bI5kHqkC6UUfPFWK9q/MQ0zwgx+K016UEr+9z48cBnmXmyYhDkrGnz023fsqlR9pPttOafPs+ywJ5zhzzJlYA+HPWdMPEsPrU2Q3xk8ZnIxGsOS1O+E/NbAbABQp41nwPSoqU9GzSnWLzZvfPX9Kga6nJrUu4YOLzrV+Holm64Yk8p9kU8K8/And1JHyxaadYHhqMskQrKXZhkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HERo6vMaZe5X0D/O9n+gC5akS4AU11pd6Geb1BmvJpo=;
 b=IrufSmDRVQUSsY1+8XgcSofdTNsxzc/IYvcxl2pkvBCzFbX4JZpv85ZLgzdx9b6BvjXSY4/7hrhoaXuixHuEGQauy+FIs66QOnEGftaeSZdYcGG625AfBTXBVHot+jz2xOXH6d1EO1pT4n7Gtz104XUTm1Ob+1v7iFe03vinx84SSrAcpxVYIHSsrcMbcZQuObVNo5fCKNjom4xhsg4y1wOnjaRoU+Hz4OGZyQQwWqMNNV5SR9tVpESo2rAZHTAROnothqN1Q9H+da8doYVj/FELAaW7rMTxOA15O1bmLbvZh/gvYw9sGjpZwCC50NZ/eA3hVjjIxVWk1aoKdrVqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Fri, 14 Oct
 2022 03:53:56 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%9]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 03:53:56 +0000
Message-ID: <084b98d1-1021-14fd-0d7b-3b85ffee3035@intel.com>
Date:   Thu, 13 Oct 2022 20:53:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@intel.com>,
        "Yao, Yuan" <yuan.yao@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
 <BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com>
 <9b198ed3-4b2d-c857-710b-3f7115bbcf74@intel.com>
 <78f2021e-339f-9dfb-2aee-51f58ea77ec9@intel.com>
 <9be1413b-ce30-acf8-86fb-3e302dc98396@intel.com>
 <dd5815fa-ec61-b7d1-c0b3-70cd0f33bbee@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <dd5815fa-ec61-b7d1-c0b3-70cd0f33bbee@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:a03:114::38) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|SA1PR11MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: c343ee69-ffc3-493d-6a60-08daad97b7ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZFu/lJ86r6mP0FvHzDcFiN+wTjv01FI76lcHTi0ytaqSMXDvHweOWL48/8hsgqRruBBIWEAJGQYhWnvnDwFyl8JXP0Jb5V1knGyXyExHGmvlkH3P9AtAMGdkrw2wRjmrHcRXhnoE0jTTszmDlTCChIrLkYRwMgWI3olixPHOux5UyQS0tTdBXNdZMASbJvusjNcxMOg4DQ/0n3Y28Byd19uQR2iacpPpBWR4/F7uH/Q4iW4WS5QaSFD8NrtmIaS0XDbnnvzLLm5Zl8Mv36xOnMkrp05Bl4BTDs4oNLrz4Vjz+xDMvosRZD0ENq5oAmnBfE4lb2QYZzsgyC7flzlfnMUTcVzDmoeKwuLMz3M4F6OqSIcAYSXVy+ltUI0z5plmj+xy/bJ/jV5MSRWitq4EFv61vjpqd6CC3KQgyMrpXcv3wDzkaoo+sPqzgkNL05hm3Ar1B+qhpUW8pMPm7wFVYD0IEmlShGL2BO4l5TKTsh/9ZUZkmJ28eImfWf7l2kqTvRdhafnhhGD57/i093iufX2S1hk4MuSNtEyC5Do3lPff2CMPcDDU/aZ0hPLz6aBOpZOirtLcAJCqD3pLrUBL+0D73Eoc5qGPGlFLJDrh6TZl1Z5acqRxb1DPs3Ko+zHMl6s5QDyDYmeQ38YQ9Jih15X8QD+H8Zysn+bt6/ihkRThSp4W/vQSNmjI9n2LuSQ+0uAUF1zcHZ6igrxfCY/9Ktx5Oez3GKb9SXQRrorwwQq3j3daPQA70qMVBj0OXRMaJ7BdxWEXLcH/Zx5zevWCDJKDcHbhh0ipCtUB5pAsfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(38100700002)(82960400001)(5660300002)(53546011)(6486002)(4326008)(478600001)(316002)(54906003)(66476007)(66946007)(66556008)(31696002)(8676002)(26005)(110136005)(6506007)(41300700001)(86362001)(186003)(31686004)(6512007)(8936002)(2616005)(2906002)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDJ6OTdpb0h3TWcwMXlkRy9TcVAzQmRSVy8rUzNUZ2VTS2pHck55Y1QybkhG?=
 =?utf-8?B?eWVMS0JYV0loVmFjZmxwK0dFTDYwUjQyM2dBVnVUejBPam1JMnlsaDFhdEsv?=
 =?utf-8?B?SFAzRHVIVUlaa3Y0RkVuZlU5TGtqdDNBdWdEQUM4Q2dwUkZtYmNuQU04QWhj?=
 =?utf-8?B?cE10QTNxU0JneEtmZ3lLMmVFRjJSejk4NHlhM3dUZGY0WElVSkYvOXRRM2dV?=
 =?utf-8?B?S2xMeTlXMFh5T0dvSUFVTDFoM2luME5ucFdNOFdod0Q0bjBrMzlCQngycTVM?=
 =?utf-8?B?Y0FRTEoveTBESldlRzlWd2w5Q3VMS2NrMExGdlNGRzZyQ0ZZRkFoSDZGdllY?=
 =?utf-8?B?TGR0OUlmZUIxYVdTQXJYUkpIenNMQVN1b0pZbUpwY1VicDFxOTV0UFp2YUcw?=
 =?utf-8?B?NXh6ZW1ibmVWNGRjcGNGK0syRHd0ZGxjYmNQVzNmQlVrTW1JZnhQVWlPQ1N0?=
 =?utf-8?B?VXFGN0s4YUs1ZUZqRDBMNHlOY1Y1ZEFRV3F6RkszOTgyRmNkSDRYeHIrZFda?=
 =?utf-8?B?aDRwaFpMT0pPT0hpeXhZbGFPRmQ3ZTdFT3ZLcmE2Tm5ndFlWUDVkb2NnWjdF?=
 =?utf-8?B?T01CQlhEbGN0cFlmNWlkUmM3eitmQ1p0NUJYV3hhL0dKM1JJUWMxZTBZek9l?=
 =?utf-8?B?Z0lpZjRVVlBkSGdPUzliVG5NejhCTlJRU3psOU9Pbi9Bajl0S00zRlh4dVJM?=
 =?utf-8?B?enpSUVdZQTRsVU1EOEwrMlFWcU5henBYT2xqK0dKbWljazNVUXFtSDFwV2c0?=
 =?utf-8?B?b0FNRy9XaEpiNWRVVExMbWJhUUNnRHdQcCt6UkZHUUUxeTk3ei9LQlN4UHFX?=
 =?utf-8?B?amtWeWhSTThtUkJueEljQUhnWmYrOU82ZFZ5dlpvM2MrZU9PSXE4WkpqQUgy?=
 =?utf-8?B?TkFUQ25qNStzUit2QjVXU1JHUjVxSUtxQmhGR2lzZXY3SXREbGo5bDJzckZJ?=
 =?utf-8?B?SlFVcXkxWDFyamtvNDNtb3Q5R2VHSGg1Z3ZWSjRjaHgyYzJOTEo1QWNtMDFQ?=
 =?utf-8?B?ZkplMUVpWThCNXZrV25QOVJaMmVVYXM5aFdzL3Z4c3d3N1g1WWtoelhoUUxV?=
 =?utf-8?B?amQvMGlTZ3FRSUJzUTR1NXlUMm45a0JEUHIxU0J6QlV1eldyS0hXbFoxTGhS?=
 =?utf-8?B?ajlqa0VzNUZGVkZvN2ZSTzNFZ3RKS0VOTk1CbjhyRi9oVUZRaER4NVpjU2lR?=
 =?utf-8?B?enJkS1doOXNTQzhJbmtxaFlZbWNyc3YyZHVrTGdReDN2WStSUkV6QzRBMlVh?=
 =?utf-8?B?N2FrSmlyU3FiMk50VGJsTHpFUUx5VlpZS1BFeS9BbkQ3NjA2WmYydHQwSDc5?=
 =?utf-8?B?T2tXOEJXQWtNUzFDM0F2ZHN6bXc0RlM1SGJNb09OMU5HRFJBM2lmNlJMWVg4?=
 =?utf-8?B?akVTeVRUbklMalEyNGpKVDFTUXBFY1JCREhkZXpiTmVaNS9CUk5WeCtJeEJH?=
 =?utf-8?B?SGpGK2lOK1htWGV3UkhEcjVibWFwb0RHVzQxdlZESVJaUUh0YUJMV21qYWFz?=
 =?utf-8?B?L1BYQTB4N042YXUvbHFkR1ZLcTVxRGVtODVtcEplZnhwSWF2UlpCeGNSa1g0?=
 =?utf-8?B?ckRWc0RpOUtsRlhTb25WV1BYblo2eGpJekFWb25YY0JGTW9LK3drb3Q3dis3?=
 =?utf-8?B?TS93TVJBZ1pQYThHMzRvNUpoREVQbFIrcms4dEU4MHVqME5hMFFWMFNQOXVQ?=
 =?utf-8?B?cHF2dzRxZzM4MnJjbUVnVTFHa0FabGZndDBCM2FMYkZxTVpVNk9ucCtJN0Fo?=
 =?utf-8?B?QTBOKzN5OW9DRlZZaDJ4Q0VVVDIreFJUTzJJY1l1WGtPaGYxT3UyMmJjejIr?=
 =?utf-8?B?NTJoSENQbHUvUEdPcW5xaHgzcE1EV0xGS3ZoVUpQVS9nK3pIc1Q0aGxHdmZo?=
 =?utf-8?B?ZHB1N0VhaC83OVVJNDhIVjBjOWJGd3BKVks3YjZJOE04aDJSNlRsd3hyMU9Q?=
 =?utf-8?B?OFkrWm9lN3ZlTnJZWkxYY2JrYWorUm96QUMxMWNMMU4rRWFmVHFrUGozRHpB?=
 =?utf-8?B?SnhJc3RCTC9vT2t5cndGM2k0alZxS0NPOEkwVVpieHVFR1NyM09TYWNnbThD?=
 =?utf-8?B?WVJzY1RqOVVTUnFUMGJFbVVoMGRleXV5ZHMzSG9XT05NdzVLZmFVaVp2aWtU?=
 =?utf-8?B?NExlK2N3MFlIakFGQ3VmVkR2c0hoUWxBR3VPVjBJRi90cy9OVVdRWVYxWmlP?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c343ee69-ffc3-493d-6a60-08daad97b7ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:53:56.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOpOCJEbSuOxIx/69sBNGspqtY6Hr5SuTIkqaOqOarJRpIZaISDfFrDo7xSFiSqkOroOP5ZBzr9Yer7wGhwnqaSg8Dp6/ZaU9kEJw+ceAyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2022 10:44 AM, Dave Hansen wrote:
> 
> A better comment for that would be:
> 
> 	 * Some user_xfeatures may not be present in the fpstate.
> 	 * Remove those from 'mask' to zero those features in the
> 	 * user buffer instead of retrieving them from fpstate.

Yes, indeed!

Also this xstate copy routine looks to need some updates.

If an xfeature is present in fpstate, and in init state, the value is 
retrieved from init_fpstate via copy_feature(). But, it has no space for 
dynamic states. Also, for extended states, the init state is known to be 
zero.

Then, perhaps, init_fpstate is better not to be accessed in the 
for_each_extended_xfeature loop; instead of using copy_feature(), the 
feature can be zeroed like this:

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 13b83b11b3d8..0fdfd03938b6 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1150,11 +1150,11 @@ void __copy_xstate_to_uabi_buf(struct membuf to, 
struct fpstate *fpstate,
                          */
                         pkru.pkru = pkru_val;
                         membuf_write(&to, &pkru, sizeof(pkru));
-               } else {
-                       copy_feature(header.xfeatures & BIT_ULL(i), &to,
-                                    __raw_xsave_addr(xsave, i),
-                                    __raw_xsave_addr(xinit, i),
+               } else if (header.xfeatures & BIT_ULL(i)) {
+                       membuf_write(&to, __raw_xsave_addr(xsave, i),
                                      xstate_sizes[i]);
+               } else {
+                       membuf_zero(&to, xstate_sizes[i]);
                 }

Thanks,
Chang
