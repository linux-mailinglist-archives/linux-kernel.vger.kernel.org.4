Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22075F1769
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiJAAfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiJAAe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:34:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E35140ED;
        Fri, 30 Sep 2022 17:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3134160EF4;
        Sat,  1 Oct 2022 00:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFD4C433D6;
        Sat,  1 Oct 2022 00:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664584490;
        bh=N/IdnHz2Hyc3nD6UlHPYfrl/UpX2qbEo2kjTMQ2GIjs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Em2Z93ymKqMkio2+67mSaiAEAG3/3BekAn0iTF6sSV/MVn/+WfOYvHha3j+8PsccB
         VBFJDf3uFvc6721erFFSlgPPoTTwryHEl+DM+ix9RrSZo/vEC5yBxx2C4rO+clg3eK
         KPJ/4CjcEZciA9e1NcEv00ppYu1W6dslZxVUYCiw9iZFOXehHzWlMXhwc9GwAF40Fz
         lDvrW2STjjz2T8BNAKXrKfFgKc3phoVb5+aFs2FxYfJFI/qSieK+X5bsx6Bv6D+8TX
         VgJDE/YGFgNmoVupk0okBFgZQaN+FGsqWpmEBW+VTAYr9GA+WtFGR/XkCXz2z9YzOR
         zyvD/rXoRGKog==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220912183613.22213-3-alexander.helms.jy@renesas.com>
References: <20220912183613.22213-1-alexander.helms.jy@renesas.com> <20220912183613.22213-3-alexander.helms.jy@renesas.com>
Subject: Re: [PATCH 2/2] clk: Renesas versaclock7 ccf device driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com,
        alexander.helms.jy@renesas.com, michal.simek@xilinx.com,
        saeed.nowshadi@amd.com
To:     Alex Helms <alexander.helms.jy@renesas.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Sep 2022 17:34:48 -0700
User-Agent: alot/0.10
Message-Id: <20221001003450.7EFD4C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Helms (2022-09-12 11:36:13)
> Renesas Versaclock7 is a family of configurable clock generator ICs
> with fractional and integer dividers. This driver has basic support
> for the RC21008A device, a clock synthesizer with a crystal input and
> 8 outputs. The supports changing the FOD and IOD rates, and each
> output can be gated.
>=20
> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
> ---

Applied to clk-next
