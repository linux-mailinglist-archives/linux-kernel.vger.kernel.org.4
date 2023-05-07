Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122946F9B6C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjEGUUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGUT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:19:59 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2C730D1;
        Sun,  7 May 2023 13:19:57 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7704ECC041;
        Sun,  7 May 2023 20:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683490765; bh=AX9HZSkrrmpr541NbbpC609XGs14X7Mlq3WHac5Hjsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=t+6oS0RBEeTF1Gc+okfqVLfqmauivNpXcMN/dBfln+/jvHBTUSpINg3E4ObQXGBb8
         bWC4G0BO1x1KHrr9O70dCzZzWdVNz8mvCnLNlRsh2jd7FXKdWpnhKtaVAsRmC0T+Yl
         ySQxMlp9ir3hhLJV+6NfHsoayzByYlh7X594xnSE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: qfprom: Add compatible for MSM8226
Date:   Sun, 07 May 2023 22:19:24 +0200
Message-ID: <3040398.mvXUDI8C0e@z3ntu.xyz>
In-Reply-To: <20230507201225.89694-2-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-2-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 7. Mai 2023 22:12:19 CEST Matti Lehtim=E4ki wrote:
> Document QFPROM compatible for MSM8226.
>=20
> Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml index
> 2173fe82317d..0baf7819ab46 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> @@ -20,6 +20,7 @@ properties:
>            - qcom,apq8084-qfprom
>            - qcom,ipq8064-qfprom
>            - qcom,ipq8074-qfprom
> +          - qcom,msm8226-qfprom
>            - qcom,msm8916-qfprom
>            - qcom,msm8974-qfprom
>            - qcom,msm8976-qfprom




