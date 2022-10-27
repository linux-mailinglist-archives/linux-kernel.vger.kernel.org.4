Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D5610100
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiJ0TAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiJ0S77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:59:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA4E356D1;
        Thu, 27 Oct 2022 11:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20F36B8277B;
        Thu, 27 Oct 2022 18:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2571C433D6;
        Thu, 27 Oct 2022 18:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666897195;
        bh=/jg2sw26OCZeulOCXwP28bV+yEw8iPKlgLkGuOp9bjU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=irk3sOh5okyVXhTBizYnXbYOSwLFoknf5Dh/FJb19qWoPsblhWhCz7sk4ksCTYfA8
         2gFA9ESgNebBPo2LN3B5b3D6loHQNpnpvW1MfblX27ltft8PGZzb+fICuLaCAP6cCI
         WECUzM2BwGOQ+CULQSWW/hMU5WxJn0sdWTsf0ZAm5AkaqXf/tM2j9LHOkJ9XPeCDv6
         F/BYlNygjhO2U3/Xk5SgoGDobcdnTK2XH1TY6fQfVyWWIrcaHdIgGRQxZ/0J44eN3d
         kBO5vc3vIVoHG+Xl7X2nJR0o+bxEXHp0Q0N1cNCzkinMXHRs+jS40lsHvqQRlf0jsm
         VwaEMKBh7XQPg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221026194345.243007-6-aidanmacdonald.0x0@gmail.com>
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com> <20221026194345.243007-6-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v2 5/6] clk: ingenic: Add X1000 audio clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        paul@crapouillou.net, robh+dt@kernel.org
Date:   Thu, 27 Oct 2022 11:59:53 -0700
User-Agent: alot/0.10
Message-Id: <20221027185955.B2571C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-10-26 12:43:44)
> The X1000's CGU supplies the I2S system clock to the AIC module
> and ultimately the audio codec, represented by the "i2s" clock.
> It is a simple mux which can either pass through EXCLK or a PLL
> multiplied by a fractional divider (the "i2s_pll" clock).
>=20
> The AIC contains a separate 1/N divider controlled by the I2S
> driver, which generates the bit clock from the system clock.
> The frame clock is always fixed to 1/64th of the bit clock.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Applied to clk-next
