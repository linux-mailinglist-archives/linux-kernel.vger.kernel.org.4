Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68D7601C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJQWa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiJQWaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:30:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8A7AC1B;
        Mon, 17 Oct 2022 15:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC58DB81B35;
        Mon, 17 Oct 2022 22:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A98C433C1;
        Mon, 17 Oct 2022 22:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666045733;
        bh=/U/gO545RBVR+HFM3XRnoel9RE6TFHkBRw1SznKckn8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lqE7NfKDNI1H+vDVy5cw0yQPzsYGZJOZjxvRqaacqI5G51ny1nRnL7mvOfwNSuNIQ
         bpsjGi0/UChpIBWgjgOpXvBryb77gHhWl2+ujojhGNsCfGnENCaJ52d/t3giH988dW
         6hyWaSavh3R55Tsu0CIDS21jcXplDZtkoDgPpCxu5NzBGiCvx9p5M1jntUimZs31un
         4Wx/ri62KsMBMW9uoX3MDOEKlIxhvMWkJzwesQWuWuy+m8nkYIpCqpGRpIRQHWFr0o
         dMibpgkgXsGVFk6pUl+jB5nVf+A6w05/u6SRoX1PDuiW0e3mY5M+DJHGFGeLy/xkSh
         yzt/8E47GrReQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a8a02c8773b88924503a9fdaacd37dd2e6488bf3.1665642720.git.rtanwar@maxlinear.com>
References: <cover.1665642720.git.rtanwar@maxlinear.com> <a8a02c8773b88924503a9fdaacd37dd2e6488bf3.1665642720.git.rtanwar@maxlinear.com>
Subject: Re: [PATCH v4 2/4] clk: mxl: Remove redundant spinlocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-lgm-soc@maxlinear.com,
        Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, yzhu@maxlinear.com
Date:   Mon, 17 Oct 2022 15:28:51 -0700
User-Agent: alot/0.10
Message-Id: <20221017222853.68A98C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2022-10-12 23:48:31)
> Patch 1/4 of this patch series switches from direct readl/writel
> based register access to regmap based register access. Instead
> of using direct readl/writel, regmap API's are used to read, write
> & read-modify-write clk registers. Regmap API's already use their
> own spinlocks to serialize the register accesses across multiple
> cores in which case additional driver spinlocks becomes redundant.
>=20
> Hence, remove redundant spinlocks from driver in this patch 2/4.
>=20
> Reviewed-by: Yi xin Zhu <yzhu@maxlinear.com>
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---

Applied to clk-next
