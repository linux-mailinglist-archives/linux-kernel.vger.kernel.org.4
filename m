Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3780699FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBPW1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPW1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:27:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E51E191;
        Thu, 16 Feb 2023 14:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676586439; x=1708122439;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eyhB6JFAAC2b9CORrA1wH7YfJGWrXX7WAgkV7NeyW4s=;
  b=OvXRumSrviwXrxIFvBKCHI3HBuzGbumWz4yqdrVjVBqBThEzcbHQZL2c
   66NGrzBu529lVCwjsCFqr96zyRw7alKGV7TRJ77FWKJZKpuP4QyHAmvB4
   +54eP0gKw4AmFtS5pB0WLirSilwxm5SRLq22WVwZyOY9O9XW4Nqn6dxUT
   oBbeLapaujKOsk08yCcfngJQEFcQs/6vjBoBZUOFgMRcFykqBlVZE+stq
   3PJ5uwL8kPVmCBiGCn1nfz6aucH+Ja61V1HdXhqP3rgs+h4IWwFAk9se9
   yZs7v1twr2PE94UlaqbOc9GRnZM+oLb2cKExx9+yy9LNpQAnzoJokY+Ff
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="311484950"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="311484950"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 14:27:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="915858027"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="915858027"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2023 14:27:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 14:27:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 14:27:10 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 14:27:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DarzpjwZr2Mr9dwXaNEJa9G/gbU2z+xZuRYS+b+B4whtiM8Q6D4xUR9m+V8a4zBiltDFuHAASOG1+ocGmBRbV8fsoXKAOmTbpKVhRxv6b/umYuVRtK69LAe70GjSnSfVaWlMK8X5ZMB1d1Y9uoYrmpye02pobcwSj1gkc7GLe8biHlHJEtWsXfxje72/PHv8xo6rfcONqFzwnEUr+syK9965mgvjnCTuk+cuyhZfgbL8vnJwShAR7EN7Oj4FqAkUdm4FEjEeRFgLkO2CnwQ+ZvVcEZbOMHhWhmP+TQGdL7U903X+rdEFhjvt6VDeuQpiv8BTBGRCQIWDn/psS7FaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NhIheebMgTInEiW3pvlN2iPu1by5On6KJKDCuJ8OYA=;
 b=N60T+1um/0JOcsOK5ahk3yPJtvnca0LuTNxav4rjmaoKhuK1QUT47fjZVoApFUdx8fY0Se4tCfp1tB3wRKlUXARIrQ7Gn5tvp5XiOSGc40qVazFux07tF3+cEO99xPshwtr+cOc/9U+thq+SDYxJdgkYMBnt4fVf2GKjYjpLlboBRYYJq4ROUr5dHttZGGPSR6nIkBhysjNiT0h5A/9hm9/mFB+gpu85mLq/S4SD2/es19QHLpYo+8kCzp6anuY9RBvY5ui3XyRZ3lgrPVJ1wyUo2hUYuV7iqV7iIgTNzGyV8HMo+1Gx0gtKIV5lmWm/t2MY4cdSdOEtcSkNcUKqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) by
 DM6PR11MB4563.namprd11.prod.outlook.com (2603:10b6:5:28e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Thu, 16 Feb 2023 22:27:07 +0000
Received: from DS7PR11MB6103.namprd11.prod.outlook.com
 ([fe80::7eea:6559:5b5c:82f]) by DS7PR11MB6103.namprd11.prod.outlook.com
 ([fe80::7eea:6559:5b5c:82f%9]) with mapi id 15.20.5986.023; Thu, 16 Feb 2023
 22:27:07 +0000
Message-ID: <3898cf3c-42e8-1fa0-395f-318bceda313d@intel.com>
Date:   Thu, 16 Feb 2023 14:27:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC v2 PATCH 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <reinette.chatre@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
 <167537441417.647488.18261538242584692230.stgit@bmoger-ubuntu>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <167537441417.647488.18261538242584692230.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To DS7PR11MB6103.namprd11.prod.outlook.com
 (2603:10b6:8:84::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6103:EE_|DM6PR11MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b979c8-c55f-47cd-16d7-08db106cefab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZHscuEyNGzXMBC5alRuJEdvu7NCNEZ3jlCuviIU82RYpHyrDq567Upbmg3PJ4dMdG6VuEygWkFl38H6omf1cKqSqf35NWcvop4uKA+8XoWDTMq3CDhMaoy6obg6bjA+PpsZ8nLoamdq1qR2/37ta9iEbr+dwn4bo14/H+C+DLkPn357ACAsKldabDtZE77ahLkNMTG4Y+XDHgVyXqz79UlvONu0OdVRWirmwWO5OxxaruaTgyIzdVrscRmeBp6CpShEyduEuXwG2LSzhIHUdc0WfvBBDVSeRmvqUVEv48NZ0s+4RyOt29mOUlvem1KbKktykH9NoDD0n8H7WBhvCOD8XFMAO0wVZ2SumjfkSLKZFGcIQWRzbMHp1ROJOu1MU6l0zt1hVvYJpJ/TY7nbZ8icHT5iVpnqGAvBhkL0SkqtfWHhnF58kJ5SYZGYfvzOsYD+62I8IlwCAvGX47FfPFHfgPoG48B5XsLVcvnUeltrWFINslKcrHzuOqCIFqlYmkzLbiNIE3es+K66d2y5X3X4ulttNApq67MuQwKhoRGh+jsJAdq+fqDZzfhObkHtdqvABaUnxzM+AiCfE5gcBksU5SsRrmeG2tI6Ce1agB49sptQgliDMWYyUb4pUUYJVsq99GuY8G6gyXE6dijQrmC1RigyZZ0u9PnZwgmh8YlIw4rHjEMcuxbhZP53B/M7J4/vAuObAEinWpjTWxk1LgyXvMA5CVWHHTNB9e6xUgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6103.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199018)(26005)(31686004)(66899018)(83380400001)(2616005)(31696002)(44832011)(2906002)(36756003)(478600001)(186003)(6506007)(41300700001)(6486002)(53546011)(4326008)(6512007)(82960400001)(8676002)(316002)(8936002)(5660300002)(38100700002)(6636002)(7416002)(66556008)(66476007)(86362001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bldNT1AraHFYTlFpNlhibXZXUkIzcDVWU2Z6V1BFY1llVy9za3R4Qzl3T3Vt?=
 =?utf-8?B?ZVpxR3MrRXZXYWsvL29paVpnWjczQ2ZDRXlidGtjTCsrR0VFNzVBcnJaTHZH?=
 =?utf-8?B?MURoYnlOY2RVcnVvK0RNbmJ0aHA5QUtrZEZrUkhYQlFJQ1VRcHVNZ2dJRDlq?=
 =?utf-8?B?UHFRM3pmODdHZFdWUFEyRGtibVQzRzU4Yko5L3djM2VEUzZNV1F3TFRFckc2?=
 =?utf-8?B?eHFray9DTEVEZm5uem1INit0VVhzb05vdThvakZJWVR5ckNVN2pZbXJrQm14?=
 =?utf-8?B?elA5dnhSdExFRkhwSFlBUVJuNnBRdGF0SVJ3QTNydk4wemN2K1BpeU1zSmNX?=
 =?utf-8?B?eHRubWRkT3cvKzhVWjZWZ3VKSkZOb285TlJScWVXMnpwdzdWaU82RndDcTU5?=
 =?utf-8?B?Z3RQVGlUU28wejREWkgrczFKanRuN2U3SmttaFJSNWJBa2V2VzlzbDhqQTVk?=
 =?utf-8?B?YWYvREZHb29Vck1Va2gzeUk1MTdsM3RSb0JtOW5PMXZFY3FzZU9GUTVKQXRP?=
 =?utf-8?B?TTRocUZxT0o4bnF4WU52ODYrN3JjaUE3bmNSVWdHVFUzLzRpZ3VYS3MvWVVi?=
 =?utf-8?B?K3dDejZmcDZid0UvR3p0WCtFdWlsT1NVSklDdVBOOXBqck9kMFlNdmMzOGFp?=
 =?utf-8?B?QlJ3clhabllzRm5wYTYxYnpqWmVlWnllNHNZMXFUaHprMWw5VCtGTW9iNE1C?=
 =?utf-8?B?QnR5TmlTMHBaU2hCaThWUWtNelBkM1UrbWlIckpEKzJKTnZFMmxiYmtGWFFo?=
 =?utf-8?B?YksyMzdtM3lWQ2lneWRIWDl1UFBOdzRlR2s1aEtuQzBkazBTaGttTUxMelNx?=
 =?utf-8?B?NmJNLzY1c2R0R3UvMTBNaXVFb1BjK0YyMmgwQ1hoRUNoRkc0a0xqd3VHdG1r?=
 =?utf-8?B?WFJROWxsVDVmSm05TDhmMFFyV0JvT3h1K3RFK1Ayb21nSmxJRTZ4dHZ4MDJG?=
 =?utf-8?B?UW5aYmdPN2xBZm03Mzk4Zm0vbitUSWY4RjVNbHZrSDgwdjBMVXFTUVpGR2lj?=
 =?utf-8?B?T3JYRGdDSWxTQnJzQ3E1NFBYcWRJbXYyclcrdFBpSUcya2RLOWVnQ08vb3Iy?=
 =?utf-8?B?NkU4RTNGU0NaUmRZS1EwK3dERXFTd3g3TlRQNlhNb2hCQ1N1Vno5ZDlZc1RI?=
 =?utf-8?B?TXFDN2w3UWc0MDl6VlFOL0lhVzU5Mjg3WmFsVHJnRllld3hxKzljbFl4YTJk?=
 =?utf-8?B?UElWUm8vMFZXS3FJR08vcUZWMFpSNzcyYjA4UlA3M0ZwK3JoTk9WNld3TXQy?=
 =?utf-8?B?Z2h2SVF2eldWU3Fwc24xRjRVYXV4SFRVd21TZXp4RTVjSlFCblpYSi9tYlpa?=
 =?utf-8?B?eWdPVlVyTTNkWHhZWEFncmJrNHpWOXBOOHROMmtyUndoYzZRZWl2QUdHLzFv?=
 =?utf-8?B?SUtHNkgrVXpMQytwQ2l5ZXRyUEJPU0QrbXJ1Z1FINkJ1VngxTWU3ZXRBMWxK?=
 =?utf-8?B?K1RpYTJyMjVXSU1DZlRBeEgwUVNlSytqWHFMWXJYQ3FOTWhRNUwzdEQ1WnhG?=
 =?utf-8?B?TUpteVYvV0duTW1VdXdHWmlLckxMaVFvcUd1STM0a3N2WWxSRG8wbS9uRFdM?=
 =?utf-8?B?RDN2RndJMzJzRXlMdFlLa1p4aFpvWDhSWW9LVktEajlrakZqRGtQdGZtVGhh?=
 =?utf-8?B?cE1IaC8zSXJ1YUJjeE1oSFEzRTNoOUtQU0Vic1RMRldYWDNnUmxjbmp3TXJ5?=
 =?utf-8?B?TmtxWmIzVjE3bUtUODVZc3ZvN2lsL0J5RE1DazBJUUJYT21PQWZ4aVF3N3h2?=
 =?utf-8?B?V0hDMnZKQlVnNW8rdWdFOENiL29yOE1ualNGYTBYRjdKckI5Y3ZueEJVdlpy?=
 =?utf-8?B?ekFNbS9pb0wxaXRJVys3b2lqTlRwVSsrR2tzb0RJcThMbVlJRTVhR3BEZUtO?=
 =?utf-8?B?ZFNaOXJOUWdNWml4UmluM0t2MitpRjNlcGRtNEdZU0o1ME4yZ09JK0wyK3Fa?=
 =?utf-8?B?MXdkelZUNGxCSmtUWEJ3VzJiMkhzL2VGSnZmTXY5SUhVZDJFQlhlWEZsYVJ6?=
 =?utf-8?B?ZlVrMWU4aTlzV1RBSy85Uk9FQXRuYnRuRnlUczFHeUt2M3Avb2t3RG92bzVL?=
 =?utf-8?B?c2h5emN2bWtQek5tamIyTDVNRFMyQml6WjNFM1p5d0NDdzRjNWFqNFBndWxH?=
 =?utf-8?Q?9mXRBsGXNchpJtpZUkJaKBMXi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b979c8-c55f-47cd-16d7-08db106cefab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6103.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 22:27:06.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1FMKTM8RRj1c6kYsVxIMUSj2pl0Jr1p7Zw1qGJJGMOobBxfMqBuFFHAvDoqWB3y91Fa42Q2J05xv5w4tv9p0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4563
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Babu,

On 2/2/23 13:46, Babu Moger wrote:
> The resctrl task assignment for MONITOR or CONTROL group needs to be
> done one at a time. For example:
> 
>    $mount -t resctrl resctrl /sys/fs/resctrl/
>    $mkdir /sys/fs/resctrl/clos1
>    $echo 123 > /sys/fs/resctrl/clos1/tasks
>    $echo 456 > /sys/fs/resctrl/clos1/tasks
>    $echo 789 > /sys/fs/resctrl/clos1/tasks
> 
> This is not user-friendly when dealing with hundreds of tasks.

Maybe add something like "poor performance due to syscall overhead...".

> 
> Improve the user experience by supporting the multiple task assignment
> in one command with the tasks separated by commas. For example:
> 
>    $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   Documentation/x86/resctrl.rst          |    9 +++++++--
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |   24 +++++++++++++++++++++++-
>   2 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 058257dc56c8..58b76fc75cb7 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -292,13 +292,18 @@ All groups contain the following files:
>   "tasks":
>   	Reading this file shows the list of all tasks that belong to
>   	this group. Writing a task id to the file will add a task to the
> -	group. If the group is a CTRL_MON group the task is removed from
> +	group. Multiple tasks can be assigned together in one command by
> +	inputting the tasks separated by commas. Tasks will be assigned
> +	sequentially in the order it is provided. Failure while assigning
> +	the tasks will be aborted immediately and tasks next in the
> +	sequence will not be assigned. Users may need to retry them again.

May need to add "tasks before the failure are assigned...".

To retry movement, user needs to know which pid fails. So it's better
to add "last_command_status shows the failure pid and user can parse
it to retry assignment starting from the failure pid".

> +
> +	If the group is a CTRL_MON group the task is removed from
>   	whichever previous CTRL_MON group owned the task and also from
>   	any MON group that owned the task. If the group is a MON group,
>   	then the task must already belong to the CTRL_MON parent of this
>   	group. The task is removed from any previous MON group.
>   
> -
>   "cpus":
>   	Reading this file shows a bitmask of the logical CPUs owned by
>   	this group. Writing a mask to this file will add and remove
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e2c1599d1b37..13b7c5f3a27c 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -683,16 +683,34 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>   				    char *buf, size_t nbytes, loff_t off)
>   {
>   	struct rdtgroup *rdtgrp;
> +	char *pid_str;
>   	int ret = 0;
>   	pid_t pid;
>   
> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>   		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
>   	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>   	if (!rdtgrp) {
>   		rdtgroup_kn_unlock(of->kn);
>   		return -ENOENT;
>   	}
> +
> +next:
> +	if (!buf || buf[0] == '\0')
> +		goto unlock;
> +
> +	pid_str = strim(strsep(&buf, ","));
> +
> +	if (kstrtoint(pid_str, 0, &pid) || pid < 0) {
> +		rdt_last_cmd_puts("Invalid pid value\n");

Better to add pid_str in failure info. Then user knows where the failure 
pid happens and can re-do the movement starting from the failed pid.

> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
>   	rdt_last_cmd_clear();
>   
>   	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
> @@ -703,6 +721,10 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>   	}
>   
>   	ret = rdtgroup_move_task(pid, rdtgrp, of);
> +	if (ret)

May need to report "Failed at %d\n", pid;

> +		goto unlock;
> +	else
> +		goto next;
>   
>   unlock:
>   	rdtgroup_kn_unlock(of->kn);
> 
> 

Thanks.

-Fenghua
