Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBC273FFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjF0Pir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0Pio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D7113;
        Tue, 27 Jun 2023 08:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE2F0611D7;
        Tue, 27 Jun 2023 15:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F2DC433C8;
        Tue, 27 Jun 2023 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687880322;
        bh=PmrK36dDdd2L2+DlUioVyo1zm8aKUBPdauoPttVDtZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=krDmM+So1ReT1wPk/1mMSMhMV+PkkUZQAWbaxZ8foAwJD+sGeDVjBLjfi5HLQ/+1n
         6cOlsm3k5MkbM15rinhcKnb0e8flPgBV5bNeCUqpn6DFfSBgm+pNk7p6aUoDQQHxsz
         uQWVgQqGyUPf64ypnqYTDabey/DKFu3LtGFujX47SrW5mK1OHCeZplfGr7pFwpskl6
         HpSvVayKqhZiMcbjt6/kRQhJ+pW907iBBiuwCaC73tjol9rITB4AISrLwk/mRHAsSo
         4E0sMGzaTFnhHcq12naZw51rGTTmN90Hd7zwNA4sOO1ppKgad3SSPyEZ5I4dA0P1BM
         pvy62d28nw68A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEAm7-0004DS-6N; Tue, 27 Jun 2023 17:38:39 +0200
Date:   Tue, 27 Jun 2023 17:38:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 01/10] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Message-ID: <ZJsCf3nYrikF7nZc@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-2-quic_kriskura@quicinc.com>
 <ZJrGG6FXWLacRLbg@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJrGG6FXWLacRLbg@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:20:59PM +0200, Johan Hovold wrote:
> On Wed, Jun 21, 2023 at 10:06:19AM +0530, Krishna Kurapati wrote:

> > +          items:
> > +            - const: dp1_hs_phy_irq
> > +            - const: dm1_hs_phy_irq
> > +            - const: dp2_hs_phy_irq
> > +            - const: dm2_hs_phy_irq
> > +            - const: dp3_hs_phy_irq
> > +            - const: dm4_hs_phy_irq
> > +            - const: dp4_hs_phy_irq
> > +            - const: dm4_hs_phy_irq
> > +            - const: ss1_phy_irq
> > +            - const: ss2_phy_irq
> > +            - const: pwr_event_1
> > +            - const: pwr_event_2
> > +            - const: pwr_event_3
> > +            - const: pwr_event_4
> 
> The naming here is inconsistent and interrupts should not have "_irq"
> suffixes (even if some of the current ones do for historical reasons).
> 
> I believe these should be named
> 
> 	pwr_event_1
> 	dp_hs_phy_1
> 	dm_hs_phy_1
> 	ss_phy_1
> 
> 	pwr_event_2
> 	dp_hs_phy_2
> 	dm_hs_phy_2
> 	ss_phy_2
> 
> 	pwr_event_3
> 	dp_hs_phy_3
> 	dm_hs_phy_3
> 
> 	pwr_event_4
> 	dp_hs_phy_4
> 	dm_hs_phy_4
> 
> or similar and be grouped by port while using the the
> qcom,sc8280xp-dwc ordering for the individual lines.

Perhaps the ordering you suggested is fine too, but I'd probably move
the pwr_event ones first to match qcom,sc8280xp-dwc then, that is:

 	pwr_event_1
 	pwr_event_2
 	pwr_event_3
 	pwr_event_4
 	dp_hs_phy_1
 	dm_hs_phy_1
 	dp_hs_phy_2
 	dm_hs_phy_2
 	dp_hs_phy_3
 	dm_hs_phy_3
 	dp_hs_phy_4
 	dm_hs_phy_4
 	ss_phy_1
 	ss_phy_2

so we have them grouped as pwr_event followed by HS and with SS last.

> Side note: Please note how the above interrupt properties can also be
> used to infer the number of HS and SS ports.

Johan
