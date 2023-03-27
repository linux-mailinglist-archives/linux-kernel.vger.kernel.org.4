Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2606C9ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjC0FJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjC0FJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:09:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A20411A;
        Sun, 26 Mar 2023 22:09:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA425B80D1A;
        Mon, 27 Mar 2023 05:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6E4C433D2;
        Mon, 27 Mar 2023 05:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679893782;
        bh=cZhr2OnPLXSFPP/VmfBMlCMvfHUaEsQsz1ANFK35DJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erV0f5WLoDYUMZhbbzO0qA7WJ/MY5CBpdr/MFTuZ3njZxnmeL30QEzibRuWstbbTq
         PjTp7GMwhJAtv8KsPLxfH+I00nHoxOWKHCnYlHXtYjYowOVYOj/0YMuUIs7bLM4DHX
         LiIXKr2XLYsOlUfEUad6zpkpJ1SkTMUvZym94wYgfqZnIhm/VApUnoiLMkVv+4I18D
         F4jJ5yZ4MXYrS/JONT3rCaIQbITFm/+ZxTtc9gPoFamIxPDCTnKKzC60XFyRS8zrhS
         QtbMkbd4VWNonJe6I9YsCVn2xXkmBDGAYYEIfO4Z5bOYir908KnrJ+AvOuOc21OQUX
         xQ2ls6fJdgt5g==
Date:   Mon, 27 Mar 2023 13:09:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de,
        xu.yang_2@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jun.li@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH linux-next V3 2/2] arm64: dts: imx8mq: drop
 usb3-resume-missing-cas from usb
Message-ID: <20230327050935.GL3364759@dragon>
References: <20230323035531.3808192-1-peng.fan@oss.nxp.com>
 <20230323035531.3808192-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323035531.3808192-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:55:31AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The property is NXP downstream property that there is no user
> in upstream, drop it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
