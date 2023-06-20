Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5117374BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjFTS53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFTS52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:57:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEF51703;
        Tue, 20 Jun 2023 11:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEB0C6144C;
        Tue, 20 Jun 2023 18:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E827C433C0;
        Tue, 20 Jun 2023 18:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287446;
        bh=CfxQ5mVtrEIiUbWtm4fQaT0MsLrFinyl7iHugoAxn5c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZSpLDvelWNUVGDaCiy2V6vlhUvD2vTJ2CjW6tJ8vls8ZpHVPH7Tf+UUHaIPfwpvpL
         9AwolQhPR5ScqAWLWrTKYz1mtcSSKFEd67hgqE5rXd85AA/NUZHL9MI/e9aPIMYdK5
         FFV9mvx6ODOK4d8FcY9Zm0c/kuQdFfTU/OO6R75CPbGX0Y3W37UgDzkf4YS/47xhog
         QbLUc0DcZb/9DgLicbloQDWxiRd0GnhjYP6PmWGwMBdEnQg6fAT5KUKwZZYFLYlQIy
         AgaCOWl+aHjidyiCvab4nqQVrx2FJCI1Zvv+jo1791jsG2sa0CP754bcBv5YkwNOav
         FSa9YvvrFMYTw==
Message-ID: <271eb754d958e56b61caf453e6ba1115.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230327-mvebu-clk-fixes-v2-1-8333729ee45d@kernel.org>
References: <20230327-mvebu-clk-fixes-v2-0-8333729ee45d@kernel.org> <20230327-mvebu-clk-fixes-v2-1-8333729ee45d@kernel.org>
Subject: Re: [PATCH v2 1/4] MAINTAINERS: Add Marvell mvebu clock drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date:   Tue, 20 Jun 2023 11:57:23 -0700
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

Quoting Rob Herring (2023-06-09 11:13:45)
> drivers/clk/mvebu/ is missing a maintainers entry. Add it to the
> existing entry for the Marvell mvebu platforms.
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
