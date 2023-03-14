Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6656B8BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCNHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCNHGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E6B74A6E;
        Tue, 14 Mar 2023 00:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1290615B2;
        Tue, 14 Mar 2023 07:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77543C4339B;
        Tue, 14 Mar 2023 07:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678777577;
        bh=emCHefuCpsMAspEjxuNYMejvLa7mR0DR4RDUwSN8500=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7AUHVNHHx1m95JXbX/DR/0w1+4cQuvIxgFwfWeKMUPSq1GILg3nXp94Z9+JZQE2e
         mdQ8OJNpIwNRlEVU4sUWsqBcgf+XPucxpgI1D0zUz/zhAJrVC23yp/W1pWbDEia7E7
         w5aA8mr3xRzEgOeTppZXI/D3b6d0V4olkGtBYExVvitUTO/K7NPJlRRN5CkH4JDVhR
         cBb+k13hTZoWiCSGOvGBJ3cBvNv5B7zIYzpaqpY5vmX/uorYt97CQnNDn1/oON0uNq
         wnEd5xi9vkp2qOoEjzQGO7geEFtYjmEf4nVA8QMbnEHcDaoHJFCriY59LGne+uud03
         lijisAY6dZ19A==
Date:   Tue, 14 Mar 2023 15:06:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mxs: Use of_property_present() for testing DT
 property presence
Message-ID: <20230314070611.GY143566@dragon>
References: <20230310144654.1540561-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144654.1540561-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:46:54AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
