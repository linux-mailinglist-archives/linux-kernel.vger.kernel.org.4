Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1BE6028C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJRJwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJRJwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:52:17 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E902B60D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:52:15 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-35711e5a5ceso131653517b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7yT/863oLdP/+cPaioe/H9gJ2n+mzUsmGJInpfD0fWA=;
        b=vgQUqOGz2jsZ1Ag97hWYKCqaEcyyNysPZOI/dRfJ6TrFps4rny0kAaSp79BDqTodui
         GqepNKcbusjizNFym7FPoWggZhW/DXDilRob9n6dfXJWQr0aKOrpHHBtF6EY71NEHbNB
         9p2MKHDAFw+bVxjQiWHj9HQeMUtSx0mmgC32CoXFPkOadxmdWhh3Xjh+0+RZuxyZN3Jp
         8pCbk0zwZa6/vcz2aOjNaLOqQTH7JUkinENSvYvu9NUkGRAsyHtvuG3FhW11A7+Hy1ko
         JP8+a0iJ7duSX80en8/l3HAFG68od9T78qQlnOANWJBLsyLwMKAJbnha8sQHnh7fsYD2
         Q7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yT/863oLdP/+cPaioe/H9gJ2n+mzUsmGJInpfD0fWA=;
        b=dPpTaNwu3b3f1Ade/IRJQd+Y3splZaKImkrPHrmN62hS4ropl8NBF8c6YjxF/dGezA
         sk7U5b4bDH5TzFD1YxypI9zjBL/nZHuuJ66SpITxjM57OLzg75NmbcPvDqCppyelQmlD
         FfsSWNc1rLq7uyamjL1tFLK0n14G6WkPNVYGcj1kluQbBWEfhhnNuLo0FRH2HJSP4+WO
         8GrE788xVTCA5GfdavtAk+RauE5uHmdfzoS1Cfdrf6OkWBJRLO3UUQnQon6lGDT5CY5z
         7hRSxKGTpFnS0QdZ7Ik3zDlQA+SYFQCboYF+NnTvBUkiRuDRazOtcFsudM8tB+2hkz7c
         EWSA==
X-Gm-Message-State: ACrzQf0U4sBxWJkbck0dhcJsFdfKC8AguM3hmNzWdkbLlKcWIhJKBAdx
        jtB0xKQyPQ8241cPyrk2cqtpm/nB3C2v5wCLSVJHhA==
X-Google-Smtp-Source: AMsMyM6aPRNFAUBNNYnUq9oUumpIVdp0vVrV7sCWZbLJfXnCM9jZHBb03NZGJGCh+XUEttlKgdFEbSyv3DhMosN/ToA=
X-Received: by 2002:a0d:d806:0:b0:355:ea3e:cf69 with SMTP id
 a6-20020a0dd806000000b00355ea3ecf69mr1712464ywe.127.1666086735044; Tue, 18
 Oct 2022 02:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221017145328.22090-1-johan+linaro@kernel.org> <20221017145328.22090-10-johan+linaro@kernel.org>
In-Reply-To: <20221017145328.22090-10-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 18 Oct 2022 12:52:03 +0300
Message-ID: <CAA8EJpqSWmy5Z4cmJnsdjMjkmACW7HSi-k5JxZ0gLCeUAWEnxQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] dt-bindings: phy: qcom,qmp-pcie: mark current
 bindings as legacy
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Oct 2022 at 17:54, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> The current QMP PCIe PHY bindings are based on the original MSM8996
> binding which provided multiple PHYs per IP block and these in turn were
> described by child nodes.
>
> Later QMP PCIe PHY blocks only provide a single PHY and the remnant
> child node does not really reflect the hardware.
>
> The original MSM8996 binding also ended up describing the individual
> register blocks as belonging to either the wrapper node or the PHY child
> nodes.
>
> This is an unnecessary level of detail which has lead to problems when
> later IP blocks using different register layouts have been forced to fit
> the original mould rather than updating the binding. The bindings are
> arguable also incomplete as they only the describe register blocks used
> by the current Linux drivers (e.g. does not include the per lane PCS
> registers).

I'd like to point out that it's not only a problem peculiar to the
PCIe PHYs. Other QMP PHY families also follow the same approach of
separating the serdes into the common part and rx/tx/PCS/whatever into
the PHY subnodes.
For the USB+DP combo PHYs we have to have subnodes, however it would
also be logical to move serdes register to the subnode devices,
leaving only DP_COM in the base node.

That said, I think we should rethink and agree on QMP PHY bindings,
before renaming the bindings. And yes, I think we should also upgrade
older DTs, keeping drivers backwards compatible (for some time?).

> In preparation for adding new bindings for SC8280XP which further
> bindings can be based on, mark the current bindings as "legacy".
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../{qcom,qmp-pcie-phy.yaml => qcom,qmp-pcie-phy-legacy.yaml} | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/phy/{qcom,qmp-pcie-phy.yaml => qcom,qmp-pcie-phy-legacy.yaml} (98%)

-- 
With best wishes
Dmitry
