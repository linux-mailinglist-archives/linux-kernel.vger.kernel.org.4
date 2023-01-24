Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D736C67969B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjAXL3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjAXL3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:29:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753A62C651;
        Tue, 24 Jan 2023 03:29:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 141C36100B;
        Tue, 24 Jan 2023 11:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932BDC4339B;
        Tue, 24 Jan 2023 11:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674559772;
        bh=5WEoIGkzQvM2CGmnowaKG97b9a5ptWcHyPkR/YW7pFA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GsZ4xcS8oIMgMR4HW6Y/IgATE97fF5C8NhNoPFn0c02QHxw3GTXfRODJoD+BxwIR8
         YJRDgSuB51ZC/GC7Xky74K7lcA/InrQGUEQ1W4AWCGBDFcRcRin0loU9C4gavpC31d
         x9p+ALYW6pssd+4sqNaGG5AJvGnBk8Beg6jrU+xmsKUe+Cy3vbn7lSX19sf6VJnyjB
         1eUzwt4ckLD8nz4fm39mkzAfJqzyntnoYnIdM+OcfJf7Z9HXo88QArMRSSLNGdSIqu
         kaDlmuK6oZuega8LS5AqXruVSgx3mjBPlnHKpKexPbtj2etiHedsbyY9MG8ilwHLt0
         8xmVIKPh/GjHA==
Message-ID: <bcdaaf94-b879-b171-f24a-82647a1ef9a6@kernel.org>
Date:   Tue, 24 Jan 2023 12:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3 v6] input: pwm-beeper: add feature to set volume level
To:     Manuel Traut <manuel.traut@mt.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org
References: <Y8+8824hy/fWkpEk@mt.com> <Y8+9WRP51u+dof8p@mt.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <Y8+9WRP51u+dof8p@mt.com>
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

On 24/01/2023 12:13, Manuel Traut wrote:
> This patch adds the documentation for the devicetree bindings to set
> the volume levels.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>

I think it is kontron.de now.

> Acked-by: Rob Herring <robh@kernel.org>

This misses your SoB.

> ---
>  .../devicetree/bindings/input/pwm-beeper.txt          | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> index 8fc0e48c20db..93cab5eee9f2 100644
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> @@ -9,6 +9,15 @@ Required properties:
>  Optional properties:
>  - amp-supply: phandle to a regulator that acts as an amplifier for the beeper
>  - beeper-hz:  bell frequency in Hz
> +- volume-levels: Array of PWM duty cycle values that correspond to
> +      linear volume levels. These need to be in the range of 0 to 500,
> +      while 0 means 0% duty cycle (mute) and 500 means 50% duty cycle
> +      (max volume).
> +      Please note that the actual volume of most beepers is highly
> +      non-linear, which means that low volume levels are probably somewhere
> +      in the range of 1 to 30 (0.1-3% duty cycle).
> +- default-volume-level: the default volume level (index into the
> +      array defined by the "volume-levels" property)

The bindings should be converted to DT schema first and then new
properties added.

Best regards,
Krzysztof

