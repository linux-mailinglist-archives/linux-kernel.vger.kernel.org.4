Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C359C729F0D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbjFIPsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241858AbjFIPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0313AB1;
        Fri,  9 Jun 2023 08:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A62C06595D;
        Fri,  9 Jun 2023 15:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C31C433D2;
        Fri,  9 Jun 2023 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686325673;
        bh=q/+ziWKfSoKTfaJCIdi7IJNNRYQucnY20/ei4bv4HeM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gDizgEl950qzCEA1Bl4he4l+1lRCI7YdJ7gtg9qPg3vfmjA5aX+sRTrIaGxMVASaX
         m/ctj62cBOHfFGL0zzIwy3SwCSAXtRCGLBfPQR7UddMogW2pMX9YY5fRiP7OeqqgYA
         k73W+CjQgnNYF99578DvZbh+IL8a7uIZevjmbZ6vPGBlgAN6C7wtfwrt3EYlJ4smma
         euCdB2KC1m1oX2ck+aQatLAychriAUgC6pUDp9PkHTwiK8xrN1W33NyYjpbojR46CO
         EM8rxb6YY359kBT+qqzOgJuhA0D2aa7H1GJtSCxo5uCAx14qpnvl9KV0TejKA6aa+Z
         ylWiX/Nl1uwwg==
Date:   Fri, 9 Jun 2023 17:47:49 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH RESEND v4 0/1] HID: nvidia-shield
In-Reply-To: <20230608143450.12283-1-rrameshbabu@nvidia.com>
Message-ID: <nycvar.YFH.7.76.2306091747250.5716@cbobk.fhfr.pm>
References: <20230608143450.12283-1-rrameshbabu@nvidia.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023, Rahul Rameshbabu wrote:

> Hi.
> 
> This is an initial driver implementation for supporting NVIDIA SHIELD
> peripherals. Currently supports the following functionality for the
> THUNDERSTRIKE (SHIELD 2017) controller.
> 
>   - Haptics (ff_memless)
>   - Serial number query (sysfs)
>   - Hardware information query (sysfs)
>   - Firmware version query (sysfs)
> 
> Changes:
>   v3 -> v4:
>      * Follow correct formatting rules for help section in drivers/hid/Kconfig.
>      * Refactor configuration names to indicate Kconfig options are for NVIDIA
>        devices.
>   v2 -> v3:
>      * Renamed drivers/hid/hid-shield.c -> drivers/hid/hid-nvidia-shield.c.
>      * Added space between braces for terminating element in shield_devices
>        array.
>   v1 -> v2:
>      * Declared thunderstrike_hostcmd_req_work_handler as static.
>         Reported-by: kernel test robot <lkp@intel.com>
>         Link: https://lore.kernel.org/oe-kbuild-all/202304011342.6Bh3cWhA-lkp@intel.com/
>         Link: https://lore.kernel.org/oe-kbuild-all/202304020922.vsngJnBT-lkp@intel.com/
> 
> Rahul Rameshbabu (1):
>   HID: nvidia-shield: Initial driver implementation with Thunderstrike
>     support

Now queued in hid.git#for-6.5/nvidia, sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

