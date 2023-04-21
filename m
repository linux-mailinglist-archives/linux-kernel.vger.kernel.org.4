Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3066EAB35
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjDUNEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjDUNEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:04:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B262A1729;
        Fri, 21 Apr 2023 06:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B36460CF9;
        Fri, 21 Apr 2023 13:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC919C4339E;
        Fri, 21 Apr 2023 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682082275;
        bh=CzmaRLEElV5r6OSmeQUesOnrWGmddrm3MWcaRGvePEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ghOgmJGOAyVhJFKROPFV3qY7d6DVECvaXitDvgs33kQMAC8DBGMXDoUlAMnD/4+Hn
         mbEnnTx7/kPd/IDVj1Uyv18886ds+J4uO6u8ipY535bvaefnBlxZTEDPBXyhGAqeVn
         2b82xSYkZvKiG31Xw6fZZ562s7y/wER8SYc8LH2bArJAdZ0jrGJZXQO8HNgQJPVkZa
         PpSvgAU0nWaRD0zat7Rm3SXhSAPBPbecY0MJ0lhjjSqaUnMip8fHEQCSzdTeB8uK3s
         YTd5UcazVOuVBsu7fBkbDxQAeaJ/9ZV8jPreyzpZE20cq6lscLwAiyTe5jww7jQymT
         vO7nkHZJ3Y1iA==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-54f9b37c634so19301977b3.2;
        Fri, 21 Apr 2023 06:04:35 -0700 (PDT)
X-Gm-Message-State: AAQBX9chQNGyhbqiymLBqg6NNz3Ua6l8iISbiJcwqZxYGRT4UZGsnSxk
        BIuZLHDXC9n6Fu5/yD6B1CgjPJmrDERlwavAKw==
X-Google-Smtp-Source: AKy350bc7AmR4GYcjy993sL2twDCdV7QNPuyM3bwV+j16P/bRNdIp5IpqL6aZwSQaNgYKdH2ZrN2Kg5AbLVd3vRIs3o=
X-Received: by 2002:a0d:d4c3:0:b0:544:9180:3104 with SMTP id
 w186-20020a0dd4c3000000b0054491803104mr1770084ywd.34.1682082274752; Fri, 21
 Apr 2023 06:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230421061825.2233-1-stanley_chang@realtek.com> <20230421061825.2233-2-stanley_chang@realtek.com>
In-Reply-To: <20230421061825.2233-2-stanley_chang@realtek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 Apr 2023 08:04:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJBDuxCAnZmHBnHuMkjTXTLet2d3o5kLRZQ_YuqVB9Pcw@mail.gmail.com>
Message-ID: <CAL_JsqJBDuxCAnZmHBnHuMkjTXTLet2d3o5kLRZQ_YuqVB9Pcw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,global-regs-starting-offset' quirk
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 1:18=E2=80=AFAM Stanley Chang <stanley_chang@realte=
k.com> wrote:
>
> Add a new 'snps,global-regs-starting-offset' DT to dwc3 core to remap
> the global register start address
>
> The RTK DHC SoCs were designed the global register address offset at
> 0x8100. The default address offset is constant at DWC3_GLOBALS_REGS_START
> (0xc100). Therefore, add the property of device-tree to adjust this
> address offset.
>
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
>  v2 to v3 change:
> 1.  Fix the dtschema validation error.
>
>  v1 to v2 change:
> 1. Change the name of the property "snps,global-regs-starting-offset".
> 2. Adjust the format of comment.
> 3. Add initial value of the global_regs_starting_offset
> 4. Remove the log of dev_info.
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Docum=
entation/devicetree/bindings/usb/snps,dwc3.yaml
> index be36956af53b..4f83fa8cb6cb 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -359,6 +359,14 @@ properties:
>      items:
>        enum: [1, 4, 8, 16, 32, 64, 128, 256]
>
> +  snps,global-regs-starting-offset:
> +    description:
> +      value for remapping global register start address. For some dwc3
> +      controller, the dwc3 global register start address is not at
> +      default DWC3_GLOBALS_REGS_START (0xc100). This property is added t=
o
> +      adjust the address.
> +    $ref: '/schemas/types.yaml#/definitions/uint32'

Again, we're not going to keep adding properties for every DWC3
variation. If it is board specific, then yes a property is
appropriate. If it is SoC specific, then imply it from the compatible.
Or in this case, you could possibly add another reg entry.

Rob
