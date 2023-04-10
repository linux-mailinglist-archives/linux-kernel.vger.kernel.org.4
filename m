Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33E26DCB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjDJTcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjDJTcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3CB1BC8;
        Mon, 10 Apr 2023 12:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F2A8617BC;
        Mon, 10 Apr 2023 19:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA70C4339B;
        Mon, 10 Apr 2023 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681155120;
        bh=RuJg2qNfDloS0SyYVWeynpsl+tqf76ntUxl/yumbHG4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nRbTM89s6sCipXKJYLD+60FifraXFcHoaBrLZsL9ncNdW2ycqRFey4LohnlzltJNk
         gujrKd0h96tvITxU7IDFTpaPmYt8pgNK7E2e+Yk7hUYIy0qtGM649U5ty1FONktl2j
         Xt5OEXFhkNzkfk4PX4Kcufq/MX5IgcKYx+XqrRRyo2Bp536jMFn1L9fzcBb2y8yP9z
         eqwFVjk9L7dQHW6VTl7u5pbtJLBnMJCQxoS7S8vt1iVv+J+ELD4meRzrzgW+eQL+Rd
         o9Vkxpb/lkY3Yiqjchzs07TtELLzDk0/bIHfruVQW2iyBge9nlA5x+YvcJdiogapoV
         g7NjaeMgk2xJQ==
Message-ID: <6b765034ee5245e81cd8e735a7b2d5be.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230406061314.10916-3-quic_devipriy@quicinc.com>
References: <20230406061314.10916-1-quic_devipriy@quicinc.com> <20230406061314.10916-3-quic_devipriy@quicinc.com>
Subject: Re: [PATCH V3 2/5] clk: qcom: apss-ipq-pll: Add support for IPQ9574
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_ipkumar@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, arnd@arndb.de, broonie@kernel.org,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, geert+renesas@glider.be,
        jassisinghbrar@gmail.com, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        nfraprado@collabora.com, rafal@milecki.pl, robh+dt@kernel.org,
        will@kernel.org
Date:   Mon, 10 Apr 2023 12:31:58 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Devi Priya (2023-04-05 23:13:11)
> Add the compatible and configuration values for A73 Huayra PLL found
> on IPQ9574.
>=20
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
