Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF80D69A395
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjBQBug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjBQBue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:50:34 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC4752CE3;
        Thu, 16 Feb 2023 17:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676598632; x=1708134632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UVzUrW4dh87UNf0QsEH6RGuCYiwAIN++Z50OWi3XN/M=;
  b=gVki56mB69KGgtDNavfi/57gsFdvOb2+Qgb7+3diR1PkzgcO7MVsP+LD
   vuZob5cGHR8yUCJJlcAs2xewWgE3syXhLG4HDgFS0I8ArvZaq1xkTtpFb
   2PpyRh9ftaslskBDLqmSxMLZwW2KAkApMs8hlAx6OGvfatwVtaT+kUo3h
   W8hskcZhGtbNfyFR4D5hVksTRJ3GimSQsXJjQgAs9F4sHlrUskTh4KgzM
   jzeLG6yEWxKTF6pCIJ/a2VSJ10GDqYVRUvAZIiv9edv2h7/tNohBawbEQ
   T+RxhVaF1WtJNLQMrB4n6AmbVh8ObqOihlXQNFArFMqpqupGvtIWNelD7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="312253388"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="312253388"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 17:50:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="734131746"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="734131746"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 16 Feb 2023 17:50:24 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 17:50:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 17:50:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 17:50:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiU1YlgLgmkDF7Zs7yZj0z6NFxF5XNzrmb3WMp0RcAB9zOdnZ1X7+OihWe1Clk36knP1s884TNBkFwZWWWyNbGRZX7zhIJOdDNHrTdouKUlE75ZEb+5h99kKCc3QenEYkcgYokoDVb4sWy6zzY9MRXiNl3d9a+xo7on46ZANhJxxQLqXMk8e4kbY59iNLbT8KMQzLxYyE7xNUvTvB06QHceLX0NsLZFIELqOafDFvWvx91Jf65LODzLtlnpkQs4SFk1XEPaXghWAv+FgUV8ACRA5nHafnNoFSIkbhM1OqD/aVIjNizFs/9vl3n6AsPI+jqKyeEfbHNMG+3U+65O7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2oqnAmY3/LWLGtpH3lDqp/NgH6S5AAyLEVFhKGfNvo=;
 b=WnwrzemxYYNOMPY4HAtgkmQfu7zoyJ2AvcRh2laUWe94xUD1oo+VwXjI0/attZ7L0rdMUWihhopKvDVnAGnNI4SG8nopqm9qu3BPHRryo2cJJF1P7qQnvTm9XnyXTa6MJ4xPKtTTRnoKI8YVw1g4PDhQzT1Y1QSbE57ok4XUBoLth7r9zziWCGkH9dCowj6BeI+r/0HqO6ehcF+iI704Dn45ru6HrKY15C3j3eLF7rrv+l9RCABDL5fjvRaMIsbXhflNZXV8/4JKb8YQ74LnZN683gwCypTnmhe2re3NAqVypFTSyids+S6EH/hgLRJpCtKvDSIaCucLEgzl+voQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 17 Feb
 2023 01:50:18 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%8]) with mapi id 15.20.5986.018; Fri, 17 Feb 2023
 01:50:18 +0000
Message-ID: <6713e2e9-827d-8f3d-0923-a03b6b072383@intel.com>
Date:   Thu, 16 Feb 2023 17:50:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC v2 PATCH 7/7] x86/resctrl: Add debug files when mounted with
 debug option
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <reinette.chatre@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
 <167537445777.647488.12333202522131465679.stgit@bmoger-ubuntu>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <167537445777.647488.12333202522131465679.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:a03:60::36) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BN9PR11MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 088f9f70-e2ac-408f-dbb9-08db1089526b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3dBqmlcLBMClRYub0HwgEVenyEoalG8Z8sMlqWoYpJSjV5U6867M+XC+Xqt8bcYDkYb4qU1TueO+UD+ezkHqkAghzx4mpDGiZ/VD8SNaVQ/b/N8vLbE11o7tNKe5GRXqv0/m4TSYmfGm9weYpf5GFTZKKfwyJJ/LZAplpzCpC0PgHvBL8TiY5Pt8ghano9x+OdgFmKbseRxhLtBLDF0xvHWwjoSR1hpsAGq0UBp+9WloNkzqXjp0VCpfUiF+dsGC2ENPSHALnGUvqdBAfGKRGAS9kpOgaNdVg73ADmOFq3VgrqtLeNKnBhzIYxrR7tqTu/Q2JcbGDsg6LG4b+QKd8fn/cJm6GtLkC/T8kekaXMtIc61iwYgg6ULUCA58y5N8GLoi9gT4osAnzU0c4sEZnX8I+eAB4YCC9m28yePIwzMlDA3ziWNuNyhrhDCsB3Jn39skUmgS4ID60g/AjE+WPl0YB8HSyvAPKYI1V//FrmTx8jd3U9bJ80PsxxOfr5eLmA0m6A1zIaCo3zQmEfLaoXGMiVtaEZPCC09scbKmkZPqz9pBjXdCO2Ze4bOP2zKgGy7K8tlGZwR/bhVE0UqVa6SjDdq/84a2lhDvnEcGWc3Bfh8upTsJzgGcBlGpITABzYKRfwO3L0uLnqkMIwfTIBgW0tWeET8pbNpiEh5JCna9Em8QZOMLMNIGa0ahyPIxJuzHkUrhkERuk14iDQjq1o1GlydO39Pa7uTo8cao/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199018)(6512007)(26005)(66476007)(31696002)(38100700002)(8936002)(86362001)(66556008)(8676002)(4326008)(186003)(7416002)(66946007)(36756003)(6506007)(41300700001)(5660300002)(6486002)(6636002)(316002)(83380400001)(478600001)(44832011)(2616005)(82960400001)(53546011)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzJGdENpYk5PZXhWbmNMWDdpcUd3RHUvb250REJ2dEhNem56NXVSQkpLbi9Z?=
 =?utf-8?B?SG1rVkxoTVc2WkVFeDd6Q3NRQ3hlTjM5OWVVVlhmT0grWkZFM1RVRUo0N0Zj?=
 =?utf-8?B?bHpwTWJubnBtM0ZwS1dXdy9QR09kd2ZXaXlBNUJVdTlycHZYZWlOK0oyM1hW?=
 =?utf-8?B?TGpVcXFaUGgvUStFdE9tMFZ4a3VEMEY0TmRUVXNOWVFpVTV6SjQweWsxWmhx?=
 =?utf-8?B?d0thREdDMHorRVJGSmxYeDlvZEN5aXdoY0hhMjVVN2h1RXZTY2RTUU5MUkFX?=
 =?utf-8?B?em5mZklJVm03UDA5Tm9nK0JGUEQvamJueEFsWG1PeFI1TWh3SUw1L01lTzJx?=
 =?utf-8?B?cFBqT2tzN2pDYW5jUnZIZnFyTHJ0UE5wdzNkTDN0SC82TDdYVTdvUFRQdS9r?=
 =?utf-8?B?UkFhYXB0aE9UMUJueitjc1ROWFhzVWZVVGRMVUhlUzlWTjlZaTVPWFh4OFBB?=
 =?utf-8?B?cFdvYnFEclJPZUphWXdDcUw0bGFTZmhUVDR2UWR6YlZWZVZJUmZHWFJOdFpE?=
 =?utf-8?B?cXJ2S0Q4M1ora3BFZ2l0Q1NzTGZIdHdIS3h5dFQvMkFOVFJOc2s4cVI1bEI3?=
 =?utf-8?B?aHpWMVg0bUd6MlJoeVNaYkl1U2JubjN0MlljbEdCMEVGallTS1NLQ3FLRFBN?=
 =?utf-8?B?TnRFQStvRWhNd0V3S0I3YkUvdHc5bXAvNkVLMXVQczMzYTlrL3dJWktDSnpm?=
 =?utf-8?B?WXJheVVNNUhVYXEzcXl5S3dYNHZNZ1g1UDZxQ0lLLy9vUFVtRzZTWWcrWUw4?=
 =?utf-8?B?ait4SVY2SzhIUFR4NUFZRithT0JmSE5zeVc5MHNUTnpTNWhjRDF6UCtnZktW?=
 =?utf-8?B?Q09ZcjR3SVZoZ1FlK1QvODR4RjM5MnhXdXZhUm5lVUtCNE1nZzByTzU2L0ND?=
 =?utf-8?B?R1pKdzVmQVl4VWhRZ29wS0RZQXJZT1JmbGpXY1lPdXNuV0IxbUlXcTNOZVp0?=
 =?utf-8?B?N3ZKWjZjL2VBc1VVaERteGQyYnBmRlZxbXNxU3duQW1pWnZXOG9LSG1BQUZw?=
 =?utf-8?B?MS9PSmsyWnM5Ry81bmgzTk9pTEVDYlpZc2todVQxdzlYejh3WlNWTDlEOTBT?=
 =?utf-8?B?Ly9wTkprQ0ZuQWpBYW82SGFLTGZ3YXlrRzVROTc2cFpLT3Uyb1I3RDI1T3pM?=
 =?utf-8?B?cGRSNzVicURFUmJNNkJVczMreHUzbTlJUitnOUFmOW5wazhqeXF5NnA1Uk1j?=
 =?utf-8?B?QnJVMXpXc2luT0lZcy9jSTdraWxrV21TK1ZPc1AxZDVlZXJRUDdQTVBsa0x5?=
 =?utf-8?B?b044Yjl3RUZsakdmdnVibVMwTTBSMFhjV0FPdnR6WG5lTE1RaDhTYVVFWkM1?=
 =?utf-8?B?MXVmQjFObkhmeDFZblFQY1ZEc0pSWnZCcEYveEV2cmZadjM2Sm55U1gxMHZV?=
 =?utf-8?B?Zk1BZ3dZTmFMd0s1dmgxSkxtMFBlbThyYVY0N0gxcXIwTCs1U1VQNGROS3RH?=
 =?utf-8?B?L3lGd1F4SWExWTM0Y3N5di9MMUpnazFuOWVHaHBvbXRlazNEdzdDVk05cmx4?=
 =?utf-8?B?ZlJxK0RHYzdFSkZEOTJzVW9UTlpoWEpobWFzVHg5WC8yaDFrQmQ1SmJLSG9G?=
 =?utf-8?B?bHhCZ01hU3BYUFRlamtKQmxVV3VCb0MwdUhkVjFDQ1hGR2ZuM0t3OGs1YTdS?=
 =?utf-8?B?aURMdjZzejlza1FXZU9SN3phaEJSSzVuT21BNzhPWVVMVUh6bFcwNUkySWpq?=
 =?utf-8?B?a2dnZGZRdEdTamdVZ2diU2h4S2N4ZkNJOWJ5bkhZeVF4bVNYNnh3ZDF2clIw?=
 =?utf-8?B?MXhmcjc4MGlEbDhjQk5wYkJNYW9zbi9lVGc4ckUyS2hnQzlPVWVSOWl0bXZD?=
 =?utf-8?B?eEVydGQ1MWhsMjB5c2VnNkw2cUtoeld0VUhPeUd3QklTKzhVNkllSVMzVWZx?=
 =?utf-8?B?eGVJazZxTDFDeUZDeG1SaWh6VXV2UXBVTFcvZ0syRk9uc3Uxdy9qRjFEcllX?=
 =?utf-8?B?UlpBRlk3TnRYMTBlZjVtWHo2elFOWFgzTzUzZVloUGZJTlZkUUZ4dWlqMTJC?=
 =?utf-8?B?ckJTM29BbnNucDlnaUdkZ3V4YjJxMDEyb1IzNnFMdmYwMWduK3JkRGhNMUtH?=
 =?utf-8?B?UU4wT0s0N2s1SUtRYW9QOXNHMFZaRW1ybW5Nb2VqMXFwQ2J3RVl6cjNNTkp3?=
 =?utf-8?Q?m3q8jwSe2jRwVwJv2BoOfDmW6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 088f9f70-e2ac-408f-dbb9-08db1089526b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 01:50:18.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeA8tpgKlmofbXt0kgZIb1yeIrVAzWb7V40Aw//vs2yYqv82XQl0s/B3yZ67zsxeBmdPynYR7nst+2VzJXC/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Babu,

On 2/2/23 13:47, Babu Moger wrote:
> Add the debug files to the resctrl hierarchy.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |   27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index c35d91b04de6..b7c72b011264 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2398,6 +2398,31 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>   			     struct rdtgroup *prgrp,
>   			     struct kernfs_node **mon_data_kn);
>   
> +void resctrl_add_debug_file(struct kernfs_node *parent_kn,
> +			    const char *config, unsigned long fflags,
> +			    bool debug)
> +{
> +	struct rftype *rft;
> +
> +	rft = rdtgroup_get_rftype_by_name(config);
> +	if (debug && rft) {
> +		rft->fflags |= fflags;
> +		rdtgroup_add_file(parent_kn, rft);
> +	} else if (rft) {
> +		rft->fflags &= ~fflags;
> +		kernfs_remove_by_name(parent_kn, config);
> +	}
> +}
> +
> +static void resctrl_add_debug_files(bool debug)
> +{
> +	resctrl_add_debug_file(rdtgroup_default.kn, "rmid",
> +			       RFTYPE_BASE, debug);
> +	resctrl_add_debug_file(rdtgroup_default.kn, "closid",
> +			       RFTYPE_BASE_CTRL, debug);
> +	kernfs_activate(rdtgroup_default.kn);
> +}
> +
>   static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>   {
>   	int ret = 0;
> @@ -2411,6 +2436,8 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>   	if (!ret && ctx->enable_mba_mbps)
>   		ret = set_mba_sc(true);
>    > +	resctrl_add_debug_files(ctx->debug);

It's better to change to:
+	if (ctx->debug)
+		resctrl_add_debug_files();

Then the functions in the call chain can remove 'debug' parameter and 
can be simpler.
> +
>   	return ret;
>   }
>   
> 
> 
Thanks.

-Fenghua
