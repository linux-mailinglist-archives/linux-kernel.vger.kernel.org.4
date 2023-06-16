Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC0F733400
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbjFPOyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjFPOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:54:23 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F45630C5;
        Fri, 16 Jun 2023 07:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686927250; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KGkoAUAKeMtiRBHVomx2iWOqlEDsXi0cSjrFNf+LsOCs1wXYKi/BYdHwuyDBjmwcTc
    rj3cruwD7eEp22/9acWr0IRg8X83RcwmgDD29sfEaKhuKhOsdNI6HStAmLQS9p5JEOms
    tA085JRZcrlj1lI/q7HT1cueuC6LOjD+y0IP7yLoRnjRNjCmcmjdgjdhODrmN9cGo/U8
    4GkTHD4NqcdISWLoZgdGghrx57UwSdRkSni4FGrnwV2KjLnh/+1O5rDiJKTpJof/2qHJ
    HuZhbN9O0H67iCUEatgZodYQt83yp4wHen92lvfKRv7yCq5m8wwHMUGs5SLzyShS3Lsa
    8QUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686927250;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CovIgCHeF0fMuwJihtOV1zblRbWNaXqCptxNFr1SbO8=;
    b=MvxaxHqptbHO5z4fRe/eq1Oavixy9RumPWI1w16fgP698bw0xVFY9LsmgWbAydRHUB
    XW4PeLE6uFa73/RTxQQwkb10T5ZZ4SrYnbwFuM8f0yFGnLksfF9S2bjX/X0Oj/hTWM00
    3dcFg4VqtJJLwpIggI73vf2qLsVyN7arg7919EqXWoBbDx5JiVrZJfFS3qbmFyQi9w5X
    VZew28S/AXrSM7GEUr9I0bMviXLzRC/4YEZl88JsIMe1niVOqulz2jg+jG2IpWE63nAJ
    pkOzpJXhqL4dWMlB0dMM1wudiRis2XfE41vSoGhlw23Sx64Dzt0BHNcDSGROC9XruWJ9
    0l7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686927250;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CovIgCHeF0fMuwJihtOV1zblRbWNaXqCptxNFr1SbO8=;
    b=NzPhoOj1mlA1aThMZ4IIPGuanB+Yj3cmkW+pgpE6O4BeuiUSj0kvAm9EaRn9oVsN0Q
    5KYTxKhCr0JSe8s7wNaAcLiHO5QCsyjosFjtjv/LIvy1HeQY1peGcryKfdOuze1hgE58
    nsRIcwvTVEiXhSjpbHBQhevVblgIMhj18t9Pbgas6QXUlcgPGyq8zb1yDlO6q/FyNoQZ
    +6MfQiFBIl6sZ7TWxKfiRJo5tDIDxUwZxUlUWHQ6zknA7qUqZ+xUdQp+XDPGDF8l5B73
    OmEj0f0QnDGgB7E7TeqPP41jBTNiAyCpXDoycOQ2Ln1SMG3UQS+3WI3jL4guWGf+yLpc
    6QjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686927250;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CovIgCHeF0fMuwJihtOV1zblRbWNaXqCptxNFr1SbO8=;
    b=Zkx1xt2T3doGB6GlxCwLHaKDZDGpC4Kb/WZ2WhNNIKNVhO48qpnoho811c1c2ExC6M
    k9QJvX5el2RmT6PXGRCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8pqP1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5GEs971L
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 16 Jun 2023 16:54:09 +0200 (CEST)
Date:   Fri, 16 Jun 2023 16:54:03 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>, andersson@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        konrad.dybcio@somainline.org, sumit.semwal@linaro.org,
        Will Deacon <will@kernel.org>, amit.pundir@linaro.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for
 trogdor
Message-ID: <ZIx3i3qmv-aM-RdB@gerhold.net>
References: <20230615145253.1.Ic62daa649b47b656b313551d646c4de9a7da4bd4@changeid>
 <ZIwKzozbXxhQHxma@gerhold.net>
 <a5605da0-5b6a-cfeb-f095-bbf963551c08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5605da0-5b6a-cfeb-f095-bbf963551c08@linaro.org>
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

On Fri, Jun 16, 2023 at 01:20:09PM +0200, Konrad Dybcio wrote:
> On 16.06.2023 09:10, Stephan Gerhold wrote:
> > On Thu, Jun 15, 2023 at 02:52:54PM -0700, Douglas Anderson wrote:
> >> Trogdor devices use firmware backed by TF-A instead of Qualcomm's
> >> normal TZ. On TF-A we end up mapping memory as cachable. Specifically,
> >> you can see in Trogdor's TF-A code [1] in qti_sip_mem_assign() that we
> >> call qti_mmap_add_dynamic_region() with MT_RO_DATA. This translates
> >> down to MT_MEMORY instead of MT_NON_CACHEABLE or MT_DEVICE.
> >>
> >> **Apparently Qualcomm's normal TZ implementation maps the memory as
> >> non-cachable.**
> > 
> > Are you sure about this? From the discussion in the chat the conclusion
> > was that we can check easily for TF-A, but we have absolutely no idea
> > what Qualcomm's firmware implementation does. It might be "broken" the
> > same way and we just have not noticed it yet.
> Nikita (+CC) was able to boot Venus (which uses that memory reservation
> call, I believe) on next-20230615 with a WP firmware, so it should be okay..

Unfortunately we cannot draw any conclusions from a working case. Doug
mentioned this happens only with CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y [1].
But even with that in theory there could be side effects that invalidate
or evict the cache line, making it look like it's described correctly
but it will just explode at some later point.

It's more reliable to draw conclusions from a failing case: I asked
Nikita to test with "dma-coherent" added to SCM on the WoA firmware.
This fails with similar errors Doug had without the property ("Assign
memory protection call failed -22"). Clearly the firmware did not read
the proper values were just written into the cache. So it's indeed
reasonable to assume that Qcom's implementation maps the memory as
non-cacheable.

Feel free to disregard my original comment then and keep the sentence. :)

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-arm-msm/20230614165904.1.I279773c37e2c1ed8fbb622ca6d1397aea0023526@changeid/
