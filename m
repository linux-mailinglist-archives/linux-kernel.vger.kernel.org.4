Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7732E600032
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJPPAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJPPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:00:44 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF193334E;
        Sun, 16 Oct 2022 08:00:40 -0700 (PDT)
Date:   Sun, 16 Oct 2022 15:00:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1665932438; x=1666191638;
        bh=dAJQnO6XbVUSwKa7ZZoaa3VoenB9pEW4pckW+dUMssc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=dU7wqKKsYlYMo3RJ8r1U4a1Z26GDwSsGCCA+KsRjoJ42sOlpKj3Um/QNpd1R/ZmDz
         IcA6hbzdsnk0bV3MQFEGnybMavp2RBSK+Y8BywluHrxF6hka0H7aNChivvEQ34vbH6
         Wn0E/EQOTeX/ISnEioSGA+3QRgQOKJw0zgGir1kI=
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Dylan Van Assche <me@dylanvanassche.be>,
        Alexander Martinz <amartinz@shiftphones.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sdm845-shift-axolotl: fix Bluetooth firmware loading
Message-ID: <bd01e88b-4bad-8678-bd05-47ea294fc4ed@connolly.tech>
In-Reply-To: <f047da0f-1c1d-27a5-d222-d781f20595d0@linaro.org>
References: <20221016143300.1738550-8-caleb@connolly.tech> <f047da0f-1c1d-27a5-d222-d781f20595d0@linaro.org>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/10/2022 15:58, Krzysztof Kozlowski wrote:
> On 16/10/2022 10:34, Caleb Connolly wrote:
>> From: Dylan Van Assche <me@dylanvanassche.be>
>>
>> Add serial1 alias, firmware name and use 4 pin UART pinmux.
>>
>> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
>> Tested-by: Alexander Martinz <amartinz@shiftphones.com>
>> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
>
> All your patches - except 1 - are not properly threaded.

Sorry about that! It seems that Protonmail have decided to break In-Reply-T=
o
again... I resent the series with threading here:

https://lore.kernel.org/linux-arm-msm/20221016144714.1742824-1-kc@postmarke=
tos.org/T/#t

>
> Best regards,
> Krzysztof
>

--
Kind Regards,
Caleb

