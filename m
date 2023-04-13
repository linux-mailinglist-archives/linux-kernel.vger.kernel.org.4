Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8806E07D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDMHe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDMHex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:34:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C69012;
        Thu, 13 Apr 2023 00:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7237663B06;
        Thu, 13 Apr 2023 07:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2076DC433D2;
        Thu, 13 Apr 2023 07:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681371291;
        bh=XsH7jura9OPQFYo3OyLRFLTN61f+7bAgwp8frJCnGj8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VBqOmgS9htmYEKpii6xW2yRgl5Cpr4O9+spNPUM9aS18UsxuqGCGCke82wB1XT2Xg
         deiW5odzuE3NZbyJ1U7r76VitOR1ormOxBJHkHaqiZ8od+LPHK2p947npwkYhnmlXM
         pXlGX7SIAHj5FlnDAmvFmbO6dzGhe3lewNr0xAdSXyov6BpScb+CSTyWS1F6+JuoKo
         wiB9DJ+EZZRYfrtbg1TBKX1uSWhDvc6bRVMQFbfJ/trNlPncZNJHgpnShsV3FmUhok
         9mIPSZ+Vh4ApUCa7FIVIgTYpNN80ZJDDlKIn8wheaXEk3SoosOD8ib1PNEOo02EDdm
         Fa7leT0SQJ9+g==
Message-ID: <2d058629-bd97-5e4d-8630-598cc22e5c58@kernel.org>
Date:   Thu, 13 Apr 2023 09:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,parkmode-disable-hs-quirk' quirk
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230411053550.16360-2-stanley_chang@realtek.com>
 <20230413030344.13483-1-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230413030344.13483-1-stanley_chang@realtek.com>
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

On 13/04/2023 05:03, Stanley Chang wrote:
> Add a new 'snps,parkmode-disable-hs-quirk' DT quirk to dwc3 core for
> disable the high-speed parkmode.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

It's the second time I am writing it. I don't understand why you keep
ignoring it.

Your commit msg does not explain why do we need it.

> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index be36956af53b..45ca967b8d14 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -232,6 +232,11 @@ properties:
>        When set, all SuperSpeed bus instances in park mode are disabled.
>      type: boolean
>  
> +  snps,parkmode-disable-hs-quirk:
> +    description:
> +      When set, all HighSpeed bus instances in park mode are disabled.

Why?


Best regards,
Krzysztof

