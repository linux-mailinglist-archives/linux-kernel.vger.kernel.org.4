Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73FC654F00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLWKLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLWKLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:11:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF23E5D;
        Fri, 23 Dec 2022 02:11:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 409E6B8207A;
        Fri, 23 Dec 2022 10:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64031C433EF;
        Fri, 23 Dec 2022 10:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671790291;
        bh=tTi/ZYIBPAGCR6Fe1IGTs8K1T4zJpm8GcL4QLqo6UTU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XGmm5P66qg1k9/bYJ5nsrWhe4lpddcg7TUCB6D1OPdOuX4+3X5UnVE338T4hZ1i64
         zszvZztMN6j+Gi1q0I5AA++N4bDZUtYaR5p6xbZ+cdCq0v1qvBnbK9erTtJxMB0sSF
         jT2AZ29Ogs0ALsMkEzlhUwuspdOfhkb0Y/I1L4MEODT8NL92uZTIGCXY35WOgnroy9
         a+gzLosBWH+SdgOeK1KUhneTZHe6Rtdn5Xl4Ii9LY+G3TqyCBNJ6IZlTuBOstOwqn4
         icjtD5NtHAzOkXyeTTROkvVuL66IxF09Yu26jYeAptb8msfryYpy20tOuslSWih45y
         sGqauVpvIH/dA==
Message-ID: <3d89e135-c8e4-ede4-950f-03900a660822@kernel.org>
Date:   Fri, 23 Dec 2022 11:11:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/5] dt-bindings: firmware: arm,scmi: Add support for
 syspower protocol
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20221222183823.518856-1-cristian.marussi@arm.com>
 <20221222183823.518856-5-cristian.marussi@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221222183823.518856-5-cristian.marussi@arm.com>
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

On 22/12/2022 19:38, Cristian Marussi wrote:
> Add new SCMI Syspower protocol bindings definitions and example.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Got lost in translation probably...from txt to yaml

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 1c0388da6721..f3dd77a470dd 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -111,6 +111,12 @@ properties:
>      required:
>        - '#power-domain-cells'
>  
> +  protocol@12:
> +    type: object
> +    properties:
> +      reg:
> +        const: 0x12
> +

Why? It did not got lost, it's already covered by pattern. If you refer
to particular warning, please paste it in commit msg. Otherwise it looks
incorrect.


Best regards,
Krzysztof

