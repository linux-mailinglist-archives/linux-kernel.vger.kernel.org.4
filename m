Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8DE6BD708
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCPR2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCPR23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:28:29 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240A56523
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:28:27 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s4so1118059ioj.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678987707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B3FjaBu6x21XrrzbR+AxSaDNfxqnAu0VSeMOIMX/zrg=;
        b=GtN6xipVyPnGEDUMBwNEtI3DlE92FVD8cSHb1s84EO/FbLFPPJd1jU3oMFbPTnmybP
         flyb3uB98J3FOnUxlqpoQnDoRkA078xnGIq4wRcFcnEklQE1Et3IdUK7E7GGpeAlXUta
         SO3/KVaOxKJ6IMAoezzL1Vi9joSKp7eonxTuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678987707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3FjaBu6x21XrrzbR+AxSaDNfxqnAu0VSeMOIMX/zrg=;
        b=XNEu/ulGdABv57216bMoW03ssLl4sKBOl2gJnwLV528LQN2Q3i7Ui1Nuey6BL0lnkw
         qp5M7vQ5yw92iPMnpwJzxH/719KD743188QLjHGEuYKejBrs7FNjopW3cCWMWHHt1Qki
         nWGE/xpqwRpKn4zkMWNwHu8bkvEJAuxsECju8lkehi3Ec0qItsr9MbF2ufE8PKmOkd8Z
         YmdIy/IHWUoWyGIoFWlftK4dJMg4iyO56wQzGiujv5ntj7r3oZWT5r4xpJWYinLMGVM8
         OlkllCmuggvrZnNPMyMsWhYkJnd4vDZOIPVo+A4NWE59UozF9jBdfDsBwqJtYgrFjgGH
         4fYA==
X-Gm-Message-State: AO0yUKXTPTHCQJ5BU+i1t5tBsN0IW2AHxOXTaWPUF9tW0Uf/iBCwKVVy
        NGIRcKeNaRC51bgocDoVpDWmHj6vyaEAOTl6aGU=
X-Google-Smtp-Source: AK7set/0JqH+UexaDw/MTN/hA95AFev253RaQms5iT54Va3edzThmccTAwBSqO0cWduYoavviohH/Q==
X-Received: by 2002:a6b:7c09:0:b0:74e:3b0f:4498 with SMTP id m9-20020a6b7c09000000b0074e3b0f4498mr26240030iok.7.1678987706859;
        Thu, 16 Mar 2023 10:28:26 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id k8-20020a6b4008000000b0074ca38eb11fsm2691459ioa.8.2023.03.16.10.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:28:26 -0700 (PDT)
Date:   Thu, 16 Mar 2023 17:28:26 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: sc7180: Don't enable lpass
 clocks by default
Message-ID: <ZBNRukXEliI2auDa@google.com>
References: <20230315154311.37299-1-nikita@trvn.ru>
 <20230315154311.37299-2-nikita@trvn.ru>
 <ZBJivckYK+JrGdG2@google.com>
 <67077784fcf9aa928be9a6503e3d1e83@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67077784fcf9aa928be9a6503e3d1e83@trvn.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 08:42:03AM +0500, Nikita Travkin wrote:
> Matthias Kaehlcke писал(а) 16.03.2023 05:28:
> > On Wed, Mar 15, 2023 at 08:43:08PM +0500, Nikita Travkin wrote:
> >> lpass clocks are usually blocked from HLOS by the firmware and
> >> instead are managed by the ADSP. Mark them as reserved and explicitly
> >> enable in the CrOS boards that have special, cooperative firmware.
> >>
> >> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
> >>  arch/arm64/boot/dts/qcom/sc7180.dtsi         | 4 ++++
> >>  2 files changed, 12 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> >> index 423630c4d02c..26def6e12723 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> >> @@ -785,6 +785,14 @@ alc5682: codec@1a {
> >>  	};
> >>  };
> >>
> >> +&lpasscc {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&lpass_hm {
> >> +	status = "okay";
> >> +};
> >> +
> >>  &lpass_cpu {
> >>  	status = "okay";
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> >> index 53f0076f20f6..f0de177981f9 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> >> @@ -3623,6 +3623,8 @@ lpasscc: clock-controller@62d00000 {
> >>  			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
> >>  			#clock-cells = <1>;
> >>  			#power-domain-cells = <1>;
> >> +
> >> +			status = "reserved"; /* Controlled by ADSP */
> > 
> > Why not "disabled"? I see "reserved" is used in a couple of other
> > instances, but it doesn't appear in Documentation/devicetree/bindings/,
> > so it doesn't seem to have a well defined meaning that distinguishes it
> > from "disabled".
> 
> Hi, the standard properties like this one are defined in the
> Devicetree specification, notably chapter 2.3.4 "status" says:
> 
>   "reserved" Indicates that the device is operational, but should
>   not be used. Typically this is used for devices that are controlled
>   by another software component, such as platform firmware.
> 
> On the contrary,
> 
>   "disabled" Indicates that the device is not presently operational (...)
> 
> Since the hardware is operational but is controlled by "foreign"
> firmware, I believe "reserved" state is more correct here.

Thanks for the clarification!
