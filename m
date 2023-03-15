Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8F56BBC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjCOSpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjCOSo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41631113E9;
        Wed, 15 Mar 2023 11:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3700C61E20;
        Wed, 15 Mar 2023 18:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D57C433D2;
        Wed, 15 Mar 2023 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678905865;
        bh=j6RzX9mQB2wO9mxpX0JVxVm/UcURJTxitn6NkHW0GYg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ml06FAkS2NBV2dPHdZMWUC5z+ezkLXtbCzY+JXnaUO1fT2Rw/O5Fq4C5cSGV5kcvq
         lEX3yibN9WBTgsX1Gb3hgZgzqBnp9hJnj+vmLcVMcAS14A+Mqn8eJEBgGL3/mFbkeX
         MWgsTlllCLBrM6fEDMj/d8AKlsLmt03xy5eUqSp9nlCj9SkPvKChkfbse66pQqS6Tz
         iaUt/oNF4GNY2EppVwlsiNtwJSyj3MmMPkE7S1kXCMIEjiasTz7r7T58GCW0ONbHri
         pnJvzeQHYG7tvTa65qCVlr327zhAM1ODuYvhaCmClOEelUb26Dyj1G5vQ4smBu5gat
         VkPP13vkcqfYg==
Message-ID: <207fd0b9bbbed6315d6199caf77e708a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230315075343.740013-1-chunyan.zhang@unisoc.com>
References: <20230315075343.740013-1-chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] clk: sprd: set max_register according to mapping range
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 15 Mar 2023 11:44:23 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2023-03-15 00:53:43)
> In sprd clock driver, regmap_config.max_register was set to a fixed value
> which is likely larger than the address range configured in device tree,
> when reading registers through debugfs it would cause access violation.
>=20
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Any Fixes tag?
