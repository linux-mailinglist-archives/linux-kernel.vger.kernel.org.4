Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635EB609B65
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJXHeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJXHej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:34:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D02AD2;
        Mon, 24 Oct 2022 00:34:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05A66B80ED6;
        Mon, 24 Oct 2022 07:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A430C433C1;
        Mon, 24 Oct 2022 07:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666596863;
        bh=Y8TIbCMRqiKv8SlehzXsY9VJzS/HgGic6rx17BIRuws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F3CVSVi9gPhAUV2rx3A9CszvsaX6/7VpTNYbVLYHI53mQdbKVKTdFYQP2iCzDaMbJ
         LAIHtORDUSYHkz1CYp5DfXMoiGnsjG6nT3pMVM2LzThmhaNxqPO5clkkz6OrTg0E8f
         D9EqlAMoqp1HXrdz5cUCbdEo8EHY9hChIo38obz/N+eOYbJ626HrwHvEgyb0AzekRn
         O7YaCrghzoepx54OvXequu5IV/h7P/CKKOcrhBxIYFIgDNjJ1Hzggl02Xlxaa7Yjav
         wOrUHwMADFC2LoqiXwswf3IoFFC81WzqhRcCFArQiAZOY5bD01X6wtIL+r66/Bwppj
         Z7+QqmGQe/xKA==
Date:   Mon, 24 Oct 2022 08:34:18 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 5/5] mfd: twl6040: drop twl6040_platform_data and
 associated definitions
Message-ID: <Y1Y/+tFZ33a3B6FC@google.com>
References: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
 <20220926054421.1546436-5-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926054421.1546436-5-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022, Dmitry Torokhov wrote:

> As of df04b6242a58 ("mfd: twl6040: Remove support for legacy (pdata)
> mode") the driver no longer references the platform data, so we can drop
> its definition, as well as definitions of related structures.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  include/linux/mfd/twl6040.h | 29 -----------------------------
>  1 file changed, 29 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
