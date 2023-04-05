Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09286D820C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbjDEPhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjDEPg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E4519B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 955B362778
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65DBC433D2;
        Wed,  5 Apr 2023 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680709017;
        bh=xi8fxeIahJClG3Ca4lSBi8mYKmlZQafWhu28ijvmkGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkNKL7GME9JiTaDSJiimGhBr+WF7sRfJBdf03It/QeNHT60/afZZ/MxUAWbhIJ/R9
         bUT0nuWgtKYhmq7qJpGiXprsMcSUjSs8AC4ZlO4rLvuOL0e8fYus5pkFEvvFQaltnC
         7R7ewI1PKZXgpGl2M3x4T6mnRxC2CoyKDuXqD3Xl33nfd+VVzVDIz0Nx5usfCVxKlB
         bSkoYA9xx697UXBgJHqHimeqOE9oxCQjMFLpys1Rshgu+OpjHDOouAh5r5owiMxlX5
         5hjECcUKcRCVWrfqkeOlJglhTKxM7aBp6sawCV9KykINL95hdPsJH2KE6nVTjRckyO
         vLGdP3L1dKQPw==
Date:   Wed, 5 Apr 2023 16:36:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/3] regulator: axp20x: Add support for AXP313a
 variant
Message-ID: <20230405153651.GS8371@google.com>
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-4-andre.przywara@arm.com>
 <20230405142103.GL8371@google.com>
 <f1d7526b-7f51-462d-8192-0a05828bfc4f@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1d7526b-7f51-462d-8192-0a05828bfc4f@sirena.org.uk>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023, Mark Brown wrote:

> On Wed, Apr 05, 2023 at 03:21:03PM +0100, Lee Jones wrote:
>
> > Is this on your radar?
>
> > Can I take the other two patches without causing issues?
>
> I'm waiting for the MFD.

To do what?  #deadlock

--
Lee Jones [李琼斯]

