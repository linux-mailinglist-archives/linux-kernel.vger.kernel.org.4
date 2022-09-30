Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1587B5F15E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiI3WL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiI3WLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:11:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA01F2768;
        Fri, 30 Sep 2022 15:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B112B82995;
        Fri, 30 Sep 2022 22:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7412C433C1;
        Fri, 30 Sep 2022 22:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664575910;
        bh=TJjukHsbHrPXxnAGkKBJL1+F80pFk9u9WxONVeM09Rw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nhz13Zh4QN4rt+fH+/KrCI0MKNofWTz9ij7GT/CTRzHHUdXcZcHfoiJmcVn6dA/yf
         w+OEwQr95DvSu0ltRcv9PJYH54PBS5MkdAn4bBscb4uOAmNNt05U4zth1aBqZJTxe6
         k1XiRT1B0I9FOPqflJHFwJFLOIqwkJt6FVNfnzVImQE5JHT8IFi69CRkRrWaJtbqVx
         HcAxfyY9abQE9gqAkQp6sHRIUr9PqRnWYb4rYAAuMda+eqVBHCRAkp9DODtsziUlx2
         cc1rF6XaJUYv66+wAioe2Liri1tMLF9+k3Dkmjjajr2U+0nN1TFLUg2LUXQPGaB2lB
         Mfebbh9IG4OMQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220822152652.3499972-3-msp@baylibre.com>
References: <20220822152652.3499972-1-msp@baylibre.com> <20220822152652.3499972-3-msp@baylibre.com>
Subject: Re: [PATCH v4 2/4] clk: mediatek: Provide mtk_devm_alloc_clk_data
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 30 Sep 2022 15:11:49 -0700
User-Agent: alot/0.10
Message-Id: <20220930221150.D7412C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Markus Schneider-Pargmann (2022-08-22 08:26:50)
> Provide a helper that replaces the kzalloc with devm_kzalloc so error
> handling gets easier.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---

Applied to clk-next
