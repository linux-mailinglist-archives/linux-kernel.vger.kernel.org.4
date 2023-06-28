Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A12F740C05
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbjF1I4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjF1Iju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:39:50 -0400
Received: from mail-wr1-x463.google.com (mail-wr1-x463.google.com [IPv6:2a00:1450:4864:20::463])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC01A10CC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:32:03 -0700 (PDT)
Received: by mail-wr1-x463.google.com with SMTP id ffacd0b85a97d-3140c177274so372109f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blueri-se.20221208.gappssmtp.com; s=20221208; t=1687941122; x=1690533122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOitXtDI9YpyV99jY/iAKB2eEKFNbHNfMiwTBF/Thfk=;
        b=saJhYd6tCpTVOG8M/a65eaY9b9izmGbZgX5e9amwBgXQFllh7CJep1xMRCC0nyf/6k
         XB0diFRbUR3JHZQoFV2g/2wJib6XRCKK72Jd0V8swEGApzPmerBL4sFP/GoPbXTCMNxb
         iG2IaRH/+ZqWxMdpPD22dIydC7+4Tzcnz6eJH66yK6Q699d1FvK/HqvM5eBkDvqR8Vwx
         WGcpv2LG2qohnnukFEmMn/VlVcNY4jXjRRcIR0/XTWVQPtFTAIC/NyJDJELP5C91a3hN
         iJIG6hTxcjZBqg2yP5lj0MZAn2q+LJEYvafqWElfx6HCsPm9MLMep/y0poufAglExOLe
         4wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687941122; x=1690533122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOitXtDI9YpyV99jY/iAKB2eEKFNbHNfMiwTBF/Thfk=;
        b=a1Lv/8AEB7vFzXguU4PLs1mEvOreohHOd9Atgfd7MFgg1mD87pF+H2lBX2oit2KMF3
         GTVQQHCfpnPjDxs/sHmNAWNMdG3fxa7o6RGW4gv62DdVT8OkO1udg723dPibqzEF+S0r
         SiqwJRKrVZu6kNaCV4OlEit9lOdhtsEcVryQLLdlN5UcM1SvRafu3GCg19OIZV4gEXLo
         z84+QCxmi/eati336KRNlnVbtwkZrEcVai0CdIDAHW8781/xRaRbJYA9DidTOYVgsJae
         bCJZBytetsNldkDBOsV3nWLv/wWDOiU7hbJV/JhJ3dSvpiskc0zGUycffrPXj7Kf3x3n
         3p6w==
X-Gm-Message-State: AC+VfDxuubpwbPUj5qiJZewmBw5FXOieu537GA5qXb8e7qP/c1lS1R6O
        pHpMoF7jmwRJ+BSaNvlEU5SJ45e2pYGxMud78aB9ttqOGCvAV5qmIyV8nvT210IA+w==
X-Google-Smtp-Source: ACHHUZ7eSpwvvOnbqbts6UDvaod39iPC6r3GuX7aOK6z58gdKDhrWKZi+Fgt0OT+x7HCxkQq0CAzZjkTAA2n
X-Received: by 2002:adf:f24d:0:b0:313:f8de:1ff2 with SMTP id b13-20020adff24d000000b00313f8de1ff2mr4833503wrp.43.1687941122254;
        Wed, 28 Jun 2023 01:32:02 -0700 (PDT)
Received: from mone.fritz.box (p200300c1c70e84004c535fb20345f739.dip0.t-ipconnect.de. [2003:c1:c70e:8400:4c53:5fb2:345:f739])
        by smtp-relay.gmail.com with ESMTPS id p9-20020adfce09000000b00311fb75d0e1sm2842097wrn.75.2023.06.28.01.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 01:32:02 -0700 (PDT)
X-Relaying-Domain: blueri.se
Date:   Wed, 28 Jun 2023 10:31:57 +0200
From:   Patrick Wildt <patrick@blueri.se>
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: add explicit rtc
 interrupt parent
Message-ID: <ZJvv_bcum7nhrgrO@mone.fritz.box>
References: <20230627085306.6033-1-johan+linaro@kernel.org>
 <20230627132406.GA5490@thinkpad>
 <ZJr_5JIqWSGq-E-T@hovoldconsulting.com>
 <20230628052557.GB20477@thinkpad>
 <ZJvXZDBGBSQfeBdh@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJvXZDBGBSQfeBdh@hovoldconsulting.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 08:47:00AM +0200, Johan Hovold wrote:
> On Wed, Jun 28, 2023 at 10:55:57AM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jun 27, 2023 at 05:27:32PM +0200, Johan Hovold wrote:
> > > On Tue, Jun 27, 2023 at 06:54:06PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Jun 27, 2023 at 10:53:06AM +0200, Johan Hovold wrote:
> > > > > Unless explicitly specified the interrupt-parent property is inherited
> > > > > from the parent node on Linux even though this may not be in full
> > > > > compliance with the devicetree specification.
> > > > > 
> > > > > Following commit 2d5cab9232ba ("arm64: dts: qcom: sc8280xp-pmics:
> > > > > Specify interrupt parent explicitly"), add an explicit interrupt parent
> > > > > also for the PMIC RTC node for the benefit of other operating systems
> > > > > which may be confused by this omission.
> > > > > 
> > > > > Note that any such OS must still implement a fallback to the root
> > > > > interrupt domain as most devicetrees are written under the assumption
> > > > > that the interrupt parent is inherited.
> > > > > 
> > > > > Reported-by: Patrick Wildt <patrick@blueri.se>
> > > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > 
> > > > It is good to encode this in the binding and fix other such instances.
> > > 
> > > Not sure about that. Perhaps the spec should be updated to match reality
> > > instead... We have many more instances like this, even for this very
> > > SoC, but apparently OpenBSD or whatever OS needs this falls back to the
> > > root domain then.
> > > 
> > 
> > Just because linux is doing it in a different way doesn't warrant an amendment
> > to the spec IMO.
> 
> My point is that it's apparently not just Linux as most devicetrees work
> this way at least for the root domain. And then it may be time to update
> the spec in some way.

I'm not sure about the point you're trying to make.  In OpenBSD's
implementation, which I think complies with the spec, for non-extended
interrupts we check the node's (or all its parents') interrupt-parent
property.

Technically the SPMI arbiter could define an interrupt-parent that
points to itself, because it's using interrupts-extended anyway to
point to the PDC.  But that would feel a bit stupid and not really
correct.  Alternatively each child node could have interrupt-parent.

That said, I understand the point that it might make sense to amend
the spec so that if a parent node is an interrupt-controller, that's
most probably interrupt parent, unless an interrupt-parent property
shows up before.

I would like to add that OpenBSD supports a number of SoCs for quite
some years and this is the first time I've hit an issue with interrupts
that were not designed in a way for the current spec to work.  That said
we obviously support quite fewer SoCs/boards in total compared to Linux.

Cheers,
Patrick
