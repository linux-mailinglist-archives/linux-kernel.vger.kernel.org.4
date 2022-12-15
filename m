Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E670664DF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiLOROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiLOROs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:14:48 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB601F6;
        Thu, 15 Dec 2022 09:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671124485; x=1702660485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tO6kRLAjcoUv3iWWPcb5MIfrZgVTmRHMe5kou0i44po=;
  b=EoByRzEhbGZl3rEwUb5/J13JIltnjO9r7VBIkWa1yI2szBsvUgGvbCEW
   4yvGRRbvLxuSlcQXEXVCeA33tue2o2djH0qyDu+qrOczwFFu6vgP0pYbK
   MmZPiq+PQ8Aq7Vc0574ruVgnqaINNyZ2/15aDJB0UHM1aW0k47Y3wAmjD
   K4UD1SpUdPV1OQQsAWZMDrLWi0oqYOIBibf/LzsLca3OOjfSxVQ6TMoh4
   Oh4iBW7gpwqqgwfMjZNQ7xYqD0p0nOFBoI2csC96gtMiKJYKLE42LGkvd
   Gw2J7R07uYEZzuQSM2Vq/kiwbpiArPUNpPGm+CpPQr2KFJw8fqBDo42wR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="318787800"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="318787800"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:12:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="627265748"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="627265748"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2022 09:12:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:12:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:12:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 09:12:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzevGQ64YtmNxs99NAhiGB01xy9Q9BPc7sKvIAgo/JRsF8Sc1aytz5EmJXIvn1+f2l+/Y+fK0Nb1dtzdsfwQ0lfxb3gv7IsA7el2WmmloHs4PWD/UofjB35cQI1XvLYHksyEqMyuc4PR3JZ2taAvS67B7GfAF7fQP3GkFygOvpbRZAnlFIhZCI3vqrAA/WzhIHt4wegYIQDpDsZowpPmPweWoVDB1Q6w3yob4uLL+SvuiM2v99FgXnJymd6ROCvQqkvjvFYpfNGJM7/YclBNMCJL3fe1w68pDK1r4H6Mdh4Rp9ZotMwep/hmarYkrcGnqT6hwaTRwfxGrluRiHD2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdiRbATOffiTmeMTOjzznsL8ExcsCLKro5NucIEwuwU=;
 b=NJV/RlJ42i03PpD6zqa88grtCpO6rbZYhthfJqHbhs65Y1AXibGtrNic+dORU04GtW9OJr50fOMO2zYS2b0v55qdQmuEQWR9l55WdCgUtlk7d4caFTn+y2L3WOCCR/da+8vPVRdvM0a3BkdiSHeIUk3r2bRWsO97EWGKwnYhL9PsFZYP+V0EWkxMEfZ8XmYfnXPHWZRtXcckfrqxCBgnSNT6WQffLHmuLiSyRVxX4lXljMA25xEXFvVcg30sX/ZrGNGcPVbMIfD7WwyrbcoUYXB9oTBzOUuDzeHeWDe7YlEk2lNsBBow5dy/Zd721FHWWCbbAogPARYj6cauJ+Al8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH0PR11MB5329.namprd11.prod.outlook.com (2603:10b6:610:bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 17:12:07 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 17:12:06 +0000
Message-ID: <171f3c50-17e7-de78-17fc-47f91f83d395@intel.com>
Date:   Thu, 15 Dec 2022 09:12:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 04/13] x86/resctrl: Include new features in command
 line options
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
 <166990898682.17806.2447018872734886554.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990898682.17806.2447018872734886554.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH0PR11MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f911b7-775b-4b9b-c80d-08dadebf7dc8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buglZfLoXEeRDp/TrTuo9CKe2rozqA8QJC2DWaIWZwXjRf98hwv+ov33xDoA54aFriR21viWgDJldiosnRTy4Lcycwf4ztH0kHw5D7SK3kxf1Lpoy8ELdTID8d0by3fkZilbACloh51FvqqUCn5PKAyMIUpS5WYxlvwKIdO6lLgGo5ubgEgdKv3yIQhUP+i9ElSeMQH4FAWsj1NUKt7ydaTpujANo6VUcnuYEBks4lOJfx7PTZphr3blQ3MSi5FJDZGNSBczpedKLsER1mTj9VXoigP8c1aEKP00qrsPcK8V4RGPuyw8zhAZRHap22PxJEuNfw6tsLkNWThbFtbvTmR7vpDHgz/mekv/kCTzkAy2MnXTHbACvxWalcMO3bnLAO3b26ihweH3vcMiW2qhRZMvjFV0WcV9WJQRi2/32CGfV97vFdyHYr+H9MSVGZozJlEAXko7cpHcVD+4C1jSuprOnF18HScJqPY9KBvF0Crwx1zmiUDXsUszrurCZ6tjYMnvHqguYbcZqsuhc1zFiMeRYtKy7f4IHbFBoO/xjYyW8BcPHV/KrzA9ce9WFiW3q4m5n5I/ROKBstbTUrjvUPn2mb3vRTaCU4QP3RSiH8maPEgJvaebqUbTWZ0HZUqboEGyEig7OON1Cwk/60l9C2SzT8bSaA4sXcLsRWpfIiL6cxuZJMmIVjkvKyK1Whdh5Sc82FBDyqTYDYJaPxL0z0iwBdt5mpFMB9EPyhzM4bs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(2616005)(82960400001)(31696002)(83380400001)(38100700002)(86362001)(5660300002)(2906002)(44832011)(8936002)(7406005)(7416002)(4326008)(41300700001)(26005)(6512007)(6486002)(6666004)(53546011)(478600001)(66476007)(66946007)(8676002)(66556008)(6506007)(186003)(316002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2FhMU01KytFd0xSN1FUcXNtVDI2SEs1cDBSTjV4WmtMYXMxQ2ZKajBnR3dz?=
 =?utf-8?B?N2hDWUJDUzBaQ05paDhjckdXd2VSbDFCcWUyV3FwWXFaVW9UdkZoUVhCMm1W?=
 =?utf-8?B?ZHFkMUx2ZTRyT2tJeHRKdXRtcUQxRmlsWjJRR25YQ2hUc1VJb2dlYzJVV2Zv?=
 =?utf-8?B?TmhNUjNrVkFlV3N3MDBnSlhiUEpMdW5Vd3FZbnl0QXRWMW1CZFRoSUNjWWti?=
 =?utf-8?B?OEpTREV1T3JaMkVXZFJ1NUd6RXNOVWtSWTBsRDA2dUtJdk5aS25Jck5DOE9S?=
 =?utf-8?B?UG5oYnlYUmpLbWlvejNBS2VwL2hQY0Zad0dUbW43TWVGV0xhOGRpeG5iejBS?=
 =?utf-8?B?YThmdVpBaVVERTVoNDNOQmxoQnNRakdXc3NZeDBGYi9GK3dYcDV6cG1YQ3ZK?=
 =?utf-8?B?dXFhYUFEb3FibkQvY3ZRamJIczgrdzdPbE1iNjNCbmQ3ZDBNa3ZsSHdXS1Zk?=
 =?utf-8?B?THFBaDhOSFhNYWJVR2gvRjQ3UlRvTGlBNGJteXNUMTJGSkp6QWhEYzdTdDV0?=
 =?utf-8?B?djNSWmlMT1N0bk1nbHJVbVNWVElraWkxRFlXVTE4YVFVVHgraDFORGFoV2I4?=
 =?utf-8?B?UmlSVkg0VWRMMWo2R2JrWW5vQkJRczBYNGFpY0NqWDJMN3VKc0tpRkJZY3BJ?=
 =?utf-8?B?ajhMOWozVEt5Ynd1ZmkxdFFrTzh4VC9tYXdqazNFT2F2dEI4dkIvT2lCdmgz?=
 =?utf-8?B?Z3djV2dheGJKaUhTWGZRRVZoRCtka0dZV05DV2twbkhkSGtHV0JTZStxRzJz?=
 =?utf-8?B?a2ZsOEgzLy9QRkRYVUpEOTh1b2N3SUF5Z1NkUWVlWFIreWFBQWsramZCYW42?=
 =?utf-8?B?TFVkYzFieHVkbDBuKzVueldDc0JMU1QvQmRVWjJCbmx4RXFxTE1ER2hTbk4w?=
 =?utf-8?B?MWlIMG1OQkJFMzQ4b2oyMWtWNCtpK28veW9TRWVRSjV2amgzNE9wWFQzcHp5?=
 =?utf-8?B?L0wybEg2OUtFeG1MaU1Bc2dIMWNuR1RXNUU5VzJDRXV3SXZHUkc2bFp0OTAz?=
 =?utf-8?B?T2pFVWIzczlvS3RadVZSZzllSFM3eHg3N3lmRFlOUUNqbHZVNTduTzNRMCth?=
 =?utf-8?B?TVlGeVR2NzhNQXpFWTA2bmxTUmhHSzVNaUx2eUFHUHVGTkNXbkg4TFVsNWw5?=
 =?utf-8?B?eDlxZElHeUxORHpHZytjRjNZRTF3L1A5QjFLY1IxSUVmc3JvN3dKQjhHV3JM?=
 =?utf-8?B?djNFa2tLbDVnNXhDRUVrcjRTcEk5WmhxemhZcTM4dCtNOGxsWUVjKyszVSto?=
 =?utf-8?B?MU9xdmNBdWw2NFpyc0dFZWhjd2NIdUZMSWF1NUwycGF4clUrZFliN1kyZk1w?=
 =?utf-8?B?WHQ0c0FlSGJUem9KMjdLOUVrdWtiMS9PU3JsenNIbHZ3aWlaRnM3TnZkdlVH?=
 =?utf-8?B?ZWFHUmVQLys0NHAwN1ViQ1pZd0dHenJoMytScDhudUJ4bHcwb0Y1eE1sTWp5?=
 =?utf-8?B?Z2o1MlZWTUVtMVJhL1ZqdHRmMmoxTUFwZzRlQVBSSEhtekw5eUpUckI2RWJp?=
 =?utf-8?B?SzM3RC9mUFh3aDFQTU80T25MTGl2NkViaERuUDlWblQzYUQvUFliZkZXU3FI?=
 =?utf-8?B?RmF6MjlBbHJqTzZnYlE5SXo2anBqdzViV1VqNFpUN1NNYU5TYkhqRlR2Znlt?=
 =?utf-8?B?RC8rZHg1c1A1eXlZLy9wSnMwbjMwcFpiNk1ZRDFYbFhteHhmK1hRS1VCZUNT?=
 =?utf-8?B?cllDanVjeFkveW01Y1BZbXhsZlFCVi9qaGx6aVRKZjRReXorb09qUVNUem1K?=
 =?utf-8?B?Mk5HLzF1UDVUczFhejBRMUJxdFhQcTFuQU9YYWZnU0ptOVpkV2h2TGhaSElD?=
 =?utf-8?B?Nmt3YVJZdGZIQld1U0w4OVYzSU9jN2dTei93RWhsYWtFanczUHVZSHdHZGZ1?=
 =?utf-8?B?endsbW5vZDFyZ2Jud3VIenFJS1RXZjIxK1NxZW01TTJEakRVU2wrblFrbE5a?=
 =?utf-8?B?QzlxZTB5V0FtbDUxeTNGbnl6ZFhVMFFYdmFwUDR1Sjk4amtqTnhsanRnNWov?=
 =?utf-8?B?SVg5NDBUeXJLQWwvMkw3R2ZiVVFpZkZvSEZsYTNwcHI4VlYrZTkxL3ZYYndF?=
 =?utf-8?B?RmFvaXFpUEV4M3d6VWRIL3RYWmhBNE1LWFM2MlF5bG5BcWIvK25pS3c5cUJV?=
 =?utf-8?B?Wnlhc1prWEJicHVOb29SczYxRHdJdjRuYllGcUl3NlcyOVlPK05TVXQ2aEd3?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f911b7-775b-4b9b-c80d-08dadebf7dc8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:12:05.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IAo6oRUfqK2QyMzhtA+JmH7Ze1oPfYnheGUgfy6lihGR8K+5EPc2X8DM5lcvL7CH07r2wSG1avl8w1Q9ZlXAGQv8Xc13EXND7heIelz7yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5329
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/1/2022 7:36 AM, Babu Moger wrote:
> Add the command line options to enable or disable the new resctrl features.
> smba : Slow Memory Bandwidth Allocation
> bmec : Bandwidth Monitor Event Configuration.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    2 +-
>  arch/x86/kernel/cpu/resctrl/core.c              |    4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 42af9ca0127e..a7b6634f4426 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5190,7 +5190,7 @@
>  	rdt=		[HW,X86,RDT]
>  			Turn on/off individual RDT features. List is:
>  			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
> -			mba.
> +			mba, smba, bmec.
>  			E.g. to turn on cmt and turn off mba use:
>  				rdt=cmt,!mba
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index f6af3ac1ef20..10a8c9d96f32 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -659,6 +659,8 @@ enum {
>  	RDT_FLAG_L2_CAT,
>  	RDT_FLAG_L2_CDP,
>  	RDT_FLAG_MBA,
> +	RDT_FLAG_SMBA,
> +	RDT_FLAG_BMEC,
>  };
>  
>  #define RDT_OPT(idx, n, f)	\
> @@ -682,6 +684,8 @@ static struct rdt_options rdt_options[]  __initdata = {
>  	RDT_OPT(RDT_FLAG_L2_CAT,    "l2cat",	X86_FEATURE_CAT_L2),
>  	RDT_OPT(RDT_FLAG_L2_CDP,    "l2cdp",	X86_FEATURE_CDP_L2),
>  	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
> +	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
> +	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
>  };
>  #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
>  
> 
> 

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
