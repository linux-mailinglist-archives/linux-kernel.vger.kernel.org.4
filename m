Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0257374C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjFTS5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjFTS5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:57:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC43610F8;
        Tue, 20 Jun 2023 11:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 892DD6142A;
        Tue, 20 Jun 2023 18:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E548AC433C8;
        Tue, 20 Jun 2023 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287457;
        bh=dc2iLR5pVFmqyz7wtfc1R3P35ih9tEb3qrjZLB7V6x4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OwPpRHmgDqXrrDNknPlR0JVnQIkbyjwhZzt7bfeHy2jjcNVTB/g/dyCSgAfm12KPG
         HHeZAd7ocXBr3sMv8ephQ5U5/a1rMVMpCehCXB/x0ojtb4hEdg43JZhZZe8F7SLxQO
         8MyOS0DLSCUCOM8gHD3ppcIe8bIiQrMd89n1eoclocnEc2YwbfAARt0sDDLlcH3uwh
         tR+0a+Vx1SLIdYlfkXyYDKseLLAngvHIIxkFlBLHKpRRGiWqFHx4Y4AG62UWs9k51o
         2cjqU+2GlMWSA1iJ/3CUGYWfAAfi6sqgG/xDSdbmQNGMf/g+V9nA+kAoNEULAI7MPp
         1Zfwhm2/U2PDA==
Message-ID: <101e859b5ef84b911b87ec87b9829dea.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230327-mvebu-clk-fixes-v2-2-8333729ee45d@kernel.org>
References: <20230327-mvebu-clk-fixes-v2-0-8333729ee45d@kernel.org> <20230327-mvebu-clk-fixes-v2-2-8333729ee45d@kernel.org>
Subject: Re: [PATCH v2 2/4] clk: mvebu: Use of_get_cpu_hwid() to read CPU ID
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date:   Tue, 20 Jun 2023 11:57:34 -0700
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

Quoting Rob Herring (2023-06-09 11:13:46)
> Use of_get_cpu_hwid() rather than the open coded reading of the CPU
> nodes "reg" property. The existing code is in fact wrong as the "reg"
> address cells size is 2 cells for arm64. The existing code happens to
> work because the DTS files are wrong as well.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
