Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996635F16F0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiJAAHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiJAAHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:07:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BFECAFB0;
        Fri, 30 Sep 2022 17:07:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A619F61CB4;
        Sat,  1 Oct 2022 00:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2603C433C1;
        Sat,  1 Oct 2022 00:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664582830;
        bh=Z2+zNHYiiIkWCAkYKhNJGpAi25tc19KhEHaBUIEP4to=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WlPT43bZju4hny7sxxb4UV5mSV4+U2/ZYcFdaDxDI+SsZPpyMpznsktbXFGtcdal+
         PUcS+T64XQVdP2oARoNC6hyNHK91hyOw/YAQVPVCNufDpyZ0j1vb7RFFGW4ECyUUEm
         Uzhe5tQlqHC95b6OmBSso3DUJtF4vizW3TD8WlP46nE8rFX/uQYceK/Ds0jWAb9gnv
         Lkh9izIXTegMI2NnvUaDP3bmQ8xf2yTlzGpvdgEqFzvHGDvaF4K94MK+BL7GslN2MN
         GiWFNh8FIzwPaFEq3mtY+N7sD94vjRgkxfsrCf36rXOOiM8lr1H3q6p4SyhZsBUO34
         ZP+oCPleaGemA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220914033206.98046-1-linyujun809@huawei.com>
References: <20220914033206.98046-1-linyujun809@huawei.com>
Subject: Re: [PATCH -next] clk: imx: scu: fix memleak on platform_device_add() fails
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Lin Yujun <linyujun809@huawei.com>, abelvesa@kernel.org,
        aisheng.dong@nxp.com, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, mturquette@baylibre.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Date:   Fri, 30 Sep 2022 17:07:08 -0700
User-Agent: alot/0.10
Message-Id: <20221001000709.F2603C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lin Yujun (2022-09-13 20:32:06)
> No error handling is performed when platform_device_add()
> fails. Add error processing before return, and modified
> the return value.
>=20
> Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---

Applied to clk-next
