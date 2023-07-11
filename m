Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3435C74ED09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjGKLlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGKLln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:41:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF97139
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:41:41 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so89060881fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689075699; x=1691667699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57xf39LMFyEPqtOACU3IizRJa+Kw824nnY9zKo/8ufU=;
        b=MONDM7ptIpi+qqP7Hj/yQHyIXm3nr0BHWZjy/AFKhQ5Td7u8hHd8dyLXu1QbVxK1eP
         mJygJ2aQJ5p9G5wukT5T7Zs4LYNHB/hmFjrAudkDD0bvao6OIXTVEt7EO+r78iWwi5sI
         oyIgU9KLj9l0Sq6EXyIYT/uLo4u68NJMEU5FyBaKPmWjGe54K9It9EGEfRc5fo5QPJsr
         4uJQRaG65Xhu9DeguT9VsIxx/9KW9GGZOp8/AsrcytygOdbi3QYz2jX9h8vwuPAwO+de
         Dxx0xoItC2dDG6VK/Op5b3HJrlVt4hkCf2hhGCefd5ooCJPw2LbPlLAgKmjQ0aIprvbI
         25kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689075699; x=1691667699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57xf39LMFyEPqtOACU3IizRJa+Kw824nnY9zKo/8ufU=;
        b=LmRdhmk27+cCuvsTRk/EYfsnE6bXMoqSFZnwUSa99v7yW6EkZIOQuOXPBJhy5qYqwh
         ymf+wz5KlygRnek4ZvGpNyC5AckEWVBDaAi2W4tGa/vap8QnM9WFG4/f0CgbJ39nexny
         uLkhbWRLH/n3BUECXcoYdlZsqfCxR3GiPuL0wmTgQwpckn1fvXaXNk7I48t2t4riHiQB
         NQYBo4nQbSDlNgvpBB57tUsT41Rp6S/zfM4IwSd5FG7DOB8ltas0Wc2z3yus9mPJJ0Kk
         R87i8l6Ct4wpnhRnwLzkS4H7lz7QF7KgRIg20KZU9lxJaaS9wUuWBK/ppOzbQomuYGpi
         pbfQ==
X-Gm-Message-State: ABy/qLaYAYp809DsqK63HR4kwBNsKSvVlsshNVAq3u1IZeg882O0fkRq
        OchsbOBFuqA8N2BjJc5Y+c1k3A==
X-Google-Smtp-Source: APBJJlGDHesLjoxZeJkv+D8H+B4GXtqjM5b4KeMOZ/fQZGyquxYUOV9+W71tJcwxwncFSUBJX/mzbQ==
X-Received: by 2002:a19:5f1c:0:b0:4f8:67aa:4f03 with SMTP id t28-20020a195f1c000000b004f867aa4f03mr12076741lfb.1.1689075699533;
        Tue, 11 Jul 2023 04:41:39 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id w7-20020a05651204c700b004fbb6f558ffsm281385lfq.229.2023.07.11.04.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 04:41:39 -0700 (PDT)
Message-ID: <775764d2-5457-9150-74ca-6e14fa5b2870@linaro.org>
Date:   Tue, 11 Jul 2023 13:41:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: qcom: qrb2210-rb1: Add regulators
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230711-topic-rb1_regulator-v1-1-bc4398c35800@linaro.org>
 <CAA8EJpoeAeitC=_pbAxFATfxx8UK-4cAQ=Zr3nKc0jhAdoG5fg@mail.gmail.com>
 <43d290c9-fdec-4832-242e-6732d9f0ea6c@linaro.org>
 <CAA8EJpozgj=MvYo=eHx1a1YD4gkXEvqHvuvp_mUBXfGMjhYWGA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpozgj=MvYo=eHx1a1YD4gkXEvqHvuvp_mUBXfGMjhYWGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.2023 12:56, Dmitry Baryshkov wrote:
> On Tue, 11 Jul 2023 at 13:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 11.07.2023 12:44, Dmitry Baryshkov wrote:
>>> On Tue, 11 Jul 2023 at 13:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>> Add and assign RPM regulators coming from PM2250.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>> [...]
>>
>>>> +               pm2250_l5: l5 {
>>>> +                       /* CSI/DSI */
>>>> +                       regulator-min-microvolts = <1232000>;
>>>> +                       regulator-max-microvolts = <1232000>;
>>>> +                       regulator-allow-set-load;
>>>> +                       regulator-boot-on;
>>>
>>> why?
>>>
>> To answer all of the questions in one go:
>>
>> "it's because the regulator is enabled at boot"
> 
> I was more concerned about the following part:
>       If the bootloader didn't leave it on then OS should turn it on at boot ...
> 
> Please remind me, are we declaring them as boot-on so that the
> regulator core can turn them off later if they are unused?
In the Linux implementation, yes.

Konrad
> 
>>
>> Konrad
>>>> +               };
>>>> +
>>>> +               pm2250_l6: l6 {
>>>> +                       /* DRAM PLL */
>>>> +                       regulator-min-microvolts = <928000>;
>>>> +                       regulator-max-microvolts = <928000>;
>>>> +                       regulator-always-on;
>>>> +                       regulator-boot-on;
>>>> +               };
>>>> +
>>>> +               pm2250_l7: l7 {
>>>> +                       /* Wi-Fi CX/MX */
>>>> +                       regulator-min-microvolts = <664000>;
>>>> +                       regulator-max-microvolts = <664000>;
>>>> +               };
>>>> +
>>>> +               /*
>>>> +                * L8 - VDD_LPI_CX
>>>> +                * L9 - VDD_LPI_MX
>>>> +                */
>>>> +
>>>> +               pm2250_l10: l10 {
>>>> +                       /* Wi-Fi RFA */
>>>> +                       regulator-min-microvolts = <1300000>;
>>>> +                       regulator-max-microvolts = <1300000>;
>>>> +               };
>>>> +
>>>> +               pm2250_l11: l11 {
>>>> +                       /* GPS RF1 */
>>>> +                       regulator-min-microvolts = <1000000>;
>>>> +                       regulator-max-microvolts = <1000000>;
>>>> +                       regulator-boot-on;
>>>
>>> Shouldn't it be handled by the modem on its own?
>>>
>>>> +               };
>>>> +
>>>> +               pm2250_l12: l12 {
>>>> +                       /* USB PHYs */
>>>> +                       regulator-min-microvolts = <928000>;
>>>> +                       regulator-max-microvolts = <928000>;
>>>> +                       regulator-allow-set-load;
>>>> +                       regulator-boot-on;
>>>
>>> You guess the question (and further on)
>>>
>>>> +               };
>>>> +
>>>> +               pm2250_l13: l13 {
>>>> +                       /* USB/QFPROM/PLLs */
>>>> +                       regulator-min-microvolts = <1800000>;
>>>> +                       regulator-max-microvolts = <1800000>;
>>>> +                       regulator-allow-set-load;
>>>> +                       regulator-boot-on;
>>>> +               };
>>>> +
>>>> +               pm2250_l14: l14 {
>>>> +                       /* SDHCI1 VQMMC */
>>>> +                       regulator-min-microvolts = <1800000>;
>>>> +                       regulator-max-microvolts = <1800000>;
>>>> +                       regulator-allow-set-load;
>>>> +                       /* Broken hardware, never turn it off! */
>>>> +                       regulator-always-on;
>>>> +               };
>>>> +
>>>> +               pm2250_l15: l15 {
>>>> +                       /* WCD/DSI/BT VDDIO */
>>>> +                       regulator-min-microvolts = <1800000>;
>>>> +                       regulator-max-microvolts = <1800000>;
>>>> +                       regulator-allow-set-load;
>>>> +                       regulator-always-on;
>>>> +                       regulator-boot-on;
>>>> +               };
>>>> +
>>>> +               pm2250_l16: l16 {
>>>> +                       /* GPS RF2 */
>>>> +                       regulator-min-microvolts = <1800000>;
>>>> +                       regulator-max-microvolts = <1800000>;
>>>> +                       regulator-boot-on;
>>>> +               };
>>>> +
>>>> +               pm2250_l17: l17 {
>>>> +                       regulator-min-microvolts = <3000000>;
>>>> +                       regulator-max-microvolts = <3000000>;
>>>> +               };
>>>> +
>>>> +               pm2250_l18: l18 {
>>>> +                       /* VDD_PXn */
>>>> +                       regulator-min-microvolts = <1800000>;
>>>> +                       regulator-max-microvolts = <1800000>;
>>>> +               };
>>>> +
>>>> +               pm2250_l19: l19 {
>>>> +                       /* VDD_PXn */
>>>> +                       regulator-min-microvolts = <1800000>;
>>>> +                       regulator-max-microvolts = <1800000>;
>>>> +               };
>>>> +
>>>> +               pm2250_l20: l20 {
>>>> +                       /* SDHCI1 VMMC */
>>>> +                       regulator-min-microvolts = <2856000>;
>>>> +                       regulator-max-microvolts = <2856000>;
>>>> +                       regulator-allow-set-load;
>>>> +               };
>>>> +
>>>> +               pm2250_l21: l21 {
>>>> +                       /* SDHCI2 VMMC */
>>>> +                       regulator-min-microvolts = <2960000>;
>>>> +                       regulator-max-microvolts = <3300000>;
>>>> +                       regulator-allow-set-load;
>>>> +                       regulator-boot-on;
>>>> +               };
>>>> +
>>>> +               pm2250_l22: l22 {
>>>> +                       /* Wi-Fi */
>>>> +                       regulator-min-microvolts = <3312000>;
>>>> +                       regulator-max-microvolts = <3312000>;
>>>> +               };
>>>> +       };
>>>> +};
>>>> +
>>>>  &sdhc_1 {
>>>> +       vmmc-supply = <&pm2250_l20>;
>>>> +       vqmmc-supply = <&pm2250_l14>;
>>>>         pinctrl-0 = <&sdc1_state_on>;
>>>>         pinctrl-1 = <&sdc1_state_off>;
>>>>         pinctrl-names = "default", "sleep";
>>>> @@ -61,6 +322,8 @@ &sdhc_1 {
>>>>  };
>>>>
>>>>  &sdhc_2 {
>>>> +       vmmc-supply = <&pm2250_l21>;
>>>> +       vqmmc-supply = <&pm2250_l4>;
>>>>         cd-gpios = <&tlmm 88 GPIO_ACTIVE_LOW>;
>>>>         pinctrl-0 = <&sdc2_state_on &sd_det_in_on>;
>>>>         pinctrl-1 = <&sdc2_state_off &sd_det_in_off>;
>>>> @@ -104,6 +367,9 @@ &usb {
>>>>  };
>>>>
>>>>  &usb_hsphy {
>>>> +       vdd-supply = <&pm2250_l12>;
>>>> +       vdda-pll-supply = <&pm2250_l13>;
>>>> +       vdda-phy-dpdm-supply = <&pm2250_l21>;
>>>>         status = "okay";
>>>>  };
>>>>
>>>>
>>>> ---
>>>> base-commit: 8e4b7f2f3d6071665b1dfd70786229c8a5d6c256
>>>> change-id: 20230711-topic-rb1_regulator-44c4ade93246
>>>>
>>>> Best regards,
>>>> --
>>>> Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>
>>>
>>>
> 
> 
> 
