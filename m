Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E307B745890
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGCJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGCJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0293E12E;
        Mon,  3 Jul 2023 02:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82B0A60E9A;
        Mon,  3 Jul 2023 09:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5ECC433C7;
        Mon,  3 Jul 2023 09:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688377097;
        bh=vvCvcdLVaW5HY77zDNvNSDkUf9oON5WYhBfmOhVV2LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FKhjPU9wi0gYdL0JGtCjyCrRK2viaJ1J6DZDySjWrJDHKj/cUz/VJmer7uBKGE5nV
         nXaDct9eOrdbkzJhqR28P85tkmHgFixtnsBVdN65ywUBPbrCMCpNRYNase4XPham42
         ORxneKGlelLynOuyzsWnmATUtwWMknBzm9dTtAUE1nGjIQ5We53lhQQ4/97s1pdtJe
         ccv4Zp1xU/2DuhOETOgReykTUThNiTGEGAlUoq2ZAIbKowFqPO5mep27tvwlAqFAp/
         FcOgGeY2OgrVXp2JmaYVpoPR0SfGiXon5R9IcgfkBnwbieOY29QJXiFTmxq2S8V9fV
         xykboCtXpZcRA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qGG0u-0006cO-1C;
        Mon, 03 Jul 2023 11:38:32 +0200
Date:   Mon, 3 Jul 2023 11:38:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: minor whitespace cleanup around '='
Message-ID: <ZKKXGE95Sv-eLQa8@hovoldconsulting.com>
References: <20230702185051.43867-1-krzysztof.kozlowski@linaro.org>
 <e09af830-d114-7ee6-0cab-e6812bc10fd4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09af830-d114-7ee6-0cab-e6812bc10fd4@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 11:30:24AM +0200, Konrad Dybcio wrote:
> On 2.07.2023 20:50, Krzysztof Kozlowski wrote:
> > The DTS code coding style expects exactly one space before and after '='
> > sign.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---

[...]
 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> > index 895cafc11480..c4209e2d4b4e 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> > @@ -155,7 +155,7 @@ CPU7: cpu@3 {
> >  
> >  		idle-states {
> >  			CPU_SLEEP_0: cpu-sleep-0 {
> > -				compatible ="qcom,idle-state-spc", "arm,idle-state";
> > +				compatible = "qcom,idle-state-spc", "arm,idle-state";
> Will conflict with:
> 
> https://lore.kernel.org/linux-arm-msm/20230627-topic-more_bindings-v1-2-6b4b6cd081e5@linaro.org/
> 
> there are also a couple of entries with property =\n\t{n}[a-z]
> 
> Otherwise lgtm
 
Konrad, please remember to trim irrelevant context from your replies
(e.g. so that we don't have to skim through thousands of lines to find
a single comment).

Johan
