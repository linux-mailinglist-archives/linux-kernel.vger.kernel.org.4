Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522CE707F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjERLZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjERLZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:25:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7DE1981
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:25:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3063433fa66so1202796f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684409113; x=1687001113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BhFInwLsH1VRwzHca+pTHra4vA2t1bJO0iPFi7Zt5Dc=;
        b=kzXs1kE4hJIcijFMsDeehT0w3FUh8L6Wm5LiY8l08WgS3NWKkJBVl9TwSRWh55vs9F
         x+k1owavGmavqBxYVhnqdGcBJOgDzsxTalV8CJTDQ/jVnOom48H32XeoaRhyZj/5hqIL
         UOXdUvTNAHvQydDbYdGOM2EGLEIRn2eLpJVyj+Crit4SspVBOloDBkGA9oIkhazGd547
         SVwyMrVqOzL3UHioR9h6iKz96uUCGAEySpvxrMh5RyHGzFuzHnz2NDvER1I2TeUHoEJ6
         6WQ8+jbXfqMAFxqiFJZkpLNQ4GLHDTr97Q4TjvP+gmJmEESR3bCHscClu3eIpco122C0
         UaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684409113; x=1687001113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhFInwLsH1VRwzHca+pTHra4vA2t1bJO0iPFi7Zt5Dc=;
        b=VzmnBKW21nOoEhf/S6lx0hpj30hOyLDzexnjLfOHbI7S8ReO9GU9IRQsFnEOIzlgAg
         5CFiQEzEaXH6yS8hPmq/7X9GDMs6yKhwYv1Imf0tA5g4OFc7XgPKKWzrV/KLYGtqr497
         oqI8HxqZKDm/D/IRyEyymSrxWVTv6iSf+GOz7PZec2WeXD8r3cuDC/6lYCmhldwnDFvV
         tiEq9RmU3jgV7ZEhM5leJXpBekqCFVMdYPrxM9wKBKvVFW02eEzPNLBcxKa314PKnSzG
         U1CECiMWWsY1+G0r2+Eri1gylIzGODSthzWnnAR/AONVgNfAfdnPqz4p1plXwYAUf18g
         U5rQ==
X-Gm-Message-State: AC+VfDyRk9XJ5HPdlniqkBfWQdmOdV+7QZgFbV0qf3iRt0d/BfRbzur9
        9XJuZqZW2t/LgROyb9TY9IAaAaJUOWfiZ3kLhgL27w==
X-Google-Smtp-Source: ACHHUZ57WDjmoMJqqO8NuR6wkBS/oUWnjJFrMWWVk4Vkli3A7c5kawOFgMjZ9urvSusdO0cpFn58OW96Xjnw0giELK8=
X-Received: by 2002:adf:f711:0:b0:309:436a:fc2f with SMTP id
 r17-20020adff711000000b00309436afc2fmr1228675wrp.57.1684409113189; Thu, 18
 May 2023 04:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230518082934.24129-1-quic_kathirav@quicinc.com> <20230518082934.24129-4-quic_kathirav@quicinc.com>
In-Reply-To: <20230518082934.24129-4-quic_kathirav@quicinc.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 18 May 2023 16:55:00 +0530
Message-ID: <CAH=2Ntz2MxM1rNeTULTWAotXWouEOj+uNHaWCjzW+ZMNZiT2hg@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] arm64: dts: qcom: ipq5332: add few more reserved
 memory region
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 18 May 2023 at 14:00, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>
> In IPQ SoCs, U-boot will collect the system RAM contents upon crash for
> the post morterm analysis. If we don't reserve the memory region used by
> U-boot, obviously linux will consume it and upon next boot on crash, uboot
> will be loaded in the same region, which will lead to loose some of the
> data, sometimes we may miss out critical information. So lets reserve the
> region used by the U-boot.
>
> Similarly SBL copies some data into the reserved region and it will be
> used in the crash scenario. So reserve 1MB for SBL as well.
>
> While at it, drop the size padding in the smem memory region.
>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
>         - Dropped the size padding in smem memory region
>
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 753581e60604..7e0a2a674f09 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -114,6 +114,16 @@
>                 #size-cells = <2>;
>                 ranges;
>
> +               uboot@4a100000 {

Shouldn't this be bootloader agnostic? AFAIK any bootloader ported on
IPQ SoCs and booting linux can access the system RAM.

I mean s/uboot/bootloader here and in the commit log.

Also which entity collects the post-crash data, is it some linux driver?
If yes, can you add more details about it in the commit log.

Thanks,
Bhupesh

> +                       reg = <0x0 0x4a100000 0x0 0x400000>;
> +                       no-map;
> +               };
> +
> +               sbl@4a500000 {
> +                       reg = <0x0 0x4a500000 0x0 0x100000>;
> +                       no-map;
> +               };
> +
>                 tz_mem: tz@4a600000 {
>                         reg = <0x0 0x4a600000 0x0 0x200000>;
>                         no-map;
> @@ -121,7 +131,7 @@
>
>                 smem@4a800000 {
>                         compatible = "qcom,smem";
> -                       reg = <0x0 0x4a800000 0x0 0x00100000>;
> +                       reg = <0x0 0x4a800000 0x0 0x100000>;
>                         no-map;
>
>                         hwlocks = <&tcsr_mutex 0>;
> --
> 2.17.1
>
