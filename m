Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F73865CB62
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbjADBZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjADBZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:25:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3308A21C;
        Tue,  3 Jan 2023 17:25:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6BCFB810A3;
        Wed,  4 Jan 2023 01:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAECC433EF;
        Wed,  4 Jan 2023 01:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672795548;
        bh=NFaBi10GYulxFVGQsaX2ldxX5dG2rSQvP0AD9yCLI04=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E5mFWAXXYdALmPzAysl/CTLtqag4jyCv/88McLMzpfGZhF6D3K1xaOZ8PlNaXGhIM
         +IELxh/5Iv5N/xZktisSJuRBPE2sJVDNEyvHlPA+UTG5r7EjUEx0iWZsP+dxovZn45
         RpFQC+IDMqhcuv9amzl+bHxj6gpWve3lhT5mGuoQ34rFytci+PUTDI15oREwRrc/ID
         xATAIhowcohMTzAW2AABd62T/sZepN9VQEQcG1c3kZq1qnYeu5H+fSTH+VZDHEBbvQ
         o6erIpZ9AFNqxUhhNmjoc10Hh1Hq1CMRuSB83HZj+oAlaRnY+KEFKeKxdXh854oeGH
         Z7o1B1SbI86pQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221224154152.43272-1-krzysztof.kozlowski@linaro.org>
References: <20221224154152.43272-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,videocc: correct clocks per variant
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Jan 2023 17:25:46 -0800
User-Agent: alot/0.10
Message-Id: <20230104012548.8CAECC433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-12-24 07:41:52)
> Different SoCs come with a bit different clock inputs:
>=20
>   sm8250-mtp.dtb: clock-controller@abf0000: clock-names:0: 'bi_tcxo' was =
expected
>   sm8250-mtp.dtb: clock-controller@abf0000: clock-names: ['iface', 'bi_tc=
xo', 'bi_tcxo_ao'] is too long
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
