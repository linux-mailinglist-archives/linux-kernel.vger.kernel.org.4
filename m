Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C8F6F8DB1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjEFBmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjEFBmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:42:19 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3936249CF;
        Fri,  5 May 2023 18:42:19 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4QCqzt3ZhdzDr2s;
        Sat,  6 May 2023 01:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1683337338; bh=vs2YuPaytKDjBTRynKJpc3Hgi9UoEfaxQaAni4Rf1a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgrpnDK+oNRTRzjJ9MeyOLAHcqsuEVKnBsWCjOW6C9vVqiprZYf8szBpM85cY96qy
         K3Fy35ZfmTWK8akDqqlzuEg+WjttweqqAtPSozoz9avltiGh8ieWLt/hvS9jZDyM/a
         UmxIaIGs4ekngFkuDpD5pkjH3CBCw+gyPgK82Ook=
X-Riseup-User-ID: 614E73F19DCF99408E8A608DE2F9D45AABC64D3F62FB10FDA8135F4B5488F1D3
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4QCqzr2WJzzJq6w;
        Sat,  6 May 2023 01:42:16 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS
Date:   Sat, 06 May 2023 08:42:13 +0700
Message-ID: <7894772.GXAFRqVoOG@melttower>
In-Reply-To: <abae55ef-172b-036f-40a9-b27c38e850ec@linaro.org>
References: <20230505-fxtec-pro1x-support-v2-0-0ea2378ba9ae@riseup.net>
 <20230505-fxtec-pro1x-support-v2-1-0ea2378ba9ae@riseup.net>
 <abae55ef-172b-036f-40a9-b27c38e850ec@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	qcom,board-id = <34 0>;
> 
> Does the bootloader refuse to boot without these? Some newer
> ones don't need it.
> 
> In case they are compulsory, you'll have to add the pro1x to the
> relevant allOf:if:then: block in bindings.
> 
Tested, nope.

> > +&usb_dwc3 {
> > +	maximum-speed = "high-speed";
> 
> Do you know whether the phone supports usb3? Usually if that's
> the case, you will get usb3 in fastboot.
> 
> You'll need an actual usb3 cable to check that though, many claim
> that but then don't have the necessary wires connected.
I asked around, they said yes but without anything to test on hand, I'm not 
sure.

Should I remove it or something?

Other than that, I've fixed the other issues with the series.

Best regards,
Dang


