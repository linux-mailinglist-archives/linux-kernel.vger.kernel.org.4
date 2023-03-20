Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ADD6C11BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjCTMVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCTMVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:21:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47269AF1C;
        Mon, 20 Mar 2023 05:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F27A5B80E55;
        Mon, 20 Mar 2023 12:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD20C433D2;
        Mon, 20 Mar 2023 12:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679314893;
        bh=BM50t43smgKoQ+Sf/G6qQpUQUjic7BRN6eiJg+AcMxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeU0KW03fFg3jRTUWxGykUPb8UVwi9GUGr+mf2lVysZcu9U9zUWRCadeBWzmxEqP2
         k1tU1fRbsoJ1GbWSl+qa1VN6s09vkQn6CU+qr22EVf1nyYVi2No+4rVoaTqj45sVDe
         CcqdKXi/JhASFgSNx5aRCqb2fGuo2tcpC3t750gon+fiNElubbJ5ybpTeqKTyFUDBZ
         roIj+RyGP54zb/3Xnb+Kg2JOeNgBW/fckFyIXnJ2TYNmyrbWG6FtZ+5lII543UyHEG
         EkSIt6eobNtosYpO0EWEW8JPB04DEvkAt6ebo+ayv78LpA9T6RlXdzdCQTnS02PjuG
         kd0yw8gfQsM4Q==
Date:   Mon, 20 Mar 2023 17:51:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        JC Kuo <jckuo@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>, linux-phy@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Henry Lin <henryl@nvidia.com>
Subject: Re: [PATCH] phy: tegra: xusb: Support sleepwalk for Tegra234
Message-ID: <ZBhPyLzY3leLKbFL@matsya>
References: <20230309061708.4156383-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309061708.4156383-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-03-23, 14:17, Haotien Hsu wrote:
> From: Henry Lin <henryl@nvidia.com>
> 
> Add new registers programming in sleepwalk sequence for Tegra234:
> MASTER_ENABLE_A/B/C/D in XUSB_AO_UTMIP_SLEEPWALK.

Applied, thanks

-- 
~Vinod
