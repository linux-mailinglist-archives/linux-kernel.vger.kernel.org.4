Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D526512FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiLST0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiLSTZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:25:18 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6609116;
        Mon, 19 Dec 2022 11:25:08 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1FA681F8F3;
        Mon, 19 Dec 2022 20:25:05 +0100 (CET)
Date:   Mon, 19 Dec 2022 20:25:03 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6125-seine: Clean up gpio-keys
 (volume down)
Message-ID: <20221219192503.udmafo2vgprh3sxm@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221217100455.52593-1-marijn.suijten@somainline.org>
 <11174eb6-0a9d-7df1-6f06-da4010f76453@linaro.org>
 <20221218101841.mjsmnwtfzbmazfys@SoMainline.org>
 <b26891a3-f784-a188-e7ef-422dda9ef771@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26891a3-f784-a188-e7ef-422dda9ef771@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-19 11:00:10, Konrad Dybcio wrote:
> 
> 
> On 18.12.2022 11:18, Marijn Suijten wrote:
> > On 2022-12-17 16:04:17, Konrad Dybcio wrote:
> >> On 17.12.2022 11:04, Marijn Suijten wrote:
> >>> [..]
> >>> @@ -270,6 +270,16 @@ &sdhc_1 {
> >>>  
> >>>  &tlmm {
> >>>  	gpio-reserved-ranges = <22 2>, <28 6>;
> >>> +
> >>> +	gpio_keys_state: gpio-keys-state {
> >>> +		key-volume-down-pins {
> >> I see no need for defining a wrapper node.
> >> The other changes look good!
> > 
> > I did the same for sm6350-lena, which we should flatten out then too.
> > 
> > For these uses I'm not sure when it's clearer/better to use:
> > 
> >     thing@x {
> >         pinctrl-0 = <&thing_state>;
> >         ...
> >     };
> > 
> >     thing_state: thing-state {
> >         specific-pin {
> >             ...
> >         };
> > 
> >         other-specific-pin ...
> >         ...
> >     };
> > 
> > Or separate out the pins with their own state and instead use:
> > 
> >     thing@x {
> >         pinctrl-0 = <&specific_pin1_state &specific_pin2_state>;
> >         ...
> >     };
> > 
> > If I had to guess the former groups related pins together (as we finally
> > do now for SDC...) which should all be toggled at once.  In this
> > specific gpio-keys case, irrespective of whether it has one or more
> > keys, the pins aren't related apart from representing keys, and should
> > thus better be individual pinctrl nodes and individually referenced in
> > pinctrl-X.
> > 
> > Did I sympathize that correctly?
> I think so.

Ack, will respin like this for V2.

> > (side-note: the SDC pinctrl groups typically get extended with a
> >  card-detect pin in board DTS or in some likely-erroneous cases directly
> >  in SoC DTSI.  This may also count as unrelated pins being grouped
> >  together only because that is how the hardware/DTS node consumes them,
> >  but it is rather concise/readable/convenient though...)
> 8450 has:
> 
> pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
> 
> which seems like a sane application of what you described.

Glad to hear we (I and sm8450 dts writer(s)) came to the same conclusion
independently.  Not sure if it's worth retroactively cleaning up
existing DTS, but feel free to.  There are still DT's out there that
define all pins individually, too...

- Marijn
