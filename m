Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A0672A53
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjARVWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjARVWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:22:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E2F599A6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674076953; x=1705612953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IkfhhRgXWo9o6PQTJMNxw2/7a+a7qUItFKHkPuY+cfc=;
  b=NAYaT0wHBYSrMOwMAe5CLjpig02jq97G7CsuFGYFbvVQIc1OWIzGnpXI
   wFoVSxiE0UXBUWHArwEIselLmbF7Qb3t5a76zdeB/XOljnH4nfLD0+/Vn
   3xhk8xXUYgwg08IcA8C5Kl3ud4AxPUxJ1XMmO5HGHFeKrg7sfkGD8LyrE
   GHA85+QWmCO/6Fm8m4CNOtbjwT5DtLOQ9BNGYCsjF5NhPVmEEaXEYjxF+
   Fe1CT+0SNacV43UY8GQIgxDAZH4wFvxTzVkNeQguH1V1uFaJZpPfbKWoE
   VnbTj3JB6a01Vjr4ixnFTeyAB0Y1pKkVeRqpCbenvotzrVg5n7PU7ZxVC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="389601804"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="389601804"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 13:22:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="692171910"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="692171910"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 18 Jan 2023 13:22:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 13:22:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 13:22:31 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 13:22:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC6NMh0sujy7mO0Q6uyJeDDXxdvYvBzqwzCD9LC7dHsKuVIv+m6ofwhkgnm9I5dUEG7fQU1VjPdpfVAjxKWINeXzYBD+Vy6cXtsFVB4U++LylhvtSGo4Zpj95xB4yzHygWk5Ea7Q8tqrOI/gnWnECJELRIOvfVgPfHMzDcsAk6xutDo6d1Ym1vVQyPmI96aoB74qg9+od8g3QbHbDCGvoSYp/LpPNTBMmwrpUafpJ5/jH/b8vKh6vZw7vFRg/zpnV6l53ubcYbkHfn+uLNn4NRZiEFUwnVv0S4d8KicxRhjL627gZslBftuPK571HosqNjVzfNt3cUwVYMNZt0ahtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKXkgGgZOcb1/Z+5wTW+qdgG51YafJ9+Hkw/y5EhVws=;
 b=U8cXgQonCgmV7ojcUQTwTMuJqZ/g73GnoTNpY28Av2E7+UqutTx9wbozc3b4c6sHHwdJnFDmq2yGygd5ArxJW6XQlrKZposmOkmPUqjObSpawGX7ipm91KcxM8NpFlo+jxNsK6NKPbzFbU9smyhG0IwLeuoJZNXH5Z/hNcqCyjAzNUoEqiIl7wkXMea+lKT3HD7XyVXJAXLjhM1hv45RmjZ+va7FVTCnFU/omMXErPR//SIiBtJ4gZlUipkv2uLLGEqohIn0xzAmtG1AqW5AGFiZlt3W+cQovM+MdQtFMUhg65BQTnNkADJUxJ7xqOxPfCWEAEvyXDJGAKC3qtl2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA0PR11MB7694.namprd11.prod.outlook.com (2603:10b6:208:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 21:22:29 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%6]) with mapi id 15.20.5986.018; Wed, 18 Jan 2023
 21:22:29 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jamie@nuviainc.com" <jamie@nuviainc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnwang@linux.alibaba.com" <shawnwang@linux.alibaba.com>
Subject: RE: [PATCH v5] x86/resctrl: Clear staged_config[] before and after it
 is used
Thread-Topic: [PATCH v5] x86/resctrl: Clear staged_config[] before and after
 it is used
Thread-Index: AQHZKrjH0OersXR6dkuAiWDKD59BxK6ksDIQ
Date:   Wed, 18 Jan 2023 21:22:28 +0000
Message-ID: <IA1PR11MB6097018866A49457E8D6F70A9BC79@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <2fad13f49fbe89687fc40e9a5a61f23a28d1507a.1673988935.git.reinette.chatre@intel.com>
In-Reply-To: <2fad13f49fbe89687fc40e9a5a61f23a28d1507a.1673988935.git.reinette.chatre@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|IA0PR11MB7694:EE_
x-ms-office365-filtering-correlation-id: 6f48f03a-5505-4970-b3af-08daf99a1a98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wY71ALESHdTpNOT9CGKm3b2enIGMFEYqcmQC8pAALKnPEFGFjVJ/kF4mNChdb1WIVv0msp+wSEDkO9KOqrSbbTTRm9w6ULxvTY6JeeGGXio0TqyDPc4QhUOBZ/IaCL80J37aTYd88DD1LrqorAZh2ScpMNau6nX7WqW8lFo1WbKqq44lgh5XE1tz5/S5PiAcn72T5cpkl1zHaXZgeUk2DE/NgEkEDj+kFMmk1PJxecC0dxaq597tHbjySaqwKKMR1yU9xEcXpY5t+Q1angxgvkf5YDjjERBPrhmzWm6ggYeKA9g33/p/WR/24PYIw5lIyUv7531bKnLAAiwuldXVxh1LagW2rfP64Uk1NyAdS5Ryptap9QDEL/LooucUsGa4GJXYFKUKNIc6knqtrW84D+FuZqYTYA+soAp18FAEaVoFHN2cHVyyfVgl1ZtzL1gXrbi6XCog0r8LjJII3jH2F8BmdYjDkCWQ3H1vuOCZgzdjftzXEp9VZq8h0eOh49i3cC1c9rxQ9Kpy29Etk01mrDZG6HtMztJTuJf3FLrIfgELPLrh/yMP2bryq8+ttz70PAI4QoWmwsU/dTIxRgcZE8Zv8+7CsaJEPtVNjIGEnMBTYedjkSOPxmsS9gpMcSx8eOYT9OjEqhaxN8Kmpzp8nesf0QDRCuWMHU0Rk0euVog/+KvKbL/UnkLc5IuaU9n1sXbErgJlwEGmtqo2zJkYP7Cfp72Rps3Q6/jvvGsdYc4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(83380400001)(71200400001)(9686003)(966005)(54906003)(110136005)(7696005)(478600001)(55016003)(186003)(33656002)(26005)(38070700005)(38100700002)(82960400001)(122000001)(66946007)(5660300002)(6506007)(52536014)(41300700001)(2906002)(66446008)(8676002)(66476007)(8936002)(86362001)(4326008)(64756008)(76116006)(66556008)(7416002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Tc997DHrx/73IqAJcFE+ZYLDB50JNExf9GiVmS/FcifEQ91EIKeZbf7dToe?=
 =?us-ascii?Q?HbMrkAJlIQXCp5qjN+egN3R+R1I9C49Ju+wWd/z9OFlO7k73zI0whh8BaOSa?=
 =?us-ascii?Q?n5tCDAxVyc0ktsnBzAeQ5xc9HotywGkPKpzl0hiqs8SEePF1+zu++yeJ0PzG?=
 =?us-ascii?Q?TMLG2gvfwcWrNob2jzk6r8X+bAfyfE+9YlpXA9WsfQaJGzHriEkBhJGGM8h4?=
 =?us-ascii?Q?lVPz/iwrvtfBkHs+KaOJ5SrPW7drUx5xp9JuSR/JQ2hb3PsorqpieEPyvNPv?=
 =?us-ascii?Q?QyGQ/75K+1KSYdjCmEeYupr/8DDoWwEqAvCB//XDnHDDUMsOEnEtrmXDKhnC?=
 =?us-ascii?Q?Qugo0wDDdIar1rE0G5PxJTmLVBipOsmn8YHEMG89roT7OVzjf/qrTZcwwa07?=
 =?us-ascii?Q?vk6SB0JGWAIChqcjhEYwKDI722oJkkqLflp/yTAkb7wpmb0xlYpRmZYYZq4g?=
 =?us-ascii?Q?1PKVwVQJ6Qs53g6PooPWh73ltkkTGzwx21vZ1M2nNb7AyrOuxlZ3QtNKOcBj?=
 =?us-ascii?Q?gKTLf8ms9KMkpjJ0PB6ofHahlWkkam+olY2+f/frYWKiKWCY0jpEDSZf1jHQ?=
 =?us-ascii?Q?/U9/+TFTyOnDpCvReKPS40/M519YyU9Sj5Mo8AnVBF5bLnJWH9ZLmgGB1sAs?=
 =?us-ascii?Q?bMO+EPlu7Ta9HXcrwMKj914q56yIfPw2KjmW8dAeWxlfT8rNi/JpPtBiKxcD?=
 =?us-ascii?Q?+pCQ245rzhh50qegxdAO4knjdshqV3lZiO1H5MPhyMgnIqCljMSP1g/7SP6K?=
 =?us-ascii?Q?0BZQSIWZkPbttBxEsAOyDyyvmk60WFtDO8WaU1884XnlhD7mJYR98LGZMfst?=
 =?us-ascii?Q?G2zkxIjEynNF70mMblLrKOpqpUnVhmejd41OaIVgeoiC0t9eBdo5Ws/iTElJ?=
 =?us-ascii?Q?hWDBUXcVb2aBSsORuJ8JUpiGDhj0KislbbnAhixXjkTvo+TAahDP8T/6xQt4?=
 =?us-ascii?Q?iYh7Dvsx0SuZe23NVUNXiTebl6ZHXPh6sBkSJhTHj9o4jCoo2AKzTiMhMfnS?=
 =?us-ascii?Q?eaVPnkjtsZkIQz85VpBgKQEK91bUQ6iheSPpi8Qoa+V+7fTdv9bAORqP0z5Y?=
 =?us-ascii?Q?TlWZRsRapj8vSWC3Qs11WBj8yVfnhoIT3EEUmAbMu3F7/ieWKmutHb+ofSvy?=
 =?us-ascii?Q?3mxFF2B9DqjTTBGMiC8RIDDQOq0l1RPpSUAK9AZ/glXzvdLPE7Um4ZI2cfdc?=
 =?us-ascii?Q?yIZq8QDkbQ9nLXMVP88z7cO4a2jW7xRTo9qNkS7WW/5xU46unka/VSwjxpFY?=
 =?us-ascii?Q?bEtVhbGC3QtcmD91w7y/TU0AMpL+OX+e3dgO55wGAACGhiriXqrGr2oTMXl3?=
 =?us-ascii?Q?5WpKOCO1eJNqK6LYx/TfnL3F2uZqIzy+q74a7/u54bljuPwn1ZkNidiHJXr7?=
 =?us-ascii?Q?/CTatydyAi2Y/zddLulZOB4xV+UJnI24B13XtSHGfKuf9ad/8g94AScKfl8x?=
 =?us-ascii?Q?1a9j6KzJOsZssojpoYYJWdK8ERs9DJKYAODYzvBkv0m2FN7AWqw/Y276wUcL?=
 =?us-ascii?Q?no1CoHDRRxgzPL1LuawllzXBBW4jMvxGRqIkGju0TsZmY+TsMZYDkosP5eKb?=
 =?us-ascii?Q?zgmX8bAXhFNdLCXDEB69XV4x7KFkHapEtBBQFCNT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f48f03a-5505-4970-b3af-08daf99a1a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 21:22:29.2216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVXSOv7K4BUpHIdcRp+OLwIRIDdSkLaCftMTS70EcNpBqsnvCBDoa8nqGrzeK7gOLnw7TjFtR3GxO9QlbL3GVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Chatre, Reinette <reinette.chatre@intel.com> writes
> Sent: Tuesday, January 17, 2023 1:15 PM
> To: Yu, Fenghua <fenghua.yu@intel.com>; bp@alien8.de;
> dave.hansen@linux.intel.com; tglx@linutronix.de; mingo@redhat.com;
> x86@kernel.org
> Cc: hpa@zytor.com; james.morse@arm.com; jamie@nuviainc.com; linux-
> kernel@vger.kernel.org; shawnwang@linux.alibaba.com; Chatre, Reinette
> <reinette.chatre@intel.com>
> Subject: [PATCH v5] x86/resctrl: Clear staged_config[] before and after i=
t is used
>=20
> From: Shawn Wang <shawnwang@linux.alibaba.com>
>=20
> As a temporary storage, staged_config[] in rdt_domain should be cleared b=
efore
> and after it is used. The stale value in staged_config[] could cause an M=
SR
> access error.
>=20
> Here is a reproducer on a system with 16 usable CLOSIDs for a 15-way L3 C=
ache
> (MBA should be disabled if the number of CLOSIDs for MB is less than
> 16.) :
> 	mount -t resctrl resctrl -o cdp /sys/fs/resctrl
> 	mkdir /sys/fs/resctrl/p{1..7}
> 	umount /sys/fs/resctrl/
> 	mount -t resctrl resctrl /sys/fs/resctrl
> 	mkdir /sys/fs/resctrl/p{1..8}
>=20
> An error occurs when creating resource group named p8:
>     unchecked MSR access error: WRMSR to 0xca0 (tried to write
> 0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
>     Call Trace:
>      <IRQ>
>      __flush_smp_call_function_queue+0x11d/0x170
>      __sysvec_call_function+0x24/0xd0
>      sysvec_call_function+0x89/0xc0
>      </IRQ>
>      <TASK>
>      asm_sysvec_call_function+0x16/0x20
>=20
> When creating a new resource control group, hardware will be configured b=
y
> the following process:
>     rdtgroup_mkdir()
>       rdtgroup_mkdir_ctrl_mon()
>         rdtgroup_init_alloc()
>           resctrl_arch_update_domains()
>=20
> resctrl_arch_update_domains() iterates and updates all resctrl_conf_type =
whose
> have_new_ctrl is true. Since staged_config[] holds the same values as whe=
n CDP
> was enabled, it will continue to update the CDP_CODE and CDP_DATA
> configurations. When group p8 is created, get_config_index() called in
> resctrl_arch_update_domains() will return 16 and 17 as the CLOSIDs for
> CDP_CODE and CDP_DATA, which will be translated to an invalid register -
> 0xca0 in this scenario.
>=20
> Fix it by clearing staged_config[] before and after it is used.
>=20
> [reinette: re-order commit tags]
>=20
> Fixes: 75408e43509e ("x86/resctrl: Allow different CODE/DATA configuratio=
ns
> to be staged")
> Suggested-by: Xin Hao <xhao@linux.alibaba.com>
> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: <stable@vger.kernel.org>
> ---
> Changes since v4:
> - Essentially a resubmit of v4, changes limited to commit tags.
> - v4: https://lore.kernel.org/lkml/20221209024436.22170-1-
> shawnwang@linux.alibaba.com/
> - No changes to patch.
> - Only change in changelog is re-ordering of commit tags.
> - Add Reinette's Tested-by, but change the Reviewed-by to Signed-off-by
>   because of the change in hands of this submission.
>=20
> Changes since v3:
> - Update the commit message suggested by Reiniette Chatre.
> - Rename resctrl_staged_configs_clear() to rdt_staged_configs_clear().
> - Move rdt_staged_configs_clear() to arch/x86/kernel/cpu/resctrl/internal=
.h.
>=20
> Changes since v2:
> - Update the commit message suggested by Reiniette Chatre.
> - Make the clearing work more robust.
>=20
> Changes since v1:
> - Move the clearing from schemata_list_destroy() to
> resctrl_arch_update_domains().
> - Update the commit message suggested by Reiniette Chatre.
> - Add stable tag suggested by James Morse.
>=20
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  7 ++-----
>  arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 25 +++++++++++++++++++----
>  3 files changed, 24 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 1df0e3262bca..bcdc679dad4e 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -373,7 +373,6 @@ ssize_t rdtgroup_schemata_write(struct
> kernfs_open_file *of,  {
>  	struct resctrl_schema *s;
>  	struct rdtgroup *rdtgrp;
> -	struct rdt_domain *dom;
>  	struct rdt_resource *r;
>  	char *tok, *resname;
>  	int ret =3D 0;
> @@ -402,10 +401,7 @@ ssize_t rdtgroup_schemata_write(struct
> kernfs_open_file *of,
>  		goto out;
>  	}
>=20
> -	list_for_each_entry(s, &resctrl_schema_all, list) {
> -		list_for_each_entry(dom, &s->res->domains, list)
> -			memset(dom->staged_config, 0, sizeof(dom-
> >staged_config));
> -	}
> +	rdt_staged_configs_clear();
>=20
>  	while ((tok =3D strsep(&buf, "\n")) !=3D NULL) {
>  		resname =3D strim(strsep(&tok, ":"));
> @@ -450,6 +446,7 @@ ssize_t rdtgroup_schemata_write(struct
> kernfs_open_file *of,
>  	}
>=20
>  out:
> +	rdt_staged_configs_clear();
>  	rdtgroup_kn_unlock(of->kn);
>  	cpus_read_unlock();
>  	return ret ?: nbytes;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5ebd28e6aa0c..f43eb7340ca5 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -527,5 +527,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct
> rdt_domain *d);  void __check_limbo(struct rdt_domain *d, bool force_free=
);
> void rdt_domain_reconfigure_cdp(struct rdt_resource *r);  void __init
> thread_throttle_mode_init(void);
> +void rdt_staged_configs_clear(void);
>=20
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */ diff --git
> a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5993da21d822..41e89fc49d77 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -78,6 +78,19 @@ void rdt_last_cmd_printf(const char *fmt, ...)
>  	va_end(ap);
>  }
>=20
> +void rdt_staged_configs_clear(void)
> +{
> +	struct rdt_resource *r;
> +	struct rdt_domain *dom;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	for_each_alloc_capable_rdt_resource(r) {
> +		list_for_each_entry(dom, &r->domains, list)
> +			memset(dom->staged_config, 0, sizeof(dom-
> >staged_config));
> +	}
> +}
> +
>  /*
>   * Trivial allocator for CLOSIDs. Since h/w only supports a small number=
,
>   * we can keep a bitmap of free CLOSIDs in a single integer.
> @@ -2851,7 +2864,9 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdt=
grp)
> {
>  	struct resctrl_schema *s;
>  	struct rdt_resource *r;
> -	int ret;
> +	int ret =3D 0;
> +
> +	rdt_staged_configs_clear();
>=20
>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>  		r =3D s->res;
> @@ -2862,20 +2877,22 @@ static int rdtgroup_init_alloc(struct rdtgroup
> *rdtgrp)
>  		} else {
>  			ret =3D rdtgroup_init_cat(s, rdtgrp->closid);
>  			if (ret < 0)
> -				return ret;
> +				goto out;
>  		}
>=20
>  		ret =3D resctrl_arch_update_domains(r, rdtgrp->closid);
>  		if (ret < 0) {
>  			rdt_last_cmd_puts("Failed to initialize allocations\n");
> -			return ret;
> +			goto out;
>  		}
>=20
>  	}
>=20
>  	rdtgrp->mode =3D RDT_MODE_SHAREABLE;
>=20
> -	return 0;
> +out:
> +	rdt_staged_configs_clear();
> +	return ret;
>  }
>=20
>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
> --
> 2.34.1

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
