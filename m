Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D23A6017EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiJQTnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJQTnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA6C6C13F;
        Mon, 17 Oct 2022 12:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A65261115;
        Mon, 17 Oct 2022 19:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3D9C433B5;
        Mon, 17 Oct 2022 19:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666035784;
        bh=n095QUM32yGV7/WxVEM63IBGXkH2yt4iCeFWvWnyh/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ODQykXpGCGkTSWBl06LBYUDJ9erj3ihKMP7kcKEZjYqcB8CxDHX9mNTMOmSW95iHi
         0ZBsBJTCWVGtOy/7CYItg9ZNN/mhNdiuLf0sLbwYUIdKmsQ6o7JwxYQKjQkL6O2Fas
         2s65pLCr9ArIXrRjfn4iJrPPO/s174JOP7A9AwtWxcL1VHQeblIWJGSUOn5ILBxMit
         JdYyUJymTvYaJRoNfCkEKaZYfqmXZW1D5Ld9GLX6Ysa4foKrphEFXhkJU/Kxt2GYTg
         wYHt/sL9ZZvTlneHQ1fu8JLRIOs5UhBURilk5KJqgbA8SVGn6P8Mub+tfxoBv2IVM+
         ix32TYPvXlLgQ==
Received: by mail-ua1-f54.google.com with SMTP id a8so4742987uaj.11;
        Mon, 17 Oct 2022 12:43:04 -0700 (PDT)
X-Gm-Message-State: ACrzQf0i3OySMV+0IbfnV9/k+mPJzegvH2i3P2UE3bU6v0nEbg7UYZQp
        2T2vsYm+cVIYnNALgmmsuLN41yEb5LSfxOx5lQ==
X-Google-Smtp-Source: AMsMyM70J0qcoiNFxfOzn0NN3VOF8OIJ2jal6FXY3SP32oK2PlQZ4Dm5jAoTAbPrEmBC8S8VKUKiecIgKGWakOZG7Qc=
X-Received: by 2002:ab0:66d0:0:b0:3d5:dd1e:8e3b with SMTP id
 d16-20020ab066d0000000b003d5dd1e8e3bmr5350546uaq.86.1666035783434; Mon, 17
 Oct 2022 12:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221017185105.2279129-1-caleb.connolly@linaro.org>
In-Reply-To: <20221017185105.2279129-1-caleb.connolly@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 Oct 2022 14:42:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLPMCyo5paKYdDu2KRFs9UueuJXigey7ScWgap1AJOJ=Q@mail.gmail.com>
Message-ID: <CAL_JsqLPMCyo5paKYdDu2KRFs9UueuJXigey7ScWgap1AJOJ=Q@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: qcom,spmi-pmic: document rradc node
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 1:52 PM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> Document the rradc node name, like adc-tm it's only used on a few
> platforms, so differentiate it from the standard adc node.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>
> V1: https://lore.kernel.org/linux-arm-msm/20221016175757.1911016-1-caleb.connolly@linaro.org/
> Changes since v1:
>  * Add a new node instead of using the adc@ node
>  * no longer depend on Luca's patch
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Doesn't apply to rc1.

Rob
