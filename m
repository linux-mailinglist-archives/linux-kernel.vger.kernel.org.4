Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401FF601C69
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJQW30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJQW3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:29:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D1C816A1;
        Mon, 17 Oct 2022 15:29:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA0B86118E;
        Mon, 17 Oct 2022 22:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F688C433D6;
        Mon, 17 Oct 2022 22:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666045725;
        bh=7vPZymAqorOW4xe3QZt5eaQojPY88QgEO6/H+3U3ET0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nYJ3LMCWfsqdG1Q+8mY32y8VR2r3JWPRhpiZDWa5ZULGbBt69A9qQjDT+ntChjnQ2
         tjGg2s+gzS+03Ex5vEo9UATP02/20JTx3MUDK89Rx0Uk9VXNn+5Egp/+C1+vgWtUH8
         +3BDqJQaNiuf7fbl5NjbmHE0sAFeTJsHR16lc4+LMOg9TQ9hJbiTfaARNX1BUmmeh9
         /VI0BZan3sVUbVJU4QjFhjxLd+XTU4xwY4iFyeOkiNnRB5Io19KU6wSr17yQb0oppq
         6IQNcna6LvAngcu4WlS/hR4XGo7wBvR0W4LpRQ/XznQOfDLPAsphCyTdSoml0fFgeA
         0PgNXPPganLqA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2610331918206e0e3bd18babb39393a558fb34f9.1665642720.git.rtanwar@maxlinear.com>
References: <cover.1665642720.git.rtanwar@maxlinear.com> <2610331918206e0e3bd18babb39393a558fb34f9.1665642720.git.rtanwar@maxlinear.com>
Subject: Re: [PATCH v4 1/4] clk: mxl: Switch from direct readl/writel based IO to regmap based IO
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-lgm-soc@maxlinear.com,
        Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, yzhu@maxlinear.com
Date:   Mon, 17 Oct 2022 15:28:43 -0700
User-Agent: alot/0.10
Message-Id: <20221017222845.2F688C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2022-10-12 23:48:30)
> Earlier version of driver used direct io remapped register read
> writes using readl/writel. But we need secure boot access which
> is only possible when registers are read & written using regmap.
> This is because the security bus/hook is written & coupled only
> with regmap layer.
>=20
> Switch the driver from direct readl/writel based register accesses
> to regmap based register accesses.
>=20
> Additionally, update the license headers to latest status.
>=20
> Reviewed-by: Yi xin Zhu <yzhu@maxlinear.com>
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---

Applied to clk-next
