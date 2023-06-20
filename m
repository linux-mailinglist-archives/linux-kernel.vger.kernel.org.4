Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07C7374C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjFTS54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjFTS5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:57:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D52DC;
        Tue, 20 Jun 2023 11:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C6461451;
        Tue, 20 Jun 2023 18:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5C1C433C0;
        Tue, 20 Jun 2023 18:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287470;
        bh=qjmVe16Z88mp0HPuccB5YwxW1CLBg/z3ac10InJAyRU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OYv7zkSXHZiNEd7RoIZuceND1NnxY+AIYGYVrl/FqmHUWgeb/pcHhHL03zlecxdvq
         JusXXUNNz3Fjpi72P1IQc5tebcPf+wI/+sUQofgYKQ/eFRLW1pu4Mt813erBT5A8MW
         plqn6nbhXLeFidiBWFxRdvcwiRXP8DZfX81gH2hSAUkVPft1j4mylNAro1I1Xn2awT
         cvz01KSK5Jwd0WROFLhiNFMoreb5y8I9v7BfILZatAEIuVOSmEddmXehLYBGtVm2e4
         /0JGvAKBGXA5ehvJR/x8lbc122G/Md6YSSGsPxnXJTJHFkO+t7THkEt5zXd2genkn4
         VgehZjyRTDlXg==
Message-ID: <2e1a1c3a0dd1de0d7ce9928598979097.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230327-mvebu-clk-fixes-v2-3-8333729ee45d@kernel.org>
References: <20230327-mvebu-clk-fixes-v2-0-8333729ee45d@kernel.org> <20230327-mvebu-clk-fixes-v2-3-8333729ee45d@kernel.org>
Subject: Re: [PATCH v2 3/4] clk: mvebu: Iterate over possible CPUs instead of DT CPU nodes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date:   Tue, 20 Jun 2023 11:57:48 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2023-06-09 11:13:47)
> Rework iterating over DT CPU nodes to iterate over possible CPUs
> instead. There's no need to walk the DT CPU nodes again. Possible CPUs
> is equal to the number of CPUs defined in the DT. Using the "reg" value
> for an array index is fragile as it assumes "reg" is 0-N which often is
> not the case.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
