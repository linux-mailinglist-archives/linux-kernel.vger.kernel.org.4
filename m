Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47568730248
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244679AbjFNOr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245275AbjFNOrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863A3107;
        Wed, 14 Jun 2023 07:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18FEF6431E;
        Wed, 14 Jun 2023 14:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB20DC433C9;
        Wed, 14 Jun 2023 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686754059;
        bh=YBvoPI/IEVtbY5FNxrgQvaHMUweYY58AfZfxW/FUfzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3LNvXuGGMNQtEoM1FFIbIMA86EOKQwXEt+3tALeKxbJwddDvByyh87z716lOdEGC
         ay6V6UsAWKdIpfQeOHUTj6uRCRuxoBSQ/ETGAidKLmmAZaEKJNYu7cWBppubt22OZZ
         qs7CsgD6eYxPn/6tp8A8zc/IMx9Wwqni4eq6r2HIflQzfEAn2bw6+gBVmE50N1J2VT
         xdtONfXgAZr/MN4pOsv/pIk3cO5LxiMXaxi73cLALIFbTrJFx3D++N+lWZ75xNd4yO
         zo3zVf4keiHIC1Lp+4V1UkRY9UGYRsboF0z0HH6nx3D0gBBtowUDJNQ1wU4JmuqIAX
         iiI/VHltBNFtQ==
Date:   Wed, 14 Jun 2023 07:51:00 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 24/26] arm64: dts: qcom: sa8775p-ride: enable the SerDes
 PHY
Message-ID: <20230614145100.xgkme7or7k2i552d@ripper>
References: <20230612092355.87937-1-brgl@bgdev.pl>
 <20230612092355.87937-25-brgl@bgdev.pl>
 <0a57a9ad-67ab-cf1a-9bb7-c645de833450@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a57a9ad-67ab-cf1a-9bb7-c645de833450@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 09:02:23PM +0200, Konrad Dybcio wrote:
> 
> 
> On 12.06.2023 11:23, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Enable the internal PHY on sa8775p-ride.
> > 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> ---
> 
> Bjorn, Krzysztof.. I was thinking whether we should even be disabling
> such hardware by default..
> 

I'm in favor of keeping the configuration as generic/common/simple as
possible. So I like your suggestion.

Regards,
Bjorn

> Things that reside on the SoC and have no external dependencies could
> be left enabled:
> 
> pros:
> - less fluff
> - we'd probably very quickly fix the missing PM calls
> - possibly less fw_devlink woes if we fail to get rid of references to
>   the disabled component?
> 
> cons:
> - boot times
> - slightly more memory usage
> 
> Konrad
> >  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > index ab767cfa51ff..7754788ea775 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > @@ -355,6 +355,10 @@ &qupv3_id_2 {
> >  	status = "okay";
> >  };
> >  
> > +&serdes_phy {
> > +	status = "okay";
> > +};
> > +
> >  &sleep_clk {
> >  	clock-frequency = <32764>;
> >  };
