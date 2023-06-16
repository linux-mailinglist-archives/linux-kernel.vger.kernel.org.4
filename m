Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE66F7337E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343965AbjFPSES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjFPSEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:04:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291C72D50;
        Fri, 16 Jun 2023 11:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E99B62D96;
        Fri, 16 Jun 2023 18:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0016DC433C8;
        Fri, 16 Jun 2023 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686938639;
        bh=25ClDeAOs/NHa1F0NW/S99YUWXo1FvU6uml1OXE1JNA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=s1/ZVkL2f4N7DCQZr2df1+r6sKcvkBBWTCu+5gLn994xQbSqbME84uOobXThkRpCs
         IctfHOIP5ZBymRYJtdJp+cQZO1Dri800SBYieKC271TiX9LlM2SX+BC61sXcF/X7r4
         r39ZTJ7tYkEfXrWxRK+caifyhYk6y9OrB4HE72joxKdGOMYmbwFBmmuY+RApnad4+/
         lDggCxbVtmz97kd2gLWaWjYbGiVYRBugpLVXyfi1/WBjdUZ79oWkcZQRe86azwrHPp
         YZAxdH4eU6fbPPfHWyuO0Zz6ec0YiFO0wTwlUAMOnpMxrifwQwg0cmc6EK2IHdaA7E
         19eSLkSp/Iq+g==
Message-ID: <7ff1662a36922973f0a7e82b28c737e4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230418090312.2818879-2-sergio.paracuellos@gmail.com>
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com> <20230418090312.2818879-2-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH v3 1/9] dt-bindings: clock: add mtmips SoCs system controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Fri, 16 Jun 2023 11:03:56 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2023-04-18 02:03:04)
> Adds device tree binding documentation for system controller node present
> in Mediatek MIPS and Ralink SOCs. This node is a clock and reset provider
> for the rest of the world. This covers RT2880, RT3050, RT3052, RT3350,
> RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
>=20
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
