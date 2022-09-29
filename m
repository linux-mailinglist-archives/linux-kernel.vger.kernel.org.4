Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554715EEA82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 02:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiI2AXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 20:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiI2AXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 20:23:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071D11ADD5;
        Wed, 28 Sep 2022 17:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFB09B8221E;
        Thu, 29 Sep 2022 00:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD5CC433D6;
        Thu, 29 Sep 2022 00:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664411022;
        bh=L85UmdSjhG3JVcpSLPn/ZMDE+UMdrUzT3VbSiE8dFGM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=N2lp/0VQNRfEu/GVTFx3/zAL8wSjTiQpplphMETeylaZ+mpLiiGNbTJs2D0Ca3m52
         7RgQsfuhyWeSfGRS5+4/+AdiZsVln36xVE6yIZiBh0wk9XooVjhfLcGT9+Eu8kbtSC
         MtYd7grSVZVDhyF3yWd0qHYhE6tNYokveCsyPWS7KLT4Bw9VqS0Yc7tb23mPU42q+j
         Xzbq7wsqRILrLzj/j4mJTsfQRY7mLeQvHJ6FFXd7KloQ/T/4/20Yw0Sf7krNe4zDeh
         gnH2hqb11Uh4/b84j2o/mjsqZp+wHmhFP89lnFx1eGOyp2LXpqUol7QY5QFlKg3rJ5
         acdn63wGuaTrg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220815-rpi-fix-4k-60-v2-3-983276b83f62@cerno.tech>
References: <20220815-rpi-fix-4k-60-v2-0-983276b83f62@cerno.tech> <20220815-rpi-fix-4k-60-v2-3-983276b83f62@cerno.tech>
Subject: Re: [PATCH v2 3/7] firmware: raspberrypi: Provide a helper to query a clock max rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org
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
Date:   Wed, 28 Sep 2022 17:23:39 -0700
User-Agent: alot/0.10
Message-Id: <20220929002342.9DD5CC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2022-09-20 05:50:22)
> The firmware allows to query for its clocks the operating range of a
> given clock. We'll need this for some drivers (KMS, in particular) to
> infer the state of some configuration options, so let's create a
> function to do so.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
Acked-by: Stephen Boyd <sboyd@kernel.org>
