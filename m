Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB0B6FF632
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbjEKPlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbjEKPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:41:40 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EA659DC;
        Thu, 11 May 2023 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=YCSKwIYzbu1pkwEd81TZJ4LTNXSEnly6dMUBXhXOwZk=; b=C/X4refVDazo6iOvpswWYfmKJr
        xxGKA45yPV1b1pGaDv1+YmeyRo1aqAV6NOsaU1nCxW+UXZPmhOW2JsKZpBq92NCYZmZY35c20ajHo
        DdghuIsUAaDIYKNSik2LuduCs8q8zJs6SBJMu/1uC98k1PCVadn7U6nxPiOnbytKO1js=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1px8Pv-00CZXR-4U; Thu, 11 May 2023 17:41:19 +0200
Date:   Thu, 11 May 2023 17:41:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pranavi Somisetty <pranavi.somisetty@amd.com>
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
        palmer@dabbelt.com, git@amd.com, michal.simek@amd.com,
        harini.katakam@amd.com, radhey.shyam.pandey@amd.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: cdns,macb: Add
 rx-watermark property
Message-ID: <5872254a-7a33-4aa5-afa3-50ad5d8c7002@lunn.ch>
References: <20230511071214.18611-1-pranavi.somisetty@amd.com>
 <20230511071214.18611-2-pranavi.somisetty@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511071214.18611-2-pranavi.somisetty@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 01:12:13AM -0600, Pranavi Somisetty wrote:
> watermark value is the minimum amount of packet data
> required to activate the forwarding process. The watermark
> implementation and maximum size is dependent on the device
> where Cadence MACB/GEM is used.
> 
> Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> index bef5e0f895be..779bc25cf005 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -109,6 +109,13 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  rx-watermark:
> +    maxItems: 1
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +    description:
> +      Set watermark value for pbuf_rxcutthru reg and enable
> +      rx partial store and forward.

What are the units? Frames, octets, DMA scatter-gather segments, % of
maximum?

	Andrew

---
pw-bot: cr

