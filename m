Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54F270FDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbjEXSXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjEXSXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:23:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD2398;
        Wed, 24 May 2023 11:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684952583; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ob3b5pyUB/sVCDpeDAp5fvv4InkL31L0mFUlY+biIdMdNe/hZu6/GfaOdDLLVqoroU
    lAJLMzRoJqewgsfzX6YKxLfdefTALphvGBDFHPwPwqgisxqe7AL8QmOguhSO7Gc323UE
    A08eXy5pH6aQke93MPHWKVpyAzXRz+wjKsG//4yxWLUwiy/jAdlHyotf3S+CjvH+v4Ys
    5x3A7yrn4N3Wfgsjpz2Ns1T4jQw87Wekuj6UjTy78PGPq/60pBNVv7qfNhfoh9OXOutK
    J9+/+2DiSvGenSFRmyte7wWhigq6KeoaWPyM9GxVjpgriSE3GxPQYjW5yqME9zzERlZ8
    tuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684952583;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nzYxZfqmHZu3SMkFeRkte0uFwcfOH5DKN0TXvCovBVQ=;
    b=FXHitUZG1ABgi+2GACyDpZgZ4Yd/mJEkMnRIlpfM28+uju14ghUutapCxbOcKFdzSB
    Ct235Pq+9X9A9/ysCAF/+hEHpeUsID+JMu6+/ji1RVkp2/XBVZUAdfZmPpIMhLOcD2PM
    I5KbGMmBXceQ1CDgDqe7KphO5aCWRJBgYfl2bJXVQrQy9jlkIa4JxfPg39NgV79+xshT
    Hah9sXemZ354/68TI27OmzHOYxMoVhpiUSgMO9h95x6eON2Dk+ZxtzHCuw6MTZC0q6q1
    1WBNM29y+vZEBRrD37zTARCG00j6pLwxEz35tLwer0liHbOxvQU+4kny0WBBsHla18hE
    83Qw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684952583;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nzYxZfqmHZu3SMkFeRkte0uFwcfOH5DKN0TXvCovBVQ=;
    b=FAxfvv/TeGW16P5eCa74Wz6dDYpPUw/xRuU4ENBPNM5ksHknmgcFWFcNHoHW/004j0
    pJ25qXSumLLmnl9VWKhnDVbjkVAy+1epic8EU+gxZYJFOmlPIivw/gHxT0zgV5+AJMGa
    tyAceX5/4t98HYoEcWGQMqC8ks14BGmlDxO47Qu1fycOgmO9yDYFIh0x9CwKhrwzWt/T
    1jH2CWZgqhA46nVvioNZNJORhk9XuDod8cXqqExwhZ3L3tKkO30s/Z1ekRODNB1kMTLu
    ix2iyuYGzWpuQq41rznrpbWuE5p4vNtCGr/GZ518gWxB8V0+KEkcDv/yD/V3TlpVXNXx
    OMww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684952583;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nzYxZfqmHZu3SMkFeRkte0uFwcfOH5DKN0TXvCovBVQ=;
    b=cUG5TmSrmsgFIBqfSlw5if33jRV9c1CyOKl2GVK6PuOG77KDiLSyWWP7sCUll8BB1D
    hzTpKoki8Q5iuz6zG9Aw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4OIN3UKQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 24 May 2023 20:23:03 +0200 (CEST)
Date:   Wed, 24 May 2023 20:23:02 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org, djakov@kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH v7 07/11] arm64: dts: qcom: sm6115: Add Crypto Engine
 support
Message-ID: <ZG5WBr4gz2mzPoT-@gerhold.net>
References: <20230519214813.2593271-1-bhupesh.sharma@linaro.org>
 <20230519214813.2593271-8-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519214813.2593271-8-bhupesh.sharma@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 03:18:09AM +0530, Bhupesh Sharma wrote:
> Add crypto engine (CE) and CE BAM related nodes and definitions to
> 'sm6115.dtsi'.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 631ca327e064..27ff42cf6066 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -661,6 +661,31 @@ usb_hsphy: phy@1613000 {
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

I would also add the RPM_SMD_CE1_CLK clock here and then omit
"num-channels" and "qcom,num-ees" (with [1]). It's not strictly
necessary but will guarantee that the clock is running whenever the BAM
is accessed (potentially avoiding crashes). And it seems to be the
typical approach so far, see e.g. sdm845. RPMH_CE_CLK is used on both
&cryptobam and &crypto there.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?id=8975dd41a9dbca3b47f7b8dac5bc4dfb23011000

Thanks,
Stephan
