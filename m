Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638106097AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJXBEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJXBEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:04:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A02F15A3D;
        Sun, 23 Oct 2022 18:04:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C280AB80D90;
        Mon, 24 Oct 2022 01:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303AEC433C1;
        Mon, 24 Oct 2022 01:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666573482;
        bh=3CGj+S4+ePd4Ip08KUwT1S7tAQ12uV6pSsu/37KtyjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlJwt/yq02VreudYtg4hYtDoLV2vS9ypiG4PDDtQbLORpuRHLsXBkOaKhbzdUOP8S
         hTBTd1wMD9SFWJuKSsjZ4yRv1ZYnngO1qto5iGf2KFcgbyslHiljA6yf8j3cSk1wqd
         YrBV/Cg85mLCt27ue7izPXIG47SaiOEGQs7LXzQ6oOonrXevjE7WsvJiYcPdb3uW02
         HixdI6im8EHEUMefspSioAFC9kxLytSH5X0uWyHZ0yWBxOJrAc0WVMqtqxvUROBwoz
         ZrxkWPCVSnw5wLZNpGeaBBaqxLxNG8y54QLX41QTFC1uar0Gb7RhFKjyDBwfPlKyvD
         jMIPfTGRDaEZg==
Date:   Mon, 24 Oct 2022 09:04:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, sboyd@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 0/2] add anatop bindings and correct dts node
Message-ID: <20221024010433.GR125525@dragon>
References: <20220923074943.981127-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923074943.981127-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 03:49:41PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V4:
>  Add R-b from DT maintainer
>  Include dts change
> 
> V3:
> https://lore.kernel.org/linux-arm-kernel/20220919055904.1659124-1-peng.fa
> n@oss.nxp.com/t/
>  Add #clock-cells property
> 
> V2:
>  Drop syscon, use clock-controller
>  Add fsl vendor prefix
>  Add interrupt property
> 
> Peng Fan (2):
>   dt-bindings: clock: add i.MX8M Anatop
>   arm64: dts: imx8m: align anatop with bindings

Applied both, thanks!
