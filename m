Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E445BAD0C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiIPMKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiIPMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:10:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC17B07D5;
        Fri, 16 Sep 2022 05:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0F59B82683;
        Fri, 16 Sep 2022 12:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB88C433C1;
        Fri, 16 Sep 2022 12:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663330236;
        bh=TwoU72GtKpmM71deYg/h2fcgUISeDPSHAxluSTZs5YM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IjB/ja/XIbKE6qdt1WR2ruPZtkTPU3r01PGNtCl+QeYmhzhYa3obsGxdeQqvPC863
         H57p2goPme5EFzo5MAFDct1NPAcP72R5XVpsOoFGW+ELp8rboFvuaUcGXfT5GwUigU
         9hCjauo7emnnIt4ngaP7Eli5qHFJsQVAwtdDt2hcb+S5FShoJ/djHFEMWsY1e7PONg
         JlKwufo+M76y95NWMmdyA1HnVkxMCKglyyVd8u/3+3svgQSykkLy0KmAdDQONnWaEV
         s8YAewlJoi/R8Dnes5v/MGTlOH4tElUaCmavvFt1Jyh97sBvNJA9FxwpFWTDP5HYx+
         wMy+ya6gRs/PQ==
Date:   Fri, 16 Sep 2022 20:10:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] ls208xa dts updates
Message-ID: <20220916121031.GO1728671@dragon>
References: <20220914211538.29473-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914211538.29473-1-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 04:15:33PM -0500, Li Yang wrote:
> Some accumulated dts updates for NXP ls208xa SoC family.
> 
> v2 Updates:
> - Cleaned up patch descriptions
> - Updated node names to use - instead of _
> 
> v3 Updates:
> - Move fpga mdiomux changes from seperate board dtses into common
>   ls208xa-qds dtsi
> - Update interrupt properties to use MACRO
> - More style fixes
> 
> v4 Updates:
> - Fix node ordering issue
> - Add SoB
> 
> Biwen Li (1):
>   arm64: dts: ls208xa-rdb: fix errata E-00013
> 
> Ioana Radulescu (1):
>   arm64: dts: ls2080a-rdb: add phy nodes
> 
> Li Yang (1):
>   arm64: dts: ls208xa-qds: add mdio mux nodes from on-board FPGA
> 
> Pankaj Bansal (1):
>   arm64: dts: ls208x: remove NXP Erratum A008585 from LS2088A.
> 
> Priyanka Jain (1):
>   arm64: dts: ls2081a-rdb: Add DTS for NXP LS2081ARDB

Applied all, thanks!
