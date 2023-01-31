Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AEB682B03
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjAaLAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjAaK76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:59:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537DA485AB;
        Tue, 31 Jan 2023 02:59:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1393BB81908;
        Tue, 31 Jan 2023 10:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B50C4339B;
        Tue, 31 Jan 2023 10:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675162775;
        bh=KizWfdLaJoHcpqoGQCUVz2SlSQqe8gsl8o7bCmMfKTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tc4D1sGpb3hOZBqC9mmXKOGlkigoH/LAkb317owIQWQmGQIW0CouS7STd22cFllnn
         9sxW25UMMQDJLKSGqpeJpyVYA8HZRHmuYJZtksQGCMMW8BBg2jl7vztd3X4HzM64UP
         OLunRf+rQxRTFZbFFrBrybRFihauckL3jIBhzaLjoG0u7rxt6FRu7oK3wdUbphvWPf
         a08zUV+9tfgQmQq+8xlnekSElE4KJW4/83RKS0ug3br4+5FwXfR3TE7RkME5we2sQk
         pCRQFBYdoggHCPwEOQgIhTNdv2Bd6l5qCcOu6tqHWlTT6igk8Yvg1SKu2w1xuGy201
         mQR9LaHcI5cVg==
Date:   Tue, 31 Jan 2023 16:29:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
        linux-phy@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] dt-bindings: phy: rename phy-rockchip-inno-usb2.yaml
Message-ID: <Y9j0k4hTCsB6vo6v@matsya>
References: <99794484-d67e-ee1f-4e76-200de20a879c@gmail.com>
 <167320365145.195794.14991903357914132463.robh@kernel.org>
 <8c33967b-1b91-42d2-879b-fa73dd8ecbeb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c33967b-1b91-42d2-879b-fa73dd8ecbeb@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-01-23, 11:39, Johan Jonker wrote:
> 
> 
> On 1/8/23 19:48, Rob Herring wrote:
> > 
> > On Thu, 29 Dec 2022 12:39:17 +0100, Johan Jonker wrote:
> >> Rename phy-rockchip-inno-usb2.yaml to a more common format of
> >> rockchip,inno-usb2phy.yaml
> >>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> ---
> >>
> 
> >> Apply after:
> >>   dt-bindings: soc: rockchip: grf: add rockchip,rk3288-dp-phy.yaml
> 
> Hi Vinod, Heiko,
> 
> This patch has been acked from the device tree side.
> If it suits you is there Ack from the phy side possible, so that Heiko can merge it to grf.yaml in the order that he likes.

Yes, lgtm:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
