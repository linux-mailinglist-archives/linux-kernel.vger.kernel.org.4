Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D661C5F1781
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiJAAql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiJAAqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0A9199C8F;
        Fri, 30 Sep 2022 17:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27BA860BA4;
        Sat,  1 Oct 2022 00:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA8BC433D6;
        Sat,  1 Oct 2022 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664585196;
        bh=Y+8tvv4q6Tk1Y0GWY8k1zYo9uxL6+vKGn1elhVnztAU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FrGTUy8ZgNhi+4ps6vmkTTBJiXn2GMhCMlJVBQYfTap1MlBWSnP0LsSD1T9BgROVL
         ENOU1KzQEMGncfcmCY3t4SmYUQzl/EChZToAVpd2PXLUjkNIIr+DsyG7Bx5QE7igWl
         2Lw7zQKEswxa1Nd4rnE9jGjor2Zm3Kcr61V1Kuem7Jc5MjGcC95TDFrAC6PGdwSufQ
         jgpfpxr9yLgsrAdKE2A7tLdUiYIs+kwLThe0bqk4Sm0R/sB0RJPp+gbG2wM20jKTzf
         iqkPHXG17to/EyHGIWWuVtxzPVXd2TLAt5c2jMgUhnWPH2qoL+u0lezdp3l81/40qg
         eP9B/u31QnfjQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220906072322.337253-1-ye.xingchen@zte.com.cn>
References: <20220906072322.337253-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] clk: mvebu: armada-37xx-tbg: Remove the unneeded result variable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
To:     cgel.zte@gmail.com
Date:   Fri, 30 Sep 2022 17:46:34 -0700
User-Agent: alot/0.10
Message-Id: <20221001004636.7AA8BC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting cgel.zte@gmail.com (2022-09-06 00:23:22)
> From: ye xingchen <ye.xingchen@zte.com.cn>
>=20
> Return the value of_clk_add_hw_provider() directly instead of storing it
> in another redundant variable.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

Applied to clk-next
