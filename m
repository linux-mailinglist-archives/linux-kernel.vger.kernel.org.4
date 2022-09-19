Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC745BD6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiISWMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:12:20 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76B4BA76
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:12:19 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id m65so1117425vsc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pH/9X2sRKKBPpBLTdOayF968gUuVS/TRh7dN+A799UA=;
        b=Vf5GaYOHcNeaYMuOePZL9rw1qmAAknaSq2ekf6UnxaRlFFHmbayoBr0+SIJBQrRCUs
         oeUqvtPCeLFxoynXoyaI6imKHRAynRwvy4RKKXDcAUx3W71b53yc9cmCKgz8Smo7Zlqh
         s7bdFB3irK9RfPQLlwkZY1DVScUEF8hulhm2mQQbcA9K71kb5KBgSnNcXYphYUBpCH4f
         lBmqeHRH1K1w2A/LDZQ/B7V2aDrpZ14LMh2bW8qz1KtP3rJ7IIiJBOIQHrOdc5+ALwsl
         9V/3Qua17ERCjA4kdoSbl17Xu+JzOU+6Mnh6MuqJ7L8QcYDT92fDZ+tEVkDTR9CptspQ
         9S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pH/9X2sRKKBPpBLTdOayF968gUuVS/TRh7dN+A799UA=;
        b=XxkJicLdSU3cPC7IiZ+wpIeGEqqkve0FPkwwrfABPUI0zbbNHuVb9yyqt+F6vBM2NM
         rsSdeBHlV0K4VPz3u8F1VDZeBq1Taa28LYYSOtpEfXFoKu/s3ukbB3ElB6Ma+Z1NEhJK
         F5kv6kNk+PLOhXIGVaJmff2+osrlfxuNXJe7fHHe85QrSETkvd5vcb/Azvfh1SZ6GPtB
         dVRoo7mp49KXH5bLXZGvykZtNXccTqVPM3hqaUtM6muiYY0iw+wqAEj/cVj0D+0cHEXA
         votd2DQ1rdLgcdV1KIkL74Qwx4J2FPyynlJe/tlWznIU0zBfDsgmn76ixeMLubccRx43
         lVZg==
X-Gm-Message-State: ACrzQf2J0p/wuuV6lYuYtsFlw+Sjax6h2ywLnLUvENlBGY2rGcMf/Ucc
        zUsLywXMHXyGg5CX2900qlM16vDluxe3sYIZOM149A==
X-Google-Smtp-Source: AMsMyM6i8LnjnTPuCG7snzL9fi65JARP3hLZL4P61QfHnx6EjZm4k70znzTyfaSKJ0YEy/5I6IvAbBKvgOEHZ11LXZM=
X-Received: by 2002:a67:e197:0:b0:398:16c1:430a with SMTP id
 e23-20020a67e197000000b0039816c1430amr3062996vsl.62.1663625538150; Mon, 19
 Sep 2022 15:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
In-Reply-To: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 20 Sep 2022 03:41:57 +0530
Message-ID: <CAH=2NtwGT7zDqjcbmgFD8u1u2J749vyRLX7RE9Zv_NwSBVZvuQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] dt-bindings: qcom-qce: Convert bindings to yaml &
 related changes
To:     linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, Jordan Crouse <jorcrous@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sept 2022 at 03:38, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Changes since v5:
> =================
> - v5 can be seen here: https://lore.kernel.org/lkml/20211110105922.217895-1-bhupesh.sharma@linaro.org/
> - As per Bjorn's suggestion on irc, broke down the patchset into 4
>   separate patchsets, one each for the following areas to allow easier
>   review and handling from the respective maintainer(s):
>         'arm-msm', 'crypto', 'dma' and 'devicetree'
>   This patchset is directed for the 'arm-msm' tree / area.
> - Addressed Rob's, Vladimir's and Bjorn's review comments on v5.
> - Added Tested-by from Jordan received on the v5.
> - Also added a 'defconfig' change where I enabled the QCE block as a module.
>
> Changes since v4:
> =================
> - v4 for sm8250 can be seen here: https://lore.kernel.org/linux-arm-msm/20211013105541.68045-1-bhupesh.sharma@linaro.org/
> - v1 for sm8150 qce enablement can be seen here: https://lore.kernel.org/linux-arm-msm/20211013165823.88123-1-bhupesh.sharma@linaro.org/
> - Merged the sm8150 and sm8250 enablement patches in the same patchset,
>   as per suggestions from Bjorn.
> - Dropped a couple of patches from v4, as these have been picked by
>   Bjorn already via his tree.
> - Addressed review comments from Vladimir, Thara and Rob.
> - Collect Reviewed-by from Rob and Thara on some of the patches from the
>   v4 patchset.
>
> Changes since v3:
> =================
> - v3 can be seen here: https://lore.kernel.org/linux-arm-msm/20210519143700.27392-1-bhupesh.sharma@linaro.org/
> - Dropped a couple of patches from v3, on basis of the review comments:
>    ~ [PATCH 13/17] crypto: qce: core: Make clocks optional
>    ~ [PATCH 15/17] crypto: qce: Convert the device found dev_dbg() to dev_info()
> - Addressed review comments from Thara, Rob and Stephan Gerhold.
> - Collect Reviewed-by from Rob and Thara on some of the patches from the
>   v3 patchset.
>
> Changes since v2:
> =================
> - v2 can be seen here: https://lore.kernel.org/dmaengine/20210505213731.538612-1-bhupesh.sharma@linaro.org/
> - Drop a couple of patches from v1, which tried to address the defered
>   probing of qce driver in case bam dma driver is not yet probed.
>   Replace it instead with a single (simpler) patch [PATCH 16/17].
> - Convert bam dma and qce crypto dt-bindings to YAML.
> - Addressed review comments from Thara, Bjorn, Vinod and Rob.
>
> Changes since v1:
> =================
> - v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20210310052503.3618486-1-bhupesh.sharma@linaro.org/
> - v1 did not work well as reported earlier by Dmitry, so v2 contains the following
>   changes/fixes:
>   ~ Enable the interconnect path b/w BAM DMA and main memory first
>     before trying to access the BAM DMA registers.
>   ~ Enable the interconnect path b/w qce crytpo and main memory first
>     before trying to access the qce crypto registers.
>   ~ Make sure to document the required and optional properties for both
>     BAM DMA and qce crypto drivers.
>   ~ Add a few debug related print messages in case the qce crypto driver
>     passes or fails to probe.
>   ~ Convert the qce crypto driver probe to a defered one in case the BAM DMA
>     or the interconnect driver(s) (needed on specific Qualcomm parts) are not
>     yet probed.
>
> Qualcomm crypto engine (qce) is available on several Snapdragon SoCs.
> The qce block supports hardware accelerated algorithms for encryption
> and authentication. It also provides support for aes, des, 3des
> encryption algorithms and sha1, sha256, hmac(sha1), hmac(sha256)
> authentication algorithms.
>
> Note that this patchset is dependent on the dt-bindings patchset (see [1]) sent to devicetree list.
>
> [1]. https://lore.kernel.org/linux-arm-msm/20220919195618.926227-1-bhupesh.sharma@linaro.org/
>
> Cc: thara.gopinath@gmail.com
> Cc: robh@kernel.org
> Cc: andersson@kernel.org
> Tested-by: Jordan Crouse <jorcrous@amazon.com>
>
> Bhupesh Sharma (4):
>   ARM: dts: qcom: Use new compatibles for crypto nodes
>   arm64: dts: qcom: sm8250: Add dt entries to support crypto engine.
>   arm64: dts: qcom: sm8150: Add dt entries to support crypto engine.
>   arm64: defconfig: Enable Qualcomm QCE crypto
>
>  arch/arm/boot/dts/qcom-ipq4019.dtsi   |  2 +-
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi |  2 +-
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi |  2 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi |  2 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi  |  2 +-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi  | 28 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8250.dtsi  | 28 +++++++++++++++++++++++++++
>  arch/arm64/configs/defconfig          |  1 +
>  8 files changed, 62 insertions(+), 5 deletions(-)
>
> --
> 2.37.1

Please ignore this patchset as I made some typos in the cover-letter
while sending it out. I will send a revised version shortly.

Thanks,
Bhupesh
