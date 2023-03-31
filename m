Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589A26D219E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjCaNpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjCaNo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:44:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0FAAD1B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75126B82FCA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F5DC433EF;
        Fri, 31 Mar 2023 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680270291;
        bh=d9Fe4OlQvEZdFcbBLYw4zSiNG69Za5tYzhCykGM8QAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tq3bgiWC/0VjSdLfisgRJ4dsJ9FfV/Me6jQmnw/pU24Tf3aufl6188YqMVJupxIh0
         DE1RhpJEycgL566GznxJcLvjxK3iNpNwIM1wvGNeKHdPlNYnla3eaz5P9eWfvJDF0+
         vOHDbTGRCyi1Z9kQ3GyXD4KrH36i9x/gwKxaWruBhDnf2byEfk/suVuYGZrmtgEqcD
         /o4A8ZAtJ2KIlEXjAQd4NU5pv8nLc+hmcT1u7u1nlhuJzgFzoZT/8kdfU1hNzWSsyj
         OzvalPPhmDQ20IToi7plb4Q+3QFXV3zepVrTjDX2VSiRbE0FGhyn7A98PikJbEPP/Z
         5D+7JNeSK4Q3Q==
Date:   Fri, 31 Mar 2023 19:14:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com, rogerq@kernel.org
Subject: Re: [PATCH] phy: cadence: Sierra: Add PCIe + SGMII PHY multilink
 configuration
Message-ID: <ZCbjzXB3GW8siHYz@matsya>
References: <20230220141216.25326-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220141216.25326-1-sjakhade@cadence.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-23, 15:12, Swapnil Jakhade wrote:
> Add register sequences for PCIe + SGMII PHY multilink configuration.
> This has been validated on TI J7 platforms.

This fails to apply for me, can you please rebase

-- 
~Vinod
