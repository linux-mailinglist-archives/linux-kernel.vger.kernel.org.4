Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562AA673027
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjASEVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjASEAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:00:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DAD4B4BC;
        Wed, 18 Jan 2023 19:58:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DA41B8200A;
        Thu, 19 Jan 2023 03:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0C2C433EF;
        Thu, 19 Jan 2023 03:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674099271;
        bh=FhiFkhMu5+0rSkHtb0UtsbyJd42oQJs2wLCe0ZTi9CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVtsz/niBxSZ324EmVjETCkSIPJDrF8njVFxqts7Dtx9om+t13bjEdGmTq2tK5YQ3
         xwUdei+4EsiwC4gZ2qnbTubVA0GASixjJr7XzvajYTGWr/LS4KPvdR6OuflAxLzyK1
         ypFow8ESvkCDpO2cPjTTYbrXSOImgJtRA2ONzrz3Q7vBCPqY0ehOUXsyx3TmTixGHX
         QjfD3deecXTUhxPldRdeLO0CsTHBbjT2VV+z5Vm6dF+yMBNww94XWKSR4Uk1I4cGfQ
         D3q6X0Jb6XnhfyU/eby1Y49S8e3L9jo8aAocEDNoVtEsChQEThhehIxFJLiHNPjfO8
         9EQpz6CbgDTXg==
Date:   Wed, 18 Jan 2023 21:34:28 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/4] Minor cleanup in msm8916 dts files
Message-ID: <20230119033428.ga6sbu42jaueac5o@builder.lan>
References: <20230116145053.1412501-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116145053.1412501-1-nikita@trvn.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 07:50:49PM +0500, Nikita Travkin wrote:
> This series performs some minor cleanup on msm8916/apq8016 files to
> bring them in line with the current standard and be closer to the new
> submissions.
> 
> The series is separated into commits by each specific change made across
> all files and these commits should not cause any functional difference.
> 
> Changes in v2:
> - Rebase on top of newly applied upstream patches
> 

The first patch looks pretty reasonable, but without documenting the
guidelines and tools to help others maintain the ordering this
unfortunately just moves things around arbitrarily.

Forgive me, but I will ignore this series until this is finalized and
documented.

Thanks,
Bjorn

> Nikita Travkin (4):
>   arm64: dts: qcom: msm/apq8x16-*: Move status property last
>   arm64: dts: qcom: msm/apq8x16-*: Reorder the pinctrl properties.
>   arm64: dts: qcom: msm/apq8x16-*: Drop empty lines in pinctrl states
>   arm64: dts: qcom: msm/apq8x16-*: Reorder some regulator properties
> 
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 78 +++++++--------
>  .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 15 ++-
>  .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 46 ++++-----
>  .../arm64/boot/dts/qcom/msm8916-asus-z00l.dts | 34 +++----
>  .../arm64/boot/dts/qcom/msm8916-huawei-g7.dts | 52 ++++------
>  .../boot/dts/qcom/msm8916-longcheer-l8150.dts | 42 ++++----
>  .../boot/dts/qcom/msm8916-longcheer-l8910.dts | 30 +++---
>  arch/arm64/boot/dts/qcom/msm8916-pins.dtsi    | 96 +++++--------------
>  .../qcom/msm8916-samsung-a2015-common.dtsi    | 64 +++++--------
>  .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts | 11 +--
>  .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts |  5 +-
>  .../qcom/msm8916-samsung-e2015-common.dtsi    |  5 +-
>  .../dts/qcom/msm8916-samsung-grandmax.dts     |  3 +-
>  .../boot/dts/qcom/msm8916-samsung-j5.dts      | 21 ++--
>  .../dts/qcom/msm8916-samsung-serranove.dts    | 62 +++++-------
>  .../dts/qcom/msm8916-wingtech-wt88047.dts     | 35 +++----
>  arch/arm64/boot/dts/qcom/msm8916.dtsi         | 32 +++----
>  17 files changed, 245 insertions(+), 386 deletions(-)
> 
> -- 
> 2.38.1
> 
