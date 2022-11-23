Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C6C634DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiKWCWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiKWCWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:22:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091AFC67DE;
        Tue, 22 Nov 2022 18:22:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C150DB81E5B;
        Wed, 23 Nov 2022 02:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79212C433D6;
        Wed, 23 Nov 2022 02:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669170132;
        bh=6U8PIp0SwFrn5knbLXFnQIk8VYAWD20xFlLAjA93zPg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qKeLsVzwGvTOtenfRi0Oe9KWWK8VMpDtOJxHCGegk2tWbzgAjZdRyQVuQZMtDfSsY
         noxOlRtzOt0LjXWPy9wOLNUgIxt2P3vSyHACNDmO67ynrUSaXAnkS4GY1PMchunAIU
         qhMXa2DlBdFKHuc31kHdxj3Tni5+KzUvvLnzO8isHw79R3umVGW1wJQulV7SLoqGSX
         hVZscnXA31eFccOZV4/ExcGZIgc5CPTfYI1o+ta5T1Vkz8UIbd+Klkvps0+JduHk1g
         6u/Y1YbyVzcaP4czAeO1entaizgY7t7jr1T5tBX0fPJ//Ms055k2/Uc3TuzNFDc8RP
         am3ODipirW5nw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221122130732.48537-1-andriy.shevchenko@linux.intel.com>
References: <20221122130732.48537-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/3] clk: fractional-divider: Split out clk_fd_get_div() helper
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 22 Nov 2022 18:22:08 -0800
User-Agent: alot/0.10
Message-Id: <20221123022212.79212C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2022-11-22 05:07:30)
> Split out clk_fd_get_div() helper for the future use elsewhere.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied to clk-next
