Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ABE6DFBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDLQxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjDLQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:53:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E269029
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A214A63729
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D09BC433D2;
        Wed, 12 Apr 2023 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317988;
        bh=Iv2JNXA7Eub8y5aMi88VqjFDcaIvmjosrLTTL4kT+Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dLbH9SaIo5CzWGKLzQCBLMO5ZaMpqWkUf1VZHGJvLhE0TWxNWIYOLW+Fn+ov224y6
         NCA7J4YULQ1FG8x6r+dv5nN/bdSeBAz0yEydiNJbBbJQy+zbfjobvgtNiQF3HP8wDH
         0GCYT9TXhAzyDbnim4rF+/GXN3/T6Mvk0g2la8LSc71DzA6E/l411iDruiKRGO6pdf
         Oc9D0nkG5y8XteCa4R3AZC3lEyaQckVPm6jOi7qW7nepv6k6/0ybmVKsvLdMUsXSES
         AUzgMfyKjVh5+0JIs3H+CifC6l25eQGvwFRNfkLhqAvZFoVpXLaVPEr+AFjBwuwK3e
         WtXqqKnOPMmHQ==
Date:   Wed, 12 Apr 2023 22:16:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vaishnav Achath <vaishnav.a@ti.com>
Cc:     linux-phy@lists.infradead.org, kishon@kernel.org,
        linux-kernel@vger.kernel.org, j-luthra@ti.com, devarsht@ti.com,
        tomi.valkeinen@ideasonboard.com, praneeth@ti.com, u-kumar1@ti.com,
        vigneshr@ti.com, nm@ti.com, sinthu.raja@ti.com
Subject: Re: [PATCH] phy: cadence: cdns-dphy-rx: Add common module reset
 support
Message-ID: <ZDbgYN1/NUsHBWW9@matsya>
References: <20230314073137.2153-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314073137.2153-1-vaishnav.a@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-23, 13:01, Vaishnav Achath wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> DPHY RX module has a common module reset (RSTB_CMN) which is expected
> to be released during configuration. In J721E SR1.0 the RSTB_CMN is
> internally tied to CSI_RX_RST and is hardware controlled, for all
> other newer platforms the common module reset is software controlled.
> Add support to control common module reset during configuration and
> also skip common module reset based on soc_device_match() for J721E SR1.0.

Applied, thanks

-- 
~Vinod
