Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1835F328E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJCPeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJCPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:34:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AD81F9D1;
        Mon,  3 Oct 2022 08:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC45CB81189;
        Mon,  3 Oct 2022 15:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9772BC433D7;
        Mon,  3 Oct 2022 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664811253;
        bh=M5rK9JeEdAPZUW077j6m2FsoSTU3aiXVy6fJVfF+n08=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JB00gpG/jxWtyXAQeF6Wqm+2YMVCMIeOMtH3D3j+zVMgsTKwg9X3eWXh2IftWF94d
         gw6M4HfsUtxE40BnhX7u78XHMbiERtoJYCaqwGUkuMeHAjxrBtoWsyU2b8rdoKQAIg
         c2GPvQZULrTyQnPKw0v3r2EZNglInQJofry6B6fGEsktFRWi3jUPwLHlYDXQdG6+XH
         gqujZiU51IRbjAyVTZffB4PVnOct2fSVsyctJEyefvsTJ7bw2rBl+/rAwgcy91DkRK
         MzRS+SaHyT/HvKZTpjgEpq0qL/bj0VLc7p5imRPGsf53m0fyuXwhe0a+Ny/upXe83f
         BNbbW8q5Vjr4g==
Received: by mail-ua1-f44.google.com with SMTP id y20so4259769uao.8;
        Mon, 03 Oct 2022 08:34:13 -0700 (PDT)
X-Gm-Message-State: ACrzQf0S6B+6V3dXUUpBwQEMBOd+Qj48x1Rof3H7lZRd5j8l8Cj7M864
        Kg+OdhYzm4lnzrpsiu8rj4jOrJ+FEkAJLcEI/A==
X-Google-Smtp-Source: AMsMyM5DBBVN3TggQcCyQRXdPbWl3J1CRWQWF3vq1uFNYZGTqs+7Y11WnvBixBWk9gQY9wmYo5yA1LcGFHjWhvIMbiU=
X-Received: by 2002:ab0:70c8:0:b0:39f:7528:6289 with SMTP id
 r8-20020ab070c8000000b0039f75286289mr9473759ual.36.1664811252539; Mon, 03 Oct
 2022 08:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <9dda705a8d67826306f6c6129722d3ad8edc96fc.1664816175.git.chiaen_wu@richtek.com>
In-Reply-To: <9dda705a8d67826306f6c6129722d3ad8edc96fc.1664816175.git.chiaen_wu@richtek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 3 Oct 2022 10:34:01 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+YeZRizJFYuU7RPTcFRe1cDjLgsTidisJ_P5PNC4eKiw@mail.gmail.com>
Message-ID: <CAL_Jsq+YeZRizJFYuU7RPTcFRe1cDjLgsTidisJ_P5PNC4eKiw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: mt6370: fix the interrupt order of
 the charger in the example
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        matthias.bgg@gmail.com, sre@kernel.org, chiaen_wu@richtek.com,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 3, 2022 at 4:05 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> Fix the interrupt order of the charger in the binding example.
>
> Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>
> v2
> - Revise the commit syntax.
>
> v1
> - Due to this patch modifiacation
>   (https://lore.kernel.org/all/20221001202918.me7z2qzm7cmrkzsg@mercury.elektranox.org/),
>   there will get some warnings in linux-next when compiling the dts.

This doesn't fix all the warnings. These still remain:

/home/rob/proj/linux-dt/.build-arm64/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
pmic@34: indicator: 'color' is a required property
        From schema:
/home/rob/proj/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/home/rob/proj/linux-dt/.build-arm64/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
indicator: $nodename:0: 'indicator' does not match
'^multi-led(@[0-9a-f])?$'
        From schema:
/home/rob/proj/linux-dt/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
