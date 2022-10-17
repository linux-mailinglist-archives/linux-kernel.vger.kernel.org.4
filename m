Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E9F601D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiJQXIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiJQXId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:08:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E505EDF9;
        Mon, 17 Oct 2022 16:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB6D7B81B43;
        Mon, 17 Oct 2022 23:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C945C433D6;
        Mon, 17 Oct 2022 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666048024;
        bh=vUNl5pHli4rVkCmhf3XgUrUrqRYbV+s5JQAn14e2U24=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cfI0CtEkN20VIsi+3dR9qBqP63FOAGAW/jluAaA622AAG+0IXWTbYEVtGXrRioMAg
         0UD1250iQF76zc3mSXOqP7eoiZjbvM4NdzcBhfvQWPo1Otq9zAWJIUDLDTc5Dv4GEP
         r/KhzTyIEzbaWkfn5xX1OsmTOy4CgtiNiQgI98D0kVJKQQU8scgWSZGtXz6WhKoip8
         vfQHzoJC5BUHsGTbd8ZZxSKM1FgpDSNtzdYCa8dGNWvEKkAnNhJqyzp+ubDkTJAR9c
         nliIeBEr9OC5+9AoAxufaVO30BNEZvtV/SFIrRiiO/K+ZYYe88Krx++GvYe2Ce5+ay
         wlAm/+H3DL35Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1f46b06be44527a93cd0bfd5de2fa8e2899524ab.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com> <1f46b06be44527a93cd0bfd5de2fa8e2899524ab.1660934107.git.mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 02/14] clk: cdce925: simplify using devm_regulator_get_enable()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Mon, 17 Oct 2022 16:07:02 -0700
User-Agent: alot/0.10
Message-Id: <20221017230704.5C945C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2022-08-19 12:17:53)
> Simplify the driver using devm_regulator_get_enable() instead of
> open-coding the devm_add_action_or_reset().
>=20
> A (minor?) functional change is that we don't print an error in case of a
> deferred probe. Now we also print the error no matter which of the
> involved calls caused the failure.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---

Applied to clk-next
