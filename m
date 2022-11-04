Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A40619F9C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiKDSSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKDSSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:18:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87BB4B9A9;
        Fri,  4 Nov 2022 11:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8333EB82F48;
        Fri,  4 Nov 2022 18:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A72CC4314A;
        Fri,  4 Nov 2022 18:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667585895;
        bh=rmlpo4V+o9JECY1YPr/Sdhc7t7BtNEUDMAGqnaqupkI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=meQAukODvG7lwuT6RqlFbHvdRRPad51+euOit6h+RjmbQmDoDIzzLQv9AqUMqPy3e
         BCUD0FZnJ7xeHmQ35LeWaoLkx1TWSc0kKsXIK6coUtn6tBR30S7XCMnS2e83qYMyGR
         ZQHFskSNdzqoe8dSobGH3pHv/p0yZ73QwDrF+mz+c/Mxd0H3jSQ8QbYn0aLGMe2KsJ
         97w7IwGzwt98FbGKYSFSv+HiVYYLGhzBRB33dbUFtOit+9/8zh7DRYLAfZM5mieB8s
         HeREfxsqzbUWYv8R5tD5GomTW0L6XRcWhWCI9wNcU+RRB7leUxCTKdA6jccoFQCK7p
         0GnoAU6EinCMg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221104174656.123979-2-krzysztof.kozlowski@linaro.org>
References: <20221104174656.123979-1-krzysztof.kozlowski@linaro.org> <20221104174656.123979-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: clock: qcom,aoncc-sm8250: add missing audio clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Nov 2022 11:18:13 -0700
User-Agent: alot/0.10
Message-Id: <20221104181815.2A72CC4314A@smtp.kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-11-04 10:46:55)
> The SM8250 DTS uses three clocks as input to LPASS AON Clock Controller
> (althopugh Linux driver seems not needing it), so document the missing
> audio voting clock.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
