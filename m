Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3F9716DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjE3Ts6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjE3Ts5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:48:57 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDF2E8;
        Tue, 30 May 2023 12:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685476133; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pop3NnhrhZEAeUjnOXlrOnJgzu7/QXn4WnQ4LxAepL1V6oGMgQLF84+ww4Ph5KGYhh
    7bG9BBsVzRaSrKBaWYFvAMhVpFtzs8hsne1cgyvdDT1sxhA6u7YnmUrwZ4J1OeRrifzG
    iqucgzfD4hkkSkvs3TyVKarnCjvCvS8lSkXpKmbcK+MyhADYp8IF+mq3j6ycTIGtrneY
    qsb7tQmzOf3LW18D1tpnHK73FsRG+FiY++ukus0bPKCzZbVzR29/upQSOt5EYIy3v+Ok
    NzyEolHSM6TfxJF83o1/wNIOYDcRf3X8UNv/bAkqJoMafRa2wB1TssHkS5Z4UYHkGXbm
    ItoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685476133;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=T5CdztljMKq8HhGIpu+2afxFrsW10AdGa/gk1f9uPvg=;
    b=Lb6nl9GUblisWuGhbK4Jqx0kW2/qRjGvGDH3lidI33DdkL8yj5zEF9Zl/U/aIP+Z7y
    qSo+aGFwFKBERvMvMjPAtUIHHgMPNysL5yVQ10CtseQ7s6dXJ4LfF9MJzHCkaG/zCXal
    PAU7RpIxAJ1YgkNMj19hf1P6batbHmRQsWVJt2xolb/4rzfwM4OaD7PBDcgqPypdfQz/
    wfGrm1eSXTShRTYR62yn76EO6JwHnY1InGXIgNodtu3Hj9u5PDNfCLGJfvvb4oUrTNC1
    k53HDDbdVo8zQBjLCkcF2fONoQ8opVJ3JZ0aUOXjcA1bTzNIJYqIg5HJPhZbm1VIH6K5
    bTNQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685476133;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=T5CdztljMKq8HhGIpu+2afxFrsW10AdGa/gk1f9uPvg=;
    b=MLjwIMvj0RorFujTsCZyyV+uniL7w5BmJJV4u9BEYV4bnSs60GYnKBLvYXgeIHzCgD
    SBhHbYapZefK9NcrBnIBD1Q1les+G77wn5K3iE40YVjvWpaX6H0Ji3qTYb6Kxx+X8oa8
    EVenO9YXQ5eE98I4uSV3SBC06Ip/m+ovLi5wKpuyD6bKck5R0citaqpVoVMBjRp7oIju
    FEN1Lr6GNy7kVTfGJg6Er+hBgeC+EcxHu4mmjFjE/pxE17MgWCA7TzUTwsjdjQh5s6Is
    MPWNgD/3MdTwC3h6sRYzLxsUOKBpEGsP6Cw4I33zwmOq3ppU+WU5IJ4Fce3oo4e3ODWR
    VIsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685476133;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=T5CdztljMKq8HhGIpu+2afxFrsW10AdGa/gk1f9uPvg=;
    b=DpfzWWAIopgKluKnlAsAh/Br4D8F+EJjOJoejLEl/vRHlCvDoHsUycfw5ZaLb41ypl
    sxnEduT67bHbcQfdvHCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4UJmqjqV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 May 2023 21:48:52 +0200 (CEST)
Date:   Tue, 30 May 2023 21:48:46 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: qcom: rmtfs: Support dynamic placement of region
Message-ID: <ZHZTHlfDsngUrTRX@gerhold.net>
References: <20230530193436.3833889-1-quic_bjorande@quicinc.com>
 <20230530193436.3833889-3-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530193436.3833889-3-quic_bjorande@quicinc.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 12:34:36PM -0700, Bjorn Andersson wrote:
> In some configurations, the exact placement of the rmtfs shared memory
> region isn't so strict. In the current implementation the author of the
> DeviceTree source is forced to make up a memory region.
> 
> Extend the rmtfs memory driver to relieve the author of this
> responsibility by introducing support for using dynamic allocation in
> the driver.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 10 ++++
>  drivers/soc/qcom/rmtfs_mem.c            | 66 +++++++++++++++++++------
>  2 files changed, 61 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index d1440b790fa6..e6191b8ba4c6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -12,6 +12,8 @@
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
>  
> +/delete-node/ &rmtfs_mem;
> +
>  / {
>  	model = "Qualcomm Technologies, Inc. SDM845 MTP";
>  	compatible = "qcom,sdm845-mtp", "qcom,sdm845";
> @@ -48,6 +50,14 @@ vreg_s4a_1p8: pm8998-smps4 {
>  		vin-supply = <&vph_pwr>;
>  	};
>  
> +	rmtfs {
> +		compatible = "qcom,rmtfs-mem";
> +
> +		qcom,alloc-size = <(2*1024*1024)>;
> +		qcom,client-id = <1>;
> +		qcom,vmid = <15>;
> +	};
> +

Couldn't you just use the existing dynamic allocation of
reserved-memory, without any driver changes?

/ {
	reserved-memory {
		rmtfs {
			compatible = "qcom,rmtfs-mem";
			size = <0x0 (2*1024*1024)>;
			alignment = <0x0 ...>; // if you want a special one
			no-map; // don't we want to map this actually?

			qcom,client-id = <1>;
			qcom,vmid = <15>;
		};
	};
};

You won't get the 4K empty pages but I guess you just have them because
you allocate the memory without proper alignment?

Related patch series where I propose using it for most firmware memory
regions:
https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/

Thanks,
Stephan
