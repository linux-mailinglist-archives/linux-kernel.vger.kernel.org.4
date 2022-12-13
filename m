Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D6E64BF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiLMWSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiLMWSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:18:44 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C0F12AD7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:18:39 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y25so7334794lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ErvQcEY/kiChWV8/GLnplJvEj1BCwrs+5TFv7+hZzm8=;
        b=qKfODtdCaYMPxdOgBIEcqWRL2PmXZy0/i5Lh9WhLdvP+PXsj+5jd5tIbUI8phLhejL
         1mC0mG2KO5XkR9bk6oq3WYjRdj+U7sidwhoBgJ1/i6LgI3m+/+EVs5XdmMHvqUPfDgFm
         ZKg5cxfhWsfYF/n0+znRhgMsXOt/SU0LB3ybTGn2DuBfpVAHn9x5ibPA/lg+TviwlJsX
         P5ijjqzx/48LhUHE0hG6pM2bzUVolyQiNG4Sxp1+0xSzgVsHu5AqRB5+EuLqOxv5Jker
         69HF6fibSpxREVHwPf/ZPo7OnRz62a07B2g5rudJbvuAsy1WbsLOO0bBRWHs2Y+4KcBS
         P5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ErvQcEY/kiChWV8/GLnplJvEj1BCwrs+5TFv7+hZzm8=;
        b=oIePvM4dj35Uf+k2ooynaobkaZpYxmT/wgINyxVFr41ArAFSw5d0zv2neMXrLGQMMa
         AReSjBOtNODeJT3jJOcWoudl5OrwSO8l2LU6O4P8tRUVAJkFb9e061iNcvmWqjyDiPgL
         sNlsczwBHnseyoM/fVYW5fVJ8/jL865wjnHL64QPtjgDrK4xOo1A/CIw/o465g44AAM7
         n/GMKNQpxAgW3CdxsvPvRalZ+9TZKIYowXET3OUCKnonXMqYokKSpH9ZREQsrCavDvqk
         AMmuMGC79ImwYYsXHcDltouyUIfboDMdZfsrMR3R16dua29+WnMn3S/4HrbW7pPynZKT
         Cklg==
X-Gm-Message-State: ANoB5pkV/bW4nRBV3hhnx93aGBC7xujtbq4AoV80pZLS2UgF/g1TBTXs
        I9LvzucoRqKmuIPB0MsQbZN2KQ==
X-Google-Smtp-Source: AA0mqf6W8jYtpVN4bLPhlNSCYPnSEZmAVr8niPaF6J78JNgjmYImHMFBSNSdEad5QDmSttwiiKlhVA==
X-Received: by 2002:ac2:5453:0:b0:4a4:68b9:60b3 with SMTP id d19-20020ac25453000000b004a468b960b3mr5036408lfn.62.1670969918243;
        Tue, 13 Dec 2022 14:18:38 -0800 (PST)
Received: from ?IPv6:::1? (dzccz6yfpdgdc5vwjcs5y-3.rev.dnainternet.fi. [2001:14ba:a085:4d00:8c19:462c:c647:13f2])
        by smtp.gmail.com with ESMTPSA id g26-20020a19e05a000000b004b094730074sm528203lfj.267.2022.12.13.14.18.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2022 14:18:37 -0800 (PST)
Date:   Wed, 14 Dec 2022 00:18:34 +0200
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
CC:     agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
User-Agent: K-9 Mail for Android
In-Reply-To: <20bd4594-7302-5823-447f-b980c476323e@linaro.org>
References: <20221213123823.455731-1-bhupesh.sharma@linaro.org> <20221213123823.455731-4-bhupesh.sharma@linaro.org> <20bd4594-7302-5823-447f-b980c476323e@linaro.org>
Message-ID: <8D9809D9-AB2F-4D9E-9272-2BFC27FF49E5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 December 2022 14:49:05 EET, Konrad Dybcio <konrad=2Edybcio@linaro=2E=
org> wrote:
>
>
>On 13=2E12=2E2022 13:38, Bhupesh Sharma wrote:
>> Add USB superspeed qmp phy node to dtsi=2E
>>=20
>> Signed-off-by: Bhupesh Sharma <bhupesh=2Esharma@linaro=2Eorg>
>> ---
>Please run make dtbs_check before sending dt patches, this one
>introduces new errors=2E
>
>
>>  arch/arm64/boot/dts/qcom/sm6115=2Edtsi | 38 ++++++++++++++++++++++++++=
--
>>  1 file changed, 36 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/sm6115=2Edtsi b/arch/arm64/boot/d=
ts/qcom/sm6115=2Edtsi
>> index e4ce135264f3d=2E=2E9c5c024919f92 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6115=2Edtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6115=2Edtsi
>> @@ -579,6 +579,40 @@ usb_hsphy: phy@1613000 {
>>  			status =3D "disabled";
>>  		};
>> =20
>> +		usb_qmpphy: phy@1615000 {
>> +			compatible =3D "qcom,sm6115-qmp-usb3-phy";
>> +			reg =3D <0x01615000 0x200>;
>> +			#clock-cells =3D <1>;
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <1>;
>> +			ranges;
>These -cells and ranges properties could go after status=3Ddisabled
>
>Konrad
>> +			clocks =3D <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
>> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
>> +				 <&gcc GCC_AHB2PHY_USB_CLK>;
>> +			clock-names =3D "com_aux",
>> +				      "ref",
>> +				      "cfg_ahb";
>> +			resets =3D <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
>> +				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
>> +			reset-names =3D "phy", "phy_phy";
>> +			status =3D "disabled";
>> +
>> +			usb_ssphy: phy@1615200 {

We should not introduce additional qmp-with-child PHY nodes=2E


>> +				reg =3D <0x01615200 0x200>,
>> +				      <0x01615400 0x200>,
>> +				      <0x01615c00 0x400>,
>> +				      <0x01615600 0x200>,
>> +				      <0x01615800 0x200>,
>> +				      <0x01615a00 0x100>;
>> +				#phy-cells =3D <0>;
>> +				#clock-cells =3D <1>;
>> +				clocks =3D <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
>> +				clock-names =3D "pipe0";
>> +				clock-output-names =3D "usb3_phy_pipe_clk_src";
>> +			};
>> +		};
>> +
>> +
>>  		qfprom@1b40000 {
>>  			compatible =3D "qcom,sm6115-qfprom", "qcom,qfprom";
>>  			reg =3D <0x01b40000 0x7000>;
>> @@ -1023,8 +1057,8 @@ usb_dwc3: usb@4e00000 {
>>  				compatible =3D "snps,dwc3";
>>  				reg =3D <0x04e00000 0xcd00>;
>>  				interrupts =3D <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
>> -				phys =3D <&usb_hsphy>;
>> -				phy-names =3D "usb2-phy";
>> +				phys =3D <&usb_hsphy>, <&usb_ssphy>;
>> +				phy-names =3D "usb2-phy", "usb3-phy";
>>  				iommus =3D <&apps_smmu 0x120 0x0>;
>>  				snps,dis_u2_susphy_quirk;
>>  				snps,dis_enblslpm_quirk;

--=20
With best wishes
Dmitry
