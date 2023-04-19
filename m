Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074C16E79E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjDSMoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjDSMon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:44:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052CA3C1E;
        Wed, 19 Apr 2023 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681908283; x=1713444283;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6B/yWg6hmnuhemiHCCm7Th3yqadpTRIk5dtsS7F24aI=;
  b=fXevyc0VpN2ON/5XNdeBZKtLRhHUM1ffGJvQAb9grbcHCvjhaTsHlmC3
   Um2WUhMQWLHlupvxB2c3FTTTpGHgZHeGX+Tz2ObVRk3Io6N1nYyydaNsD
   hrZI/OgVjRch+5Lg7KN7VsNWimU6Ok1WcuqgLWPBhxKBmaoL+HRsYglp6
   iuCCy/DRbK/NINU4f2MNYjfIoPj2a8JkqbNbTmziNNGRlHp1Uxo2xT7Y0
   KSk5XZG8B59MUDsyrX8I+tDz4mrw52Oxs7cRg0XOjvh6jfBPuaObJWpJ6
   HsVP6ctP2YTFvoE4riAsvFnkE3IzEC+s4UJa5oG4lv2APHBKwMeAytpOY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334244588"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="334244588"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 05:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="641739533"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="641739533"
Received: from hbourgeo-mobl2.ger.corp.intel.com ([10.249.34.207])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 05:44:33 -0700
Date:   Wed, 19 Apr 2023 15:44:30 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Babu Moger <babu.moger@amd.com>
cc:     corbet@lwn.net, Reinette Chatre <reinette.chatre@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, pawan.kumar.gupta@linux.intel.com,
        jarkko@kernel.org, adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v4 3/7] x86/resctrl: Rename rftype flags for
 consistency
In-Reply-To: <168177446947.1758847.11380042804869155387.stgit@bmoger-ubuntu>
Message-ID: <6cf118d1-efbb-6c6e-225d-c93a1875eb0@linux.intel.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu> <168177446947.1758847.11380042804869155387.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Babu Moger wrote:

> The rftype flags have two different prefixes even though they are used
> for the same purpose. Change the prefix to RFTYPE_ for all the flags.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |    8 +++---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   42 ++++++++++++++++----------------
>  2 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 62767774810d..c4fc5a1c630c 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -248,10 +248,10 @@ struct rdtgroup {
>  #define RFTYPE_TOP			BIT(6)
>  #define RFTYPE_RES_CACHE		BIT(8)
>  #define RFTYPE_RES_MB			BIT(9)
> -#define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
> -#define RF_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
> -#define RF_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
> -#define RF_CTRL_BASE			(RFTYPE_BASE | RFTYPE_CTRL)
> +#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
> +#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
> +#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
> +#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
>  
>  /* List of all resource groups */
>  extern struct list_head rdt_all_groups;

This needs to be changed as well:

 * @fflags:  File specific RF_* or RFTYPE_* flags


-- 
 i.

