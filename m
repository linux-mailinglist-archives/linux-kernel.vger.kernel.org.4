Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAAD72D6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbjFMBYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFMBYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F6810FF;
        Mon, 12 Jun 2023 18:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5501462F8E;
        Tue, 13 Jun 2023 01:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD579C433EF;
        Tue, 13 Jun 2023 01:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686619437;
        bh=a7KC+mT8DCW37njz6sjR2A/VlZgTuxVuVorJVWQu4TU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XvCeOG4ObZ3pLzxWArmlLsejcKf0vl1en2EJAmX/xtCUYBwsfjnHpnAqHM281EmzT
         Sx0x8siNHfVJVBuErjQILtsoLwxtLB4QHXAVoZCxSQGK5QkKyeRq0/gKLwJaqNifvQ
         3pfg+pFekn2W2RzulbElj3FrCEPi73WLun1EJwo3HifCzjCxn5aj+Lbu6jKR6T4itr
         siRN0yTfO+Yfmsf4pS2a0+3w/lyg8ItWmCHNvpOjlnyGeioolce9wjyqnWoHf0FOEK
         5nj3YZHGfDcovrOzMsRDcOrnJP6oyNGn916InSL0DASeLZFhqSpOmPcP7I3UEiSZF5
         z8eCGFBgzlVpw==
Message-ID: <432db59b24e7cb15d7c6e67f4976d543.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230525075011.7032-3-runyang.chen@mediatek.com>
References: <20230525075011.7032-1-runyang.chen@mediatek.com> <20230525075011.7032-3-runyang.chen@mediatek.com>
Subject: Re: [PATCH v4 2/2] clk: mediatek: reset: add infra_ao reset support for MT8188
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Runyang Chen <runyang.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Runyang Chen <runyang.chen@mediatek.com>
Date:   Mon, 12 Jun 2023 18:23:55 -0700
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

Quoting Runyang Chen (2023-05-25 00:50:11)
> The infra_ao reset is needed for MT8188.
> - Add mtk_clk_rst_desc for MT8188.
> - Add register reset controller function for MT8188 infra_ao.
> - Add infra_ao_idx_map for MT8188.
>=20
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202305242320.AZzmINEa-lkp@i=
ntel.com/
> ---

Applied to clk-next
