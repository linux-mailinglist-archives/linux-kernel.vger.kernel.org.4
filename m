Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9173FF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjF0PQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjF0PQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37591735;
        Tue, 27 Jun 2023 08:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FCC0611CE;
        Tue, 27 Jun 2023 15:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9746C433C8;
        Tue, 27 Jun 2023 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687879009;
        bh=zcg5VTHtV7nio5jd3NtBafSOvGTKTW5bNlR/bEqbIcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=if16nDJdJKGrkct5P9OI/SaQ/Sx5SeEjD5dvafflrsul+ruUjSdJksYdmMNYWi6kC
         FG9+Txe6R3g7UNU1xfaqlYE9YSAKPIBfjPIttpXCxu1dkK2SbwlPoiYukpjRLuc0LK
         4j0q7SZ5wkve9JyX/1fnDaG+tKfAalIPjusK5M/G7UZeY31Dafmsu3jsGWVpeomwFz
         FpzDPUtk3hITyS3PB4jrvT8p5nWxkOmhYoSlpApZ1/gXQG3LbZd6lDFt6lhCmNIwkp
         TIw38VZnpk5b1HoTPQygFq0e8qHNohW4BJBROi9H+qmPy98LnoTTt5bg3WL+uFGVUK
         KwVNCNXhAsbsA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEAQw-00045R-Gd; Tue, 27 Jun 2023 17:16:46 +0200
Date:   Tue, 27 Jun 2023 17:16:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 08/10] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <ZJr9Xiv6_0nG0Pui@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-9-quic_kriskura@quicinc.com>
 <2eab503f-fa0d-990e-bed2-2445c5496798@linaro.org>
 <b183a130-6237-7d15-5d5a-b56582b92b35@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b183a130-6237-7d15-5d5a-b56582b92b35@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 12:43:23PM +0530, Krishna Kurapati PSSNV wrote:
> > On 21.06.2023 06:36, Krishna Kurapati wrote:
> >> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
> >> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
> >> platforms.
> >>
> >> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

> > Not a comment to the patch, but very nice that Qcom ensured every
> > endpoint is wakeup-capable, this used not to be the case before :D

> Yes wakeup is supported by all ports now, but I didn't make those 
> changes now as I wanted to keep driver code diff minimal and don't need 
> wakeup support for the product currently. But for sure, will update 
> driver code to handle wakeup on all ports in near future.

Why didn't you include it in v9? I thought you had a working
implementation for this?

Since wakeup will be another case where glue and core need to interact,
it's good to have the wakeup implementation from the start to be able to
evaluate your multiport implementation properly.

Right now it looks like you only added wakeup interrupt lookup and
request, but then you never actually enable them which is not very nice.

Johan
