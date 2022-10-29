Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363C8611FE8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJ2EIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJ2EHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:07:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192B31D463A;
        Fri, 28 Oct 2022 21:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6D32B82BE2;
        Sat, 29 Oct 2022 04:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22990C433D6;
        Sat, 29 Oct 2022 04:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667016471;
        bh=PUxVhkhHCWBR95ZcJLsy9eKo6iGmXv3k1ozIsxKz8jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WmLx2vAelJAfBa7x0lmuq/3cy+CWV/Wiebk3dlQs28txdysKfVeu5q1oDKvxSDIda
         aylUoCce/TJpW4/HtX0e4wUYEegLbsFcMU4bERXTropVZyqotNnvKaAZdJjbp8QCYT
         rkp7PQZWU6aKdhPuFvPUxM5ZKhKI8UAEOAwuCztzDByfq6H6f4AtocxMAMcPjyrpB8
         k6yA6rln1MfhYrKjDx5dgrNXkLCwrMDTOohDAgXKuMZoM8NkoT6xsQiJPLAhN4vj29
         7FcUfy8nhteUaaPbGVOuJZW7NCpfCFq+W0VIQBEkvE5HKTWOx5QfjQzpYGtehPDqRJ
         02tyeL4MvJjXw==
Date:   Sat, 29 Oct 2022 12:07:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        j.neuschaefer@gmx.net
Subject: Re: [PATCH 0/2] ARM: dts: imx6sl-tolino-shine2hd: Add backlight
Message-ID: <20221029040744.GN125525@dragon>
References: <20221019065159.969852-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019065159.969852-1-andreas@kemnade.info>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:51:57AM +0200, Andreas Kemnade wrote:
> Add a backlight here, it is a bit special situation. The vendor system
> has an option to add some extra brightness together with a big warning
> that power consumption is increased. Not sure, where it should fit,
> but since the backlight is probably made of leds, this might be the most
> convenient place.
> 
> Andreas Kemnade (2):
>   ARM: dts: imx6sl-tolino-shine2hd: Add backlight
>   ARM: dts: imx6sl-tolino-shine2hd: Add backlight boost

Applied both, thanks!
