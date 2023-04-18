Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774FD6E563B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjDRBN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRBNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:13:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D03A8C;
        Mon, 17 Apr 2023 18:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 379E76176F;
        Tue, 18 Apr 2023 01:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861A2C433D2;
        Tue, 18 Apr 2023 01:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681780403;
        bh=RGVB4b1Ma/kemnqMd6QFYrPQXvJkDZYWawFz3hC5t4U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YhM43pLMLnpYrnHFd76107gj08QmgTS0Ai+eBSvLbgEpRRrFHrEmOtKeE49msoN/Q
         obhPiDUu4YHgVI+ySsqvuBipzkyP2mfvNYqIlmlyq5wBULGLcy0P+O9uy2B1/o5l+t
         0xVEKpea/pgs51J1U7SQpRFSPAIWf/Ug1+dEizqUxVY8mMB1NBNzVhhyg/FydcSR+X
         E/G+iTeNTM6GUFAMBngWr+ucey82v02X/yXiQ//axBfyuCkKl4mypJ5Dy+lZM/fP4W
         X+c3Qzz5ECjGbGNdzIMfsInrDoEGZHcnvKYkDvgN4yUIJi38lG3k01amdZbMmtO3uZ
         ZOyU2T+OZTqmg==
Message-ID: <cb922046c9e9ae2359b7f22fa7436e2c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230417074115.30786-3-hal.feng@starfivetech.com>
References: <20230417074115.30786-1-hal.feng@starfivetech.com> <20230417074115.30786-3-hal.feng@starfivetech.com>
Subject: Re: [PATCH v1 2/2] clk: starfive: Delete the redundant dev_set_drvdata() in JH7110 clock drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-kernel@vger.kernel.org
To:     Hal Feng <hal.feng@starfivetech.com>, linux-clk@vger.kernel.org,
        linux-mm@kvack.org, oe-kbuild-all@lists.linux.dev
Date:   Mon, 17 Apr 2023 18:13:21 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hal Feng (2023-04-17 00:41:15)
> The dev_set_drvdata() is no longer needed after we used a wrapper
> struct to get the data in auxiliary driver.
>=20
> Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> Fixes: d1aae0663023 ("clk: starfive: Avoid casting iomem pointers")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---

Applied to clk-next
