Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652C26BDA32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCPUdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCPUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:33:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE3162DBA;
        Thu, 16 Mar 2023 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678998817; x=1710534817;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uZTCYmxtHKEThYNTj8MQ+Uol5/CjMu5sT3N2HzQ8P1s=;
  b=gMs+9ka1xQe6UaU+9D2oLpO6C7ml/0O3uEsEvbYt6Bc9Xh8ZDvaZPbK/
   jBsHYMO8EWXU1V4/aMxqaBaSn/lXkgnPrTFq3jdlIsi72h6y4W+fXNIBS
   ndpT92Knfd2RPRA+sR56dYm9EHWgrAVysGrwZoTe1Qcjty9LScIuMqVim
   yGpI3gXCR4P84WmGtOdP+yKQGoREw1uGbg7ddiOGAhUTMaMi8pEPJ1XJr
   nxJpiJVowTZoo0vhFIXbKr88HUUBqgzAnaj9rDVYfAAHJmwRqdl6DKmce
   hSF/9hGUxZbxMWwsjnWW7aaceTe5LZHem/CwPxAjMRPbd5eFMYW+nfJa2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424377691"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="424377691"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 13:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="630040924"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="630040924"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 16 Mar 2023 13:33:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 13:33:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 13:33:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 13:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqzmH0m5Pl2my9DP9tp01tR+DKJMsN450JhX1r0Y/xgPluEa1ZVjoWp8j/JLg1IhE0SkTPK0Ls+ykwSFmkUXMHUWSrfhOI2JHwMvuc+eUEiiM8jXfOvXbiariVIWu93pVmhPZDjTZ1/1B+L8VCVb837nbhQ+FwUjq1X8ZD1JtqXddOS0qFx9PlZMu3cLtHhnNsnWaoEaDkiZ99trm7oxT+eykz4JiExNsRrA8AJA0REEa3IcEis5leTICPpCL1ThblSWoP/1sL9kqmsKso6W9VqKIgJhL4InuyUzCzncLeO/YYRHnmzDzy5C/LSFx53zik9YkAilIp/5ey9qXcrdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLPkBXVC73kXe190HMF97U7SyvcM5hxt9tRIsnLtQaY=;
 b=ccbEDPDuoBmF+JBOqWRfF1dEXx/MvWH90n44FZQFNsWTaZmyxLo+uogHnpEPUelggJy+UbZhVWFXqhZs/J0l3O//wKDMA4DNUeSbcu7YY/ncHwrGM+CADP6fkKl1Qa7KdOLLs3aVTPHLPwnKRSR/IAbUxnMR/wJpRw8266dv+ol/3lJnd4d5NySag3logKywKo4XO3VT+3Ep/QSHh3AFvjKojoGzrh5snu7qhGHG+X+nsVM1F7oqbKyCZiUb/bHAHHKFIunwbrzXxxan/i/r9WEwXZBSRssxsOFFUpKLgRwMPsT4wkEAfnjXdS1Cm7ctkQkTFWxA6f7hu29IpkfkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 20:33:26 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 20:33:25 +0000
Message-ID: <7a71ac36-d9dc-c2d8-31fc-127225d21ee4@intel.com>
Date:   Thu, 16 Mar 2023 13:33:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu>
 <9af9eb7a-476c-d4b0-e114-3f5c2b45dd95@intel.com>
 <MW3PR12MB45537DC45130BB5F02F0F3F095BC9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <71b58853-e7c9-b522-3f90-c3d84cba1317@intel.com>
 <39c85927-9c34-0284-86c6-724f417423db@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <39c85927-9c34-0284-86c6-724f417423db@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::28) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c60179-704a-4120-b565-08db265db150
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbGEqHtSaqIZDWvDZoEqDUiBQU+8pnQgDkQSYP9ESx7aONl3iI/YIMWh04ia2FlnJB7Gwzh7Mw5SnUABcR3ITBhuhG2iImSynBAM63gBP46AH77z7VB/Dib02snYmUY13eUfsAdotIdDYFyCa5uJO/4Y4/WhzJl2UOTladrjPNw9MVv2nA7slebDCwr2BU+yJpGXQ9HMshKGuzqfRF4hjrYtGMiIbo7ATfMO9mgs+yat5gugqVWHOnFJEU+pzCJBSKb6lA4nbJUcqIWeyaSLp+th4z0+3FmTk0q3pdAEGOfUOhIp/jMf9BnJTuu8PJgz4zJwE6yQA5tFsiTYiMyx8z/S1anCdtwLj8LllkMwa5UxV2CQIB53jM9i18ZXzI/V1fs69b7AtiHqStQuEYhxR2F/lr9Q7px5q7XLI4RBQRSET9FPzfLk9WT9sScuWxDWVj8VTvZdT44YkKRGNZ5ZHSgzwP5ytYWDJ03dqrooHSfru4jldc5nPkuVP7XaYPqvPn5d2K6eDI529OfbOQhbRG64xsNZUBUI40/GFflbGNgcMwVUo/NofzM7LIZ35iELO/KtXB79AKMGK2PGoUKoWpX/Qa1d3PXyM/nJFf9R49wJYboeE1jGdLT1wwfuWt4Vl+yaBoeDojXB3zSlAMLR6LnNDqNUn/jzLHDXJENkroZduw5SPxt5AWO7qLZ3raTdBPcErN14I7joN1zYZNZ54I7/HncQjr6iOBb7fydw1dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199018)(66899018)(6512007)(6506007)(53546011)(7416002)(7406005)(82960400001)(2616005)(26005)(186003)(6486002)(31686004)(6666004)(316002)(66946007)(8676002)(4326008)(66476007)(41300700001)(66556008)(44832011)(2906002)(83380400001)(54906003)(38100700002)(478600001)(36756003)(5660300002)(86362001)(31696002)(110136005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmFLVnBMbHMzQ1ZnY0pNUmc3SzhMQ3FKaURsWTVPK25LVlg0QmlUa1NHam9D?=
 =?utf-8?B?Q0svVVRkVDZoVnZ5Uzhkby9GZ29iR3dYUUh0aVpLcDVIcFR1UzRIV3U3NDRn?=
 =?utf-8?B?RVpXbXp0ek0wQU9uQ09XYlBrNFpMbXlqbHVNRXVkdExBV1V5dnNhNVVLcVhK?=
 =?utf-8?B?N3hhU1E5QnJCMDkrMEY4bnZRQVhvaDFFekdKZEJBUnhzQnZ3VWFJR2VsaVMz?=
 =?utf-8?B?YjIzck5rQ2Q2dEJzU2RYckNZQ0txMGxLNE1Xa2NWd2twd3JyRnhWQW9mK2x3?=
 =?utf-8?B?VkVHQWZ0eUtwMkY4b05PdCs2MHJaUjJRZXppdkhqMDZoQ1NwRFFLV1ExdGt6?=
 =?utf-8?B?YTl6Wk05Z3NPM2pnNXFJb21EQjRCbUJvSFpmMkRJeUsrOUtWZ01lZ2xlR3h2?=
 =?utf-8?B?dEs2LzUyUXU1MEJQSlh6MVRuTThPVkYrVnVFQnR5aytJSElhWHRzczhDTDVs?=
 =?utf-8?B?Y3VzNkpDWlU3K0s0OVVpSjNHWWRQVkpBMlZOL05pRnRwRk5sRkFMa1VNZUpl?=
 =?utf-8?B?UFlPbVhybWs0alJ5Q3E3a1R5eGFrb0hoV2dtblY1UFRhbTRPdHNGYVpvMDJm?=
 =?utf-8?B?QWVob0NHaDJqVUdEdHQ5WDdGaElyQWh4MjQvWjJMaFJvcy9nb0ZqMXRYQ3dQ?=
 =?utf-8?B?Zkp2RUY3MVN0dW16YkVqWHJGMllveUZuUGNtOXJndzdUdG1DdjNnZTlhSndH?=
 =?utf-8?B?cFpDWTBOUEJwWlYybFhqbUgrRkY3L3RyeDN5UjloeTV1WndNOFBkak45em5s?=
 =?utf-8?B?emh1ZEo0WUd3K3AvT0c0VThKdjZnby8xTEJOeTV0THg1SjVRRjVMSnFrR0tS?=
 =?utf-8?B?L3VWcS9yYUZhWENCUk9KZy9qZ05TamZ5MmFUNmxuMjM5US9WYVUyOWFkdHRH?=
 =?utf-8?B?Z3p5dk5zSVNaOEdlc2tqNGo2cnFhWW91TjR0VHd3ZStVU1NKNXVvZDVvejFa?=
 =?utf-8?B?Q1Y0K2R3VW5ZdWRCT05FWDVkMllmeC9OYUNvQ09PanJWYndpeDRoK1BvU3pO?=
 =?utf-8?B?Q1lhT2tqZzhMMm5YTHlabEFXNDhtdHRKd3czMll5TTd4dmF4dkJNd0ZHWlB4?=
 =?utf-8?B?ZlFoSFpiNjR5OHFHN3d1S3Z6ZTJhVGExK0hna2VjMEN4R1VTU0MzT1hySGZq?=
 =?utf-8?B?NW1FTDREc0FDaFlXSnBHL0ZxcmhPanZyT010TWxlYStSbGtoUS9OYWMyTitG?=
 =?utf-8?B?YXpYMzF3OC9PSXMxT2hBR2FhbENVZE55NXBLYzBJMkl3d3ExMi93T1g5dzZ4?=
 =?utf-8?B?dUxTcGFjUkI3eC8xQnJQTWp4eGFUY2hyTmJkZExmVkNRcE45eEJVN2F6VDZV?=
 =?utf-8?B?ZkxYT0RLTkNXcVpBUncrS1pvdGNiVDBaZ3J3NlZwYVJpTnk5OTE1M1MwYWlE?=
 =?utf-8?B?UVkremZVMkt6aExWNUQ0TzFLNkxmblBhbmsvNzBIdnE4dlJzMmI2MVJOd1Vz?=
 =?utf-8?B?Tk9MNVcxWkQwanFhZDFKQ3U0OGpIek9qMVdDUWlHOXorZXllTTlFWDJKcGhU?=
 =?utf-8?B?TlY4a3kxd2VzRnkxRS93R0JOSmtwL2hjQ2d5dDgxOE9qL3JiaE9XdlFHSXFo?=
 =?utf-8?B?WlE5djNGbmlSWlp4T0JuMVJUSEJVLzk2TXJlVHFBZkpMelM0a25VRE9CSUMw?=
 =?utf-8?B?SXpGdmxpSktUUzNvbUtEa2xzaTZGWXVrUGJqb0o1NlQyZkhOUmV2RTlTWUtI?=
 =?utf-8?B?dnc4VHdLK0NFMmRjZTJueTRtS09JSFU1SG9pM0x0TFpBbjFCZDVSYVZDemtJ?=
 =?utf-8?B?Q2U1V2ZoZzRlb0lJbDZTOVlFazNyRkdmNGJVRVAzTUptS2hybmpIOUpzeFhk?=
 =?utf-8?B?TFladmMrQ3hvQ08xUjU1NUptandWWHlaM25Kdkx1a1JFNGhZbWc3d0hNZE45?=
 =?utf-8?B?NlNKUkR4dWIwQnZuTktPVFJZMXhiV3ZCd3Y1d1FzOVFzVmliVURoWUc3NnNp?=
 =?utf-8?B?L1ZoN1IwdFJqd0pwSVVCQnE2b01YLzdwbjJrRzEwOVBWd21HWTMzWGF4Sitv?=
 =?utf-8?B?b0x5ck8wMnNNNU82eCt2dTE4RTh6b2ZqR1kybmowamkxcGE1cTFlbTNsazZm?=
 =?utf-8?B?eS9UcmRyZkVRSTBkRWFzN0FwTVdVbGxMU0V3OVA3YzNBa085eFQ1dW9mVUFz?=
 =?utf-8?B?eHJtNnNsMGJrM1BUSDhveUJMcDljdEdYS0ZHNWdiSmlMNnhTSkFSSnR0L0dy?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c60179-704a-4120-b565-08db265db150
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 20:33:25.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS2hMoYwmPdbPcyZferjlr5UZZDGgb5EGZ72wZEknx2xUZG5ZBxh3w/0rptxVkNRlLRuOQ18mWIJdEbg7NHOXrdZ6SMsBZLcEhD2Q5QESeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
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

Hi Babu,

On 3/16/2023 12:51 PM, Moger, Babu wrote:
> On 3/16/23 12:12, Reinette Chatre wrote:
>> On 3/16/2023 9:27 AM, Moger, Babu wrote:
>>>> -----Original Message-----
>>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>>> Sent: Wednesday, March 15, 2023 1:33 PM
>>>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>>>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>>>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>>>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>>>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>>>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>>>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>>>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>>>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>>>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>>>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>>>> peternewman@google.com
>>>> Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl group
>>>> at once
>>>>
>>>> Hi Babu,
>>>>
>>>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>>>> The resctrl task assignment for MONITOR or CONTROL group needs to be
>>>>> done one at a time. For example:
>>>>>
>>>>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>   $mkdir /sys/fs/resctrl/clos1
>>>>>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>>>>>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>>>>>   $echo 789 > /sys/fs/resctrl/clos1/tasks
>>>>>
>>>>> This is not user-friendly when dealing with hundreds of tasks. Also,
>>>>> there is a syscall overhead for each command executed from user space.
>>>>
>>>> To support this change it may also be helpful to add that moving tasks take the
>>>> mutex so attempting to move tasks in parallel will not achieve a significant
>>>> performance gain.
>>>
>>> Agree. It may not be significant performance gain.  Will remove this line. 
>>
>> It does not sound as though you are actually responding to my comment.
> 
> I am confused. I am already saying there is syscall overhead for each
> command if we move the tasks one by one. Now do you want me to add "moving
> tasks take the mutex so attempting to move tasks in parallel will not
> achieve a significant performance gain".
> 
> It is contradictory, So, I wanted to remove the line about performance.
> Did I still miss something?

Where is the contradiction?

Consider your example:
   $echo 123 > /sys/fs/resctrl/clos1/tasks
   $echo 456 > /sys/fs/resctrl/clos1/tasks
   $echo 789 > /sys/fs/resctrl/clos1/tasks

Yes, there is syscall overhead for each of the above lines. My statement was in
support of this work by stating that a user aiming to improve performance by
attempting the above in parallel would not be able to see achieve significant
performance gain since the calls would end up being serialized.

You are providing two motivations (a) "user-friendly when dealing with
hundreds of tasks", and (b) syscall overhead. Have you measured the
improvement this solution provides?

>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> @@ -683,16 +683,34 @@ static ssize_t rdtgroup_tasks_write(struct
>>>> kernfs_open_file *of,
>>>>>  				    char *buf, size_t nbytes, loff_t off)  {
>>>>>  	struct rdtgroup *rdtgrp;
>>>>> +	char *pid_str;
>>>>>  	int ret = 0;
>>>>>  	pid_t pid;
>>>>>
>>>>> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>>>>> +	/* Valid input requires a trailing newline */
>>>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>>>>  		return -EINVAL;
>>>>
>>>> The resctrl files should be seen as user space API. With the above change you
>>>> take an interface that did not require a newline and dictate that it should have
>>>> a trailing newline. How convinced are you that this does not break any current
>>>> user space scripts or applications? Why does this feature require a trailing
>>>> newline?
>>>
>>> I have tested these changes with intel_cmt_cat tool. It didn’t have any problems. 
>>> We are already doing newline check for few other inputs.
>>
>> You tested this with the _one_ user space tool that you use. This is not sufficient
>> to be convincing that this change has no impact. I do not believe that it is a valid
>> argument that other inputs do a newline check. This input never required a newline
>> check and it is not clear why this change now requires it. It seems that this is an
>> unnecessary new requirement that runs the risk of breaking an existing application.
>>
>> I would like to ask again: How convinced are you that this does not break _any_ current
>> user space scripts or applications? Why does this feature require a trailing
>> newline?
> 
> I do not know of any other tool using resctrl fs.
> So, you want me to drop the newline requirement for this. I can try that.
> Will let you know how it goes.

You continue to avoid my question about why this requires a newline. Until
I learn why this is required, yes, from what I can tell based on this patch 
this requirement can and should be dropped.

>>>>> +
>>>>> +	buf[nbytes - 1] = '\0';
>>>>> +
>>>>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>>>  	if (!rdtgrp) {
>>>>>  		rdtgroup_kn_unlock(of->kn);
>>>>>  		return -ENOENT;
>>>>>  	}
>>>>> +
>>>>> +next:
>>>>> +	if (!buf || buf[0] == '\0')
>>>>> +		goto unlock;
>>>>> +
>>>>> +	pid_str = strim(strsep(&buf, ","));
>>>>> +
>>>>
>>>> Could lib/cmdline.c:get_option() be useful?
>>>
>>> Yes. We could that also. May not be required for the simple case like this.
>>
>> Please keep an eye out for how much of it you end up duplicating ....
> 
> Using the get_options will require at least two calls(one to get the
> length and then read the integers). Also need to allocate the integers
> array dynamically. That is lot code if we are going that route.
> 

I did not ask about get_options(), I asked about get_option().

>>
>>>>> +		ret = -EINVAL;
>>>>> +		goto unlock;
>>>>> +	}
>>>>> +
>>>>>  	rdt_last_cmd_clear();
>>>>>
>>>>>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED || @@ -703,6
>>>> +721,10 @@
>>>>> static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>>>>  	}
>>>>>
>>>>>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
>>>>> +	if (ret)
>>>>> +		goto unlock;
>>>>> +	else
>>>>> +		goto next;
>>>>>
>>>>
>>>> The documentation states "The failure details will be logged in
>>>> resctrl/info/last_cmd_status file." but I do not see how this is happening here.
>>>> From what I can tell this implementation does not do anything beyond what
>>>> last_cmd_status already does so any special mention in the docs is not clear to
>>>> me. The cover letter stated "Added pid in last_cmd_status when applicable." - it
>>>> sounded as though last_cmd_status would contain the error with the pid that
>>>> encountered the error but I do not see this happening here.
>>>
>>> You are right we are not doing anything special here. pid failures error was already there.
>>> I will have to change the text here.
>>
>> What do you mean with "pid failures error was already there"? From what
>> I understand your goal is to communicate to the user which pid
>> encountered the error and I do not see that done. How will user know
>> which pid encountered a failure?
> 
> We only have couple of failures to take here. Those failures are already
> handled by rdtgroup_move_task. It logs the pid for failure(using
> rdt_last_cmd_printf).

The pid is only logged if there is no task with that pid. How about the
error in __rdtgroup_move_task() - how will the user know which pid triggered
that error?

> 
> I can say "The failure pid will be logged in
> /sys/fs/resctrl/info/last_cmd_status file."

That will not be accurate. Not all errors include the pid.

Reinette
