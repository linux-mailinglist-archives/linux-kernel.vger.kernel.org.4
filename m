Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9786ACE5E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCFToW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCFToD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:44:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5784A869B;
        Mon,  6 Mar 2023 11:43:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBAF561142;
        Mon,  6 Mar 2023 19:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D90FC4339B;
        Mon,  6 Mar 2023 19:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678131820;
        bh=sNfZd21SeP+ahQLJJHWS6qkgv0M4jKsZAQnFOI8P47w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tCZhAEZeq4yPbZcD4E91LpsTXw8xEGuwzxILvLWuApK2YK7Hy27F7k/Hiy42wxmyL
         MEUOKrIwkunEMzoPV1EewTfqOI2DsSnMb2F3mJnAxjDARtEfagM2njNTgIOi/cpr+V
         P+EvjFlzjedTlgXTshjGy7mcu3+PwGQQ5n0+0sOt9cpXqR83SBpT7afk+EQdEs6Zxl
         uDc/upgk7zC18qJUn97ZOP/oUVHvHD1SVz8ffCoGasyQfJbz9icqWAxVslTj44LoxY
         7NU5HkFKbPhYlxLFpX8oZCddpJvmsihkzT0Mdx5mV5RwVgMS3LNEAGBrY3vqfRuDJB
         0dlIrzIpgfbLw==
Message-ID: <00ca8e475237edb9a52b4215c62cd12a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230302205028.2539197-1-dario.binacchi@amarulasolutions.com>
References: <20230302205028.2539197-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [RESEND PATCH] clk: visconti: remove unused visconti_pll_provider::regmap
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Mar 2023 11:43:36 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2023-03-02 12:50:28)
> Field regmap of struct visconti_pll_provider is never used. Remove it.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>=20
> ---

Applied to clk-next
