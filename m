Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2347C63B179
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiK1Sgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiK1SgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:36:22 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF3FF08;
        Mon, 28 Nov 2022 10:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669660218;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GKZLgAKbgAJsBsUL/AQjiQQ9KI6oNqWjLldVq5sSTCo=;
    b=bnuUZZti3OLRZwh+fgHiXl9FHmurJEVCn+3NNH8xZBdWfB93XmCKJQWotwR71yyV3r
    JFuxcC4VnT0s1btD1CDlnd90obC+xMwNzTP1fMghluBrF3rAh/pWrltgjriOqT4FgW3I
    Ac5dKaMgLLqGBwCo8qSo6X1ccDNhPCz59VfJX8M7iUMKvPNi/PUEjshwH6Mm8T+E1/TB
    MFx9Hp+vAnCX2k+/tIKsoZ3o6Jzt1Mf210PNdSw1+IIgty06jkBzG1zOZfNXxIFCp9DT
    b5cuKbwR//ndjKsC53kc3ZEqva4GJowo3mJdViSOFDXzL+IV96LHhO2yiFk07skLM9Ha
    +XDg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWxfrI"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yASIUHtUH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 28 Nov 2022 19:30:17 +0100 (CET)
Date:   Mon, 28 Nov 2022 19:30:10 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-wingtech-wt88047: Add flash LED
Message-ID: <Y4T+Mv+uIx7jQwky@gerhold.net>
References: <20221128051512.125148-1-linmengbo0689@protonmail.com>
 <43c24e7e-49b6-ff46-2f40-9413af7ac252@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43c24e7e-49b6-ff46-2f40-9413af7ac252@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Nov 28, 2022 at 09:56:47AM +0100, Krzysztof Kozlowski wrote:
> On 28/11/2022 06:16, Lin, Meng-Bo wrote:
> > WT88047 uses OCP 8110 Flash LED driver. Add it to the device tree.
> > 
> > Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> > ---
> >  .../dts/qcom/msm8916-wingtech-wt88047.dts     | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> > index 166bed05996f..a87be1d95b14 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> > +++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> > @@ -23,6 +23,20 @@ chosen {
> >  		stdout-path = "serial0";
> >  	};
> >  
> > +	flash-led-controller {
> > +		compatible = "ocs,ocp8110";
> 
> The compatible is not documented. Checkpatch warns about it. You need to
> document devices before using them.
> 

Unfortunately Pavel never applied the dt-bindings patch for this - only
the driver patch was applied. André already sent a kind reminder [1] and
two resends [2, 3] without success. Since it's a documentation-only
patch, maybe you could take it through the dt-bindings tree?

Even the original version [1] still applies cleanly to linux-next. :)

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-leds/20220212180942.8241-2-git@apitzsch.eu/
[2]: https://lore.kernel.org/linux-leds/20220404161428.17175-1-git@apitzsch.eu/
[3]: https://lore.kernel.org/linux-leds/20220505185344.10067-1-git@apitzsch.eu/
