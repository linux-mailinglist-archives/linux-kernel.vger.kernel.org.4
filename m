Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA064E0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiLOS20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLOS2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:28:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A39147303;
        Thu, 15 Dec 2022 10:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671128883; x=1702664883;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+1ZJMs/Z4G3iBvwWCNvkmql6/nWJzz4tcEm14jD/pIY=;
  b=AETyUSnPyLQeJqdzZrO+livUb37m9YeZh0IoABiT5QOhndIsofHbqqs7
   Ut9Z4zcGmHEnpjT9wu2EcqGJ5rm3FodGQEJVDChrKrb3lo/FyYQmMLLmM
   ogAZqW3yzRGjSsh5zaJSdthGjxjot/BwiDmMwBoRwofjmOJRmK9xlUpqg
   cUnlhUmEUqt1TKv0PwA5EG1r/HpW2/+7GJQsVt/IzDDb9IdLA0CiIZwPb
   v9MJMmBrf09+AdTNzKp4dZESTP9QOlVS0YKW4ielf9ePc2ru4UndHL/y2
   qwXqaz5SYdswTZ3T4ghLSTzeSS1NcCA3y85oy7qM9fLcwNt59sgtlFdRR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="320649332"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="320649332"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:26:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="718102985"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="718102985"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2022 10:26:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 10:26:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 10:26:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 10:26:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3uCQcDNYQmpsnniVktVjQamxHBRjDpSoAvnfH6ZXUOHw375gB2mVoT9AQVm7tv+vi0U6xqxizguQydUKo2jnRLEhefQcAo+JRnPsmFWr438Ot58HTC1XYipkaajlUz1YRCtTbY7T9s/VtuZmtk02WVhkcfvo8nJ+22v4cUx+/7/Y228ejt5BiKEFL4964rn5eXAgb8oSjCDJ6Bs1ZkszVoQ//011qmhXdAPtRH6hTUvUkHYsotV0r5mBKLQngRls9V4VjGWmLWxdoYwmzOYNbj9d5f5lCGfx8p+FEMsQ/b4q1MuJfKpo0QiucTu+TPCp/NtkgnoobOKgUS2ayK/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/hZ9tTBnKOjI4nwa3zm7mnpAI7kiTOJXhgyH5oG/M4=;
 b=NwfWVYE+WqRrlqLVrvb3hj+6PtQXUswW6k480oP5A5gbwEErzEoFrmv3LBKNMsWd1zysSF80PxqZHH7q1/Rxr8OaPYbl5OG8HSTeqVhhiPVFvBSu5Hq8uWpyWVOSHj+CxfidemdVq42iK/kEjhhzZFns7AHsEVa1DwauvssCDZABf+iFP/Zydm2hxUmw1PyoLC0P2zLcHJ1EJnLLoIL46aso3eRExyGMz30SyG+/R+INRDKQ7F5VwPaeLgXB1wnd0Jvx8dGN3NgbDe1Fs+zSFIcCqKvoHGikR+u7PV1KVcdq0ktbrFB05Q+c+/Q7mhjc/gdfh5EHSsmXOd0flfXqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5290.namprd11.prod.outlook.com (2603:10b6:408:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 18:25:42 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 18:25:42 +0000
Message-ID: <819f31d8-5fe0-908e-9861-f4ec36105cd6@intel.com>
Date:   Thu, 15 Dec 2022 10:25:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 11/13] x86/resctrl: Add sysfs interface to write
 mbm_local_bytes_config
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
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990904243.17806.8875872967137007418.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990904243.17806.8875872967137007418.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a291bd-f34c-497d-cb17-08dadec9c619
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVKmdVIAKK8qdlO00AjJUIeg9DZ9VN66KQt2m3Y5b0d/zvKLBc12q+hg3ZX7bBr/aUqs5GNOIQu78Ssy4Ay7oRisu8ryNj9nn/cipDtUR6Q2ULAf7n1sQC/rXudopGiQqRnammL0LPe+p1HyCIuwoRl1G1rRqkzhexjLhZDlXPLjGaOhCy1ZVIguKL6kCrGybzyaZhHL42BeKaNcKxJlw+sPhC34NQZ3KP8WWsmwgituOQbiTSAVbX1ziudpsqWn/6zwRxcj8DeME5K9eo+/GR9lS6DGWpWbcdW+Ev4zMRsx8g4YkdsoBkax7Lw3+ozHxUJYWMIDCIjSWzaAkqHqnYL1b4Mx+FXzAcAqxit963C1KbAcglWT/G4VJhIUksZbMZRgniCGFtyjV5nFhKNsNr9Y6iIwT2AnBX5HC5Z3NQL1EMTtn+htWed7G1ym+llLy3S9v4FaKsBnZ0lXETMrHjz+C76yb4bimM3g5MraolcKGIQ3lJyvyAY66ZS1e982H6j+i0BDSOVAOz/ZQk6dg/udHzWReRrH+zRPtlUN7qCODLnUJp1bpbftR48CqQlgmUttknDcI1P3GiUGLWiTnZjguo7tTLo4RkLPjufBvLxekYLZfD0FQVwbO1aSrUssO4I7BqlUYqvwB1fMp4BcKPO/3+Su9K/70a5DnJexdXwmzTwPTGIRoAjfmd1ARw7+E6IqKVfnIjzuIdCBUTDp6epZkHLeY7VjdtC+EN0U02k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199015)(83380400001)(44832011)(86362001)(31696002)(8936002)(82960400001)(7406005)(5660300002)(38100700002)(7416002)(66476007)(66946007)(4326008)(2906002)(66556008)(8676002)(41300700001)(26005)(6512007)(6506007)(186003)(6666004)(53546011)(2616005)(316002)(6486002)(478600001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEVuMkdISTJrUXpNUmhWZlZpdHlRM1g1eGRPT3lncThTWW85d3paUTFZbTdI?=
 =?utf-8?B?bWswQ0p0SWFtNzNSa3J4YlRLNEZiRldjWHdRK29MSXVBU0x6dDlqOXJGWTJ5?=
 =?utf-8?B?YWFEV0NSVXNneWVMWTZiL1RXeDdabk1heGZ5YUhJNVVHOVdJbEhJbUx6aEda?=
 =?utf-8?B?RG1FanFlZ2xIbEpoUStnWnVsd1dVTDhkWTNhQ21HZWI1ZFdwMlJWWXVHclJz?=
 =?utf-8?B?cUp1RmUxeFBJZWFneTJNSlNWRERJZStzV09CaWJLcDJqZWRaaUhFUnJ4NXdI?=
 =?utf-8?B?bVVLcTNXR2VMOVNYT1dVdjdqVnJOcVlIVXlJelVOTmFxYmpkZmtiYm4vbkt5?=
 =?utf-8?B?RE9SL0huNENUbFZudFhPRU5Yc1lPRXoveXMxVEZYMGhsc3VmbVBCOXhPOGtw?=
 =?utf-8?B?Wmx2OUxjTUgyQnJ5RWlrcWhkZllwclZUNk8zY1lYamx3MHRnWlZ5RWt4cXdl?=
 =?utf-8?B?SzlpSjZCZkEyaFFJdjg0VURsWGFUUFgvbk5Lcit3Z1NxYlNKMU1rOTJ1Y3J1?=
 =?utf-8?B?dFZ5YU5LV1JzeEZBZ3Fwd0xwRFllMFZ5R3hmSWFrdk5ySFBxZ2ErcGdBcEow?=
 =?utf-8?B?dnNTYUpvbThDM0prS3cwVExpNGh3ZmJXa1YwZ0JmM1BKVFE1THZpQXpqcFdL?=
 =?utf-8?B?Y1RpSFRZUHVlZzNjZ1Y4WmR1SmxPZVpDLzFkUGZlNU9RNDkzVExsYTU2STlY?=
 =?utf-8?B?TkRxRDRZQ2kwTnBjYzgreHlPZkgrUDdlazlVbXMwbjJNUHpvVGh5Sm5TVzgy?=
 =?utf-8?B?cTc3OUpMYmRvaXd6OUE2U3N3TFNoSndOUTVJY2tWcTV2OUoxTkxnZFJMaFZP?=
 =?utf-8?B?ZjgxOGQ4WXJoVk1RVXBLZHpEYk8reHRIMGdJa1dTczFEQXd1SjZUcTdwZmRl?=
 =?utf-8?B?WlJhVUxQRDhOZmNqY0JVV0VrT1FLSnJuaEtNTDhWUXl0dTRPZGFUSVB4MXdC?=
 =?utf-8?B?Zzl3OC9KcS8wTW1OWjNhRm9LVjI4cEpPVDNibmVUaVE5UnNPZENJSFg0aEF1?=
 =?utf-8?B?WUVPVzRGdXRMNXNVcVVJYTJ1R0t4dlJjakM5U2cxK0tqelJCM3ZWMnJOczBh?=
 =?utf-8?B?T2h1eVVEUXl5bWovc2lKSXYxamVnejdpSGN1bE14YjhuTDRNY0M5YU5RTGZw?=
 =?utf-8?B?NzJWUWNxNzM4VDZscXRlbkpiUWNhM1RvNzVnc0x5cEszSjZyMDAzYStneXh6?=
 =?utf-8?B?YnVJS2J3Ui9FSkNNdE53TlRVeXQ5RXFYMVBSQWh6ejFnZmJEV0tGbGxwNk1R?=
 =?utf-8?B?SFllMElUakI5eXZvTllPSW9GQitCQTJuLzdpVXM4Rk9VTUFYQlI3anhVR2lW?=
 =?utf-8?B?RGl6c3hWR1N5UElUSGpOaFhVLzgvUHc5Yk1wdWJ6dENrV0RGRGZsVFBRaFVm?=
 =?utf-8?B?VDZabUVpUll2aUJwRkxFMnVBS3NNMURVK3hrZDlRYlBjK0NGVXZCbVgxdDBo?=
 =?utf-8?B?V05lVnhHODlVODBrYVhvc0NRMVl1Wk9IMk9qUUN1RW44bVR6R0p3MUxQcldH?=
 =?utf-8?B?cVF1b21YVGF2aW5taDFxV3VoRGFVRXZyN3RPQXlFbkhqVmg0cnJUNGhtekZ4?=
 =?utf-8?B?cmMxR0xsc0pJYk1PVEJvWm1kNlo3NFBIMWFwemhRWE9RVnBkL2lYcVF2Rlov?=
 =?utf-8?B?MnNUQzA1Y1NjYkFtN0Y2SWZtWWpicDVTVWJSMTE2WUxjSFpBcEM4bFh3OFhZ?=
 =?utf-8?B?RkI1M3BYQm1CdVBralNoa2U1dC9WeTdOV0VwV01xWnBUOEc5Wk5sRUJIMkRP?=
 =?utf-8?B?SzRLL2RCaFNyaGdEcVN3MlJuZXNxNmpzc20ra1dLcjArUUdKUHQvbDZ1blFR?=
 =?utf-8?B?eUlrS0c0QjNCcTBUemhyVnVWUVZ6UWZBNGZvQlpETGRtNGZ2VWQ2MXUyRmxs?=
 =?utf-8?B?REJoR21sNHE5a1pvK0VUalpKbDdIcW9hdmtEcExXSGd0Z2hZR29OdXFMUWc5?=
 =?utf-8?B?eUZlVmpXMGptay8vbXMxbVBIb2tVS0FIdzVRNkdTR0MyWTRCdmFFV2lKRXlM?=
 =?utf-8?B?cUdPSXFOTGxYbGFPUUVPdkx6N3dBcUVYeFpBanpBWG5wMGdHSXRQVzVjbUQv?=
 =?utf-8?B?T0tDcVFqZXd4SjRJLzJMU1E0WmpHdHBKVENpZzBEKzdYcnhBdndTQTNMMXhV?=
 =?utf-8?B?QWpaR1J4RTJtSFJZSWY2dDdjSFIrVkp2SGxCRUNDQzR0U3pMa3VVYmZUT1Qw?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a291bd-f34c-497d-cb17-08dadec9c619
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 18:25:42.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fF1dQktG6CDEQelEXdekLIxPKoW9K+1LjHsiUDiMO5mGew9DK/57EGvhziXRbfBjsWHaN7C8BPB+0i3qg6AkDGpD4kkHMlSCnaUWye0rnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5290
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

On 12/1/2022 7:37 AM, Babu Moger wrote:
> The current event configuration for mbm_local_bytes can be changed by
> the user by writing to the configuration file
> /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config.
> 

Same comments about subject line and usage of "current".

> The event configuration settings are domain specific and will affect all
> the CPUs in the domain.
> 
> Following are the types of events supported:
> ====  ===========================================================
> Bits   Description
> ====  ===========================================================
> 6      Dirty Victims from the QOS domain to all types of memory
> 5      Reads to slow memory in the non-local NUMA domain
> 4      Reads to slow memory in the local NUMA domain
> 3      Non-temporal writes to non-local NUMA domain
> 2      Non-temporal writes to local NUMA domain
> 1      Reads to memory in the non-local NUMA domain
> 0      Reads to memory in the local NUMA domain
> ====  ===========================================================
> 
> For example:
> To change the mbm_local_bytes_config to count all the non-temporal writes
> on domain 0, the bits 2 and 3 needs to be set which is 1100b (in hex 0xc).
> Run the command.
>     $echo  0=0xc > /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
> 
> To change the mbm_local_bytes to count only reads to local NUMA domain 1,
> the bit 0 needs to be set which 1b (in hex 0x1). Run the command.
>     $echo  1=0x1 > /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 8a22a652a6e8..6897c480ae55 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1641,6 +1641,32 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
>  	return ret ?: nbytes;
>  }
>  
> +static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
> +					    char *buf, size_t nbytes,
> +					    loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	ret = mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -1748,9 +1774,10 @@ static struct rftype res_common_files[] = {
>  	},
>  	{
>  		.name		= "mbm_local_bytes_config",
> -		.mode		= 0444,
> +		.mode		= 0644,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= mbm_local_bytes_config_show,
> +		.write		= mbm_local_bytes_config_write,
>  	},
>  	{
>  		.name		= "cpus",
> 
> 

With the subject and changelog comments addressed:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
