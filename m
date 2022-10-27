Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D45610022
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiJ0SZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiJ0SYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:24:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB4831DED;
        Thu, 27 Oct 2022 11:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBCCDB82752;
        Thu, 27 Oct 2022 18:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366AEC433D6;
        Thu, 27 Oct 2022 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666895089;
        bh=59Pw40a4Cn+LbgrGbl89Wp804IafCpdymwLTbzmtb8Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PwetMeddijuZSfdb3qiz+ALrl6FPHsc1Ei/dIxhQiaQxHCeRRdYV9+Hpiq/qZghfF
         jcYKLCDWLeYWlzaMjMRMc116RahtvDMmn5AHskY8stRDqNNPRWHfFUtbG7G+iYCglM
         VtMEI+FWgRCBrujaz+mRJPPa5t7E8pEFJJ2ihiJHqKn42Gk19m82BVaHCAjypsdDeY
         e7CNhKZU/TtBq5flOmTRUm9xNx/38qUmYnMjpWYMBeryAUNHDynM25IGSn4fQk5pmA
         VTkcAcoCRwM+2vKazzC52qq71AmrnfB8Oc6KgA+ayo4fhRabQkyDPrEjTbLBkActAQ
         huWBKCeodfluA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e5009a33-1f71-1fe3-3a06-98bba031fdf0@linaro.org>
References: <20221026190441.4002212-1-quic_molvera@quicinc.com> <20221026190441.4002212-2-quic_molvera@quicinc.com> <e5009a33-1f71-1fe3-3a06-98bba031fdf0@linaro.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: clock: Add QDU1000 and QRU1000 GCC clock bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Thu, 27 Oct 2022 11:24:45 -0700
User-Agent: alot/0.10
Message-Id: <20221027182449.366AEC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-10-27 08:54:51)
> On 26/10/2022 15:04, Melody Olvera wrote:
> > +description: |
> > +  Qualcomm global clock control module which supports the clocks, rese=
ts and
> > +  power domains on QDU1000 and QRU1000
> > +
> > +  See also:
> > +  - include/dt-bindings/clock/qcom,gcc-qdu1000.h
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: qcom,gcc-qdu1000
> > +      - const: syscon
> > +
> > +  clocks:
> > +    items:
> > +      - description: Board XO source
> > +      - description: Sleep clock source
> > +      - description: PCIE 0 Pipe clock source
> > +      - description: PCIE 0 Phy Auxiliary clock source
> > +      - description: USB3 Phy wrapper pipe clock source
> > +    minItems: 2
>=20
> Why the clocks are optional?

They should not be optional. They're always there.
