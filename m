Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0016E5092
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDQTFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDQTFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:05:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFF755BC;
        Mon, 17 Apr 2023 12:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1681758314; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=INqIBw4Ne4PgLy5vmY0LJBcYVa0jPhdpwP0ZTp9SvMxTNVsY/5fzEw4Skd5x0C/1lM
    avWfzxvnZt+uRnH45Cu4Ovs3SoNTTuoAlpFhLhchgsMpT6JS2/2XYDPHpnQhey7Obvt/
    VZ4RfzxGZA6mWk99KLwFndVy+VrPm3dFDIIc/6uhhLx039+zBheT93/znAjr8r5HhJVD
    Mm2v+WKgsXbfwy8Fo02bI1Q//XVeoA/Cc+B0V9EXkHBOKeDTVQcuT666uryILzn3LM1w
    UXs5Q7dTdcg7t9TkmUUB+p5XG5ZdSQgTCVeuC9foygDJ7FueeWTKeHRAofnIceU3YQ1t
    8iUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1681758314;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zMu8aCbltdkyaF8tMU4hcbAdwR6OQSkVDX5++sopalU=;
    b=Z7THDmGdOJQi/D7qEGmW6cpwYVxZqgCIJK1hVZ9v02urqRsWJ5hatiZ9WjyP9awBjq
    kKCgIiVsgKmV0UxqIenaBoAWuqiWBf0xeCHCb3H1XWUzZYY7VnGsztgMgedGlkkvYnT2
    e6kHB9d/Qm6h8jq3kgZtyqbShoc6SE1wV6/x53BcEH+fuFvBMOLw+x65CiddyzKoToNB
    QYZX/yvMbhTvnGSkAuEFrr2Ef7UqH7hwXgjzzM5qwlKsZDQWwcOmPQXbqzcs8dx+5Ovf
    Zjq60svGQ9wa5BJxF498XiGPh7mrcEqRHWpnr0GFbbxJUxsiA0YvKixNr/o9KXDLml4e
    3rnw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1681758314;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zMu8aCbltdkyaF8tMU4hcbAdwR6OQSkVDX5++sopalU=;
    b=tj9FF4MBFTjzEVOyc693G+9bSO3gFpH7oVu3u4z60niTHeJB8ND2Bc7uWZOsUOFAnP
    b/hPAXWDxFgIVDROTq77rmn5T42vAgbNozYfSx2zm+Vk7DdCk5ib/Co5Kv/HGiPe4QFv
    phpbyOp1dl0YZcT6VKPzbgHp7DeLYEJ5RnIyYBl7asrhwTRVEVDPALOrnHcjOcOzLRUj
    J4L13kuhYcN/4+deaiDpt99qL7MGRKuWwht/pygsiYykFirzPvg5S1yTcMWLhHxrzI3b
    EhmvyS+F7EdkuXqXg3HrxtYKK7DLukKbQi/p9JOEhkIPgF8LX75ReM3qx1dSCNTuqgy8
    +e/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1681758314;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zMu8aCbltdkyaF8tMU4hcbAdwR6OQSkVDX5++sopalU=;
    b=Rb+/EdXy6QJAJY1dx4i43fy15Q4UmnxHB5WJh1ND7b6jw4thZLbpKP7mpJXXVNJUEa
    Qo36RKaAvge/AJtMfdAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8peN1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az3HJ5EeE4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Apr 2023 21:05:14 +0200 (CEST)
Date:   Mon, 17 Apr 2023 21:05:06 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RFT v2 01/14] dt-bindings: clock: qcom,rpmcc: Add a way
 to enable unused clock cleanup
Message-ID: <ZD2YYrOdQMD3pi7u@gerhold.net>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
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

On Wed, Mar 08, 2023 at 10:35:17PM +0100, Konrad Dybcio wrote:
> Disabling RPMCC clocks can be a bit touchy. If we can't guarantee all
> (or at least most) of the oneline peripherals ask the interconnect
> framework to keep their buses online and guarantee enough bandwidth,
> we're relying on bootloader defaults to keep the said buses alive through
> RPM requests and rate setting on RPM clocks.
> 
> Without that in place, the RPM clocks are never enabled in the CCF, which
> qualifies them to be cleaned up, since - as far as Linux is concerned -
> nobody's using them and they're just wasting power. Doing so will end
> tragically, as within miliseconds we'll get *some* access attempt on an
> unlocked bus which will cause a platform crash.
> 
> On the other hand, if we want to save power and put well-supported
> platforms to sleep, we should be shutting off at least some of these
> clocks (this time with a clear distinction of which ones are *actually*
> not in use, coming from the interconnect driver).
> 
> To differentiate between these two cases while not breaking older DTs,
> introduce an opt-in property to correctly mark RPM clocks as enabled
> after handoff (the initial max freq vote) and hence qualify them for the
> common unused clock cleanup.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> index 2a95bf8664f9..386153f61971 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> @@ -58,6 +58,12 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  qcom,clk-disable-unused:
> +    type: boolean
> +    description:
> +      Indicates whether unused RPM clocks can be shut down with the common
> +      unused clock cleanup. Requires a functional interconnect driver.
> +

I'm surprised that Stephen Boyd did not bring up his usual "rant" here
of moving the interconnect clock voting out of rpmcc into the
interconnect drivers (see [1], [2]). :-)

I was a bit "cautious" about it back then but at this point I think it
kind of makes sense. Make sure to read Stephen's detailed explanation in
https://lore.kernel.org/linux-arm-msm/159796605593.334488.8355244657387381953@swboyd.mtv.corp.google.com/

We keep looking for workarounds to prevent the CCF from "messing" with
interconnect-related clocks. But the CCF cannot mess with "clocks" it
does not manage. The RPM interconnect drivers already talk directly to
the RPM in drivers/interconnect/qcom/smd-rpm.c. I think it should be
quite easy to move the QCOM_SMD_RPM_BUS_CLK relates defines over there
and just bypass the CCF entirely.

For backwards compatibility (for platforms without interconnect drivers)
one could either assume that the bootloader bandwidth votes will be
sufficient and just leave those clocks completely alone. Or the
"icc_smd_rpm" platform device could initially make max votes similar to
the rpmcc device. By coincidence the "icc_smd_rpm" platform device is
always created, no matter how the device tree looks or if the platform
actually has an interconnect driver.

Stephan

[1]: https://lore.kernel.org/linux-arm-msm/159796605593.334488.8355244657387381953@swboyd.mtv.corp.google.com/
[2]: https://lore.kernel.org/linux-arm-msm/20211209091005.D3344C004DD@smtp.kernel.org/
