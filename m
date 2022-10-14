Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A8D5FF418
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiJNTbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiJNTbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:31:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B23109D61;
        Fri, 14 Oct 2022 12:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66E9261C0D;
        Fri, 14 Oct 2022 19:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48C8C433C1;
        Fri, 14 Oct 2022 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665775901;
        bh=tUBPE8pgS14Vo1Xv8t8dwBDPEUaw9xIL3GQsyiJxdeQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ESk+l1AjA5D4CHUMEGShawJE/ElnWJ+d9Urkmoq7c5IIp1ACXvyv2lZWZY1SSvFul
         a9IIAemS/2lFkww8GzfZG7u4MmNHuA4n9GInj9sph7O51vTFYOe28WM1pqJCCsd+Ew
         jVqHY+OUqyM20XDQemUl6aopAautE6lAz28L8tZjURk4FNGADYCVWpnGdRo2pMI9pc
         ySTbzEW9vYfcMGiUvCzTBhyz9eMVMoJzc8O5eBO0G1aBxj1ZbCJ7om+FcGCgprEeK/
         D+fkbDjly7N3sPj+Hk2AXjABjbTCTmZlvP3SojzGspeOL5Eg88L0HUP4QYYVUso5qt
         /impH1mfV1T6w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220815-rpi-fix-4k-60-v3-2-fc56729d11fe@cerno.tech>
References: <20220815-rpi-fix-4k-60-v3-0-fc56729d11fe@cerno.tech> <20220815-rpi-fix-4k-60-v3-2-fc56729d11fe@cerno.tech>
Subject: Re: [PATCH v3 2/7] firmware: raspberrypi: Move the clock IDs to the firmware header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime@cerno.tech>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Dom Cobley <popcornmix@gmail.com>,
        dri-devel@lists.freedesktop.org
To:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Date:   Fri, 14 Oct 2022 12:31:39 -0700
User-Agent: alot/0.10
Message-Id: <20221014193141.A48C8C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2022-10-13 02:13:09)
> We'll need the clock IDs in more drivers than just the clock driver from
> now on, so let's move them in the firmware header.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
