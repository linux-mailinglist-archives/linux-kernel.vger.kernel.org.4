Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E1F5EAC55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiIZQUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbiIZQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:19:29 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B677F6843;
        Mon, 26 Sep 2022 08:08:28 -0700 (PDT)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::6])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 96526C7D7F;
        Mon, 26 Sep 2022 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664204876; bh=J45pSAflEnMdguMe8nXNMflm4Xmyc66iCyYkvZ/c4ZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HaSrQkrli/qTlXB0D2h7RiDh56v2IpKGy8h9XBcSaFJJtpBCl6VrpXvKApi5rcXTW
         0ba5Qz5G7AzYv2gdvxBeCHb885VoevqLuh86SKZgUx5nv7zqoHSRX8OKP1uGd/FiPU
         8+IdBmK91hPJnB1BROlcPXKv/g3rCF++GzLCCbQ4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: qcom: pm8941: adjust node names to bindings
Date:   Mon, 26 Sep 2022 17:07:56 +0200
Message-ID: <13105309.uLZWGnKmhe@g550jk>
In-Reply-To: <3dda8e86-b92b-488a-5afb-0cb49e7e52ae@linaro.org>
References: <20220925210229.128462-1-luca@z3ntu.xyz> <3070538e-fa8d-4506-bbf8-c2770d092eb5@linaro.org> <3dda8e86-b92b-488a-5afb-0cb49e7e52ae@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Montag, 26. September 2022 12:29:11 CEST Krzysztof Kozlowski wrote:
> On 26/09/2022 12:04, Neil Armstrong wrote:
> > On 26/09/2022 11:22, Krzysztof Kozlowski wrote:
> >>>   		};
> >>> 
> >>> -		usb_id: misc@900 {
> >>> +		usb_id: extcon@900 {
> >> 
> >> Why? extcon is Linux specific name and should not be added to DTS.
> >> Anything requires it?
> > 
> > It matches the current dt bindings:
> Then instead maybe let's fix it in the bindings and DTS?

What node name do you propose? I doubt "misc" is a better name as it really 
doesn't describe anything so I don't really have a suggestion here..

Regards
Luca

> 
> Best regards,
> Krzysztof




