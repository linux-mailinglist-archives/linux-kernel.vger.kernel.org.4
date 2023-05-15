Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F207702D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbjEOM4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242164AbjEOM4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:56:25 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D47A1BC5;
        Mon, 15 May 2023 05:55:50 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B25E985F71;
        Mon, 15 May 2023 14:55:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684155348;
        bh=q7l/rpFtzMMtTi2QEH2d8cneVzx5hYI5+mDkbNkqf4o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gil6/kBpXeWn4qsccIAb1SoAD96Ezr43ETkPH8VFrk6pF0jEqXBFmluTIvk1wAIDw
         ORjlwBTZZz58/O2tscA2qzjVYsprcsYlEBJAWpl5fQdtYCAZF/lfjqljZdynVnmjsh
         zqWMLbLLH0ubhmR6kZOESZvji9QZ6/Kk0rPrxHaeiOaq9UcAYsLPNUbynmFAMTivBo
         Vx64Bc2hE1sUSNDMaPisyF/8aO/ih6E3x6fbBo9IziFsZ0yjm9khbz1rxF/Vpmad2S
         8Yje5aFizpsXPGtuRDbAuT5lZ1vlfaaAr/kghvcIen/iEunfwnFSWLofxBAQidGV+U
         wl5iaGerG1Olw==
Message-ID: <9b62a0db-1374-2c89-5ea3-286467bd1e4e@denx.de>
Date:   Mon, 15 May 2023 14:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: usb: usb251xb: correct swap-dx-lanes type to
 uint32
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Leitner <richard.leitner@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mike.looijmans@topic.nl
References: <20230515103337.130607-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230515103337.130607-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 12:33, Krzysztof Kozlowski wrote:
> The "swap-dx-lanes" was never described as uint8 in original TXT
> bindings and Linuxx driver expects uint32.  Fix the type to match Linux

Linux , one x too many .

> driver expectation and original binding.
> 
> Fixes: fff61d4ccf3d ("dt-bindings: usb: usb251xb: Convert to YAML schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: mike.looijmans@topic.nl
> ---
>   Documentation/devicetree/bindings/usb/usb251xb.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb251xb.yaml b/Documentation/devicetree/bindings/usb/usb251xb.yaml
> index 4d1530816817..ac5b99710332 100644
> --- a/Documentation/devicetree/bindings/usb/usb251xb.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb251xb.yaml
> @@ -231,7 +231,7 @@ properties:
>         power-on sequence to a port until the port has adequate power.
>   
>     swap-dx-lanes:
> -    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>       description: |
>         Specifies the ports which will swap the differential-pair (D+/D-),
>         default is not-swapped.

Would it make more sense to update the driver instead ? I doubt you 
could have more than 256 ports on this device after all.
