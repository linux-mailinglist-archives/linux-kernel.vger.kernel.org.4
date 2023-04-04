Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C726D6DC5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjDDUO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbjDDUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1604930DC;
        Tue,  4 Apr 2023 13:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A380D63971;
        Tue,  4 Apr 2023 20:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96A5C4339B;
        Tue,  4 Apr 2023 20:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680639289;
        bh=+NWgaUFOSRZ7sm/txa6jkhFilTgZ4ske6EBNLQgIegQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jyA5hapwY9ClE2ISVEAAFpLUxCfAKH/ZFHk/H3VamFkuA0+FZ2nlk6dp31IDGDIe1
         cBEIwZrnIWbtGioT8NSrIdzcKaDB6GmxVB+9jHd6JOcyjzZrZ8/e3z2J/ngFUPE7mJ
         GIU6tKyK6y5ipMUbajUyg5mVy2nfKHREJUf78VBZURof0+WfBRelzZjA7brsb07XgI
         wLH+WL44KzU0xX98lpz/luNttfW1f4XQU58s5pdXTpSywJZ7T2xf28AdSXculHOIrc
         TgCOEtnronsy783dvNEOTGjJOoVQ2V/HV9kYx28zRvJRO5WIdW7tRzj1BTDhjcHW4C
         +vMR+HE3BZKaQ==
Message-ID: <34afcf5c824f1738bebfab2529ddce9a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230404101622.5394-3-quic_devipriy@quicinc.com>
References: <20230404101622.5394-1-quic_devipriy@quicinc.com> <20230404101622.5394-3-quic_devipriy@quicinc.com>
Subject: Re: [PATCH V11 2/4] clk: qcom: Add Global Clock Controller driver for IPQ9574
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, arnd@arndb.de, broonie@kernel.org,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, geert+renesas@glider.be,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel.ziswiler@toradex.com, mturquette@baylibre.com,
        nfraprado@collabora.com, p.zabel@pengutronix.de, rafal@milecki.pl,
        robh+dt@kernel.org, shawnguo@kernel.org, will@kernel.org
Date:   Tue, 04 Apr 2023 13:14:46 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Devi Priya (2023-04-04 03:16:20)
> Add Global Clock Controller (GCC) driver for ipq9574 based devices
>=20
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
