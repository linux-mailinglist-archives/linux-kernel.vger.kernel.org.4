Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3486FAE5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjEHLoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbjEHLn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D1E106EF
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:43:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1019661782
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 11:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E734CC433A0;
        Mon,  8 May 2023 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683546200;
        bh=01f3Go1YWZ5fuIRF6yYHIXEN7EeVi5WcswKnPII6Gxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4rq1gttmEtCjLmqaIPKu7Le4ItutJzvCW83HeWYf+2MX5cR+PdcH+7//L1c2Fqrv
         Wt4xkajZwFbwFhl0Pn9gsYztzmZ2WkceRLzXxjh08QrOTkLydZb1tEOGHSzHNJuAHA
         qkTdfOuT2YqC0silvowU9qw6/ImUJ1X7K37ixF3J9Q2YG8unWtXsqwAxkVAsavV1Ri
         RWIE9aF/0L5IjgHW6jn6Oof3dt+vTacZX3gUVdSh2c/i8acwXL9rAEAT9k9UKXMM6i
         WMF2+pyiT//9uwH6do6TU1M6LCixIxUoRVWsSax7OHlj+/cpoLaYtGmeT0OLmYbKB7
         c5qIcyOIjDA0g==
Date:   Mon, 8 May 2023 17:13:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Daniel Machon <daniel.machon@microchip.com>
Cc:     kishon@kernel.org, Steen.Hegelund@microchip.com,
        UNGLinuxDriver@microchip.com, joe@perches.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Power down serdes lanes and CMUs initially
Message-ID: <ZFjgVNsyIcLemolS@matsya>
References: <20230417180335.2787494-1-daniel.machon@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417180335.2787494-1-daniel.machon@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-04-23, 20:03, Daniel Machon wrote:
> This patch series aims to lower the power consumption of the Sparx5
> switch chip, by configuring optimal quiet mode for serdes lanes, as well
> as powering down unused CMUs (Clock Multiplier Unit). Before this series,
> serdes lane quiet mode were not optimally configured, and all the CMUs were
> powered on by default. This uses needless power.
> 
> Each serdes lane is provided a CMU clock, depending on the serdes mode
> and the serdes index. CMUs will now be powered on individually, when
> needed. The amount of power saved varies, depending on the port
> configuration. As a reference, this change saves about 1W on
> sparx5_pcb135 and 2W on sparx5_pcb134.

Applied, thanks

-- 
~Vinod
