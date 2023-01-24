Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA8C679F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjAXQzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjAXQzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:55:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB444A239
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:55:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2106612A8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8394BC433EF;
        Tue, 24 Jan 2023 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674579307;
        bh=uW4BR4hU6+NQ85CfKGOZEMbq7wuZDujByN26U8b+Eao=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ZHPn4Djcsgl5OQJaH7ei2/mUG3wl8YZzM7rz2R0Ndh1y6L5mVuoMM94K6wEZ5UC/u
         eVEHm12nZjXBzzoiuyYX/DCflwmfvMhr1RbH98fHTmOFImzmBgROuuMfDnmEQD4C2A
         hBRoK4tj54akqcEs4WCrbDqWQJ7av5hnRg+/z4rKGVp31LBNMIzn4p9ya5eBcMwpB6
         l68vqanidnNeNEm7zf0rBln38HfOtgNCZBKhEjzFAzN/pcaBZvPbZ7lH/4n9xMHy1Q
         rB9N6/kePdOK0LSQjK6DFgxiadPwYJZVQe6K+/oqY4jdIMHbW6Ajk4ToRdUzwutr3i
         6O/YIFr2pvNiQ==
Message-ID: <24da8988-193c-fe6d-7a7e-32526caeeae4@kernel.org>
Date:   Tue, 24 Jan 2023 17:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/5 v7] dt-bindings: input: pwm-beeper: add documentation
 for volume devcetree bindings
To:     Manuel Traut <manuel.traut@mt.com>, linux-kernel@vger.kernel.org
References: <Y9AKUJui+jJRCtRH@mt.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <Y9AKUJui+jJRCtRH@mt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 17:41, Manuel Traut wrote:
> This patch adds the documentation for the devicetree bindings to set
> the volume levels.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel. You did not cc anyone, so that
won't work.



Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Subject: drop second/last, redundant "documentation and "devicetree
bindings". The "dt-bindings" prefix is already stating that these are
bindings.

> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/input/pwm-beeper.yaml | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> index 24a40f0f77c1..fe1bbc10147b 100644
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> @@ -28,6 +28,23 @@ properties:
>  	beeper-hz:
>  		description: bell frequency in Hz
>  
> +
> +	volume-levels:
> +		description: >
> +			Array of PWM duty cycle values that correspond to
> +			linear volume levels. These need to be in the range of
> +			0 to 500, while 0 means 0% duty cycle (mute) and 500
> +			means 50% duty cycle (max volume).
> +			Please note that the actual volume of most beepers is
> +			highly non-linear, which means that low volume levels
> +			are probably somewhere in the range of 1 to 30 (0.1-3%
> +			duty cycle).

Wrong indentation. This should use property units -percent. If it is not
percent, then missing ref.
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

I doubt this was even tested...

> +
> +	default-volume-level:
> +		description: >
> +			The default volume level (index into the array defined
> +			by the "volume-levels" property).

Same problem.

> +
>  required:

Best regards,
Krzysztof

