Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6279601AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJQVHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJQVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:07:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08915647E6;
        Mon, 17 Oct 2022 14:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90D70B81ACB;
        Mon, 17 Oct 2022 21:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E280C433C1;
        Mon, 17 Oct 2022 21:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666040841;
        bh=9fZvPQ6FH4+BSR67d3rvJb0rl7mn1fy9ZWDE+8emsZY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uuB1yBzqtJUBiAgzUwLG3e267P0N3b3+y8NM3FAwPCErwlfNhNNcXD+FdQKUvfdtW
         1tQIh6ah1kqlHOGh0iw2UNhee2T3wR8Ds/MqN/4PbTaf+WPpj+d24RpmAQ4HH8jbwu
         L98VL6LGAZf2ifkHgI4pF0sbgSrwEDHA6qtPMfWMzwnNEdLoCv3F4MCmapE7pI7VAH
         mn2DkXnw4YCVicpPHuwDXKLilfQ3RBZ5crk71fHh22Otlkgd1Im/xdU/0NYZ+79gT7
         y5PIZCZiZnIen4r/YJ4CBUYo7MHON7PCF9x1U23oNAG0kNkXhpevPQ+/CghUQccUvE
         Ht3edwh0MDHQQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221005171348.167476-2-conor@kernel.org>
References: <20221005171348.167476-1-conor@kernel.org> <20221005171348.167476-2-conor@kernel.org>
Subject: Re: [PATCH 1/6] clk: sifive: select by default if SOC_SIFIVE
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
To:     Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Date:   Mon, 17 Oct 2022 14:07:18 -0700
User-Agent: alot/0.10
Message-Id: <20221017210721.3E280C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2022-10-05 10:13:44)
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> With the aim of dropping direct selects of drivers from Kconfig.socs,
> default the SiFive clock drivers to the value of SOC_SIFIVE.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied to clk-fixes
