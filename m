Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698816777AC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjAWJrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjAWJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:47:11 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE7321A18;
        Mon, 23 Jan 2023 01:46:58 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z3so8338158pfb.2;
        Mon, 23 Jan 2023 01:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mNVBQzYKvaOsqX4tRiNZzz8ZPdnvV/rsuJuQmq+/ajI=;
        b=Uc/8qzIHjHoClILDsnW/XzarmHzWCdK4Bov43AZp8h9efxDKt93QLkupqBBWUGtdRI
         ZM5XF15VShg1LM3PhHQ8MSP85m4tgDqB80QWYVhD02BC8qBOSWBI4wLcXZE7fKVwet3/
         GYIpBceIx6r6rJVxM7CcfiYE7otQrNs6bQWnguKynuubNfNNwmCuHZM9AAjRACEATSlz
         Q0Nr3OogD7Mpi1G9mrFNHvlpJ4mD55Zb5rWeMcVEHaanVjYqYG5wh6sTyc1x/pt2+Rda
         kztN6lnz4o+ELB5oII4dcLP3vSk/lhkKJN0A3HKhqJhs7DI5lREORM8oXsESaG51xg1T
         lkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNVBQzYKvaOsqX4tRiNZzz8ZPdnvV/rsuJuQmq+/ajI=;
        b=s2LUObusCb2SRjqmN4MWwIb4kbFqsh3qtqWDFepSMYzsuM0M7E0KdOsGB/vARm7uPN
         zrRyRlDU+uDGwD8t9IZjkmL/NGVdCzDps8nQ86iDvrQyzzH2Hqc1IUXKoOCIj0CXDKmf
         nBtIg+LF9dZE4+IKKG1W76gx+mTA7jOL1AKBK0/gUTo6j3QbT/bX3rSj2l7l5tj9+QMC
         PfcQZUOu7IcaSK7KAA5tVoeYszJDwr7WWVBDSZjR+YXjWUH74uOcrkySznIBQSjCuQOS
         jAKw4OyJvXBP83z8J1hLJfTPnA3/8g+ck2CCGURs3BeSaMhCkVEEKgPQx+TcabJ2IDv6
         rqFQ==
X-Gm-Message-State: AFqh2kpHcBlpzqGY9l/ojS2zKkjaGGRBma63sZp7gDCYgvhDnjrSdsQJ
        RJEZtk4aWUjCGdrYma+ynacOP5vhw7zVBaqsrj4=
X-Google-Smtp-Source: AMrXdXuovTbBXeXg8I+9+vyt9mizydIvPf196uiVN42cD6gdZP+kuDBCMbqAnhRsIAjDDDQCRzBhpSQOXiG92c3JuzY=
X-Received: by 2002:a05:6a00:13a3:b0:58d:973f:e2f1 with SMTP id
 t35-20020a056a0013a300b0058d973fe2f1mr2446981pfg.10.1674467218360; Mon, 23
 Jan 2023 01:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20230121112358.52216-1-robimarko@gmail.com> <20230121112358.52216-2-robimarko@gmail.com>
 <ebdd9932-e251-0cd7-6c98-3c735ecb74a6@quicinc.com> <CAOX2RU7p-0ZTx8fkY4hOk=Zmx6RT+1PwVL+CQxkjzVadm0ehTA@mail.gmail.com>
 <29d9de45-1ce7-d6e5-bf02-052e911a067b@quicinc.com> <CAOX2RU7BfESmsUdZ5jBfYjWXUnDWmFizT8UiPwgzb_SsrT0jnA@mail.gmail.com>
 <0b224700-4774-0c34-7ce1-0a984b62b3c0@quicinc.com>
In-Reply-To: <0b224700-4774-0c34-7ce1-0a984b62b3c0@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 23 Jan 2023 10:46:47 +0100
Message-ID: <CAOX2RU4JaVTTrroG1RZw=Lnj76_2P2Xfgg5u7iTgDFuA3DKZQA@mail.gmail.com>
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

On Mon, 23 Jan 2023 at 05:44, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
> On 1/22/2023 10:39 PM, Robert Marko wrote:
> > On Sun, 22 Jan 2023 at 18:05, Kathiravan Thirumoorthy
> > <quic_kathirav@quicinc.com> wrote:
> >>
> >> On 1/22/2023 10:29 PM, Robert Marko wrote:
> >>> On Sun, 22 Jan 2023 at 17:57, Kathiravan Thirumoorthy
> >>> <quic_kathirav@quicinc.com> wrote:
> >>>> On 1/21/2023 4:53 PM, Robert Marko wrote:
> >>>>> IPQ8074 has efuses like other Qualcomm SoC-s that are required for
> >>>>> determining various HW quirks which will be required later for CPR etc,
> >>>>> so lets add the QFPROM node for start.
> >>>>>
> >>>>> Individidual fuses will be added as they are required.
> >>>>>
> >>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>>>> ---
> >>>>>     arch/arm64/boot/dts/qcom/ipq8074.dtsi | 7 +++++++
> >>>>>     1 file changed, 7 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> >>>>> index 8eba586065a3..f29491f647fe 100644
> >>>>> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> >>>>> @@ -301,6 +301,13 @@ mdio: mdio@90000 {
> >>>>>                         status = "disabled";
> >>>>>                 };
> >>>>>
> >>>>> +             qfprom: efuse@a4000 {
> >>>>> +                     compatible = "qcom,ipq8074-qfprom", "qcom,qfprom";
> >>>>> +                     reg = <0x000a4000 0x1000>;
> >>>>    From the HW document, I see the overall size of this region is 0x2000,
> >>>> any reason to stick with 0x1000?
> >>> Like always, I dont have access to docs and 0x1000 is all I could find
> >>> downstream
> >>> being used.
> >>>
> >>> Any chance you can share the regions inside of QFPROM, it would be great to use
> >>> the ECC corrected one if available.
> >> Sorry, What do you refer by "ECC corrected" here?
> > Isnt there a corrected region in the QFPROM meant for reading?
> > As far as I understand it's protected by FEC.
>
>
> Yes, there are two regions for the QFPROM, the region which you used
> here is the one used for reading and there is a error correction logic
> for it and it is size is 8KB not 4KB.

Ok, thanks for the info, I will expand the size to 0x2000 then in v2.

Regards,
Robert
>
> Thanks, Kathiravan T.
>
> >
> > Regards,
> > Robert
> >> Thanks, Kathiravan T.
> >>
> >>
> >>> Regards,
> >>> Robert
> >>>> Thanks, Kathiravan T.
> >>>>
> >>>>
> >>>>> +                     #address-cells = <1>;
> >>>>> +                     #size-cells = <1>;
> >>>>> +             };
> >>>>> +
> >>>>>                 prng: rng@e3000 {
> >>>>>                         compatible = "qcom,prng-ee";
> >>>>>                         reg = <0x000e3000 0x1000>;
