Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B897216EE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjFDM1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjFDM1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:27:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B50C4;
        Sun,  4 Jun 2023 05:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65FAD60EF8;
        Sun,  4 Jun 2023 12:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADA9C43444;
        Sun,  4 Jun 2023 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685881642;
        bh=gxQ6nKoPBAQ1Q8i3faPhlPwgOkXsdkQ9hFmYeNlDbFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gal9K4zSCMMc+QtYTb9i3Yd78n1ELFVa+hWxX54/+LbW+YQ6h1nrUn9RtYzXcDJgA
         3ctUTJ6Di0/Y/sgjCrbVa0fz18qfMk6Ur5N4UcxAfzcRPzLGtNiM7TjqDJcguuIgcI
         jHIoRYjLfM+4ivCgRke4jwqQACfrV9nCBlvGhB8qBxBjZ/oNsj3WTCtdOimjd0tjiQ
         ROo21i6wapbfskycdsfu13kUolu4E5Bc96lVUYBxPOvCdiZLiHWxpAMJxrSxjBPw4+
         pLEcRxq5IStOkOQk5su1zhI1AT8XZjIReQIVicUSk/cBmU0pYfzpHGWUTJJ2OfUgbo
         bWCRAmQ3MVBdA==
Date:   Sun, 4 Jun 2023 20:27:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: imx8mp-beacon-kit: Enable WM8962 Audio
 CODEC
Message-ID: <20230604122710.GH4199@dragon>
References: <20230528110119.2632850-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528110119.2632850-1-aford173@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 06:01:19AM -0500, Adam Ford wrote:
> The baseboard has an WM8962 Audio CODEC connected to the SAI3
> peripheral.  The CODEC supports stereo in and out
> and a microphone input connected to the headphone jack.
> Route this CODEC through the simple-audio-card driver.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!
