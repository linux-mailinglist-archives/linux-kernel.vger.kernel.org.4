Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB49873750A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjFTT2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTT2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DDA1704;
        Tue, 20 Jun 2023 12:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB73260F02;
        Tue, 20 Jun 2023 19:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACE7C433C8;
        Tue, 20 Jun 2023 19:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687289280;
        bh=ExNcPNEX95ZDzx3tWopUJakPOtmqst+7q9RzIbG8YCQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YiP/XE4EXT4Zfq9rxaSYCPGHcctO6omqYJivbZAPl5FtQGVAGpKetojMCfNxM64Js
         R1rNzqPuEf54TNIWTW48YaDCCt53sLpPa8p4ztMCP96gUknE2lO/VImn4Wuxetfxws
         L+my/lHOyC3/8nE5L5xkDqN07rD7wbJHsC24hdWLlJZ3l0T/CnUC3akSrPpKn5dV09
         7+DJnx4sH47E/f3NxrAfTDEvjbvNKUZx8wPR/fsnOxa8ImhzIYWni511ARiez6dJTo
         Vi8XS1GSXB+HABdwlZy2CK0J7rlmoWQKxlQoSa5xu7JxznwdUmRNpzaUrT2CCOcSU3
         8TlkxlujToFrg==
Message-ID: <22242a1887670e5c2135042442ebf168.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230615101931.581060-1-claudiu.beznea@microchip.com>
References: <20230615101931.581060-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH] clk: fix typo in clk_hw_register_fixed_rate_parent_data() macro
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        mturquette@baylibre.com
Date:   Tue, 20 Jun 2023 12:27:57 -0700
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

Quoting Claudiu Beznea (2023-06-15 03:19:31)
> clk_hw_register_fixed_rate_parent_data() 3rd parameter is parent_data
> not parent_hw. Inner function (__clk_hw_register_fixed_rate()) is called
> with parent_data parameter as valid. To have this parameter taken into
> account update the name of the 3rd parameter of
> clk_hw_register_fixed_rate_parent_data() macro to parent_data.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
