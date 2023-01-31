Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C0E683849
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjAaVG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjAaVG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:06:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890A32D71;
        Tue, 31 Jan 2023 13:06:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24B0D61719;
        Tue, 31 Jan 2023 21:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAE2C433EF;
        Tue, 31 Jan 2023 21:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675199184;
        bh=2SI43GAd/Uo23yPrQZT30ppWFreFy7xGgyu3ykD7WEA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=D9dsms4Z2oU2Dm+CgtokNWpOURyhgNSVpu3vimTbqVjpxFGw7Vyt3rVFZ/iQEjw4R
         eTwhqMRGcfqi9/+3GAhvE9tJkCfUKDcqOZOC72Fc/P09DPjKEfaeVP52QcWa88kDIQ
         xb+P+dU/WQABKQQgnOtTmFvmio2wXAx626E0Wr9Tehe/YPy67DAuECYTP7p3jyQGPW
         GLuUadHMrZCkwXpnzTlTV/+R5UGGUhgbC9JlIfhAFVzO7fSq2zZarAH3WiQCaEG6L+
         uz4sGIWlDuY6S0PB6goPhNiVKVh5IGSYZWubYhy61rw4IAA1xr4LI9ijA3PLaMRCjR
         VFup27km8OtQw==
Message-ID: <b1cd40bfcb027b54bc7ec15f4834c644.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230130114702.20606-5-quic_kathirav@quicinc.com>
References: <20230130114702.20606-1-quic_kathirav@quicinc.com> <20230130114702.20606-5-quic_kathirav@quicinc.com>
Subject: Re: [PATCH V2 4/9] dt-bindings: clock: Add Qualcomm IPQ5332 GCC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Kathiravan T <quic_kathirav@quicinc.com>
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel.ziswiler@toradex.com, mturquette@baylibre.com,
        nfraprado@collabora.com, quic_gurus@quicinc.com,
        robh+dt@kernel.org, robimarko@gmail.com, shawnguo@kernel.org,
        will@kernel.org
Date:   Tue, 31 Jan 2023 13:06:22 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kathiravan Thirumoorthy (2023-01-30 03:46:57)
> From: Kathiravan T <quic_kathirav@quicinc.com>
>=20
> Add binding for the Qualcomm IPQ5332 Global Clock Controller.
>=20
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
