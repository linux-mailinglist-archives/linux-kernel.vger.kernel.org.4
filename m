Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F0A6277CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiKNIeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbiKNIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:34:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF971AD9D;
        Mon, 14 Nov 2022 00:34:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA1BD60F15;
        Mon, 14 Nov 2022 08:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3645C43470;
        Mon, 14 Nov 2022 08:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668414840;
        bh=oARtbUp947T2K9BSrViJId3dXLzsDaIvOSl0fcmT9B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Re2MgvdBtQo4N+pQA45TqETtAdNzNx2D2Tixaq8EOw4FGpIvbQtqOip453+r24oBD
         7XbxdQ4YlMwY6Z6Fk9+EyuNzPb8My9Krh4muzW6c55Oca9wEKgldvWOe/O/QiD0ObJ
         rCdf/mpLXebZHdjXkz7+rkErrMUkxfyjlhpQUW/nQLNGRXJPJCZP32e4jcajdnmt4d
         LttqwWrFPzV+t9RtcYplV9fh0XrXMGcJf3CFN/AXsIJ+QpzMBnYkFAQrPiC+QCjUaP
         ZcHqAtvXjUecITIxl/8Feu+gN18lUWqxe7YY1S35MSgAUEEpL2MdDV0iM0Rm/oCsNR
         wAjH1CDQwgJcg==
Date:   Mon, 14 Nov 2022 16:33:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alistair@alistair23.me
Subject: Re: [PATCH v2] ARM: dts: imx: e60k02: Add touchscreen
Message-ID: <20221114083352.GT2649582@dragon>
References: <20221104204251.1458958-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104204251.1458958-1-andreas@kemnade.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 09:42:51PM +0100, Andreas Kemnade wrote:
> Add the touchscreen now, since the driver is available.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks!
