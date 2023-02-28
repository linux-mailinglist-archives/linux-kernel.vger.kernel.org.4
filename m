Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3985E6A5E02
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjB1ROp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjB1ROm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:14:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A19451449E;
        Tue, 28 Feb 2023 09:14:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B186C14;
        Tue, 28 Feb 2023 09:15:24 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E16D13F881;
        Tue, 28 Feb 2023 09:14:39 -0800 (PST)
Message-ID: <06aec285-1e66-8e06-4016-8981e6626fa2@arm.com>
Date:   Tue, 28 Feb 2023 17:14:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 6/7] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Content-Language: en-GB
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-7-tony.luck@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <20230126184157.27626-7-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 26/01/2023 18:41, Tony Luck wrote:
> With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
> per-NODE instead of per-L3 cache. Suffices of directories with "L3" in

(Typo: Suffixes)

> their name refer to Sun-NUMA nodes instead of L3 cache ids.

(Typo: Sub-NUMA)


> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 71a531061e4e..9043a2d2f2d3 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -167,6 +167,11 @@ with the following files:
>  		bytes) at which a previously used LLC_occupancy
>  		counter can be considered for re-use.
>  
> +"snc_ways":
> +                A value of "1" marks that SNC mode is disabled.

It would be good to expand the acronym the first time its used in the documentation.
This gives folk a few more characters to google!


> +                Values of "2" or "4" indicate how many NUMA
> +                nodes share an L3 cache.
> +
>  Finally, in the top level of the "info" directory there is a file
>  named "last_cmd_status". This is reset with every "command" issued
>  via the file system (making new directories or writing to any of the



Thanks,

James
