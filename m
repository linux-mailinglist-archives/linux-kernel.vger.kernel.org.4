Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66E60ED47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ0BLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiJ0BK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:10:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CFD63F00;
        Wed, 26 Oct 2022 18:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73254B82399;
        Thu, 27 Oct 2022 01:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A99BC433D6;
        Thu, 27 Oct 2022 01:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666833054;
        bh=VWd30oTwyvksTyVTDfeh8V7aHOOQT63px8KLQkTs16E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eaOg2N9g35yQVZhra08R53L9zVHS2DxpWyW7JcFXfjxZGQ0BDX8EV445XSeSkDI7O
         hGFkJr820P+6lWhWtPN2AaX62EQI6P17hBz+QUrMESnQm46N4wr8XK3+g9MPlrRebB
         08rwlZwgY5sUuENnw6Wfuh/DdrCU2UOTTyJurn++1v0k+rtp8x/5J+AUcF1ZG12oUP
         JOPjRKOB1eyvY3BUxFdKPkcyiPOyEhiiDYzEChamz2s75N8O3eGQveYuzihtPMuaba
         GL3xGF6iYtkbUeC8d+x0BHot7z3u/UAMbA6vW0rVpaJ5/G9LrdN53SnDhE5kamkqS/
         zVWsbd8XL5M8w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221019152947.3857217-3-arnd@kernel.org>
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-3-arnd@kernel.org>
Subject: Re: [PATCH 02/14] ARM: davinci: drop DAVINCI_DMxxx references
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org
To:     Arnd Bergmann <arnd@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 26 Oct 2022 18:10:51 -0700
User-Agent: alot/0.10
Message-Id: <20221027011054.0A99BC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2022-10-19 08:29:28)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Support for all the dm3xx/dm64xx SoCs is no longer
> available, so drop all other references to those.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
