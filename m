Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B67619FA0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKDSTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E5810C;
        Fri,  4 Nov 2022 11:19:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3381622F5;
        Fri,  4 Nov 2022 18:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516D9C433D6;
        Fri,  4 Nov 2022 18:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667585969;
        bh=/6OsB+dulhFB3yptmo8kWwGfCbQ1YEZqND5NzVSg734=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JsZ1QyZSeCbcnbgjmInbEzZEbOIk5dFpLiZkU4RnadTE2skdIrObaWl2OexGKHDOz
         UUDCx/xZX1yQg7yxrtsBGijseeGswW2UINETehPEINvNfZ/05f4ourdMj9Picy/u8S
         y4wA/e6ZxZvmw1kZ2cp13NQPG8YUGGICOk5b95q43I5sJe62w/P3yL/vxSWZ0/Jde8
         PUi7pV0iOr6gkPXswhWYSdNZyjnKID4AiI7oQr8td5Ugk6qbrefO3AEEUhsYjxNu9o
         jYV0sR+haLiKzNuEC9uz87go4WNjCi8ZNkLtNHZgC21jZfXxhiYSvpjaiZ8hJAEic0
         FqYzmzUP50Erg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221104174656.123979-3-krzysztof.kozlowski@linaro.org>
References: <20221104174656.123979-1-krzysztof.kozlowski@linaro.org> <20221104174656.123979-3-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 3/3] dt-bindings: clock: qcom,audiocc-sm8250: add missing audio clock
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
Date:   Fri, 04 Nov 2022 11:19:27 -0700
User-Agent: alot/0.10
Message-Id: <20221104181929.516D9C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-11-04 10:46:56)
> The SM8250 DTS uses three clocks as input to LPASS AudioClock Controller
> (althopugh Linux driver seems not needing it), so document the missing
> audio voting clock.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
