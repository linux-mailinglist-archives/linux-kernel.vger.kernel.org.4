Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058B06E55A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDRAMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDRAMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:12:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8EC2D50;
        Mon, 17 Apr 2023 17:12:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9EC562B0A;
        Tue, 18 Apr 2023 00:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1346EC433D2;
        Tue, 18 Apr 2023 00:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681776765;
        bh=RX6BuVTmZze3wL2+UbiX1MEnd8GOlsV3v3qiuoE7FfA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B1ndp4MeJwf8XUKir5+7XFF1sFR4fvYkgFeTrR29+GWYIdbktOvLinfkNGOnTglE1
         Z+4h92O5G/L46b8vfzczZ+VRdU/OTazBFzbPM7kVclFY9uq+Uqbjvlbsh4/IWNviPk
         tGzmnjESYk4tLF/DFGjh6vL90ZRJN/7w+uy31RoLPib29D0nKjl+1zumj50HI4E4NR
         pxpN3uekwfZxAVK8X4/U5to8mq0+akXSILfOjxxaP7cvR/PMTF2NpG5Dr392PoMIz4
         S4lOkGKIozeUpkZmyItqPhMoSJJmChFx0tF/XUgxpZKe+jcZyUtd+V55pyn9ila15R
         BcvVfLApWElbg==
Message-ID: <42ef1f67c681025ab6c749279d9d3f1b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230416194624.1258860-4-mmyangfl@gmail.com>
References: <20230416194624.1258860-1-mmyangfl@gmail.com> <20230416194624.1258860-4-mmyangfl@gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: clock: Add gate-clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Date:   Mon, 17 Apr 2023 17:12:42 -0700
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

Quoting David Yang (2023-04-16 12:46:21)
> Add DT bindings documentation for gate clock, which can gate its output.
>=20
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---

NAK

We've been over this many times. The binding will not be accepted.
