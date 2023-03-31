Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABB6D2159
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjCaNRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCaNRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2F81A955
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9545D6291D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B5DC433D2;
        Fri, 31 Mar 2023 13:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680268661;
        bh=p6tek0JeK10uVkXKZcHwz6OJ/prwLyGRaIuHmwOqWh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LhLKKPZHuOhtAvhvxO2/2+gCdVW8U3nWFcT/CtJPCP20/PJ++hoR/+GaFmtC8Y4tx
         BSpiZNc2TrEZQSDBxNz5RnFNihWfrEd+pyrow0f3h9DFb++YgivXdrTFALXODrMkD1
         /Ge0mXutZtmkEP2xPqQjGY6+5csfVxqDW21CTW7TlkTPYUFfSGFLZeNxCBxckWaTAy
         p8eKIfkslL01mPOFwhUShLS/LFatTVAlZBhl8zIy7dLWNkBK8M5477G3EqQguQsoVz
         8epg7G6mMUXVNBK0TubMEfj4KrAGCW/RskV1xQ+l6KoeT4m3x3/ZArd/zGbT4bcjbd
         gJIVey8aBrW7A==
Date:   Fri, 31 Mar 2023 18:47:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 1/3] soundwire: bus: Remove now outdated comments on
 no_pm IO
Message-ID: <ZCbdcTDZt5P4EZiG@matsya>
References: <20230322164948.566962-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322164948.566962-1-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-23, 16:49, Charles Keepax wrote:
> Things have moved more towards end drivers using the no_pm versions of
> the IO functions. See commits:
> 
> commit 167790abb90f ("soundwire: export sdw_write/read_no_pm functions")
> commit 62dc9f3f2fd0 ("soundwire: bus: export sdw_nwrite_no_pm and
>                       sdw_nread_no_pm functions")
> 
> As such this comment is now misleading, so remove it.

Applied all, thanks

-- 
~Vinod
