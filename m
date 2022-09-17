Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D875BB98D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIQQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIQQrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:47:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652E326C4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:47:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a2so16296154lfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=eyOdTzNHZuIyZWqk79aZigY07XUgTPO5dQbDGrEP++o=;
        b=BYqv2qxsjpv1xJrZrILkiyOJqrdUO21leLLG/54jUQWnwcKCGl6FzxZAnlL3kB5uat
         wYZ1yv+LVPCfyb7UrjCT/I7o9fD30oeEIn2+DMUjXK1UW3cEtygbLbXUxL0ihA7A5Z5p
         vccKVL7w1tQ3/gEygtcYsaVepWv6U7B0oalbqkL//l8oepUzPv5U3v3KgF1c1dswzUZO
         s3ru0+EFSINADApLG1DCvHL8PI3NuIQiztSwwVkQncPlwagk7XEe5h+uMHjTM35CNP/q
         Jf07irRrtNx98cX0hyN1hVlMApvoP9I64xxQSQKzt2bVrIfEqmXGfQ9FPW9sXSN62dop
         XMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eyOdTzNHZuIyZWqk79aZigY07XUgTPO5dQbDGrEP++o=;
        b=MoWZx6xUJifJorSRkV1rwQFz068Tina0wsUU0tzdyhuGs4TLDRCtdDHlgGI2r5jiTm
         33xFJX8ppyr2NA1Ch+aNwL114xmmwPBFHTsnBxW6HCEbotKrFtjEI2YXI+wxPD0oHCRv
         P4oJxi82anuFFM4Q+2Ft3auPMEoIl+ANNL2rxPzOwujlX5ne1kUAQZI0Titmk62i1CB2
         2vX6wTShWf2N95SgoIEf3SQoP9OwRY3EAkjZ77dHrznGi2odIt7OpNnq/gO5/cOegkyK
         BZXjIZ1E3KDY4siFGhyG0pTDgzCipj/UJLHoUmrv2EDyXhsdSdK0+VRQS9P+oOjpnhNG
         ur9g==
X-Gm-Message-State: ACrzQf15PVaabt5xrQ+K5QtOWSpqVThf8BiWkdq7XTouqupptj0Gfvdp
        aD70g7Sfl4V5TGtGc3eu47ImRA==
X-Google-Smtp-Source: AMsMyM5wffhMqs2EPEjN/Eb8TP77wXTFU1miQzugefQUQ9v/LLd+r2r35aN0ZC28PtivGa0RItaU7A==
X-Received: by 2002:a05:6512:3502:b0:493:e21:b77d with SMTP id h2-20020a056512350200b004930e21b77dmr3283343lfs.580.1663433239805;
        Sat, 17 Sep 2022 09:47:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a19-20020a056512201300b0048a757d1303sm4177719lfb.217.2022.09.17.09.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 09:47:19 -0700 (PDT)
Message-ID: <e8bfcd8a-c1dc-d3a2-8be9-8f224f26fd5d@linaro.org>
Date:   Sat, 17 Sep 2022 17:47:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] media: dt-bindings: i2c: ovti,ov02a10: Drop ref to
 video-interface-devices.yaml
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220916133728.73433-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916133728.73433-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 14:37, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> video-interface-devices.yaml isn't used so just drop it from the
> DT binding doc.

Can you explain what do you mean by "it is not used"? I see it being
used in the code you remove... Since it is there - it is used...

> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml
> index 63a040944f3d..bd1914cf6c33 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml
> @@ -17,9 +17,6 @@ description: |-
>    @ 1600x1200 (UXGA) resolution transferred over a 1-lane MIPI interface. The
>    sensor output is available via CSI-2 serial data output.
>  
> -allOf:
> -  - $ref: /schemas/media/video-interface-devices.yaml#


Best regards,
Krzysztof
