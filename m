Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F256F7FAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjEEJQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjEEJP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:15:56 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5F918922
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:15:52 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9da6374fa2so2130452276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683278151; x=1685870151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ouxVM4+18uZjND9mt/Qif2bix7633huXUwRPfA0VGdU=;
        b=Mukrhxy9VOYacixacT89IKTM9z5vxTBLDIFrWg+lXoPmqVt+I1eXNxl1h4dynJiSKg
         XAFfiTbGFMg7tklgEd3ItQdSr8lDmOHl9gq+GpufhtL1bBPrFfnHSf3Eix0r4xsgPpDR
         ghSg0BoFZLR8jC81E9oA1dxgRs/dobzYNXlju+B4sTBUzaC7EafJUHOCWNjueizoP0hn
         HQx+BXIqNP5Z/gUIA5j7uvxAjvuVWtMdrYfUMIOYIRfDfyo91mXaLsJZAtpnHpRxfaru
         uwi6c6hUmG1UhwuOc408XCTjUg1TewdXTlLt6+EXFji7784m3okiOqKrc2GLFga6pdnc
         c7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683278151; x=1685870151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouxVM4+18uZjND9mt/Qif2bix7633huXUwRPfA0VGdU=;
        b=bpE1gfQ9tdt6OZcxwm2oNM9H93btALTLxCQWxclgMLHxAwN+SdZL+1mJ32QnNBvYDb
         ZpICYAvUe2zOeeLTHpuijy6GmpMNia7LYUspzyYp4XARNIqzaBYAP06el2hfbfpy9VQd
         mu434cQjbMMyXI2fUE6CJMj0VJ7shZob9eOQNYp/PSCPZ4/HCrLURp2bBsXw13n7RVXv
         w9e+/tEB2eXliDYeNnmexy2Jbdcl74DlAOjOEVhOkGOXSUxcjOvb21jasFYuimM7FPjJ
         talczbZWIUxbTfYLuY0adk5bcLKKsd0VC5MO2U/7cS1PHIEcjvGPUOFNv/XgZ/Q1FU0U
         nqhA==
X-Gm-Message-State: AC+VfDzhimnS/+MY2IeGCqpNSvycZVcbTaxbMMN1m9uJSnFoCmmyYLk+
        3sWoVzpGdFD3I5yYqpKk9PytZflKDFRlGYQUYd20yw==
X-Google-Smtp-Source: ACHHUZ5+7Zm5rTODjdohUw1fUYDnmaslFrxAgZez40EWz6LKmOTt8xMd4OqCB5BtTxyjR0sgi0E6c4OH09QsziiUhsw=
X-Received: by 2002:a25:3792:0:b0:ba1:643f:c114 with SMTP id
 e140-20020a253792000000b00ba1643fc114mr951330yba.35.1683278150984; Fri, 05
 May 2023 02:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230505075354.1634547-1-bhupesh.sharma@linaro.org> <20230505075354.1634547-4-bhupesh.sharma@linaro.org>
In-Reply-To: <20230505075354.1634547-4-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 5 May 2023 12:15:40 +0300
Message-ID: <CAA8EJprw-KP94Q-8V-uvdsj7y64AdHoMxJQS2X-wtspGmFiifQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qrb4210-rb2: Enable aDSP and
 cDSP remoteproc nodes
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 at 10:58, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Enable the aDSP and cDSP remoteproc nodes on Qualcomm QRB4210 RB2 board.
>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> index abea44fd369d..3e8ace0ceebc 100644
> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -34,6 +34,18 @@ &qupv3_id_0 {
>         status = "okay";
>  };
>
> +&remoteproc_adsp {
> +       firmware-name = "qcom/qrb4210-rb2/adsp.mbn";

Please follow the established practice of firmware names. As the
firmware is not signed by the device vendor and is generic, this
should go to "qcom/qrb4210/adsp.mbn". Same applies to the rest of
firmware paths.

> +
> +       status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +       firmware-name = "qcom/qrb4210-rb2/cdsp.mbn";
> +
> +       status = "okay";
> +};
> +
>  &rpm_requests {
>         regulators {
>                 compatible = "qcom,rpm-pm6125-regulators";
> --
> 2.38.1
>


-- 
With best wishes
Dmitry
