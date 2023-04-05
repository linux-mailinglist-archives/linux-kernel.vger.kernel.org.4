Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552E46D7F43
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbjDEOXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbjDEOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:23:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E335FD7;
        Wed,  5 Apr 2023 07:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E0AD627AD;
        Wed,  5 Apr 2023 14:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8F3C433A1;
        Wed,  5 Apr 2023 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680704558;
        bh=gNMuGtNk55Etp9uwZDsaoJtgOXXUOQtkbkq6y21/0Aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pu4d+aV8TJKn0a7t9iUnP73HKd8M3sXgzPm1W+BBf8sQ1QnAvTkBwEmmtST5mRwwT
         S87etsyJZoLV4mnTnz8aJf736x8gfglTGL/4UDiT4ZuPlA78jox8GYaWEG3fi8DF0K
         Aqp69Dy+F2QkZoSakyrDxpMxzpf99NOBx5RQewrKAQ9BST9WzH/G4BRvBSFfi9pCSf
         sIlm4kMr7SG+TrVaA9B+tCE/RDHdfPKsoHStBM3CPFfopG6AliB0Pz0K1UeUUEsZdb
         98nw5orKbPF3v1G52R9YUXIAYZgMbjGijAfRE3PpTLkQJb2e6Be9nAGYcW7IPbg4PY
         klgmqmSQAdS3w==
Date:   Wed, 5 Apr 2023 22:22:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mq-librem5: add missing #clock-cells
Message-ID: <20230405142230.GF11367@dragon>
References: <20230328061123.1984643-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061123.1984643-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:11:23PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> '#clock-cells' is a dependency of 'clock-output-names', following
> binding doc, add it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
