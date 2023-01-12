Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78964668696
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbjALWL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbjALWLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:11:03 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F97B4AA;
        Thu, 12 Jan 2023 14:03:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673561002; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=emLjTGbwx0btbz+xhmtt/yg9dHdbNY9EfoXCucecWwSAZbnnZCyQKF9q4GCSMrCNKK
    1axdrthj/VHoGztPtsHq9YDs1XzRwswOQOl0X+g+mgHiDjCvPgK1+L1doNOYAuB9eGeM
    lxppx/wETHzbrWSUUwkYgrnMcv4j43WgdAAgrebMnZTD+y3jZkPOZ5xWhegO0x6vg5Um
    UII4azAKt9blBH4DRFZp2D6Z2rVwYJb4+I5VH/6a+OpWvob8AMlZrIgNpyI/zPiUqhBb
    a9x0b8SYSlelgqLwlnnPBdE7FDo26pBE3F+Iu2+K5607JsSBJKuBYU9Ivxzf2vEqR5G6
    xB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1673561002;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=rjM2Ovo73mTF+d+xK7MGawlB/cNEYrJxwgPYAP8YQ+M=;
    b=bZeEt8i91uR6WRelULcO8KLIxM/z0j0ZbtBVY7kOJ32x4xj49T5EOgcYjf+02tHq3C
    5/y/vj82you2g0VMsVyKk5IpvLNrjayllZFgMhlkxImAk0GLiSRNLxltyFVgvCFooGzY
    G0EKDoj5gTKyHOD6LS171rVtLHen9kxnQMP6O9yWHoyY/7nRKij8/4Fw4N4h5SuC0KV7
    6dx9Piunl6woPRtHB7+7S5cPVKXEi3A6LJc/xTb53O3rU9s4IZZRjOQDMyvRlZyJUPiM
    /zMr8/tyn57lo28403itanEb8gKIeot7nt6g1agsPtZDOKKvB54tGDKC5fjPTgnL09Fa
    hICg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673561002;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=rjM2Ovo73mTF+d+xK7MGawlB/cNEYrJxwgPYAP8YQ+M=;
    b=dGwLPsSgnvsu3uPfLmkShE9fadtjwgszL02BmM5SXoUZKOoXaHSJbnRSKuTPyLW8X5
    rAtYSQYXvvZFw3OWqo/etALhUAGUVXyJiSiuMM7pzsMBf9Dudj5aD71uOaWy6N9/8Zug
    VnMyoa0S5BD2lH9CP4GBZN9MZOUKrP16bGESi2MRA1yCzWQ3Df5aT/0fLGME1Yvi/3U6
    cx9yHbi2xOk0bbI1MZxqaIQnPyUfbs40ndsJ1nFTJzEAryvWLa1WnyUBI6cDybao7JgV
    cEoL6QDVWE7A+oPJhu43WW2mSSm3jErKVESViagKnuyl6XEyoT8aVMpcSz2c95khn/dr
    Srtg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWwfGjtQ=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.6.2 DYNA|AUTH)
    with ESMTPSA id yacdeez0CM3M4fq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 12 Jan 2023 23:03:22 +0100 (CET)
Date:   Thu, 12 Jan 2023 23:03:15 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Matti =?iso-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add
 MSM8226
Message-ID: <Y8CDo0jI/ygpnNtR@gerhold.net>
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
 <20230112202612.791455-2-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230112202612.791455-2-matti.lehtimaki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Thu, Jan 12, 2023 at 10:26:04PM +0200, Matti Lehtimäki wrote:
> Adds support for platforms with only single power domain.

This sentence is a bit misleading. MSM8226 also has both CX and MX power
domains. The difference is only the way they are exposed by the firmware
and the drivers in Linux.

The RPM firmware allows Linux to vote for either
 - Voltages (exposed as regulators in Linux), or
 - Performance states/"voltage corners" (exposed as power domains in Linux)

For the hardware there is no difference: When using power domains the
performance states are simply translated to corresponding voltages
within the RPM firmware.

All newer platforms have moved towards using power domains for CX and
MX, so for consistency it would be preferable to do the same for MSM8226
and MSM8974. Perhaps the RPM firmware even allows using them with
voltage corners? In that case you could just add PM8226 L3 to rpmpd and
use it as power domain like on other platforms.

For some reason I assumed this is the case for MSM8974 2.5 years ago.
I have to admit I no longer remember why, and verifying this reliably is
probably hard... :/

But the VDD_MX setup looks identical for MSM8974 and MSM8226 to me, so
please also apply the same changes for MSM8974. I would also appreciate
a small comment in the commit message that the MX voltage rail is still
represented as regulator on these platforms. Also, perhaps this should
even be a separate patch given that it kind of fixes what I added for
MSM8974 back then.

> Adds support for external power block headswitch (BHS) registers
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
>  .../remoteproc/qcom,msm8916-mss-pil.yaml      | 41 +++++++++++++++++--
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
> index 6e6e69ad9cd7..6a921f2711b2 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
> [...]
> @@ -106,6 +108,15 @@ properties:
>      items:
>        - const: stop
>  
> +  qcom,ext-bhs-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: External power block headswitch (BHS) register
> +                 (only valid for qcom,msm8226-mss-pil)
> +    items:
> +      - items:
> +          - description: phandle to external BHS syscon region
> +          - description: offset to the external BHS register
> +

Please disallow this (qcom,ext-bhs-reg: false) for everything except
qcom,msm8226-mss-pil.

>    qcom,halt-regs:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description:
> @@ -205,13 +216,35 @@ allOf:
>        required:
>          - power-domains
>          - power-domain-names
> -    else:
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8909-mss-pil
> +              - qcom,msm8916-mss-pil
> +              - qcom,msm8974-mss-pil
> +    then:
>        properties:
>          power-domains:
>            maxItems: 2
>          power-domain-names:
>            maxItems: 2
>  

You also need to add minItems here now.

> +  - if:
> +      properties:
> +        compatible:
> +          const: qcom,msm8226-mss-pil
> +    then:
> +      properties:
> +        power-domains:
> +          maxItems: 1
> +        power-domain-names:
> +          maxItems: 1
> +      required:
> +        - qcom,ext-bhs-reg

And here you need to add the mx-supply as required, since you don't have
it as power domain.

Thanks,
Stephan
