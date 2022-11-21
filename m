Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20C5631E92
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKUKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKUKih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:38:37 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A5D19C32;
        Mon, 21 Nov 2022 02:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669027106;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CFPIooPY9A3fwgmPUWsvu1z+wHnKX09eCQ2XOhKQQU8=;
    b=eNQ+uav6No1l5xx8BhRAYY+SVZnr2t0DnQjzGmFwbCuxdoYB1aBjUDma4M1ZioL1QL
    luisu5Tg6Rf50W8kXQ1/SrcUNCZ6bXV9idHw74OHdSat6Twp4psd7PgrVkXXZ6+/oUWS
    SVM5F08PkxoM7SmmjlbKGagP10qBSRVUFHqKDId7VwY+UELL6/W0USh6xJUD5aGmqDE6
    mZrv6Y+i6Wq5tNeY77o2tMz4ZCqEYo3RsS57a4JqTBZWcCHGx2SLkbcP9kFzFyzwxF07
    1IqaUCFReVwdp6VIzmbvW2e6lKnu2d8GWDLZzVrMmZu9HZY9zaKn7a1X3qbv+MMb7o7V
    u79Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWwfGjtQ=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yALAcPVB9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 21 Nov 2022 11:38:25 +0100 (CET)
Date:   Mon, 21 Nov 2022 11:38:16 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add
 initial device tree
Message-ID: <Y3tVGFNzsPJA2Cs3@gerhold.net>
References: <20221121004813.3883-1-linmengbo0689@protonmail.com>
 <CACRpkdav1biHFE-SP_xwjyDAvjp+1fOTyMMMDJWqMJMmEpGXAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdav1biHFE-SP_xwjyDAvjp+1fOTyMMMDJWqMJMmEpGXAg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:27:30AM +0100, Linus Walleij wrote:
> On Mon, Nov 21, 2022 at 1:49 AM Lin, Meng-Bo
> <linmengbo0689@protonmail.com> wrote:
> 
> > GPLUS FL8005A is a tablet using the MSM8916 SoC released in 2015.
> >
> > Add a device tree for with initial support for:
> >
> > - GPIO keys
> > - GPIO LEDs
> > - pm8916-vibrator
> > - SDHCI (internal and external storage)
> > - USB Device Mode
> > - UART
> > - WCNSS (WiFi/BT)
> 
> I don't see this WCNSS in your initial device tree?

The WCNSS remoteproc currently has the &pronto label in msm8916.dtsi.
This can be quite confusing, I know. :/

(I think "pronto" is the code name for the implementation version in
 MSM8916 and a few related SoCs or something. On APQ8064 this is called
 "riva"...)

> Which one is is, BTW?
> 
> The WCN36xx actually supported by the kernel or older
> such as WCN1314?
> 

It's the WCN36xx that is supported by the kernel. :)
Probably WCN3620 in this case.

Stephan
