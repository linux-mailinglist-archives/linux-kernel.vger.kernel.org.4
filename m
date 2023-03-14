Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07BE6B8BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCNHGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCNHGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:06:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8323696F1C;
        Tue, 14 Mar 2023 00:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 737A0CE12F1;
        Tue, 14 Mar 2023 07:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E166AC433EF;
        Tue, 14 Mar 2023 07:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678777595;
        bh=5WUYMWsB/q/x4Fh46p6wM5DfRauDvR5orH0FEC0x1UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqgtqjmW44d/ImcJ3WQObPkonsKMYE0LdDbDIl8Sw5IWUBmu0gvXPsgsqYpnMrmlW
         SbOgErvdtPDbRCDdFEfc7PbV1FwsJmzYSyF9ab1K98aevhA1ahZDSA8xiS19fozXDe
         zoKt5OC1o8kFwSydmLEs3eKDIWrWmkkLi+fadDfxwxA8bY75wqtUUcvhSJ/xXkeC48
         xLPHt5gWiBUmZNG+YbxUuUVNOnKQB6B+UjNsR8XAxKjLt/nyUGAhu9seUmwu0u8GgR
         eVRrCU6R8UPsBSIHC51comUCZa1zMX8vsObZFIGplLpu2RPl2dwRSaVE40cZcCLTo8
         8q7gVHMPbHQ5A==
Date:   Tue, 14 Mar 2023 15:06:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: Use of_property_read_bool() for boolean
 properties
Message-ID: <20230314070629.GZ143566@dragon>
References: <20230310144655.1540724-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144655.1540724-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:46:55AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
