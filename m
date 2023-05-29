Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D141714D07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjE2PbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjE2PbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:31:18 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8834DD9;
        Mon, 29 May 2023 08:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685374271; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZWNNI8PyCR+d4i5F2P9GsPf0j+rqx7oQWPXBR2AgoFU8EXxZDqZmttHqmLxznOfMhA
    cug+3TY3WFfeG6VMBvldrZ1F72EeF7H6xcWaNyzdKQv0HutluJpa6n+cj8GY7+ZNJ963
    R3Z2dybFUvNef1KiiH8SobofruNZwNW7FA5iVRA6JPds0BprRuhFxN+xn6T6KimXXs2+
    r+oHI0Y0xKBw5EjdnoM8g6Ss5+wU1imBldpVK1tfQwz12BtUVub1mcVsGOHcFWwqjr0z
    TtAEBI8VXTMydclIabsZU2kqDgDgtr2Lm7Z3BwyARzqwr+Rh9brn0fTMBxz1JfDKxLsT
    q8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685374271;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uhEl0+pbjdfQRz9s1ekPHu0lLoDCnjrJFq1o5JKvOJo=;
    b=hVY3pULW+QjkA1hqPLjjxVgqKrRZlpGqrqdsWvdjqQrvhpRirAMWG7xt6lhaBBfs/E
    BYnvfVcW5altB8zjCvMoQh1ylzZy7cIqJTMzW7DOjmF1iA0SbBsFYQWnQMLR3SyozQWv
    kUI060FpqoExACC1vBOimB7oV0E581eP7KqWlhPeA09gbNwjjhnMsJhlIVamNAc/BlSj
    jy97J75waFx06rGK3IRSSkOp7uOlrQ7fDtRv7R0SLVIMLPkJwDR1kZ3a6IMztRzgMwO5
    fIaD1y10CtKw2Ah+cLxMEGC4+xGnmt58zqGPu1pvPgicnnzxBB5+Rovf7S4Og9w+NIR2
    soUw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685374271;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uhEl0+pbjdfQRz9s1ekPHu0lLoDCnjrJFq1o5JKvOJo=;
    b=oxkxPJboe6874s3mgvvK5mCyiJfYijN+c4ZpPsihxZLm/2SDIzP9fAOS1nWHM7JTL5
    YJS2caHzjwY+dIWuC0kYkKmQzF2pMyufdmfPKLVDcI+dUdIUc5/voxeCns9tVUxsfYJm
    DXRkOpTNohakl4JrwozIWpuchnjF2Tv8Yac/oXaXspjLDAC/2KGrdZeXSqubuazPg+X2
    G8Q8V4/SvJtYm2Giv+Yq902RkOngrBT0Lpc6EdTBViztf/yXzWY4ndDaKdyw1u639cNx
    6vrT65xEjk1A1eIJbl9/WckFxx7qGjg2zOSpuWawkE/5yxMxtbLFqybH2QrHVNwrjHZe
    a4xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685374271;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uhEl0+pbjdfQRz9s1ekPHu0lLoDCnjrJFq1o5JKvOJo=;
    b=urc66XG1iByNukL4E01a7Kvrca0FnXy30XAvhG3Ycok47s8u0LdXANE8VA+OsHwkeW
    TqBhUJ48LO3CMuSTmfCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8pqP1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4TFVBfH1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 May 2023 17:31:11 +0200 (CEST)
Date:   Mon, 29 May 2023 17:31:05 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] arm64: dts: qcom: msm8916/39: Clean up MDSS labels
Message-ID: <ZHTFOZFxq-JgLP-p@gerhold.net>
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
 <20230525-msm8916-labels-v1-4-bec0f5fb46fb@gerhold.net>
 <6f1954e6-e98d-6911-8721-c50082bfb1d7@linaro.org>
 <ZHS-HSgaBxMXiKy9@gerhold.net>
 <17f31258-bc38-245f-532f-fdaa1ee8ad33@linaro.org>
 <343e2e95-17ee-f5e3-61e9-7e0b793859a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343e2e95-17ee-f5e3-61e9-7e0b793859a6@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 04:26:09PM +0100, Bryan O'Donoghue wrote:
> On 29/05/2023 16:24, Bryan O'Donoghue wrote:
> > On 29/05/2023 16:00, Stephan Gerhold wrote:
> > > Do you mean update the examples in the yaml bindings
> > 
> > Yep.
> > 
> > grep dsi0_out Documentation/* -r | grep qcom
> > grep dsi0_in Documentation/* -r | grep qcom
> > 
> > Consider splitting this patch out and fixing up[1] Documentation/* and
> > arch/arm/boot/dts/*.dts[i] , arch/arm64/boot/dts/qcom/*.dts[i]
> > 
> > We may as well be consistent everywhere.
> > 
> > ---
> > bod
> 
> 
> [1] In a standalone series
> 

Right I will check this and try to adjust the documentation and/or the
other SoCs in a separate series. I would still prefer to apply it for
8916/8939 as part of this series since I have some unrelated follow-up
changes that would just cause unnecessary conflicts for Bjorn otherwise.

We already have most newer SoCs using the naming convention in this
patch so it definitely does not make the existing situation any worse. :)

Thanks,
Stephan
