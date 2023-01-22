Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5FE6770F7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjAVRKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjAVRKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:10:09 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E116413516;
        Sun, 22 Jan 2023 09:09:26 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 200so7219138pfx.7;
        Sun, 22 Jan 2023 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vYSXXg5e6s/NvCMij6drYU933rOuoET93FHCVB0DyzQ=;
        b=QgiPbB3zmcZQ6q1HB0ZmVaGKTzB91HabHLJNzixu4QY6/AOSMuJX/9qt5jk8P9XNmH
         iL0aqhNhJS6uscxjKYkiFpF+S2y8wdH4GU12QPjx5lQ6F/+ih1LP9qVQ5bSV5jePu/03
         T2hn1zw4saZ72O0Gm/YcmjIgUdbQZrzw0lHix08iGfmZz2QRvfJJ5FVFifQkPQvTocDK
         Kmpy6Y6RtCKXeUSuoUzlCEzntf5c7v+Hj5k+aVUvMJPTr8L3DKL2HZlwZ5agq9kJ8tMy
         96tk6T0f6zf/DM84ZPX8QoT2wnkb3V18onMAsp8ypEULlzN9m/7rz7eZQoURctfDVamq
         xzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYSXXg5e6s/NvCMij6drYU933rOuoET93FHCVB0DyzQ=;
        b=gBdZNo7fPvNGcXzkNSAgV/u/d3mc08O+78kw8tagdLj0cmrmROtzsMtJiQdNMKmGzu
         OgzBS/DdPkeg4JOomG+U7aJJyS4PjN4V/Frhq93II5+HcGk/AuyIVuYhBXfegcmKT3yt
         /Vo1sVWi0bhuCpUR9YITOZ/l3Fn5NjbZJTnX/ZNRuKH1o7UgK0WWp9KQUOZ5Q4ApMKLj
         YBI4k2GjHMsrU/ICUI58UiA7X+T/+stG8Kvw3GEmK4TABi+oXtxkQsTyQH6YuvDMD/Pw
         gGeW6FSkXvsSsIW5u3/45cFtN2TqF8CV+mcWGBtdcEbUgjzFYJdriCK4vNvPJpSzS61u
         xqgg==
X-Gm-Message-State: AFqh2kqbNhk9LGh8IElKj3upQlvnNjAoObXy0+fVtmBNkgiruOofwLKv
        gJ3Cvb83/RnfNIeLZRWaD07nml+dBlVCPIw8DbT5Bjjcs3M=
X-Google-Smtp-Source: AMrXdXsBVB8n/1RhZCeU7snMZ6saiO98lUVGkEkzDdthQucxeEbfO4XxgPU7br4QJd6/rwMScuiWHnpsxUo1bikg1lI=
X-Received: by 2002:a05:6a00:13a3:b0:58d:973f:e2f1 with SMTP id
 t35-20020a056a0013a300b0058d973fe2f1mr2205617pfg.10.1674407365181; Sun, 22
 Jan 2023 09:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20230121112358.52216-1-robimarko@gmail.com> <20230121112358.52216-2-robimarko@gmail.com>
 <ebdd9932-e251-0cd7-6c98-3c735ecb74a6@quicinc.com> <CAOX2RU7p-0ZTx8fkY4hOk=Zmx6RT+1PwVL+CQxkjzVadm0ehTA@mail.gmail.com>
 <29d9de45-1ce7-d6e5-bf02-052e911a067b@quicinc.com>
In-Reply-To: <29d9de45-1ce7-d6e5-bf02-052e911a067b@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sun, 22 Jan 2023 18:09:14 +0100
Message-ID: <CAOX2RU7BfESmsUdZ5jBfYjWXUnDWmFizT8UiPwgzb_SsrT0jnA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq8074: add QFPROM node
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2023 at 18:05, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
> On 1/22/2023 10:29 PM, Robert Marko wrote:
> > On Sun, 22 Jan 2023 at 17:57, Kathiravan Thirumoorthy
> > <quic_kathirav@quicinc.com> wrote:
> >>
> >> On 1/21/2023 4:53 PM, Robert Marko wrote:
> >>> IPQ8074 has efuses like other Qualcomm SoC-s that are required for
> >>> determining various HW quirks which will be required later for CPR etc,
> >>> so lets add the QFPROM node for start.
> >>>
> >>> Individidual fuses will be added as they are required.
> >>>
> >>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>> ---
> >>>    arch/arm64/boot/dts/qcom/ipq8074.dtsi | 7 +++++++
> >>>    1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> >>> index 8eba586065a3..f29491f647fe 100644
> >>> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> >>> @@ -301,6 +301,13 @@ mdio: mdio@90000 {
> >>>                        status = "disabled";
> >>>                };
> >>>
> >>> +             qfprom: efuse@a4000 {
> >>> +                     compatible = "qcom,ipq8074-qfprom", "qcom,qfprom";
> >>> +                     reg = <0x000a4000 0x1000>;
> >>
> >>   From the HW document, I see the overall size of this region is 0x2000,
> >> any reason to stick with 0x1000?
> > Like always, I dont have access to docs and 0x1000 is all I could find
> > downstream
> > being used.
> >
> > Any chance you can share the regions inside of QFPROM, it would be great to use
> > the ECC corrected one if available.
>
> Sorry, What do you refer by "ECC corrected" here?

Isnt there a corrected region in the QFPROM meant for reading?
As far as I understand it's protected by FEC.

Regards,
Robert
>
> Thanks, Kathiravan T.
>
>
> >
> > Regards,
> > Robert
> >> Thanks, Kathiravan T.
> >>
> >>
> >>> +                     #address-cells = <1>;
> >>> +                     #size-cells = <1>;
> >>> +             };
> >>> +
> >>>                prng: rng@e3000 {
> >>>                        compatible = "qcom,prng-ee";
> >>>                        reg = <0x000e3000 0x1000>;
