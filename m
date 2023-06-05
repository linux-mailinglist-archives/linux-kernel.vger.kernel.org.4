Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA8723089
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbjFETzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbjFETza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:55:30 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62F9F9;
        Mon,  5 Jun 2023 12:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685994926; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TiqTiQoeYwt1hT/OSFns5ECSVxjSLxTpp6RD096s4c/p2igjY2011GdxKnxYYkFOjz
    8aFjVmiUSftAL6P6SSJESCG9ndwTSV8ppTJuteVf2+vs/9kP4lWZOHZb/+rHx8izFjS9
    X6QsM/EVF5pBadfntWNIoIAjwTLMPJCIl5kY2c1b7h/UKstATSv4EWt/j0p8iG5E4Lvz
    cEEOlUjX0uZeCr7BRwU8svI9MgJRbpjRYQsPGKSfSDfJWmicwcmejGs/8g+X797NizWR
    QRKQpyxLtoDPa/uCG8topmkPQfQTSosgprxcBEODKfH0vwi7Utw1L/We42Trev5HtXH4
    roHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685994926;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=q8v7xhsKQbAC5AuoVzmw8VwkS8GgEtK8YKcKro0Zup4=;
    b=nTAbuQ1C5vBMJckQqX0MBjvGamEPpfZ9iN2VZ6i5zgncCZzMHZe9JJK5clCYFKL0ZR
    G8fsgIszfpoU74JJDS61iWgaA+N9SJ+OzNIhZoTmXV6JIUe0MsGqu1M0iyHFHUzdwAGu
    G2xXK/wjFg+HI5sLirXxjQjzwV8zocXsi3ULufiiwxXUqztxGA2MMvs0A1hIceqKLbxI
    FDjaIi14AyECkxiR9X+/OFjpZDHm/fm5M7kNUN7CytZX51YUpTqHw9FWyLLhjKyuK58u
    5MoDN3HyT61c57Dj8d2JT1pXBcd3sUuqNCAGfJqJ1WI/Fe0w5A5dDt6O9Jh2EXgtI8op
    0Ivw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685994926;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=q8v7xhsKQbAC5AuoVzmw8VwkS8GgEtK8YKcKro0Zup4=;
    b=EXMfi9XyR+YwrRnc/npE2iBLbkPl9wALXKH80JMG4kCj1KHB7xUrYUKGicI/tXJ7Rf
    UzaIs3GFbPc6mLFAVw4mnHMhWcwXZGjcLAJe/kzYnAPfT855Pmp9IfRNU11CXuGSNgKf
    pcvygqJW4wH9jb22mod29XQhaFl1zorBmIHU6NbCq1xrwNis0P1NA3BEBsnIl35jA4I+
    cRhKuhYwgW9G6iBp7RHx1m1FEkb4Hr1wMTTCwq6fjdSDL0FD5qfTd/STWkYRgKZgPoUM
    EcQgvKqAtyrc3DqdR5fGT509neKA280nyD3Ix7oBUbnaVo6rH11N9Z4uqwG6B4JeXJ5p
    r50Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685994926;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=q8v7xhsKQbAC5AuoVzmw8VwkS8GgEtK8YKcKro0Zup4=;
    b=P/RtfydcsVP5sK9GhO/ehWLn9tkIZXU4DH6ZEEZWDLaSwuXxGatjLlFl2WO6PV+rss
    yDkNLnsqVp4lhw5J0/Cw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z55JtQBkD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 21:55:26 +0200 (CEST)
Date:   Mon, 5 Jun 2023 21:55:25 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 12/14] arm64: dts: qcom: Add rpm-proc node for GLINK
 gplatforms
Message-ID: <ZH49rdvUqgbpfeBU@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-12-e0a3b6de1f14@gerhold.net>
 <9b6d4356-300b-176f-84ef-8a073e8cfe9b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b6d4356-300b-176f-84ef-8a073e8cfe9b@linaro.org>
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

On Mon, Jun 05, 2023 at 09:43:50PM +0200, Konrad Dybcio wrote:
> On 5.06.2023 09:08, Stephan Gerhold wrote:
> > Rather than having the RPM GLINK channels as the only child of a dummy
> > top-level rpm-glink node, switch to representing the RPM as remoteproc
> > like all the other remoteprocs (modem DSP, ...).
> > 
> > This allows assigning additional subdevices to it like the MPM
> > interrupt-controller or rpm-master-stats.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq6018.dtsi |  48 ++++++-----
> >  arch/arm64/boot/dts/qcom/ipq9574.dtsi |  28 ++++---
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 113 ++++++++++++-------------
> >  arch/arm64/boot/dts/qcom/msm8998.dtsi |  98 +++++++++++-----------
> >  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 126 ++++++++++++++--------------
> >  arch/arm64/boot/dts/qcom/qcs404.dtsi  | 152 +++++++++++++++++-----------------
> >  arch/arm64/boot/dts/qcom/sdm630.dtsi  | 132 +++++++++++++++--------------
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi  | 128 ++++++++++++++--------------
> >  arch/arm64/boot/dts/qcom/sm6125.dtsi  | 140 ++++++++++++++++---------------
> >  arch/arm64/boot/dts/qcom/sm6375.dtsi  | 126 ++++++++++++++--------------
> >  10 files changed, 564 insertions(+), 527 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > index 7355f266742a..fff4a4014bd8 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > @@ -146,6 +146,32 @@ psci: psci {
> >  		method = "smc";
> >  	};
> >  
> > +	rpm: remoteproc-rpm {
> Krzysztof, is this fine or should this be just `remoteproc {`?
> 

What if you have multiple remoteprocs? I took this naming convention
from sdm845.dtsi by the way:

	adsp_pas: remoteproc-adsp {
		compatible = "qcom,sdm845-adsp-pas";
	cdsp_pas: remoteproc-cdsp {
		compatible = "qcom,sdm845-cdsp-pas";

Thanks,
Stephan
