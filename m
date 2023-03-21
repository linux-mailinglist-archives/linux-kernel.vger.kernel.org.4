Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8A66C3EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCUX6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCUX57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C08D;
        Tue, 21 Mar 2023 16:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 825A361E74;
        Tue, 21 Mar 2023 23:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2664C433D2;
        Tue, 21 Mar 2023 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679443074;
        bh=UyBZQu//dK6YIN2Hhik6aydJiVU1mQzZJsoluwZgzgY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=X1ywQzClIA/IIy6qrMSpj8zqk1nF2fQRr/gMkCbpxrrYNeXGA/BvmRvpoPC0Pe94H
         b9sIBM4N6fli1D/xyntONk4da7U+sNXVA1VtTzRWjD1hTlN/bgd4VL4nx+IC7ClX88
         d3mWHNOyBXBTGKCbFI++EormE7xMP8qDWYYj95Rq2J648rBKpv822K1C2mz+7RLgh4
         ZeJ8Eh+e4+hy61RGxbFsolDjevVYKIH58AIWOwVx2gqe/h5hY2G2i1+Y5NJ72jOuE0
         ex2gyko8ZDtJlKLgaWEBPEPN3QGXLFmRMIcvz5nKPb4is5WUmoNCb4eiG6Hfwx0xm/
         NJYXPRUgN3uZw==
Message-ID: <62b766cef78d95793af95f428693c359.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <95f11f7c-611f-49a9-97e8-0de89846e430@spud>
References: <20230320103750.60295-1-hal.feng@starfivetech.com> <95f11f7c-611f-49a9-97e8-0de89846e430@spud>
Subject: Re: [PATCH v6 00/21] Basic clock, reset & device tree support for StarFive JH7110 RISC-V SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
To:     Conor Dooley <conor@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>, kernel@esmil.dk
Date:   Tue, 21 Mar 2023 16:57:52 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2023-03-21 16:03:54)
>=20
> If you're happy on the driver side of things, do you want to pick those
> patches up on top of the bindings and send a PR to Stephen?

This sounds fine to me. Let me know if you plan to send a PR with the
starfive clk bits.
