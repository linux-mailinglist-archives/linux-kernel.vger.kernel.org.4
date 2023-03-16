Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9748A6BC5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCPGDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPGDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:03:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A378D32F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:03:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55FE261F1A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D33CC433D2;
        Thu, 16 Mar 2023 06:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678946621;
        bh=ww0ZocYsI+02bKy+ETdHwsgDsAG5ndYxat5xHnfTfiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4VG7dnf/DqeAEPohsBa/rE5su759zx0QSzs+nvK/FkE6yTEKDy6VdaHXfJVb8ATZ
         xsn/DNhc70ePNYS/OAHJKbwIJnHR1Co1kUHYHu/2TgNAjVT8AEGaFj2WgrdMBRsYWc
         1ue1ia4lNt1ptuNMA+86kZw7jrB34vNFFmTy3lgc+kzu54cuMpDytmf3xG2Asf+hho
         WCuGj/pwFoAB6kdugkw2UiWGoe5qho7yJK9eBfgjmtWrMPzUt4Q4sGQes/pp0ubxpD
         7ujHyh9zjfX+ShBA+ZVl7xwj22vCzYDwjavZyPL4imnPREJT5O8cxMoSgwkdZ8GM9t
         ZLDhWjltcGZ/A==
Date:   Thu, 16 Mar 2023 11:33:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: stream: restore cumulative bus bandwidth when
 compute_params callback failed
Message-ID: <ZBKxObsivQKtGOhP@matsya>
References: <20230316013041.1008003-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316013041.1008003-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-23, 09:30, Bard Liao wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> The _sdw_prepare_stream function just returns the error code when
> compute_params callback failed.
> The cumulative bus bandwidth will keep the value and won't be decreased
> by sdw_deprepare_stream function.
> We should restore the value of cumulative bus bandwidth when
> compute_params callback failed.

Applied, thanks

-- 
~Vinod
