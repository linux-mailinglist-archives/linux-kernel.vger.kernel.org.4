Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA4066A148
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAMR6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjAMR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:57:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D3149D5;
        Fri, 13 Jan 2023 09:50:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8FBFB821A4;
        Fri, 13 Jan 2023 17:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACF4C433D2;
        Fri, 13 Jan 2023 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673632244;
        bh=FnagUZgEXRRDYaf933HETSbfnBBpYz3V+x3ryh1PkNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9ur/ScPWVnRwda0Bb6t8CD5FeIi4gYX3qtDc1UlRUkWZ9oQNRbaC/Dw8Yh31/ewA
         8wK/lNjjJWsJhMDuRlPjqXuWQlBeRqj3dss6TkXDG57JS6N95VaYkkmEtE2Mut85ZN
         TKi0xHC9u1J1q0JSAdNwZyDMt8kXbqHsqifLeyYbSJEUoiTdjewA5ceE2AIIIRe24y
         GGa3Cci6mZGJaLz6B3qQ1zSglxBS/P8xeDRkLm17p61wL98IpT7oIpFHkzlcy+jg6W
         zuevhmPnY2jsS80nwuYhOCtUYj4iiOqR2ZFiCt8d0OLuhL/Ppc0h8aAD1AjHMgbH8E
         v1N+D2DrHTiWA==
Date:   Fri, 13 Jan 2023 23:20:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        JC Kuo <jckuo@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>, linux-phy@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: tegra: xusb: Support USB role default mode
Message-ID: <Y8GZ8HNASmlJgRNd@matsya>
References: <20221216042146.99307-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216042146.99307-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-12-22, 12:21, Haotien Hsu wrote:
> Support role-switch-default-mode property when usb-role-switch is
> enabled.

Applied, thanks

-- 
~Vinod
