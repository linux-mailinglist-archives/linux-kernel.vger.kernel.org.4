Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CCA6C3C14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCUUly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCUUlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:41:51 -0400
X-Greylist: delayed 172 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 13:41:49 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090693B862;
        Tue, 21 Mar 2023 13:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679431125; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NujyCUUEuZYxloUBc3+USyHsIS3soISUsO3rzdDli1eTo57fzs5H2Q5DTaheVRmbQ+
    MeXsTI8vTPoFULdX4Jr1tlfWEmAhwKG2R3O6k+vy3vBmxiP7Kq3LHQHc4tIHqEbyCL6s
    zfyy8sufSDgeQkiDlsgiUJrMUV+czOF8hFSLD44UP1X9zYMO6MrlezATksx8QTxy0d7L
    BvJAWI+BtvR+ZKyG7ol86MyhyeTnozmNB4enRz/MxfD9Rrz1QB2h2SNimkfkM12PoAZj
    XLnpFOgR1mgwvcvfGgT2fsVb88BjYt9JeZPDsppx2dNk1+f3QiTvNp6gzU++0xoJt9Xp
    /gPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679431125;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=VW2u1rxZfoleWEV+NDM3NNhETGJc+x24ln7uHM4gVmo=;
    b=QAbxCmqo6ImkJpNZASkcMeMh/d2A81Rllme5qKi6HX5lcsKl/eDL2wZWKetUj1KYSW
    b6qZfhcR6gKIdDp0to4O0iriv7d9VsC2KKsXyM1r3ohAd7qBRqa4IovB+XZ7e14Zms3g
    gYnnuAJapfv3n0w4GcnBRPWvtfLZye5p78TEcd7WI4NnieuDUkc9WNU1A+8MvN50Bc5a
    0+OHkAFK/9V8y99J/mHww41hmK6RR+aeWIEFgQ40HQnmFOWv16ncMhjps+VAtyeaCkjJ
    ff6NEVUUErUoofPpjvS7RIctHH4QcO3btlw8mO8i6d1pbCDnWJf45Qx72hsUsDSUbyLL
    w1Yw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679431125;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=VW2u1rxZfoleWEV+NDM3NNhETGJc+x24ln7uHM4gVmo=;
    b=a8lKhp9e0taDuFaMWWgfmLW9BKodlin2ndNX92KP3/U2IHdnH6Yv4q64SecgMFV30c
    nt3TwoGqY8Npisy+XS3rnUC0kjQ2L9tjxSsh+67li7Do0kI7lzfOkRQQx1eSqjmjQHyY
    dxScMuCZdICNHMsVk+eLhb64zrCjHSDHzbQH2MpmznmKRKyAGn6+CKSDf8NAl7QEtqC6
    KxTmBee8tvstUmR/FdVhngOHcviNIFxP4t0ZoNwOdu482/O2XW1ZcRN/yL5spAS4OteT
    tOU2a6SJWoXdMBH1VQk/BaWyAHdDDJlgIBFVjXOJPjQ8/KNzvTbFcLJ4aTFUvidEJE2j
    8jGg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKjXrKw7+KY="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id i40d22z2LKcjHBV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 21 Mar 2023 21:38:45 +0100 (CET)
Date:   Tue, 21 Mar 2023 21:38:36 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sm6115: Add Crypto Engine support
Message-ID: <ZBoVzFTr8LBWsmrX@gerhold.net>
References: <20230321190118.3327360-1-bhupesh.sharma@linaro.org>
 <20230321190118.3327360-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321190118.3327360-3-bhupesh.sharma@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:31:15AM +0530, Bhupesh Sharma wrote:
> Add crypto engine (CE) and CE BAM related nodes and definitions to
> 'sm6115.dtsi'.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index c56738633431..b2d2cdde41fa 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -664,6 +664,32 @@ usb_1_hsphy: phy@1613000 {
>  			status = "disabled";
>  		};
>  
> +		cryptobam: dma-controller@1b04000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0x0 0x01b04000 0x0 0x24000>;
> +			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;
> +			num-channels = <8>;
> +			qcom,num-ees = <2>;
> +			iommus = <&apps_smmu 0x84 0x11>,
> +				 <&apps_smmu 0x86 0x11>,
> +				 <&apps_smmu 0x94 0x11>,
> +				 <&apps_smmu 0x96 0x11>;
> +		};
> +
> +		crypto: crypto@1b3a000 {
> +			compatible = "qcom,sm6115-qce", "qcom,sm8150-qce", "qcom,qce";
> +			reg = <0x0 0x01b3a000 0x0 0x6000>;
> +			dmas = <&cryptobam 6>, <&cryptobam 7>;
> +			dma-names = "rx", "tx";
> +			iommus = <&apps_smmu 0x84 0x11>,
> +				 <&apps_smmu 0x86 0x11>,
> +				 <&apps_smmu 0x94 0x11>,
> +				 <&apps_smmu 0x96 0x11>;

If you apply the 0x11 mask to the stream ID then the last two items here
are identical to the first two (0x94 & ~0x11 = 0x84). Why are they
needed? They look redundant to me.

Thanks,
Stephan
