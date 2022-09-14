Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C55B82EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiINIb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiINIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:31:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB80F5467C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663144314; x=1694680314;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PPCtt0/49njBW7l5wD4plhh/E1HhknakqHCg3d/Kwzo=;
  b=b9EzdzBa2yEogat7wVnCNkGQiHzYMCaC3RwYUC9UvMhZFg9vYOOX/St5
   4Lbfx8MUtHMJ6V+W5Rq+YT8gRbSaeiIiLNKVJN4l97t8ZkN1e0xjKoaI4
   ACwRfyAAebSKZgTXjs17bezHhA4AwqlmAOEdiHt39T1aiZJeMGZb5Sxd+
   Lm4DOMKMmOUmd9lHeCT0HYiuX7ohcAg7yfeJOPA4PCguyY4I65ZLZBHLO
   8e63E5/ue/dguoCYSrQYTAEtnYf55lhcXdTWeDIkx3rxv3PCh8wK0dnNe
   P3k61mSW+tcT3vsSrhhzkBwScF8lr8RkGmDXnpfRwv31Z0l5NNetfqRSe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="299728786"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="299728786"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="945426720"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 14 Sep 2022 01:31:53 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 01:31:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 14 Sep 2022 01:31:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 14 Sep 2022 01:31:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2E0KLPAp56Uv4Hny2uBmjiwArLTn8cQFTSPTNJRJ/YH0RZ9cGLGscRRtfNLGG1PvnTRdROV/emqKqWal3wFwh9Z62WsG7+0wHbRsg/XknZDAyMn2QYCA+b4mTSBMxATZyHTaG+dPbfWX6/7QiMemDpMdctyV2DSMGD+wI3CrzsSecM+QuLLOPH/FfaVupdG/R4V/vOhuaSv8gzXFzUMRBtYE4A8FVqBHK2qFSGqCdwwDkMA8LyztdKMlXM+teRumKw8lNaTYdMefgJ/t4k4B7185lTExM5ZGnUWFEM0UH5LFcb2GkKWV63nReKp2aL6TzhRemKt8nZ5ZbmD2dJE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4qQEZwW7benEwXKAPAaUeXoHlAXbdHP4nG6bWf+bzQ=;
 b=SDNSEvvbQUQyqpqF0JkZjnj7zFCwvK+H6Ej1bxB1apOOyMFubZpSt2VFg+hLC9Gn7q06JlEMlejMO0nkEkYCYIVONcedastipbKSn8HtEw4MahW1d/7fHp8pk1SaN3GBJTZHbNJhXwaS+8XWQQsBQ1VfMtausvPx9Vriu/9kWmqvdv3zhfBdtVsbrtxzLMGCVHiNF7qRtW9kx2tIVhSv3uw3JgLAM/MlSAKkrq9tMDGqFeqKuNZ01QnVwUT3IEtwvzQHAWg/btye7s4f+0nM+6VR215mvfeF8EKzgQdphZ04lKp8fkrfgQoeFy4E+FPAjUO113z93YJ7Xml+JIzOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by LV2PR11MB6022.namprd11.prod.outlook.com (2603:10b6:408:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 08:31:47 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::4d24:8150:7fb7:a429]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::4d24:8150:7fb7:a429%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 08:31:47 +0000
Message-ID: <a031ae8e-157a-81e0-1a83-df7ac2b81b39@intel.com>
Date:   Wed, 14 Sep 2022 16:31:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: [char-misc:char-misc-next 21/24]
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c: linux/spinlock.h is included
 more than once.
References: <202209032043.kTT0JeZP-lkp@intel.com>
Content-Language: en-US
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202209032043.kTT0JeZP-lkp@intel.com>
X-Forwarded-Message-Id: <202209032043.kTT0JeZP-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|LV2PR11MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fb5ca6-12da-4652-399f-08da962b9058
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dog9bTJ9VhuOWkZtzXhxTBptNJhyHBBixGiSV2E3jHAJ88FyCwAbuuti8tWTPZsa8KRmTfH+H+jBJ92eGWH2nIgf/E8hsUHPk0ezJDQYrGUcFaJs9y10OEjP/ErAONAdEu4B5pmZNU8R9HLbBraIWwwZLmlbU2SZwo/GZnGgz1CJrwOD5yyIRSvA0g1V8Un1ujIbff1qATESUPLoaWrLWuQvFZn9yGZqt7ozAaIp/E7bocIhVgEzusxVUVixbVTFLmpXduZkrkxlnUv6xWlKz2k/ePWiymN0GuRC0999b5jmnKj8urthyXO2Zy3S2X/VET297g5GXSykQYItjuAkQG1SLHx1DqqSacAKarYn0EqbPSbiflkGGHJAyDGMyx4e8IxRnM1NqEEQybaeRrW0JdBzB9F+6RtSWACuquMQFUL9tfl8VSSU0O3itZC37Y3nMka7lEFMBe07D/Wvk7Na1cuStSkcdsVejSskG80nmEx7yQ7PgMQ8Nh2pyqGg8UtFvI8JvE1YtCUWBAc+SbsO4619jVkB9Zgbg8a5bUXdeVvIIyZ/Chd13h+I6GjdzgSNskSoHBQprDYHFVwvTpoehHE2riRy8NqgDUrNQe29QAJRCDAjlJXQmBAWDyrk2zpV2SRWszupjOA2/jDdYARaWtLR5APil1Tv7NyIgkvfDGjSB7YrsU74Yuviq4mzG/tdmrUUw4GBBMBuiWL05HbgHgK+Etp8Nv1CvMYXFhyGekVCHJT1crR0remSSF9se/x21TDpxDmNv3GYkzPK6FvjrVRn6yr9We8ed7bLOYd8SFdjipBNMMBOmYvkkzffbxpcGEpxmfGX7zk3BDLcasKu55sHXjCkJzOsXC8JSV7dg9Gm5hw5v7U40K79FcL9hMqL3MIcNfQhP+aQsuDRr2q5pqqs8GZRMAy65SuG2TChHbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199015)(83380400001)(6486002)(54906003)(966005)(478600001)(316002)(6916009)(36756003)(6506007)(2906002)(31696002)(2616005)(86362001)(6512007)(26005)(8936002)(5660300002)(38100700002)(4326008)(8676002)(82960400001)(66476007)(66946007)(66556008)(6666004)(41300700001)(186003)(31686004)(43740500002)(45980500001)(473944003)(414714003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0ZyS2NCanZSM1lqWUJWRktaNUVtcWFUWk1XNUptaDJ6dk9TL1YwbjNNVFpv?=
 =?utf-8?B?ZEdxanp4Y0s3ckY3VUdDSDFRSnMvVVRzK01QQ1VGV0dlUDB0a296N3dZeWhB?=
 =?utf-8?B?NVRvT25QZGFMODkvTmxDZVZTcTBKRk5TbWNUVmdFSkViTnJFQWpYUHVVUkJX?=
 =?utf-8?B?RXhLZXN0TlFnSmpSL1poTGh2dE9jcHp4dHQ5YnJJQ3lqcEYvWEg4WHFobG9o?=
 =?utf-8?B?QjM4dUdKSW1kVVhaU2FqTDh1TWFiR2FROE91dlFyc1k0alkzWEh3amJVbmZC?=
 =?utf-8?B?alRKbWtGcHd1QjVMRjFEY25PaHNhRnEvOEVRdGptSVQwaXIyYmZtT3ZUMFZE?=
 =?utf-8?B?cVhtK1BZcG9IYnI0d25TaGFESlFzTFc3N1lPSk5STmI5VWZOZzNrVWtCU096?=
 =?utf-8?B?WTFSQVlWRXhVNEloVHFHTGFGVklXR0UydnFKY04vOFBHNnoxMm9JSHVEL3dm?=
 =?utf-8?B?OUYwM1UrV2Y5cGVjL2x3R3hHeFhlRG5Nei8ySTJFTjJlb2VaRUdGQVVkQWRs?=
 =?utf-8?B?VGlZaTl3UXdyS29qcjRPaFhoZis5S0ZsbjBiK2F0YTI3aktJc0xXVTJDOGsr?=
 =?utf-8?B?MG1sMUE2SkEySUU1OThuRmc5VytXZEVrWUZmVHlOM3U0c0hNZDA3RWpqejFj?=
 =?utf-8?B?MVdKK1hmZDZPYTZGckt3bFNOQXVDVjBHVFA4Szd5S3V1WG1mcGhqRlIwL0dG?=
 =?utf-8?B?QTFuMU5Ib1Y2blZucmF1WmRZRml4MHo5QmxsUTIrVHZSbTVUeEdYS1A2M1NN?=
 =?utf-8?B?WU1ZUlVxdjl5ZDRCV0FxUW9iRFRUaDVmQ0lQbnphMTdhdmp1c2YyRnJxbW9E?=
 =?utf-8?B?SHlQeTNheFFtSjVCaktweFFJNFFmLzZVbU9zNmF1VWo5bncvTkIwOGRYMnNI?=
 =?utf-8?B?WjVQS1dLS1NaRTQ2djEra0lZMzBKeG15NWluakhrWUk5WjRQbE9YbExzSVla?=
 =?utf-8?B?RHQzSEE0dERXMDY5Y05tMHJXOE1KT2NVRlQ0VmJxK2FKY3NkV3F3LzdET1BU?=
 =?utf-8?B?Yk81ZU1ycGZSQUNGUTU1dTZWRFhyNGRHYzRaY09mbHFQWm4zVG96ME84SG04?=
 =?utf-8?B?TWFtQkczbWlTK0NFWE1ZTW9mNS9keHAxQTB1OGJwV2ZBRytDeEFzTU5nYU5E?=
 =?utf-8?B?TjlKZmZGYUVJOGtJOEpxU2ZTWmFRaWpMamZSczJKdmhKQk1SU3JEdU5NcDJl?=
 =?utf-8?B?RnpqK1RsWkE5WHVHb3ptazYrY0F5SnJCbnFnRG1PS2Mwb3hNSmthdkQvMDZO?=
 =?utf-8?B?VVNCVzVWOVBRRWpjSXk1SHEzMUhLWWlRZWpMc3hoRFkrWml2MCtpeTY1RG9D?=
 =?utf-8?B?MWJmSnpEUjdwazFCL0hkbzhBYU9JOSt4dTVzak1EOWs0NjFIaW5MY2luUEx6?=
 =?utf-8?B?L0JjZzdOVlV2OGJGSUI3YW5TZTVobEZUVkxxeHMzSWRDV2g3MWFURzkxbk1X?=
 =?utf-8?B?RURZM1RGbWJEbEJWNVlvL2NTb0RPVVJHOGhraDI4NHU5TGU2ZjVoV212VWhF?=
 =?utf-8?B?aTlPRnJER0p6OWRIQXd4ZkRtWXM4R256STUzRWhwNEFOZk1qRS9wYjRrbURT?=
 =?utf-8?B?Zks1aVc1cUhNTitnYlJGLzIwVUhOUlNjcnZjMklyUHY3ZXdxbnBwYmhxa2Jk?=
 =?utf-8?B?d2hyWFFEZDJjV3hIcE5lN1k0Q3RzVFpNQllMaGtjR1BZZ3dQSnBMZDQxTlBH?=
 =?utf-8?B?RFZNSjRhVmN4bVhHTHNxWDU5KzZZWTRlUWgyZ0J5N0gwdWRpT0dwbFU5Y1ZH?=
 =?utf-8?B?dWtPRVVwb2wvbWdOcGczYnBGaTNPOWg0Z1ZlVWtuUTJqSStwN04wdTZFVi9T?=
 =?utf-8?B?MDBtZXF1eEJVK00rcnQ4d1p1RVdSTEJoNGJCZk92T3ZUVGoxRkttZ1hHRFpz?=
 =?utf-8?B?TkZETXpkRzA1VTNtNDFDVmFOdEVYSk9zZzdlQ3hrcnk4aDBUOVgwdnBYYzRY?=
 =?utf-8?B?WFZETm5YOVlCUlVtdERXVC9VVUNtY0dlaXhEZlVOdk8rRnpPRUprN2ZXOFRs?=
 =?utf-8?B?bWJudEVsZG1aam5LREQ5SmlZeGJBa2hnOVM1b1ZZUW5Oa29hbDQ1eEpOY2Fk?=
 =?utf-8?B?RTM5bURPUVI3M2hSakJoclZsbUpyUFk4WFp6NFFNdGtiRkdxaGg2dzJ0WlNI?=
 =?utf-8?Q?SvwbVDiXoJfftYR6EKnX9D7f9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fb5ca6-12da-4652-399f-08da962b9058
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 08:31:47.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCo+CUEl4L3Q0Y7m/uucTX1o4pSjhN4boq80UH1VoeYBTHGzZgbmTJqZUVNQEK45vvbiHCrTdIoMwoK/80oD2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6022
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-next
head:   ceecbbddbf549fe0b7ffa3804a6e255b3360030f
commit: 7d3e4d807df2a216b9aa2944372f2b3f6ef3f205 [21/24] misc: microchip: pci1xxxx: load gpio driver for the gpio controller auxiliary device enumerated by the auxiliary bus driver.
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>

includecheck warnings: (new ones prefixed by >>)
 >> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c: linux/spinlock.h is included more than once.


7d3e4d807df2a (Kumaravel Thiagarajan 2022-08-25 01:30:44 +0530   5) #include <linux/module.h>
7d3e4d807df2a (Kumaravel Thiagarajan 2022-08-25 01:30:44 +0530  @6) #include <linux/spinlock.h>
7d3e4d807df2a (Kumaravel Thiagarajan 2022-08-25 01:30:44 +0530   7) #include <linux/gpio/driver.h>
7d3e4d807df2a (Kumaravel Thiagarajan 2022-08-25 01:30:44 +0530   8) #include <linux/bio.h>
7d3e4d807df2a (Kumaravel Thiagarajan 2022-08-25 01:30:44 +0530  @9) #include <linux/spinlock.h>
7d3e4d807df2a (Kumaravel Thiagarajan 2022-08-25 01:30:44 +0530  10) #include <linux/mutex.h>
7d3e4d807df2a (Kumaravel Thiagarajan 2022-08-25 01:30:44 +0530  11) #include <linux/kthread.h>
1f4d8ae231f47 (Kumaravel Thiagarajan 2022-08-25 01:30:46 +0530  12) #include <linux/interrupt.h>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
