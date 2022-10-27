Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A0C610497
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbiJ0Vjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbiJ0Vji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:39:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990F0E034;
        Thu, 27 Oct 2022 14:39:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FFD7B827D0;
        Thu, 27 Oct 2022 21:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9219C433C1;
        Thu, 27 Oct 2022 21:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666906775;
        bh=PnidLjfH/auqOf7LWpdRJJdl6coNXBfgOkF2gQzyHF4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qgVdZXXmVUN1wldXvK1QLJA2PsRcZJe3Yiw1yZfNm1OzkTRETw7gZf8KLiHZG3PFS
         Q2iaPrvXt4UVqBhJZKu2nCAJqF1SGkidezsppfR+sagwWkmu+vExUGuOzLCpWjCkRS
         6VwMnrRAtgRMe3/b+8bxBoqMwBx2bYpwUFiUp7PkmkOGR3Bb05nCvFjIAyetQ03NO7
         J5pp9FsjjhHr2lJaYX2amZFihlzxgBuB7otf4L4W0zXajPnlkVg25Ow79vibMoZrYa
         FHs2F+sVmQrEF/nkIiFbm0/K66BxfD4tAcymi96SnjCMEsnhP0pX1RyZiyZUMy/Ycv
         34s4+9pkLUfFA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221026141631.696863-5-dinguyen@kernel.org>
References: <20221026141631.696863-1-dinguyen@kernel.org> <20221026141631.696863-5-dinguyen@kernel.org>
Subject: Re: [PATCHv6 5/6] clk: socfpga: remove the setting of clk-phase for sdmmc_clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Date:   Thu, 27 Oct 2022 14:39:32 -0700
User-Agent: alot/0.10
Message-Id: <20221027213934.E9219C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2022-10-26 07:16:30)
> Now that the SDMMC driver supports setting the clk-phase, we can remove
> the need to do it in the clock driver.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Do you want to take this through mmc tree?

Acked-by: Stephen Boyd <sboyd@kernel.org>
