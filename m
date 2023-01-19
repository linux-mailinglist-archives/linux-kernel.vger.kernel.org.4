Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB13674BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjATFLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjATFLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:11:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E92C4E9A;
        Thu, 19 Jan 2023 20:59:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2DEFB820FE;
        Thu, 19 Jan 2023 06:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0264AC433D2;
        Thu, 19 Jan 2023 06:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674108859;
        bh=gjLSPUZt6xaons6m+9xOYICSVfpvADrPllIevlXag+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qz1H4e0Py4Tql1URFdxEPgDq7ngGrjMVeEiAohrmrS9pI9dOYn4+JrudXDqgQIHfj
         Pv64m/GBCpNThxNzDbugtuX4GB3Xumhh/VNw/qYSOPn62Ka/UdpsVwl1x3qmISqclS
         Bl+4SnecHK0mGtc6QmYNQna7X6jUXZOWhmFwxAYkk9LDkqFGBJDkZebX5YlhSkeGmT
         MYAeHmYF2/MorMkNqhJfH3RsEGpLcTCZ3HGO66tjLC6ej6EK56B+VinzQW+zPz/zax
         Ieblx4iiVeZznjPga/BF1vjX96D2dybUrSE2OOaluZS+0ZS27lej/gV8H0sNHgXuky
         wefTKdQGjUbPA==
Date:   Thu, 19 Jan 2023 11:44:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the phy-next tree
Message-ID: <Y8jft7UDgvMqPwv7@matsya>
References: <20230119153623.339d6739@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119153623.339d6739@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-23, 15:36, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the tegra tree as a different commit
> (but the same patch):
> 
>   fb1ff01307ee ("dt-bindings: phy: tegra-xusb: Convert to json-schema")
> 
> this is commit
> 
>   56052eee689a ("dt-bindings: phy: tegra-xusb: Convert to json-schema")
> 
> in the tegra tree.

Ideally, this should go thru phy tree or some other tree with
phy-maintainers ack!

-- 
~Vinod
