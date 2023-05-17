Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6634706708
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjEQLo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjEQLo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332C40E1;
        Wed, 17 May 2023 04:44:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17E46638AE;
        Wed, 17 May 2023 11:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CE4C433EF;
        Wed, 17 May 2023 11:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684323863;
        bh=C02SHBQiu+tlh04YA0Fr1SR/mnCqkwhUZgY8QGG1bGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=idk7gucnQ20R4EMJR0DI48jCP7YtxVUfVCY7hHsDY6XcM1LBIn4X+73TnIPr72uLE
         xNQcvmX11a+FxV3TceCLELDeAJ3RxOaRAbY0Y0tEaxqIT/p1t8Cx7LY+jgfeEa0NNj
         pj1o+UGYP5AQhbhoBGJR9SKL0n7gkjO/J/6KThTEoONpMy9uJrLAnagvdvXbgdl5Wk
         mkd+Z9L537OeiW4rhiAm2fomIb3qwZ5QWbDPsZ/6mR9EtM+w/T63SZbcXaBIIXCx2k
         FocN5iyLK9dlL6HoyoBdg6FRZthIc0AO/uNwlhLsD0YHWvlY2XE0Xu4tLwfqm1Ve7f
         hZ6TLBs/ghGLQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pzFZv-0004D3-Cj; Wed, 17 May 2023 13:44:24 +0200
Date:   Wed, 17 May 2023 13:44:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v8 1/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Message-ID: <ZGS-FymhdA_zOQmj@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-2-quic_kriskura@quicinc.com>
 <ZGNiDVq1duvyZBUB@hovoldconsulting.com>
 <f2f8c7bf-6d1d-7890-a8b1-0e27969e63f6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f8c7bf-6d1d-7890-a8b1-0e27969e63f6@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 04:40:11PM +0530, Krishna Kurapati PSSNV wrote:
> On 5/16/2023 4:29 PM, Johan Hovold wrote:
> > On Sun, May 14, 2023 at 11:19:09AM +0530, Krishna Kurapati wrote:

> >> +        interrupts:
> >> +          maxItems: 7
> >> +        interrupt-names:
> >> +          items:
> >> +            - const: dp_hs_phy_irq
> >> +            - const: dm_hs_phy_irq
> >> +            - const: ss_phy_irq
> > 
> > I assume that these are only for the first port, and that you need to
> > define these interrupts also for ports 2-4.

>   I wanted to add them when wakeup-source is enabled but since you 
> mentioned that these must be added now and driver support can be added 
> later, I will make a patch separately for this in v9.

>   Can I use the following notation for the new interrupts ?
> 
> dp_hs_port2_irq
> dm_hs_port2_irq
> dp_hs_port3_irq
> dm_hs_port3_irq
> dp_hs_port4_irq
> dm_hs_port4_irq
> 
> 
> That way the interrupt names for first port will be same as ones for 
> single port.

For consistency, I'd say: use the same scheme also for port1. Perhaps
"port" is unnecessary too.

And since these are getting new names, you can drop the redundant "_irq"
suffix as you did for the power-event lines.

For example:

	pwr_event_1
	dp_hs_phy_1
	dm_hs_phy_1
	ss_phy_1
	...

> Wanted to clarify this before I make a formal patch.

Note that I have some more comments on the remaining patches in the
series that you may want to wait for before posting v9.

Johan
