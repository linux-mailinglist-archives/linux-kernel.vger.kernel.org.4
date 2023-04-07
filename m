Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0416DAC42
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjDGLhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjDGLhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:37:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D766561BA;
        Fri,  7 Apr 2023 04:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680867426; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ogRunCNgf+X6hfZj9vHay1N/BYg+q+7s/1dfjsC+8RTk7X8gjgYIqtwNTTVisXz+Y6
    FIxjGmM/ADJNViLFAPTcMkKzDlevFupgS6K1fKr2MzO4+wc+UR/964SO/vMZoa+92D8c
    MzVoyOf1e4HwcmMve9ZoOiEKkqQW/1jg/THlWwveRtFTPxiQiA1oV+y7boltyQnn73vW
    fGb9PuAv+QBfVk2PPShUpF5hm7oBbg9QvEhzfq+iqxwbQTB/ktOvmcc+QelcxFQ+H6pp
    GPx8SEIrJLcPh9SRHiNVDq7vXo5yplJUV9wFbT5qi38O3MfXT8E+uPJtYDGDeWUOzdEA
    F5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680867426;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=WtcNgXXpAMGIIst+4wNEMLyfSz80SI4jFwbanGxvG/Q=;
    b=OO5HfLoSxoJVpcRKU8doKTrqfjTNAiltE5BdxrNjMUM+2TWhfzwDNhPIaEFa6CsoJu
    47D50paIQQDTHBtogO9B/rgUcBPgoUXPupoqW4dzzhT/MeTg7IcGcaIIFnoTvDgp4tf8
    SLG5UPK7dNvSUcDe5jjFa4R8ZKe1NF7+UTnIAHRSZclJlo2sU0HofJbtOjI5YfvH03PP
    +DrNKTbiA6G3P6jAmRHemOqZ99fNCZ+2Dg2kPi/W5D42N3mtEDMpBd0xax1EE8l28z1f
    /3rzHk2TAhVYcUQHhFcrMXCtq++0f//vxeebOQ7vgXnQLAvK7BLGKQrX/MsX9VM+Zfua
    zgwQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680867426;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=WtcNgXXpAMGIIst+4wNEMLyfSz80SI4jFwbanGxvG/Q=;
    b=iHGE9XIfJ2DdIkkqA1bmAhW+soPFstURSvpietIs6Nm9xO3k9ifiBmgvmCrC0fdhQZ
    jHwxfZg5YpusNqrzBqvdNkZyeDc4/u+uFyZ3mYUd/zZ6hUpb4janhbDNVvEWzftSP5hM
    1t/dRWkrtSk5zemcqKPFTihveetuicv9lgXHUrG3zVaFo9weo4FQenGwulhi5ynEAStF
    BTrZw3mZiJRjWo9OMAeqxdukwnTPrCW2eSLhtXrB4hd4K000o1YUbMzs20R7XPyN8CPD
    coeIPD7ifP0aLyrz1z574uygI/31V+A8aohE2t2WGOjRPVQgKakw/2X5X2nbe1eHYjtS
    4XUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680867426;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=WtcNgXXpAMGIIst+4wNEMLyfSz80SI4jFwbanGxvG/Q=;
    b=i0CxDF4R99oPsYjvqWrjelIewiROralEB2uJPLlQKvJpwu4EkBy/m2S3I2oW+vKy2O
    oEN8LEYVFrvF+TXlG7Dw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az37Bb5Ed8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 7 Apr 2023 13:37:05 +0200 (CEST)
Date:   Fri, 7 Apr 2023 13:36:55 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Message-ID: <ZDAAToSzNLVo6le8@gerhold.net>
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
 <168069726278.2356075.14351594478003012447.robh@kernel.org>
 <20230405134727.GA2461305-robh@kernel.org>
 <1e6e2590-ac78-400b-35ce-321d5e52f385@linaro.org>
 <9df12111-ec84-c4f7-fbcb-bccaef91b048@linaro.org>
 <3ce9b5ec-8b02-537a-c663-c849e80cab66@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce9b5ec-8b02-537a-c663-c849e80cab66@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 09:55:40PM +0200, Konrad Dybcio wrote:
> [...]
> I don't really know what kind.. I can add something like:
> 
> rpm {
> 	compatible = "qcom,rpm", "simple-mfd";
> 
> 	mpm: interrupt-controller {
> 	...
> };
> 

IMO we should indeed add something like this, because the current
representation of the RPM below the top level /smd node is misleading.
"SMD" is not a device, bus, component or anything like that. It is just
the communication protocol. There should not be a top-level DT node for
this.

Instead there should be a dedicated device tree node for the RPM like in
your example above, which will allow adding properties and subnodes to
it as needed.

For unrelated reasons I actually have some patches for this, that switch
the /smd top-level node to a "remoteproc-like" node dedicated to the
RPM, similar to how WCNSS/ADSP/Modem/etc are represented. I need this to
add additional (optional) properties like "resets" and "iommus" for the
RPM, but it would allow adding arbitrary subnodes as well:

https://github.com/msm8916-mainline/linux/commit/35231ac28703805daa8220f1233847c7df34589e

I could finish those up and post them if that would help...

Thanks,
Stephan

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index dcbc5972248b22..1c24b01bd268c8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -310,10 +310,10 @@
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
+	rpm: remoteproc-rpm {
+		compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
 
-		rpm {
+		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;


