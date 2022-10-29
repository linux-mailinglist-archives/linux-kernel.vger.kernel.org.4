Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6FE61226D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJ2LdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiJ2LdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:33:11 -0400
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [IPv6:2001:67c:2050:103:465::209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F26AA3B;
        Sat, 29 Oct 2022 04:33:10 -0700 (PDT)
Received: from smtp2.mailbox.org (unknown [91.198.250.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4Mzy2q21q4z9sf2;
        Sat, 29 Oct 2022 13:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1667043187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaBEU8XRk6EfyLvaqOBHb+G87K1IzT9V5VB8jSJlgi8=;
        b=l0uqO4DbD7GczSQEp5EcFr5mUxgwt5NUTytg5CRnZwFt1N2JXZ1EQN1KdVWzQjT/tBTBO1
        ipHHjVpVzrqlVuHSZpt9hQRTp0KK+SF94DyAltroa5qil1eUX2YfRj54O6+bzhUxCM+aqo
        iRcmntt8EGmQWbEdJiAlFaPmsxbK1oZA2GzDPppSIV337MKY1+soLPEaMECSwbeLLNc6hw
        h63eB+L5Zjw8QD3rwFtdcyYZib1+o0xwi0Bk6q5Ig2P5bnkZ2fJnomFMq2DufLoaeavcOi
        4g3HP74ZAQimlMFGFaCp6d35w1X5JSmVDzIsHq4L/AB4z3UjeZv8ranu7EVD6g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 29 Oct 2022 13:33:05 +0200
Message-Id: <CNYDHMTS0PVZ.3F3UV93H8QSW6@ancom>
Cc:     "Andy Gross" <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Luca Weiss" <luca@z3ntu.xyz>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: sdm632: fairphone-fp3: add
 touchscreen
From:   "Job Noorman" <job@noorman.info>
To:     "Bjorn Andersson" <andersson@kernel.org>
References: <20221024140001.139111-1-job@noorman.info>
 <20221024140001.139111-4-job@noorman.info>
 <20221028214443.oeg5u4n4bjdyeuks@builder.lan>
In-Reply-To: <20221028214443.oeg5u4n4bjdyeuks@builder.lan>
X-Rspamd-Queue-Id: 4Mzy2q21q4z9sf2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Fri Oct 28, 2022 at 11:44 PM CEST, Bjorn Andersson wrote:
> Please include at least all the mailing lists as Cc on all your patches
> in the series - I'm not subscribed to linux-input, so I don't have patch
> 1 or patch 2 in my inbox.

No problem, I will resend with all mailing lists in Cc for all patches!

Since this is the first patch series I submit to the kernel, I wonder if
you could elaborate a bit on what the correct process is to select
recipients?

My current git send-email workflow is as follows:
- --to-cmd=3D"get_maintainer.pl ... --nol"
- --cc-cmd=3D"get_maintainer.pl ... --nom"
- Cover letter: the same commands but run on all patches in the series

If I understand you correctly, your advice would be to change only the
second part of this workflow to also run the command on _all_ patches in
the series. Is this correct?

Best regards,
Job
