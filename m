Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07815BB60C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIQEWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQEWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:22:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977A8A345B;
        Fri, 16 Sep 2022 21:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 416E7B829FC;
        Sat, 17 Sep 2022 04:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1032C433C1;
        Sat, 17 Sep 2022 04:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663388549;
        bh=Pn2M2dcqmSrWXkRUDQfl9YCElCbOmpHY4lmHYVK20V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0AboqGG76DlfIx4TkDiy3bRxnRUcplKV0jJlrnoQkbJIVQfXg2eAqcg8YRsTQaCv
         gPkLvNTb2OGa6Stc1n67ZRdKsKmQFdZ232ZB8BtTESJu+Mkx+ok2XKcWISa9Fg2NnM
         1hT9k8lndKkI84PCX6+7QRQ9aOVtfTej5BPe5pWI5ILZCJiVR406JctX52YN5XnUg1
         3n97KBowk9jC4VjtBQmJn9nc+PfA7SpWfYeinTYwKVOcFgXWV55HJ98h1mIvmQIUMj
         9EIE4hMRP3Z34KpAy79NAuOHRFDGNeWmLG7jY96o0YjgEvD8ZYDr6ZWBvAtb3gDViO
         j2PsYWtFtL8TA==
Date:   Sat, 17 Sep 2022 12:22:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-gw52xx: add CAN regulator
Message-ID: <20220917042223.GQ1728671@dragon>
References: <20220916152836.1801233-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916152836.1801233-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 08:28:36AM -0700, Tim Harvey wrote:
> The GW52xx has a transceiver with a STBY pin connected to an IMX6 GPIO.
> Configure this as a regulator to drive it low when CAN is in use.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
