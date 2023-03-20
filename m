Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608FC6C11E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjCTM2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCTM2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:28:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3231C656
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C0F5614CB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFEFC433EF;
        Mon, 20 Mar 2023 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679315310;
        bh=yUkGfrDzv/jv1co34aVR1AP5xTMAmn01gRsBLr4S8GQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CL/1HMM/X04RYvUGj7lqPfybLbi9BWzEw8B2gFbNCkFKw9nZ0I3X7sIa9ZfhERq1j
         o890phEUyQ/TknkCIuqfVxgzuHhhx5NZsGw52VVJCy7OnC9EoE/4Lmu4VPVoxR9xUv
         tKqhzzYKS6fh0xHBt4zd9XsmrRv/k9a6Y92tyjY2/WbBYl+d7N03CRcP4HJX7wJxWa
         uaGk+Xygx9qclppNZqqlTNSY7esbxbMte/dtOLqBpMHWdkPvoS13+CJs44T4R6v4FS
         0Rms5pYLzo+B8FuVCUz6GaCK7Qpe223UHEUstCmx02yHnYsCm7F7jqFxcLCRDA+NO0
         jbm/yB2bry3xA==
Date:   Mon, 20 Mar 2023 17:58:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alain Volmat <avolmat@me.com>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: st: miphy28lp: use _poll_timeout functions for waits
Message-ID: <ZBhRal1CmLs6mIA3@matsya>
References: <20230210224309.98452-1-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210224309.98452-1-avolmat@me.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-02-23, 23:43, Alain Volmat wrote:
> This commit introduces _poll_timeout functions usage instead of
> wait loops waiting for a status bit.

Applied, thanks

-- 
~Vinod
