Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500C9732878
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244119AbjFPHKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbjFPHKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:10:25 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ACD2D60;
        Fri, 16 Jun 2023 00:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686899413; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EmmwaDuL+oUewtzIiE4mMsN60386Wlm+mEhq6h17zDIg2lUIonHUkz4W8b9bhJlEHl
    jRNalDQCa0AgZfZGCGNz770uh4t7eE53C3xv2croPeVbQPzRTL+yWyE80hln/nl+5zTu
    +JAeeFOzxpRKwFTSo/1eei7SpJT1Jsi3lo0BjmX8Vb4lM1nrlB4H/jNpxJY204Pxrmir
    mHoS41pWswarj1It+lcCcIAQPQqEYs438TRfHKu7ULn9mujP2Ua2m1zzkWRdN6qVTlxl
    oLlR0PIkrhP2TnwZXi43jo/SFujCDZ98sQwToO3MnCNqcnfVWoorpIqnQSGX3HpUmDjd
    SK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686899413;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6bj6OhpL8ADtbPRgjI8wj2KMXCzk6AQP6LCMNnLHMHI=;
    b=ZQXj61qvRs3thiEvSzOJxIYl9zT7VH3Upws/0MouWvDYHKshYk57CGuyxc5hYCwwHW
    pys3rYB/gKjErYJbysji3lN8v74anlueocXHjMmH5ryr5MNMwUrIFdT/6TTZmzs8T7lV
    E9Ks77QIhFoDWAbRQZSDFalMAyQOe7uqXeqQRYkCUlJYzihdKEeCEYeacKmQt2YYWgaV
    Mjq7YRLp+57R6MqY+GRMVXhjDP3C9O85/vGfsEHcuv/vRdLyFdKCfmtvHYiAnhU+JJLc
    +a4pSP4fRl9qn+Ys0xSqn1xsXYNhAitC4UF6v/gZWMruyeS3kRbk31P87qF6D49xr+Xg
    rFow==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686899413;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6bj6OhpL8ADtbPRgjI8wj2KMXCzk6AQP6LCMNnLHMHI=;
    b=pQW5HiJZ6tsJMvqqgpU2Lb5dO4oT1D1PEd6WtbQtz64mdgWEF2BL5zn3aNnm5LHYst
    R8Z5e4dxQavNz7pa1GNf2Wv7AS6+MCwCGLHpfHbCaaBOhJ6GKWBib4z+hkNV9HZQLeJV
    K7qityReSnN9VLChbzaeG79XdC/gY9X44qSMmN6rSFNogbr8ZyW+rSnFtOedlB3SQIVH
    YK7OF2ygRm5oHm+hTPSDcPfU29wfTOa0gimCvFasQcRRknQMJKas7qXLS9bZNMg/Xv5z
    bLmYrFHpuu6/9/4mhykgB7WMV2DgksGnoKIJTqcBnJdZ/Jxh2MG7DaBniUAGEwcG0zDk
    SCLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686899413;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6bj6OhpL8ADtbPRgjI8wj2KMXCzk6AQP6LCMNnLHMHI=;
    b=R93C0+jXkkK1vueO15Gd+JLVoJKNNsnakhYppOt7XTPMuRimALW+AHUu/w/eyookjW
    Gi8haWBJK8OfVYZfPlCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8pqP1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5G7AC59W
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 16 Jun 2023 09:10:12 +0200 (CEST)
Date:   Fri, 16 Jun 2023 09:10:06 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     andersson@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        konrad.dybcio@somainline.org, sumit.semwal@linaro.org,
        Will Deacon <will@kernel.org>, amit.pundir@linaro.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for
 trogdor
Message-ID: <ZIwKzozbXxhQHxma@gerhold.net>
References: <20230615145253.1.Ic62daa649b47b656b313551d646c4de9a7da4bd4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615145253.1.Ic62daa649b47b656b313551d646c4de9a7da4bd4@changeid>
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

On Thu, Jun 15, 2023 at 02:52:54PM -0700, Douglas Anderson wrote:
> Trogdor devices use firmware backed by TF-A instead of Qualcomm's
> normal TZ. On TF-A we end up mapping memory as cachable. Specifically,
> you can see in Trogdor's TF-A code [1] in qti_sip_mem_assign() that we
> call qti_mmap_add_dynamic_region() with MT_RO_DATA. This translates
> down to MT_MEMORY instead of MT_NON_CACHEABLE or MT_DEVICE.
>
> **Apparently Qualcomm's normal TZ implementation maps the memory as
> non-cachable.**

Are you sure about this? From the discussion in the chat the conclusion
was that we can check easily for TF-A, but we have absolutely no idea
what Qualcomm's firmware implementation does. It might be "broken" the
same way and we just have not noticed it yet.

I would perhaps just omit this sentence so we don't risk misleading
someone with information we're not sure about. :)

> 
> Let's add the "dma-coherent" attribute to the SCM for trogdor.
> 

What about sc7280? I guess they use largely the same TF-A firmware?

Thanks,
Stephan
