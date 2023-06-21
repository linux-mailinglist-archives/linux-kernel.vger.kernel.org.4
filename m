Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35555738DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjFURyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjFURyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:54:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431942694;
        Wed, 21 Jun 2023 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=gMoi/Kpkd2t++Ir/CViW4ziy87M/IAsQ7OmN0fHf2Dw=; b=J6+W9nxHLgw1DgYyz/zaXz7NqW
        o84OefmCJAT5zF9/nwmpIGa5bBaUnBu58d5v22SX4F2lWBoIM5fspymsNGpIuCUg2QbIJNbKCx8Ms
        Za1EvbZk7F/02l8SFb+BWLzuJ9phGRv5lM/4H/9B2lUyCTw3+w5w8Rlqzz5X3zP0EBgYQLICRTHuP
        LM7mhfg+qcHfSUY1YpjZD3T1wAN0mq7G50/bVSVdVNx/oooiHr3VE2R4jTIU+b6LZg7HsnchplvEj
        z9+WuA+pzkQNLxRHQMgr8bxb53yT5KPiuFV+D2ZkM45Wr/gI2rNNmdM8pQysfw9tYvG/4GxrprSVG
        ejXEb38w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qC200-00FIdQ-0N;
        Wed, 21 Jun 2023 17:52:08 +0000
Message-ID: <23e944f2-789d-9758-a26e-0cb99861f30d@infradead.org>
Date:   Wed, 21 Jun 2023 10:52:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 6/7] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev
References: <20230621174006.42533-1-tony.luck@intel.com>
 <20230621174006.42533-7-tony.luck@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230621174006.42533-7-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 6/21/23 10:40, Tony Luck wrote:
> With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
> per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
> their name refer to Sub-NUMA nodes instead of L3 cache ids.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/arch/x86/resctrl.rst | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index cb05d90111b4..13fc9fa664fc 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -345,9 +345,13 @@ When control is enabled all CTRL_MON groups will also contain:
>  When monitoring is enabled all MON groups will also contain:
>  
>  "mon_data":
> -	This contains a set of files organized by L3 domain and by
> -	RDT event. E.g. on a system with two L3 domains there will
> -	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
> +	This contains a set of files organized by L3 domain or by NUMA
> +	node (depending on whether Sub-NUMA Cluster (SNC) mode is disabled
> +	or enabled respectively) and by RDT event. E.g. on a system with
> +	SNC mode disabled with two L3 domains there will be subdirectories
> +	"mon_L3_00" and "mon_L3_01" the numerical suffix refers to the

	                "mon_L3_01". The
or just insert a semi-colon. Anything to break up the run-on sentence.

> +	L3 cache id.  With SNC enabled the directory names are the same,
> +	but the numerical suffix refers to the node id.  Each of these
>  	directories have one file per event (e.g. "llc_occupancy",

	            has

>  	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
>  	files provide a read out of the current value of the event for

-- 
~Randy
