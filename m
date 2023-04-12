Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1F46DEC6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDLHUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjDLHTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A707A5FDA;
        Wed, 12 Apr 2023 00:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 453FC62EC0;
        Wed, 12 Apr 2023 07:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C421C433EF;
        Wed, 12 Apr 2023 07:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681283978;
        bh=TQltmBsNQWqTpXlk7lYjhpue27q5v+hRw8tcrt0yGbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHRwriL8YKvV58OPayVsfvdnkqVOVxf3/v1jjfjI2g3pHjssVEMGZmUZQ9JdAKpb1
         G4wbvvmdEA7fAh7HkmD7cy/wc6j8iP1rZCA3nDR7Ma9IqWM8alnLSMA27jU8d9rAYd
         eayNO+hSxdkAsGabjDSvDO1LcX6NbDPBDaebcrs2RAnVr5gGutjCSrHxoIF0FTpedZ
         rfq3HAnp2dWPQNgMSD2++Vq0U59bmT+pn5KE+wARGYeF9YURyGmxw/vAmZM1zIzu7Y
         rOHC2NDKP/7vJIAGE9lSPRGKgYmDr8PGmOl0M5ZzYexDOQXjtVGFSqBoudLvu8s09S
         7RX46qupNG+3Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pmUlV-0007Yv-R3; Wed, 12 Apr 2023 09:19:38 +0200
Date:   Wed, 12 Apr 2023 09:19:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-lenovo-thinkpad: correct pin
 drive-strength
Message-ID: <ZDZbif25qQh79cuG@hovoldconsulting.com>
References: <20230407180710.128815-1-krzysztof.kozlowski@linaro.org>
 <ZDVtXkCON8DFUDjh@hovoldconsulting.com>
 <887eb9f6-9882-37c6-4332-ddae7a354187@linaro.org>
 <ZDZUiW+74rhhRAfS@hovoldconsulting.com>
 <15e1d05f-b7e1-27bc-7363-aefd2d155eea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e1d05f-b7e1-27bc-7363-aefd2d155eea@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 09:03:31AM +0200, Krzysztof Kozlowski wrote:
> On 12/04/2023 08:49, Johan Hovold wrote:
> > On Tue, Apr 11, 2023 at 06:58:33PM +0200, Krzysztof Kozlowski wrote:
> >> On 11/04/2023 16:23, Johan Hovold wrote:
> >>> On Fri, Apr 07, 2023 at 08:07:10PM +0200, Krzysztof Kozlowski wrote:
> >>>> Fix typo in drive-strength property name.
> >>>
> >>> In the future, please try to use the established commit-summary prefix.
> >>> In this case:
> >>>
> >>> 	arm64: dts: qcom: sc8280xp-x13s:
> >>
> >> Sure.
> >>
> >> commit ca1ce7207e53cfe69aee5002eb3795069668da53
> >> Author: Johan Hovold <johan+linaro@kernel.org>
> >> Date:   Fri Aug 5 11:23:17 2022 +0200
> >>
> >>     arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add alternate touchpad
> > 
> > Yeah, we initially used a longer prefix (including "x13s" which was
> > missing in the Subject of this patch), but quite soon decided on using
> > the shorter
> > 
> > 	arm64: dts: qcom: sc8280xp-x13s:
> > 
> > instead.
> 
> Thanks. Do you know if this rule applies to other long-names? I was
> usually keeping full name or shortening them by cutting end, but maybe I
> should cut the middle?
> 
> sm8250-sony-xperia-edo-pdx206
> sm8250-sony-xperia-edo
> sm8250-pdx206

I would not call it a rule just yet, but I guess there are further cases
were this could have been used. Perhaps you can all decide to use it for
the other Qualcomm dts as well.

For the X13s the, 'sc8280xp-x13s' is enough to uniquely define the
board and it mirrors 'sc8280xp-crd' (and using a shorter prefix makes
the commit logs easier to read).

The general suggestion is still to check 'git log --oneline' for the
files in question and use what appears to be the (recent) common prefix.

Johan
