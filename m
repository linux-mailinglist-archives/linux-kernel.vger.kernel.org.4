Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06393639BFA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiK0RX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 12:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0RXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:23:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B33C63BD;
        Sun, 27 Nov 2022 09:23:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD9F960DED;
        Sun, 27 Nov 2022 17:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2C8C433D6;
        Sun, 27 Nov 2022 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669569803;
        bh=QIMLfSDoL2lbgD+2NPt656LV7PYTHEk9OFRVgEJkQ6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6WvF6BELW59nr2a2BhTjwjrpyngeFskVIePIM+nQYgIZm8teu3eAQPa3goYTeRv9
         NWeEvdYKq/y1OV6eFVH9E5hGk0hLLwaPPGiTtPEbOVr8/XDXi7C2tjrrTvwdVBBK/Z
         igZv7PlC3qLhJAMV0xPH8YBsvBKx0OwPxRk8zwd8G1PE5LWM83kj0ZRV9RuPoowJAq
         YGeD6GoiojCyU4NiKz8bIvdssGXe8lZal6j2m2JUWXkwNKYPFurBUL3fJvabLX9wPW
         TTKXr3Yat9dp3KQh3Xvya8HxbJj/7lRduvDG2MVQH+1Kayj8KHfis7PcV04ekgubG7
         fPP5D+3V3bDjw==
Date:   Sun, 27 Nov 2022 17:23:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 4/9] dt-bindings: vendor-prefixes: add bouffalolab
Message-ID: <Y4OdBr3/uTPVbxMk@spud>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127132448.4034-5-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 09:24:43PM +0800, Jisheng Zhang wrote:
> In the following commits, we will support bl808 SoC which is from
> Bouffalo Lab Technology (Nanjing) Co., Ltd.
> 
> Add bouffalolab vendor prefix binding.
> 

Perhaps add
Link: https://en.bouffalolab.com/
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 6e323a380294..81618f1dc01b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -194,6 +194,8 @@ patternProperties:
>      description: BOE Technology Group Co., Ltd.
>    "^bosch,.*":
>      description: Bosch Sensortec GmbH
> +  "^bouffalolab,.*":
> +    description: Bouffalo Lab Technology (Nanjing) Co., Ltd.
>    "^boundary,.*":
>      description: Boundary Devices Inc.
>    "^broadmobi,.*":
> -- 
> 2.38.1
> 
