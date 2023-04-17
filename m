Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146B46E4208
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDQIFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjDQIFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E20F1BF;
        Mon, 17 Apr 2023 01:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EFBA61FD4;
        Mon, 17 Apr 2023 08:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6F3C4339B;
        Mon, 17 Apr 2023 08:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681718704;
        bh=0Y/mnS2pjaYk07j+LJSA/55y9ntA2FADo9/M3Dr4xgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGKJDv/BLy56BiFvmzmoetNbBUmKx1OS5vjufwpa9DMDa4mpBFiD918rvHExFqe9f
         YsTYesSOFT7FcZyJvTAJjSCRAtAFNpoX/uS6xAF3TxMBqeB7QPV7uAbmI0B0qMB7Yn
         kATDatbmgWXBYL3FWMniD9DEHM/iztPJ4+H9e4pSqLzimIeAP6znCuSo8LggP5GfRZ
         M0bNu7BjUDOxcEQmUQUttIaWAC36jaDyOwaKa+KYPlrauqv/uKzIK69VTXgd1RPXy9
         mZGu2O8Y+qd8VOMWyw+ziPsCOVg2C4bT42JBJQ/xl0FDFDpV9LUUHS+izm0F1VV3K7
         xax7EE8okIlgg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1poJrL-0003gR-Mp; Mon, 17 Apr 2023 10:05:11 +0200
Date:   Mon, 17 Apr 2023 10:05:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
 PHY
Message-ID: <ZDz9t9TkBqZ1fcfn@hovoldconsulting.com>
References: <cover.1680693149.git.quic_varada@quicinc.com>
 <1efa9a64499767d939efadd0aef897ac4a6e54eb.1680693149.git.quic_varada@quicinc.com>
 <0a66e291-a86d-1ff9-e674-839b8cc8f1da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a66e291-a86d-1ff9-e674-839b8cc8f1da@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 09:41:49AM +0200, Krzysztof Kozlowski wrote:
> On 05/04/2023 13:41, Varadarajan Narayanan wrote:
> > Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
> > 
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  Changes in v8:
> > 	- Update clock names for ipq9574
> > 
> >  Changes in v6:
> > 	- Made power-domains optional
> > 
> > Note: In the earlier patch sets, had used the (legacy)
> > specification available in qcom,msm8996-qmp-usb3-phy.yaml. Moved
> > to newer specification in qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> > ---
> >  .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 43 +++++++++++++++++++---
> >  1 file changed, 37 insertions(+), 6 deletions(-)

> > +        clock-names:
> > +          items:
> > +            - const: aux
> > +            - const: ref
> > +            - const: com_aux
> 
> Can anyone explain me why do we name these (here and other Qualcomm
> bindings) based on clock name, not input? Just because different clock
> is fed to the block, does not necessarily mean the input should be named
> differently.

I guess part of the answer is that this has just been copied from the
vendor dts and (almost) no one but Qualcomm has access to the
documentation. What would the input names be here?

Also note that there are SoCs that enable both 'cfg_ahb' and 'com_aux'
(e.g. sc7180).

> > +            - const: pipe
> > +
> >  examples:
> >    - |
> >      #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>

Johan
