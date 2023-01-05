Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082B865E198
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjAEAcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbjAEAcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:32:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E9958F82;
        Wed,  4 Jan 2023 16:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672878635; x=1704414635;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AXGGQk2DsaNVxKPe4AUJJy1zIDbVqprMuilR1rQfhLc=;
  b=EED/eT6q0nS3XcQ+dnYlapDKvSqgaYCd/L2uPy04TThx+iibJhqWpk8V
   smM22sd2UeNai9HW5YpADBjuokbXyUBbZQi40XJaDiFWHRI7WKtmS7+j1
   pBdof0RbvSVr2E4whnxwp4JtRfU4qaLJXRxDJSmU1ZxupuLXEKqUGQimy
   boK79v+6FVAFok9YwpzPRHbenUT78cB+hq+IdCKAJoWWMd8oNja5QXOLd
   cJQk9jdqxwHkuRQHbYVLFS4KpEHbwBnauSFiqX/CYEyGx7CANtsxqFW4q
   Bh11ZZg8Fd6+71wP4TxO20wrWs9Fpu2m46CJYzPzI6lxZOQLMi/fkYLXg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="323312313"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="323312313"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 16:30:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="723854990"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="723854990"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2023 16:30:34 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 16:30:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 16:30:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 16:30:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SutZKlGQ/jMb8mCs+pBbI1ATWQT9zKP/wfzi94aBWMs3afy0iEP1DC2MlzCZ4qweMcBcrTyt8ROnbmfXLxtkz7w3sOMba9MgMsW4Yz1oLyDqfRBQBr/EM7ISlrOBHgVOBmiKqxawkuu/19WMFz2csVqIaxZ0oZT3dDtzubyQk5++cg3pWaPOMH1M7SIUW0W3ATC+070Y1NHLzK2jFiBQDWltx1FrSoIlEfmLZis/UaVx2AuTr7H4ZdAcH5Putzu9aavXJOhMhp702nWChoPVwO0H/9K6+1T6wa2363haI7nyDyOPIU0qA9Xy+bZPzXqiZ/BLfKbQSLKJKTUVy7vBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwJ/wzoY8Rvpe8aYObTTcmc3Pj4g7WdTVEaTMFm4XGA=;
 b=mptQC8QYXLyzigRwf5olHOkBZkytff8qdYVgrTvuaY79fjDrZwZm+dnmN5a9hdEFkjnyZas89LBsPiPvKoTiv/RJcsGOoNB+UvrCtv8nos/UwKSG939LVO5tpP1Q3wXXkVkIgGChgB1xjCpNA79mKt/YzcUbnXe/vCF1Vfn9f7SpwiP+EPwOY/0TK7PwslQ7ZxgV4+yLm9veWlPoUQ2QJmYy2LQh5F/GDekqMD1D45fp++ooWmlgVUtixThahQzmGFpw/D2lDQTreE02IurG+65EmmZkr1+6cBTLh7bsJjT6sp5GfC3K++sOOrQVXPTz9j9OdGENp/VAJ71L0ZUrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7507.namprd11.prod.outlook.com (2603:10b6:8:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 00:30:26 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 00:30:26 +0000
Message-ID: <ea72280d-cf15-b1e4-17d2-966de7f6394e@intel.com>
Date:   Wed, 4 Jan 2023 16:30:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v10 13/13] Documentation/x86: Update resctrl.rst for new
 features
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20221222233127.910538-1-babu.moger@amd.com>
 <20221222233127.910538-14-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221222233127.910538-14-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d00e02a-626d-43e5-37b2-08daeeb40a8d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpZ5t0l+vEo/exdY/ZOt2tuGDggzGo7A17hoIvygz/I5hjcEymUAaZbbZgiah2yfqH1K2WwxghPKFvFQZnWfpFSRHvvuREijHhBNwZfpuwDcw5dWe9vSm68/3xIbM+Rs2vNMBbI+OnIByEId1u5VIrbeYFRSIJX8i5RUvlO24RKpxdAhw1dpYNfuSS47EaHYlBOGTn3jdbKwL00+8/BpeRwBG5b5HmVdLDWo4meU8kkAOHhX39FK/3GgwSMKwyjBnLGYLXL6lakz1dXTjYienGYKyWiHNUWJoYLskIqr2Wgc9GN7ljUdW3vCkwIP20SG/oGTbXKIOFZ4t74Ga/OUzOy3HPm5jvT21qOn2H1u6xqcQB57YPA8K6EC14DE1AWy+Pu0SSAr+fQ4CJ4aU/rs49sUZt5rS4iHerDjMx1TPGHR2curlMewPmQzQ4ujuUhd1G6HB/Z9MvzBNxK7MiGOGYnNxyAX6Tu7HI1p4ZbDoLJmViVZF0T46zMOxt+irQt2yeYqtBsAU+aGRa1ydMv7gQTJZlLX5j7NItDbRWQIQmrQkYjCHCkYURoBYspqpgL4QVhudfrpdHbguGeSj6vzJ2AgiMZAsRl6MFvEU8H3m54DfhiKwyrlnKaVkI1dS34/zAIJm1aTq4tbl8oOWJQUh63A5uwHFZEuCt8Zl6FupumXv6y1s50qRLWVD2FuM195SjRwSKhd2cb5JBtxSc/ItkbKYivsxfktAEWb4AylgB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(83380400001)(2616005)(31696002)(86362001)(82960400001)(316002)(36756003)(38100700002)(31686004)(2906002)(44832011)(15650500001)(8936002)(4326008)(66946007)(41300700001)(7416002)(7406005)(66476007)(66556008)(8676002)(5660300002)(53546011)(6512007)(186003)(26005)(6666004)(6486002)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdTWUNVTWJqMEZGQnpKUkl3c0JISmlkWmxmQVl1NlJiZXZnQUdqdWc5cTBo?=
 =?utf-8?B?UWJiUWJCeUxLbG1sZFVyZWVvRmg2aXZxTHM4YjVKcGwwbm5aNlJObENRQ2N1?=
 =?utf-8?B?a2FtM3FJZmUybzhnRWE5YjZnUnM0ZFQxZDdiaFY0b3FKWlJrOHQ3RVd2U2p1?=
 =?utf-8?B?WHBuNTJXRmRCcTFqdE9QS1hwdmd3Ti9lMUNRR2tYRlM3dzlURklSRTZ3SHg1?=
 =?utf-8?B?NVBvOXJ5ZnFaRDNLVEFoZmpqcUVjUHk4QWhJb2xsSVRIbkdqOGowcHJ2Y3Zk?=
 =?utf-8?B?RlBHdlhPWGJwYkdzK0lwU09pSmY0WUhEazRzMjBTR1A1YjQyWUdMdWFWOU5D?=
 =?utf-8?B?dVpncmlKenlnVktaWEtUS3VXTjN5MVlJVGVWdE5XTWhvdG1iQUlsSVViK0FF?=
 =?utf-8?B?VkY1L1BsODFhbXpRdmx3NjRBTk5rdHlmZmNxREdzUittZ0x5N1lwWnY1RnBZ?=
 =?utf-8?B?MVovUjVRRDQ1V0l0U1QxaFMybUJjUVBWWm1XUWp0YXE2MExPUmZRZ25CTE8y?=
 =?utf-8?B?Uncvd0d3R2JrN0NmMkQ5OSthRWE3akt3MFp0RzRlNmFCb3Z3SDgyV1lOQmhI?=
 =?utf-8?B?NG5xU1FnMkkza1gxeTNxRGNxWTkvYzl3T1FxNXZNWUlVQnFWck5MbGpWYi83?=
 =?utf-8?B?SzRkM3J6OHZNcWRmLzVFYmQ3cjdzcnZTM1lrN2NoamVoVHJTaHNjeEJmM2F3?=
 =?utf-8?B?L3lPYXNoOENRMC96ZHFKV3YzQmVQd1VGVFdBSEFnbk5zSW0wM05PVjFOVElR?=
 =?utf-8?B?MVRQZGEzb1VJM2pFRXl6MmhaekZESkhxeWhkUGVvVk5Pd2RwVEo1Tnp2azRQ?=
 =?utf-8?B?YmJmYVdtRmsyM2FBZWs5SGpEZWJnaEM1OGtzdWU0ZFIycnlac0p5eGt0bDY5?=
 =?utf-8?B?WTdLSkFLeEx0dlB0ZmRKV0RMb0ZKZmgwdWpqczVrdWUvMjdMTnRyR0VpY0dQ?=
 =?utf-8?B?Z0xycUZTSGQ4Slk0dTZvR1RxZXljTTNGWm9lRGxXcGhFUkplT09JVEN0bXp0?=
 =?utf-8?B?YU9WbldRWTFwVTdhaXBvOCtQRW1wSW85UnBwSzZ3dmxKRU12Snc5UnlWNVgr?=
 =?utf-8?B?ZTBKbVR6Q1dKM0pwYyt1WmFHQkpURTZyN3B6K3RMY3ByRFFDVEMyOVQ5cUds?=
 =?utf-8?B?ajB4WHRMYWZhalZZYTBUNnRZVDdoM2xTZ1NPU0pDZ2pleFhONkNZN3N3YVRS?=
 =?utf-8?B?OWNhTFFVa3JjMzh6ak9VYWs0MFY5VEFXQ0lWVXVxa25GclAxRFB2NmhKTldX?=
 =?utf-8?B?bW0wVkNFNHBMbndOa1d5ZFpHQmMzQXE0OXBrYVJzazlzTC9tNUF6TFloQWt3?=
 =?utf-8?B?aWt0L1BKWUlleWNRN1M0bUgrNUZySnNYRGVESVoweGdMUXRZUXNQejJFY1Az?=
 =?utf-8?B?V0p5YUNqZVdvOVdWQytPdm44ZmprcnZ2dytlQ1VOelg5NVQxSnFLYWc1aDVY?=
 =?utf-8?B?ODJQVXRNZGpUVUZENXhyZDN0WEd5U0w1aDFCSWg4SjFUNU1vR2hTQlZJdjk2?=
 =?utf-8?B?S01BZGZsdUw0VGJqM1U3SnQ1Slp4S3d1VFY5Nnk2ZHAweHlwRlVIVWhLMWhs?=
 =?utf-8?B?K0VjWmJPblA2dW0vL2RtL3UxRDkyZUNOdzhRcmJPVVE2WHkxa24yNUQrczBm?=
 =?utf-8?B?bTdaTE50Z2RoUXhPVWgrWG5XWGgzU25jY2xkY2N1djRPYURyV3RUcnMvblpB?=
 =?utf-8?B?cjRMeDQ5dS9vMnBUMVdUUWhnUEtEUlIvOWovREZwaTFIUnRVVnRSZjBkeUhh?=
 =?utf-8?B?Z0NkZEszVlc5OWIzOVRZcUxTTzh5REg3V2Mya21xblp2VTZyalpSaWlodjZX?=
 =?utf-8?B?bWZxVE1EazU2RTREMkZxbU1CTDFrZjU1cWtKVlNkUnRZR0ZlTlY1VHk5eWVo?=
 =?utf-8?B?aDlzeGNyMUNVT0xuR1lwTkx1WWJJMDdnamI2N1FGNHVwL3NkSU9vWnpOTmFi?=
 =?utf-8?B?RE5VWFhYNWNqaHVZakJhcmYwa2JTdnU4ODh6cmovYTZ4VTJ1QTJRL2EvTS9h?=
 =?utf-8?B?NEw2cWFIdGszYjRoVkRtaFlQRDAxMlY3cnRLYUFvM1BXK2FlMWFWL0JHNmg5?=
 =?utf-8?B?RVJycUI4dVQ1S0J0cVhsbW93Y2ZDakRQR0RuVDBEZFJ3KzBBUFpDM2JLRUdS?=
 =?utf-8?B?OUw5eU9ESTMyNEh3QmFOcmJzRG1pU1FrdlZFbnVVbzNMT0U2ZldWMTdobUYv?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d00e02a-626d-43e5-37b2-08daeeb40a8d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 00:30:26.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P25lWL1AkYJvXMvMVaeHQmKZ4iZ0AdusS8fomL1RAIzjNlA+L7ec9sSD/oPraOVQ5wgFhFQEismmy7gUHhU6xtp0Li3qKzdH/ulyYFFYof4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7507
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/22/2022 3:31 PM, Babu Moger wrote:
> Update the documentation for the new features:
> 1. Slow Memory Bandwidth allocation (SMBA).
>    With this feature, the QOS  enforcement policies can be applied
>    to the external slow memory connected to the host. QOS enforcement
>    is accomplished by assigning a Class Of Service (COS) to a processor
>    and specifying allocations or limits for that COS for each resource
>    to be allocated.
> 
> 2. Bandwidth Monitoring Event Configuration (BMEC).
>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>    are set to count all the total and local reads/writes respectively.
>    With the introduction of slow memory, the two counters are not
>    enough to count all the different types of memory events. With the
>    feature BMEC, the users have the option to configure mbm_total_bytes
>    and mbm_local_bytes to count the specific type of events.
> 
> Also add configuration instructions with examples.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/x86/resctrl.rst | 141 +++++++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 71a531061e4e..bea6cab06873 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
>  This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
>  flag bits:
>  
> -=============================================	================================
> +===============================================	================================
>  RDT (Resource Director Technology) Allocation	"rdt_a"
>  CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
>  CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
>  CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
>  MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
>  MBA (Memory Bandwidth Allocation)		"mba"
> -=============================================	================================
> +SMBA (Slow Memory Bandwidth Allocation)         "smba"
> +BMEC (Bandwidth Monitoring Event Configuration) "bmec"
> +===============================================	================================
>  
>  To use the feature mount the file system::
>  
> @@ -161,6 +163,82 @@ with the following files:
>  "mon_features":
>  		Lists the monitoring events if
>  		monitoring is enabled for the resource.
> +		Example::
> +
> +			# cat /sys/fs/resctrl/info/L3_MON/mon_features
> +			llc_occupancy
> +			mbm_total_bytes
> +			mbm_local_bytes
> +
> +		If the system supports Bandwidth Monitoring Event
> +		Configuration (BMEC), then the bandwidth events will
> +		be configurable. The output will be::
> +
> +			# cat /sys/fs/resctrl/info/L3_MON/mon_features
> +			llc_occupancy
> +			mbm_total_bytes
> +			mbm_total_bytes_config
> +			mbm_local_bytes
> +			mbm_local_bytes_config
> +
> +"mbm_total_bytes_config", "mbm_local_bytes_config":
> +	Read/write files containing the configuration for the mbm_total_bytes
> +	and mbm_local_bytes events, respectively, when the Bandwidth
> +	Monitoring Event Configuration (BMEC) feature is supported.
> +	The event configuration settings are domain specific and affect
> +	all the CPUs in the domain. When an event configuration is changed,
> +	the bandwidth counters for all the RMIDs and the events will be
> +	cleared for that domain. The next read for every RMID will report

I think it needs to be emphasized that configuring one event impacts
all events. How about (please feel free to change): "When either event
configuration is changed, the bandwidth counters for all RMIDs of both
events (mbm_total_bytes as well as mbm_local_bytes) are cleared for that
domain. The next read ..."

> +	"Unavailable" and subsequent reads will report the valid value.
> +


Reinette
