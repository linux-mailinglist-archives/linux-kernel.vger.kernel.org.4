Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E8B70FD94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbjEXSPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjEXSPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:15:00 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8737798;
        Wed, 24 May 2023 11:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684952085; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Bi+o9EhqUBz+vngYotyvibyzjoU5I0xOePtrwM/AbFH0OVmr6UqXFWM4OleDSBtfyw
    Wty1QmVi5ZwsApOg0c4k9Wn9FECPB1B9Nau4rVDrI41Kv1kLqi81qrOxn2E85WrGtuQI
    20HE1hCJohJaWkL3H3vMozZYIxxlJXQQINUuNvznKoY5FCCP7O8kSTMZgpHEprKfA3mm
    +WKRSQE0u2GmDVoF9zHUAyXqqNUyoCkTWG0fE0qUBa0XcGhrMtxVOOTnrfokzJQJb1ad
    WIi4ma7Gb/TvTmuYZ4bPrflMspiEoa9XvRgS2XrBTHICNqMgKZVJ6ot/+jA7Q8UZV6yv
    ePOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684952085;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ebMjJAQLyC7d5uZBcrDbK4kzzjssGBQJQs+ymJkCW0o=;
    b=PY6chqOzsqwO9h8bnO+gFbOB3sYwqDA4SnMqy6NFcP0So1544F1s8S0NlLli4G+jWu
    8Tp9Ivp5c7SW6OmMhHzyxd92k60g2kYVn4mmkRbU/cwZLDFA9LpAxP+MNK0dlWN40RcT
    z7LOcxU1UhIKK7Nqi8j01QPnucoHY7iVoVREHWfygmcYTouFue1817dFSSQZRoJOQmhr
    qu/OauQrfzs+TKP4LDP8Kc9rM+4w96LyOeaRZ77YaQjqDzAmMShQpuqmAe5TeAz3FHq8
    6Ukp7ItOCrtYN87M3Q6SZZg9e4bkVtA/AUUqqbm88/d+PDgjatEes2nfsxhyvaaC0AnK
    +xOg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684952085;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ebMjJAQLyC7d5uZBcrDbK4kzzjssGBQJQs+ymJkCW0o=;
    b=gCipYpstZUxMWzmMtbzfYywFa0p7z1r/hLWElZmhBqoH9+xnxOTnGvbmrbebQzF8ku
    VIjTS6HDXMz3SAmBjT5fF9LIMA3k/gRZo/ldHkuFTwLIT7LTfITIRWn3lbX0bqkYS3s0
    oIcfDvImfnwBYQVRCHshRNKgQCUE9BCJdUr9iZKOjRhJSyJDSVbzmymbBxphmIjWA+O2
    HONv+hCrCLSoPUo//JxfIQmNYV8ctMEhamOikibbJ46l9r9LxAuef1VqVmQpNVV7DwSc
    WQyYns8TYpLLdzFc3OQjRoGsJKcGnncsPBDHA10k2zh6wWOMJvX9BP8+kgNlmnn3smjL
    1wKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684952085;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ebMjJAQLyC7d5uZBcrDbK4kzzjssGBQJQs+ymJkCW0o=;
    b=AcHTJRa7hcIGqmJtHAZLEtrKxDeYEgt/omI4t5D46LvbJmpSYt2Nj3nt9uSiaXMA9H
    2QTiM4FiZxIrQWWnibDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4OIEiUJW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 24 May 2023 20:14:44 +0200 (CEST)
Date:   Wed, 24 May 2023 20:14:37 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8953: Add BLSP DMAs for I2C
Message-ID: <ZG5UDYXLkfRK0dTy@gerhold.net>
References: <20230422-msm8953-blsp-dma-v2-1-076134481b1b@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422-msm8953-blsp-dma-v2-1-076134481b1b@z3ntu.xyz>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 10:36:49PM +0200, Luca Weiss wrote:
> MSM8953 has two DMA controllers for the various I2C, SPI and UART
> busses. Add the nodes and configure all the I2C nodes so that the driver
> can use the DMA.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v2:
> - Fix subject line, add "msm8953" (thanks Alexey)
> - Pick up tags
> - Link to v1: https://lore.kernel.org/r/20230422-msm8953-blsp-dma-v1-1-0024801bb587@z3ntu.xyz
> ---
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 48 +++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 602cb188a635..c9b589353918 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -1274,6 +1274,19 @@ opp-200000000 {
>  			};
>  		};
>  
> +		blsp1_dma: dma-controller@7884000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x07884000 0x1f000>;
> +			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			num-channels = <12>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,num-ees = <4>;

You can omit num-channels/qcom,num-ees here if you have a clock.

"dmaengine: qcom: bam_dma: allow omitting num-{channels,ees}" [1] helps
with doing this, although it also works without the patch. (The patch
just avoids a non-critical error in dmesg...)

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?id=8975dd41a9dbca3b47f7b8dac5bc4dfb23011000

> +		blsp2_dma: dma-controller@7ac4000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x07ac4000 0x1f000>;
> +			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			num-channels = <12>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,num-ees = <4>;

Same here.

Thanks,
Stephan
