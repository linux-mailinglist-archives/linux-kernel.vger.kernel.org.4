Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F616C6F71
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCWRiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCWRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:37:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD22738B63
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679593008; x=1711129008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+oRZBGlRDE2mN2HqkB0otRZAMosS9UyIjnPhkCjAn4k=;
  b=M/nKxx1bD6EOLfH/WqiAW7+01tb+RJSOglwJi+ynOWE0yrbuIb8AgsCM
   Yls1TIHrCWZBtyCI5j4kQH5TS1FhTJIq8w78P1euXzdUw+vL3BRuivwsk
   mZGArlBZa/JYeEqsbQmWb8WMVKfi/sCoYWvKBTRU91U2BrVFGm5cHJ4CQ
   ooaC4jemCG1E9zcu6pq4vFOnx8N+JqQ2zht2jwAsCNnpYyfDdxZpSH48r
   RldH84U7SOVf+mlx2GJQsn6I5rZYSOMRzAf8HRnAlPcnjfuMIDUJKSwQe
   UwZo8YEotU7jRsPV3Jq5hPUT/XvQn+m23efAeKPhD9SqLQflAE/1vfqb0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="319228538"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="319228538"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 10:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="806351892"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="806351892"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.252.131.62])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 10:36:47 -0700
Date:   Thu, 23 Mar 2023 10:36:46 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Staging: greybus: Convert macro definitions to
Message-ID: <ZByOLjobQ2TrdFXQ@aschofie-mobl2>
References: <cover.1679558269.git.sumitraartsy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679558269.git.sumitraartsy@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 02:01:04AM -0700, Sumitra Sharma wrote:
> Convert macros to a static inline function, to make the relevant 
> types apparent in the definition and to benefit from the type 
> checking performed by the compiler at call sites.
> 
> Sumitra Sharma (3):
>   Staging: greybus: Convert macro gpio_chip_to_gb_gpio_controller to an
>     inline function
>   Staging: greybus: Convert macro struct gb_audio_manager_module to an
>     inline function
>   Staging: greybus: Convert macro struct pwm_chip_to_gb_pwm_chip to an
>     inline function

Hi Sumitra,

Please review:

https://kernelnewbies.org/Outreachyfirstpatch#:~:text=Following%20the%20Driver%20commit%20style

That is the section on 'Following the driver commit style'.

Cover letter Subject seems to be needlessly truncated.

Alison

> 
>  drivers/staging/greybus/audio_manager_module.c | 7 +++++--
>  drivers/staging/greybus/gpio.c                 | 7 +++++--
>  drivers/staging/greybus/pwm.c                  | 6 ++++--
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> -- 
> 2.25.1
> 
> 
