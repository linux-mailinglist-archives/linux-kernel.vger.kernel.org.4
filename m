Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717A7641C86
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiLDLCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiLDLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:02:28 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7074918355
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 03:02:27 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3bfd998fa53so91801507b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 03:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sly9FFV6PPdwjKHhbkXSdTXIAxVTK0QYG6mKZfA1Zqc=;
        b=rrHzxjgTXU/75BgotShC4PQNrhSA+9P1lyg+8Net3xvq1Qfsa/r3GelchbciY/fPVw
         6EIThnqcSMbi+KFpMotEOBiohKdvdl7lrL1+2M5jZ9KPn561YVLJSHPIU5QH/D3klOOw
         +BM7d24MZ4on8PAZQ0USBRMDeFhkWDUoJREOxAkCKenwt3AZ5vhyl2B+7LSTLOx76HgZ
         6kKiZFJfYKkMzeTGLA3PG5NAlRHbDKwTkl9JIXMdBFaQ+QdJv+U9J7kxofdascjTw+be
         AlXANjiWSlDEymM5g4TJMG7829Girpkbz8eKQPl0xeWV76jGji9QRfgKd5y8YLx4quvp
         z7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sly9FFV6PPdwjKHhbkXSdTXIAxVTK0QYG6mKZfA1Zqc=;
        b=zEPBBg/FYqDXzv/2OxK31HOLxCwDzO9W5Qpe/WWgn3MbBqbZTQAa/Jzgn6t2T4DPET
         zVMXhnMQGMX9YwIlZWkBo7fg9esNO/sDZvW74kEBQHvGBE1ZL5dZhBaC+9LDYx7OeGYo
         oYl8XeqlKQ0rQBDlhoch1UUUUaVwj5T5D+ERtwHKLT4TKPr/YZdQLaFXsjRtvNzsKpFV
         4tLhBNXRp94MXFasAGzZZEeKoxGxdIMtrnqugxnnHQ60cc0N/+UQ3AiQwxfW1SP8m5aB
         mNN4mh7NvrgTqS6QD2KijykXiskBai74l2eNIjSP5x/8FdfbjTo7/4HTqFoiu0SSY/B4
         6DyQ==
X-Gm-Message-State: ANoB5pkYVmXQOt8HJYlVUmH1L4FSDwYzQscNgHgZ6JlQa8dTRNKBB0va
        di5fjC2ry1aOOl8Z9o7uNMXom6D3Bt1/CA/VlxQb2Q==
X-Google-Smtp-Source: AA0mqf5y2GGWzumv7cs86yLEX/YNbggh57hMnSI74C/hc0MITQKA0Wnq5A2wj8x3Z1raSFDPq8dbZ5+QpeEH879r3s4=
X-Received: by 2002:a81:6704:0:b0:3d2:61bc:e6a with SMTP id
 b4-20020a816704000000b003d261bc0e6amr22543662ywc.132.1670151746671; Sun, 04
 Dec 2022 03:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org> <20221204094438.73288-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221204094438.73288-5-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 4 Dec 2022 13:02:16 +0200
Message-ID: <CAA8EJpoWu=gKnYz91KDf9pgCcAGSaNznCYjubQ4ZfATgvWNC9A@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sdm845-sony-xperia-tama: fix no-mmc
 property for SDHCI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2022 at 11:44, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> There is no "no-emmc" property, so intention for SD/SDIO only nodes was
> to use "no-mmc":
>
>   qcom/sdm845-sony-xperia-tama-akatsuki.dtb: mmc@8804000: Unevaluated properties are not allowed ('no-emmc' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
