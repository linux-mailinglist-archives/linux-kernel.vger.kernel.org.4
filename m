Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA547642E5D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiLERIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLERIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:08:11 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FC0D113
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670260090; x=1701796090;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V8hw6xk8bseiQy0po/c8MUezsDb/goqpSeqXqVhsC5k=;
  b=NOysg42qC6/8unE2qGN9FBxALrUt+0m/MEjuxVQNZ+zaKwUIGx4djcYu
   aBeijO+OuwwrA2R6pI+SZckk02FXiNk/L04OUBRgG3W4CuDOdajHmjrey
   6Bw5ajAXuzquPtmhF8IqKveUORErIaPCqoYGzYYY8eUge1gjpXkXsHkW5
   J/PEtXBIyqEenVdOzWCuw6F3fjMpHjMxksDQJ3rBrBveGH+jP033LNJ61
   7l1s7Ki3YHSfOvGMnOrAidZ2xg01mpvTJnk6+g7JMsAkuU0Ed3ID7JyO0
   k1XekvWO7b89CR5UVDDbjmThgOhqjK9xuVpSyetNsI+KCtwy8/a31BaTm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="380698179"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="380698179"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 09:06:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="770414828"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="770414828"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2022 09:06:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 09:06:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 09:06:01 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 09:06:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+s5q6zqmI06GzPx8E7sZ6PNnMixeuqxnrbuwYPP8Qvo8ZDVjcmQFOOKr6jmNSee0ICCcZHkL1Le1HWslP2ZAHP6JdVgMsxrpE+x9KFKL5bfJwOYzVwFz7ybYN2OfVbkCjcTHFrfQatWX0sCup7Oobd8qYzg1zmrJvI0ceLMNgtijogVd0AV7LJQMmrj1+4zCkVcAQuwemQkkKNG3MlYHzZHmi2IjxM6LDg6S+3rj90uKPuOMAWBs9BZqJGcD1GHPJnY7ZF6XHtjI7oHKOISyg3XV1H1BTaG1Oiwx9UfdwSUleJuzt7FQcWOQWiE89eZuiOZHKNqLx/rZQ9f2gSSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyp0KPHg5sBhMHckm+fPPkt6K3unPUhDdFJzk9OEgOk=;
 b=ViNc8vWH4ksnDv4fs4TMJJEDUx5LNOjW0TWfwGOdMvMhKq2TEraPkCwWLXdpc0FA0ZmjcS2/wCHNC8lWk3/1WTa7aVKZQcAYFkwHvwwfGosKnbt9b68p5YK5BKVaFDQoObdHcUdYaOHgKhVwOQEG4B5w5/q2hWyQTVB/CkDhv7bMCVg4ZP0J3m7aWjb2K2LEwrmyKGbltkwfOUxsws0cLu1P6CfQOkLEIy/1aYAGeFxgbdtHaCztRK0CnbhsV9UjnWBvJI4owiYtvhwxCr0Lj6uT+sz6IK34WvQ88rMotF1UwjComY137Fi/U1fInEq9reNW4f3N8k7RMzBUGwkPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB6067.namprd11.prod.outlook.com (2603:10b6:8:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 17:05:59 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%3]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 17:05:59 +0000
Date:   Mon, 5 Dec 2022 09:05:54 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch V1 3/7] x86/microcode/core: Move microcode_check() to
 cpu/microcode/core.c
Message-ID: <Y44k8gXIG+usGkL1@a4bf019067fa.jf.intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-4-ashok.raj@intel.com>
 <Y44bbZMMf8I6Lzl/@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y44bbZMMf8I6Lzl/@zn.tnic>
X-ClientProxiedBy: SJ0PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::21) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM4PR11MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: de060f8f-7497-4fa4-dc08-08dad6e2fb01
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bg5bHCkKj4v7F74CuHEC315zsuQWpn+TLPhOMG8zOQ/lHZB3ANjoHqC1PF/r5RIu92l9+NANfDIBN6KFS8g3iJ1MNt8BLV8odU1PtsV28G0pL6qxczHB/tHIklFC2kFu/KjgHXRXTiAwFYRF0u08mbWenWLti5ZAvjNEl79dnpG2atKrYVVA4j8trj38/cumKMpARkMaxLdE1nBJG4CwhZapqBJFwwOsJbdFymO8oR4IsimftM4P3yP+GtjJmVqLieRlqfVmQyd76q7ElShzAW97nf3EJGY2Wnja+dTLfOaceMj+fm4q5Nb4Yipr7b0l0y05bz/HHhqCLJYCI4ucDurfB9sXyVKlYsxlkJQSasKF3lX0SaHgc0uDYHCUtjKHWb4zH/SC3kspR2yKEgJeHybC1fsskgDq4t5zqHgRWds+p9vHhIlQ7oX4OpkfTWGPyzgaITJeUrG+AFlUkq6mYkFDz1P10KWE0f9I12yZkgdEJ7gutrN1PpiCW7uih3hcSJs9hzripNJ2yC27V+jq3u+qNqMBLRVhYp6FwiXqwj2SuA0PTzK/dRp/Novz/kPLgWvtfn10ESCvLG/oL1RXFqwGM30e5rsFwXdmqEG2S2cZot/vjkB7756/rqvRTxDMi3B9ZhUbMhsOi3B3iKCCkZehNpyilRXvlQsDgt/tk1pgnlSgiCzpCRt7oOoVho26
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199015)(86362001)(478600001)(6486002)(186003)(38100700002)(8676002)(2906002)(5660300002)(44832011)(6512007)(107886003)(26005)(6666004)(4326008)(6506007)(41300700001)(8936002)(6916009)(316002)(66556008)(66476007)(66946007)(54906003)(82960400001)(83380400001)(66899015)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drvMygCjnRznxY22rYXvaO9MjetmVYHIrsd7mSPbuG5/JRsm5Rg4wZL0wP0D?=
 =?us-ascii?Q?ICks6udPjLSBmAjRqDV43oVJ09ZZMniJgK0Rt2IFS5V4TwKJxMb0vQFs8rFH?=
 =?us-ascii?Q?YKx7FdS3YVdduoJeUNuPvTngCyHv4XNyuwH7o6bRGW268MWs4E2PuRzF2LP0?=
 =?us-ascii?Q?mpnERJTm6FRpmj04YXcEX8H120wRROoAZydw7xycXuyHoKbZtdXEAac2pFoP?=
 =?us-ascii?Q?FmY0fwFOZkbull01/xH0ootIDRHllVyJeHKil4qaf7Yg0wHIPiM4PbpPAEbG?=
 =?us-ascii?Q?dNxbUUl7/aOm+t7ULeAJExWYLGhI8QeBDlP4pxVTKZ9XeVOJum4IOGskFtu8?=
 =?us-ascii?Q?D6yB19OJNuc4rcsxT6swQ+RhbZqrxWhdKKP6h748gs78XhzNUyValohAqLGI?=
 =?us-ascii?Q?/FNvAH/sDvCaHnswm75ybY8uGD30nEALI677mFa/a5jKsPfqEmjMdujv5I4+?=
 =?us-ascii?Q?dAtZxLmHq4N3N2VxlVkA5qlvROoMu/nscJ8GHoprvBS54qpHcBz8Ks04CzFE?=
 =?us-ascii?Q?sWnKTlUn4MbRWsABzvU55rtKlGerUumnskEuis6jqBKWFwZp0saZm2r3mBk+?=
 =?us-ascii?Q?tfE1unpq5YaRUXL8PrI9hau5P/Zz9+6IhsoKkZFeBgpnOVm2MCLs3KSxYiLu?=
 =?us-ascii?Q?wThoQs0l7S8FGepRtPi4E7HaFDC+28F3lCRCYrGicMRckBSrlbgFUxyLrB3i?=
 =?us-ascii?Q?t6I1Ao47FdNRRaOGhf9strGarGx2DSc/zQaawahiylrLiyc3Plry3OB2bb5k?=
 =?us-ascii?Q?VoLBQMP5Q5Cv8riyeqJAkedAQ/+tyMP6zFw8mh5CpJRdIE7wXj1V86OjnakN?=
 =?us-ascii?Q?xAKB/IPTqXj9NP58XsU9GM3JxRCUNzaRvW2/jMG1Wn6Gms6uajhvRkiTqTkT?=
 =?us-ascii?Q?pTc2QrOybCcBPSbYUhmDeVJsd9l6C4jMXvcSr76C+u8jgV2kR5gHhW1IWZEA?=
 =?us-ascii?Q?+DiyqRkjVhZWNm1anNv9eVkXpKk1JQSeecXIX1jO8k079a8fWuN8zUXIt9Ke?=
 =?us-ascii?Q?b4AmWIJSYO7LNSjt9lZry72kTtmu4YyFy59d1kQHk+uI/JVzGcPL2+oxnxmo?=
 =?us-ascii?Q?t90bRYeUrLZX7YBEmOUHrUvX8SIdx1EYOwlsj+3aDR97HatqcbQVDc8t/jVM?=
 =?us-ascii?Q?FrXpMA/IiPEcBgfPItyP5oZjMB7e40NoutzR3xYmj5wdWh6c8S1Avw3rXB/v?=
 =?us-ascii?Q?imTBX3nR5GXvH8QRYVddaOdfgzomLxjLYUaRf4jrq5aQrQMNdmNwOJFHJ1RM?=
 =?us-ascii?Q?E16U/yQmXjJ34RAS5DrcAVOAhjTyupwb5DnKXTVMy6e6g2cBKS8h+fclqtek?=
 =?us-ascii?Q?iL8t+zaRRGcw/5ZiGKqwOPYxHA68hy3fQpd8+5x8ETj1zSG+P931yYzahpzP?=
 =?us-ascii?Q?leH+O0osRUo/e5Wnoa5KUuLBT5xj+FeGs1hJTtODljovIg8ibW5knil31x3G?=
 =?us-ascii?Q?MgOFjQdMqDsT2GRTWlvUhBnL59IHUO+OUBuz3yoVHfYsIpt+Vuw0mBvy8g8G?=
 =?us-ascii?Q?CzGFudrLGTe039nbaXiOxjWj4Iod2ONWbnggXGe23XuYRHfHAj0A3stOMizl?=
 =?us-ascii?Q?x00wXaljzyiyKElEeBa8ZaoO+qcIRnHdwUPbn4vtJoKorzFBfzWh/D97v5or?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de060f8f-7497-4fa4-dc08-08dad6e2fb01
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 17:05:58.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C614NqY23NbivpB8OgSnFVq/6GLHKjXgsbqNyCscdsX5ylxAFSCJGqAoZz3r915w1IGsxmBBFB+EmUznCrmGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6067
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 05:25:17PM +0100, Borislav Petkov wrote:
> On Tue, Nov 29, 2022 at 01:08:28PM -0800, Ashok Raj wrote:
> > microcode_check() is only called from microcode/core.c. Move it and make
> > it static to prepare for upcoming fix of false negative when checking CPU
> > features after a microcode update.
> 
> So this function is there in cpu/common.c because it uses CPU facilities
> like cpuinfo_x86 and get_cpu_cap() so the logical place was there.
> So that I don't have to export a bunch of things but rather have the
> microcode loader call into it only.
> 
> Your next patch is using more of those CPU-specific facilities so
> "bleeding" them into the microcode loader looks like the wrong way
> around.
> 
> get_cpu_cap() deals with all those c->x86_capability arrays and other
> functions which do that, should be there too.

I was trying to move this similar to how x86_read_arch_cap_msr()
moved from x86/kernel/cpu/cpu.h -> asm/cpu.h.

Keeping the usage local since there is just one caller to microcode_check()
but there are other users of get_cpu_cap() like in
arch/x86/xen/enlighten_pv.c which seems to be reaching out to
../kernel/cpu/cpu.h. 

That said, what you say also makes sense. I'm fine with what you decide how
this should look.

Cheers
Ashok
