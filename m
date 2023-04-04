Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB396D6DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjDDUOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDDUOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD72F2121;
        Tue,  4 Apr 2023 13:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6765A637C8;
        Tue,  4 Apr 2023 20:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11DEC433D2;
        Tue,  4 Apr 2023 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680639242;
        bh=ha4V0E9P3kWrC+Zr2fUF+Hka0cIazVHY+NwllSabj/g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=H6TzIaksUjvnXtc/U1MDgqF30kOHADleviRiCLocI2M45Qilbmmx8e1uuyxj+k740
         jAxuDH2sRRDGDg2T+b514gk+POktrIGhkjXrFTdLLa1abhxGnZFQdrBC7jKDKIVA2a
         9K8V1JpzKYtfntsWnRUXo+jGyECAFMyD03khx/aqxXqF0U5AMR0Hbu/ld9Ip2gg4Ka
         Ci1JEtAzVREV4gG6iFWJSm6b+y/SPmrONpRURZsJ1OLZoAIE5dMzveWuRbFZSK4Kp5
         O06pY7HTL/cetLPtKAW70HJYXR6mZYhmKUy6H4WRD84vNXDYg4lxdk82SF84a452I1
         MB9gujDJAVAbw==
Message-ID: <b67794e35c0baec8f9616fbff8879c0d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230404101622.5394-2-quic_devipriy@quicinc.com>
References: <20230404101622.5394-1-quic_devipriy@quicinc.com> <20230404101622.5394-2-quic_devipriy@quicinc.com>
Subject: Re: [PATCH V11 1/4] dt-bindings: clock: Add ipq9574 clock and reset definitions
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
Date:   Tue, 04 Apr 2023 13:14:00 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Devi Priya (2023-04-04 03:16:19)
> Add clock and reset ID definitions for ipq9574
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
