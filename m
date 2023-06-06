Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C195B723C89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjFFJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjFFJG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:06:58 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC02E8;
        Tue,  6 Jun 2023 02:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686042414; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iDCNYdm7JTLiDLNmFtfUAjZr1UiesJxNO8/KTf5OlGv6WaSHk1cfpluOhHKYdnNgQi
    YRlva+6qyWHAJ+EBpybp0N7BWx0rfyqcD+qbHgHgzUuuU1spLmwxYEDMy/nWG4Pdeg5x
    YbV6GoY+hx4dT3VsuEu0VvB/W5BVEsl+KNWGIY4vscN3KPbNfwbgP46pGKEIzQ9/DSZ6
    hwNU+02Qp7ShjhfqM0/xeI4wqnwDihuutvuyyY/j3K1Ovukdq1rv+WuMH6wtfbs9MoFT
    KPsv4zXuwQuhc+FA83ABtm3xpSTDLcT71hcOFHsN8dCx2/Fl410ik1sjzjBE2VJc6lxv
    XzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686042414;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MxljD7ks5H/LgsphPWxQ4t5v0cK2mi0IBL2/Ko8mMDc=;
    b=aPCHaPCXgIzHF5ea2rVIfvll1o7hQytOKlcC/FHoPFKnF7BJxwi1DwUbs1mMgoHs0L
    L/Rr/Dq7XmzsrKUV7Bm7vBnuCbCuNiQsHdWeBScL0b8QSqBP6nH9GOuruS1z1OrLccfO
    JLgM2jCh9vYLehIiQIP0bOMFH9VwABN9kRGb5RRxLH5Eet8IQ9GiG0kGMUZm44dRlQ/I
    eKm0V0azlJ4bRd9ndkas62zrU9JXhhZxSNwERCedRRxVtKJvvAyWg91hFZnSc/7BMXiN
    lPewi5mvoaK7DAb5D+lLIkV4zQXaxmajMV9DCQSZaNZrcPnuem+BgBcqIHmNuN6UMX7E
    8cGQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686042414;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MxljD7ks5H/LgsphPWxQ4t5v0cK2mi0IBL2/Ko8mMDc=;
    b=Nivw6PPvm02HZYqAm05b3lzcVMCMSsJfhE2uHUSDWDO0K9NL/8QqHNX7R6iqJRzpI8
    S6GPRXpzPVj80e/Rp63uZBqNgdARi1MLeEOhyE3HUCXeaSz9R8VJiUQY8kX3As/FNwrP
    CBwAitMqjmx7HQEaab3xyrRH6nhrL3s1NvB7wZDH3ZjCqCx7/2mBgSCWKMrIrb5qbHgv
    ascfbvbSG0IK+bAxkKLYnVPhBSPgG59bUOLo311KliuygFO46F5gzRy/B2qAnfxNjxWT
    4t4I/VcqycbnuMTR9GHV92BL4C8mAj8HqQNKD4KCkb8lPbclPjk+yYDrjru86I1RhLVd
    q5dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686042414;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MxljD7ks5H/LgsphPWxQ4t5v0cK2mi0IBL2/Ko8mMDc=;
    b=0o844zOm9ZCfU50CXT8WN6pfx0hJyuhU1CUluPy8qDAZJQgnHL+buhlBpa46FvQwKd
    9HqoUeQS87NnLxdRnABQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5696sDLQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 6 Jun 2023 11:06:54 +0200 (CEST)
Date:   Tue, 6 Jun 2023 11:06:47 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 06/14] dt-bindings: soc: qcom: smd-rpm: Use qcom,rpm-proc
 in example
Message-ID: <ZH73JxLd1i1vUcyw@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-6-e0a3b6de1f14@gerhold.net>
 <d0fa3b01-edab-fe8e-c309-036cbbcec7ab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0fa3b01-edab-fe8e-c309-036cbbcec7ab@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:37:04AM +0200, Krzysztof Kozlowski wrote:
> On 05/06/2023 09:08, Stephan Gerhold wrote:
> > Use the new top-level rpm-proc node instead of having a dummy top-level
> > /smd node that only contains the RPM but not other remote processors.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
> > index c6930706bfa9..06e574239bd4 100644
> > --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
> > @@ -120,10 +120,10 @@ examples:
> > [...]
> > +        compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
> >  
> > -        rpm {
> > +        smd-edge {
> 
> What about binding updates?
>

The binding for this is in PATCH 05/14. The old binding replaced here is
deprecated in PATCH 07/14.
 
> Anyway, this should be squashed with previous one.
> 

Sure, I can squash in v2.

Thanks,
Stephan
