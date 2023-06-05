Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51188722358
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjFEKYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjFEKYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:24:06 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D04694;
        Mon,  5 Jun 2023 03:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685960642; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JJ0i9Q4bHW4MKttszRWIs71hBZbIkHnupdhYsy7UPPfp1tfqzjQmdeU3R59eyOJyaT
    KfoaKG6CMYOcLR8OaZ3hDZ4apf1N/Xhgs9dNv9v35k+GSnZ7r8kemB3UBS7FWyx1gXHe
    /GZ4jV0Qh4ysG2ct/oz6DILxPKp0AEf1BVIna/cImvDMxF6BxNMP5m+mKOYhZ0qqexxa
    zte08va4GwqxxzdoD8PAMprTZCv4dkSpvqkThgaKDhDtUXauFXhmO3pNf0j8dNRgjsP5
    Dec5ZClGYnA6lnFdlWQjvkbpIzjrs4+7F2oqyfFuWmrrvb7RNpA/mTih7hRkhfNI4IAL
    L4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685960642;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/G5YxFuVt/PQPjjBymERubZJ/AgaMXPPNH/lbNDTfJI=;
    b=IuQemZpnMqqd8b/RRSLUwAmpoVCr9Zihgpc7VkhhusO8XSv0WaSALCbSI9/PWRWJa0
    qi3kDHbPPe+t1y1vc4qF0T9vLnc3z2Ie8N5d5sCCzN47WCtzKsS/IqYliDvzGZQpyV94
    sGOhYuesCZXIBWrJFgM6doDqdCV54jMCwYpsoSqpe63z/G1DHyCh5/3Fj1cG26fKQUhS
    8LfP7BVnXEQc+4BGlxMR5gU2VFvQKoBWK8CUpoKOv0w97jSRXS0hc17YrI6sUyXOb+Lo
    29rvh1Vs/1mKiI8s/u+CqSEvKvddCGjZcTNQLU9pZeH17yK9sL+x+Q8fTseIiF9Ya790
    SxXg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685960642;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/G5YxFuVt/PQPjjBymERubZJ/AgaMXPPNH/lbNDTfJI=;
    b=TPTgY3CfrGKfRSgbf/vJcGQTQJKll6bOhze+H6WgcWpkDeOkUKtCTlnbmfBo9OHxYs
    lkuvm6dnMhsyo8R7bXgKKy/wl8oAWG1+eUuun7ecMy4FPc9XrfRHSWTc0Kic4A4V/JmN
    9isBBa1eUWCcZg2+2bYgRTKAC7uihZQMrLKQTAl7W9/kCGFiRbp22WL/Qg1Ffas3d4bP
    yFQinbIy0Ai5ABlAEIwU056qarGpMkiFs0WLfC2Y2mO5HdukB0sGHEGzSdKhI1yLSi7t
    QBPMXSJhubCoXq2gBONEZyb7jKbvMBe/QY77AJRnCKODoKMlJ4/tyhZk3V8CO9UFeJ+p
    psYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685960642;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/G5YxFuVt/PQPjjBymERubZJ/AgaMXPPNH/lbNDTfJI=;
    b=vF30bbWnrD5f3Z/pFsbTS2d9I9wDOqfDnWF7BScBldfycDFUzeeYfcOBCNBBlgSIK6
    uHgMe0MWdDrD7YH2H/AQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z55AO29r5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 12:24:02 +0200 (CEST)
Date:   Mon, 5 Jun 2023 12:23:53 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: Split sdm845-db845c to add headless
 support
Message-ID: <ZH23uaMD2I249E8I@gerhold.net>
References: <20230605094710.2037879-1-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605094710.2037879-1-amit.pundir@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 03:17:10PM +0530, Amit Pundir wrote:
> This is a follow-up of the upstream discussion,
> https://lore.kernel.org/linux-kernel/20230124182857.1524912-1-amit.pundir@linaro.org/T/#u,
> around adding a reserved memory region in sdm845-db845c
> for the framebuffer memory (the splash region set up by
> the bootloader) but the general opinion was to avoid
> adding that reserved memory for the headless DB845c
> usecase.
> 
> So this patch splits the sdm845-db845c into a common dtsi,
> a new sdm845-db845-headless DT, which disables the mdss
> display subsystem, and a new sdm845-db845c DT with an
> additional reserved-memory region for the framebuffer.
> 
> The default sdm845-db845c.dtb remains pretty much the same
> (with an exception of additional reserved-memory region),
> while others can use sdm845-db845c-headless.dtb for their
> headless systems.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>

AFAIU the DB845c doesn't have a locked ABL. Wouldn't it be cleaner to
add a simple check in the bootloader to see if there is a framebuffer
set up or not and then disable/remove the reserved framebuffer memory
from there? This should be just a couple lines of additional C code in ABL.

It would also prevent that one accidentally uses the headless DTB with
a bootloader splash and gets the UFS crashes you observed.

Out of curiosity, can someone explain what's so special about the
framebuffer memory on newer platforms? Is it protected by the firmware
to disallow other devices like UFS to access it? On older platforms like
MSM8916 the bootloader framebuffer memory isn't really special. Without
reservation there can be temporary garbage displayed on the screen, but
it's gone as soon as the MDP driver is loaded.

Thanks,
Stephan
