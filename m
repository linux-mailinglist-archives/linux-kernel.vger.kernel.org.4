Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D06DCE2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjDJXg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjDJXgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1371BC7;
        Mon, 10 Apr 2023 16:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56A6E62003;
        Mon, 10 Apr 2023 23:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49ABC433D2;
        Mon, 10 Apr 2023 23:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681169783;
        bh=TirLwEYBbP4VCi+NhiloSleSjPJ6R//R3r7qXDcBu9I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g8NZ85bPEriDDh2zVqaVoPv4YOphP1x+jqdyhswCs08JNo32vx/uYplhfJmCSIKY0
         BtnpSARwyar60MHcxFJSDO0Kzl4Qys/FwC9jLiCu3c+MpcJANIMbkMTB0yNlrWfJpI
         9MTcOpBJ952vtKUngt7jwgtFfRaEni39llZhTcrGA8MprqhHOp7xVAFSLGuLhmheYn
         SvIVXC6xKsLfhRqdopJO3Za9tVcS+zdmR/n8lNcZgnuW9d4pvdYstlMM/4ZwV51CRI
         bH3pcNUkb8szMUfCFodqES2p20hmnF/cOevZzKSLrtWe0+3MxRse7xA2p0xOzCIHl/
         qe3jScwMooj9g==
Message-ID: <216176104e507b860e24399bf020d836.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230327-mvebu-clk-fixes-v1-2-438de1026efd@kernel.org>
References: <20230327-mvebu-clk-fixes-v1-0-438de1026efd@kernel.org> <20230327-mvebu-clk-fixes-v1-2-438de1026efd@kernel.org>
Subject: Re: [PATCH 2/3] clk: mvebu: Use of_get_cpu_hwid() to read CPU ID
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date:   Mon, 10 Apr 2023 16:36:21 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2023-03-27 11:43:19)
> Use of_get_cpu_hwid() rather than the open coded reading of the CPU
> nodes "reg" property. The existing code is in fact wrong as the "reg"
> address cells size is 2 cells for arm64. The existing code happens to
> work because the DTS files are wrong as well.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Note this should be marked for stable so that if/when the DTS files are
> fixed, then at least stable kernels will work. This is untested, so I
> didn't mark for stable.

That makes it sound like it breaks for existing DTS files. Is that the
case?
