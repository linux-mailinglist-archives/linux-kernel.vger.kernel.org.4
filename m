Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225B56BD74F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCPRlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjCPRlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:41:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AC3E1FD3;
        Thu, 16 Mar 2023 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678988455; x=1710524455;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pIcocqssnHpj5YTg4Gz4Xr7HpH9jT8ExeZYPGEm6IPw=;
  b=jmixQH0xVomJguQ+xNJUj2TcX8L7DDlwUeijk9V7hBlydSHvWr6nOf8X
   Wa1Q4aBPlcKOokwp/RQBbV43fArnuTSZosXeuJvFVn9PDSRfvB8hmM8lP
   lmit5OUXe+YlzWgDB5ptI7AefQ6kcFazBaDRycffOaPxaZSyjFi03S+hK
   KkMPkuO4HQeiaB21uSgS2OWYH8SY5PLWtnAkU0GKuvuyMdyLcMznCS46c
   rAD9Ed9UfvlwnwocnmPzrbfir0v2oeGsklKCQQQ2WkL3dcFwUUQIxwXJv
   9Bp0vLXygSSzb2Af8Cnk+nRis6qldbbVMZLSgfZ1tSfICNltOcJq2mE9t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="321920268"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321920268"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 10:40:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="748977377"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="748977377"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2023 10:40:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 10:40:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 10:40:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 10:40:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbVuKZ4DDwb3ChK1cRuC5C/C1ts3KZWuNKySGVUDjP/kBXVcSSXzIqWCTBf7wmGKNwFRB87/KTHUYw+sYuj9xBW4SYQ2mgZnliqkBia2x80snO2PtRHczRtm9ebxnb0YWZY3uS7Lglai1K3XjmLk3IqLgsl9eYbGQUQ9kLPCbwyvcN3IfCEm8YCxAhzdqL7T26VyswbTmZCLuaz/hy0wuVW7bs8/Wi+3IMbwX6Zvxxb643FFbS2W2FHsOcglrnGFczZON3J5GThh1CQfgIgwcqdiQSMqA2jzvSTATggywPdzuik16j9LRku4nyExzl8p4Q2XDh4ftJooSt0QUfNz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B2NTgg8ML39fIWhKT94jcq0zvRZxBLZWGByAZ/j9JE=;
 b=QafJVcX5X0Hdv2w1/YTu4Zsl1V3podZKV9wJgux/yydAjZC4tfEd9CVc6d/ANPeRNA7n2gWzDwZ12de10N96Vf5aaHl77ON9QpxOif04oURht3s2IgyGm1fEzKgiQnjcCYGNQImlN1MpSq9lkTRTdUobyTjRujtcT/3RfD2sxoNm+3RtSwuya8ZI/SUcZinuOQbfAXPDgtbx0da3A94Jr4VnzeRogPyWk9P96sfqaGNS44gGhriJiY9WrE4SlJH3Pq+wQv4kCj1iW4n80J9QbEPcxXk+BKY+HwCPP+EMSuhICJ/5Nx0vnGqGCdKxcV7mNM1IrAhF85VDsbDqzN0wbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 17:40:29 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::9a08:f53b:3a33:1211]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::9a08:f53b:3a33:1211%3]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 17:40:29 +0000
Message-ID: <e70030cb-e0b5-41ba-4913-361a2038e58a@intel.com>
Date:   Thu, 16 Mar 2023 10:40:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 6/8] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-7-jithu.joseph@intel.com>
 <628e092c-793e-96ce-71f5-80392ad69569@redhat.com>
 <9dde72aa-a28d-2b0e-7b90-6b1996dbf202@intel.com>
 <f45c26ae-865b-b7b6-0f2a-5906d9c0a349@redhat.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <f45c26ae-865b-b7b6-0f2a-5906d9c0a349@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|PH7PR11MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: eba71a7a-039e-4930-831f-08db2645886d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYjWsZO/ay4/6bHXrUnf4KDl8tcLREBGDT19COUuOLwZ26Xz21ZrednMaNX9X3tMc+gXCTg43H8kNHDXotN4Iteb0jTzg9ml0dh2mlWGopEmJu94aBLplNEuxiyHvIShiHHqML9io9uR0fpQIaolOfBXdXYZON0JFUHtBYgDaakvcEaUCNfKCae+UdoBXpSGrkziWxgEE6xRqxVBhyDVwhxMAre/Oe16c4zs3kCi8T0PpiT0jCTeJwoM4IKlg1IWtysiMJm8USi+3U/DnsrJo41EfPTsNzLmVM/hLAXvFZGA5KZM6nQnr+L6MXJdESyWAY6TeqpuXbW6ld4oZboySuW32zEMNrj3vjhPUbM3Ilh35G+/gRW8S45m/98KChab2854X77Tt8tN8unPMi2M1eP60uUAjP+WH/sluGJo9YIIZ05amFlhEtJHzy1hw+eJYKgF6EAjfcSTuAhLaDJDt05wBwlT5sYwakfHzSneY5reb3AV++155KBq1s0l3Iq0Xt1Zwpjz6+zwm+o5QKoVMXXQGkTDFt33xtOB1x0pl/BfR1fgceXr+dngk2UUmFFR0iwBLOHbeVlJ05TQttTwIi0kvaoNIDPSPZAMgLHko9jxFeTgcUbZuzrVOFrcBEowj3B1m6RZFyMDpiNfVgEVQvfSHC9l+pKDaG9FTSzJXHXQ/Z2Pws9yI4ptCbQ4XbQPF6qCoDomdzPlAfSL+x5GFIuDD8HpuVpDm5d+K66UuWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199018)(4744005)(7416002)(36756003)(82960400001)(5660300002)(83380400001)(6512007)(478600001)(186003)(6666004)(6506007)(2616005)(6486002)(26005)(53546011)(66556008)(31696002)(38100700002)(316002)(4326008)(66476007)(41300700001)(66946007)(8676002)(8936002)(86362001)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3EzQUJOamtmcUlsRmFQVjhZME1mU1ZTMmJhbUxtcUxkNzBSVE8rdWlmRzg1?=
 =?utf-8?B?Y3VZcFl6eDlxUXdBQ2FCb3llSnlZTU1tcGNnQWRDSWJtbTk0WEtCY2VqVkRi?=
 =?utf-8?B?Unc3RnhCbzY3Mi84T2YzeHFZZ0FqN1Znc0VyMk1DdG1LOGF3aTU1NW8wWWhs?=
 =?utf-8?B?b2VHd0s3VGlSOFVmMjFscUJRUnpjekJ0NjJWT1d6MlZnVWtmdmVpL0dyNXIw?=
 =?utf-8?B?SnBkZEdKaGRJdW51ZEZ6NU1KR0tSTXdSU1ErSzJzcGh2b2lZR3oyT2lEbnhH?=
 =?utf-8?B?ZVhlVE82dXhzVEViQ3NBZEVmWENTU3NlZlZKWlhMV0tkRDNmRDBJSUoxMS9J?=
 =?utf-8?B?YU93VVdqU1pwMEFHdHRRMVdCRXJrbE1PM05pckZWSVEraDRwRWJUTVJUSTZq?=
 =?utf-8?B?OWVqWjBOUXF5NkVRc21xWURhWlYzYm1qM1VoWWxkUlNxdDc0bFVkaFpneGhX?=
 =?utf-8?B?RXdSWDNNN1M4Wnp6VGV6emJYU29wcUFGbThrZXdqSERlekQ5cWlxOThVelF1?=
 =?utf-8?B?eGZRd0IvTGxTZjI5M2NUMzJCdlhnSFluOWJTZlE1cWp4OEprOXh5cTl1bWVi?=
 =?utf-8?B?VFc2aExhN0cxazk3bFlGVzlHOEZoL0o3OHJCUFRoZUd6Z1puaEhTUzk5djJS?=
 =?utf-8?B?WWxkKzRHNXNQNzgzK2lrMWdpcnltVWN1cEhvTlQrcWY3TzJPRWlydVRVWXp6?=
 =?utf-8?B?dkdBNWxDSmE1a2VhZGZPSnRlSzFxeXhMSWVjalJFL3REbm5NSGRiakxhOXRv?=
 =?utf-8?B?YndBbWVWYW9nZUM0UzVxVFpaSGU0MDlIZzlYVnhjK0JCRzh0Z2xtdjVQUjZr?=
 =?utf-8?B?dmRIMWRsQlR6VmU5Z1hrRkJEUzluM1VCZHBKSzByS3JScDUwRVZycVY4cW1i?=
 =?utf-8?B?Ulo4c0FJM2FSZStQcTd0WVhzM3BSVDdpNU1oS1JuTG9vaEMxWUNPQnpGWWNB?=
 =?utf-8?B?cTR1RHdiMkNFY0xaaEpZL1dzYkQ1a0tGWG5xVW92QXd2MEU3RDNHc2FQOU8v?=
 =?utf-8?B?c3FEUGRqWlJXK0FiVC9YM2w3VGRDb0lXQnEyN015WE4wSU9zWnNrTytuOS9T?=
 =?utf-8?B?akh2Wm9DSVV1eTlmWHV4NVhFOURTemNrWDZxQjZYeXlKTHhkeTd5ckRUUGJa?=
 =?utf-8?B?M0ZwOVJUcFZ6TUpDVlRIdDFZVUtzRVRCR2tBZUFwYytDVElMRzdqeHB5bGw3?=
 =?utf-8?B?RzlJNnRQK0lpb1BDMWp2MUZXNS96ZTFpdEMrMlNhMFFjbEtOV1F2TzlwREtp?=
 =?utf-8?B?dWhWQU9yMFlMN3AySm9SMG85eklYRm1pMmQra2llUTV3TzRCZzA0YStsS3A1?=
 =?utf-8?B?bTlMcHhRUGhDVEpaS203WVA4SUxncHZoNHpoY3NObjJMZ1NrQUlGSUpsVWpz?=
 =?utf-8?B?dUNBUVR1RzQ1TWJNZytLRk9ZL2RnWVZiakE1UUhNODdPRFRQQ2JweEVhdTFt?=
 =?utf-8?B?c1lzZVQyME1SS0VFUlhGalk3QktmMU5VQmdjZzJzcHFLUVFLQWF3VTdoTTh6?=
 =?utf-8?B?cHZBU2cramQzaFNSZFRRdDlXNzdDMFlVYWdaV2NuMUdjSVBIQWZ2SVZHSVpp?=
 =?utf-8?B?QzNhcm9JUjM1blBPbWRDclJzaGdDbHBqdGN5aVV2ZGxqWGpsRzVVamVMTTc0?=
 =?utf-8?B?QXAzZW95d0t3MkdsQlBtQUFuZlNGV0UyMDNPU2VRNlhkWVVOdlUzTWtqSE5R?=
 =?utf-8?B?L2tKZVNEZjBUUFR1WUZDZjVGTUsxbiszRFp5bFI5UG93Sm14a01PNDFaNWdV?=
 =?utf-8?B?L0pnNnBmZ3luY01MYld3RVFQQnovQUNmelJ4T21TR0N5cS9ubVgzTVZYeUl4?=
 =?utf-8?B?MVRZSHB3bWV6bGdvTi9uR0w3T082bjlmR3QvdXFJcmxKTG41RGl0QmIyMjBS?=
 =?utf-8?B?QllxY253QmhRUUhPU1JUN3hCSkpvQTh3VGR4S2l1WHl1RDZmRGlwdWJTZlY3?=
 =?utf-8?B?VGl5Z0d2UW5hMFFvbFVSSTFQL0NRL25qVlpkUnNZRFAzRWNMR3MyYmpsWXV1?=
 =?utf-8?B?UVY5WER5WTVjYW9DSjF4Z1FTb2NoVWZKZk53SGRXNWkzcjBPUllGcE5udklk?=
 =?utf-8?B?bHhJZ0ZYOThYN0FaQlNZbzNHRUwzL1YwYUNldmJqOXNkZUpMeTkvUk5RenJQ?=
 =?utf-8?B?UUVtL094RlMweFpXWjhid1VtbU84dXhleU5aL0VmQjVYTmdoVFNnYWhoRHEv?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eba71a7a-039e-4930-831f-08db2645886d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 17:40:29.0127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWZmJBnH1VXuxnYoY6dHzLwEWB3T6MPZakK2Y31piX0lg1WM0QLa570AvSWHOcailkfHF4bEqc7Jog8FYqBkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2023 2:59 AM, Hans de Goede wrote:

>>
>> Only one IFS test is allowed at a time. This is done using "ifs_sem" defined in sysfs.c
> 
> Ah I see.
> 
> After taking a closer look I do see one unrelated issue with this patch
> sysfs.c: run_test_store() does:
> 
>         if (!ifsd->loaded)
>                 rc = -EPERM;
>         else
>                 rc = do_core_test(cpu, dev);
> 
> But AFAICT the loaded check really only applies to the first (intel_ifs_0 device) test type and the 
> Array BIST test should work fine when loaded is false.

This is true, the load check only applies to first test. And the patch (5/8) in this series adds the
check you are suggesting to allow the second test to proceed (as given below)

	if (ifsd->ro_info->test_num != IFS_TYPE_ARRAY_BIST && !ifsd->loaded)
		rc = -EPERM;
	else
		rc = do_core_test(cpu, dev);

It is possible that the snippet you pasted above was from an earlier state.


Jithu
