Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2566CD27A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjC2HFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2HFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:05:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456B130C2;
        Wed, 29 Mar 2023 00:05:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E96DB82021;
        Wed, 29 Mar 2023 07:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CF6C4339B;
        Wed, 29 Mar 2023 07:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680073538;
        bh=wipivAAqsGXZPI/rDaR0yF4+hItiQ0DkA624Vr9x1Gk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=texZjFYnR0gtlt+igVyCvpnwBbmfOfCsWCX5qInD2viZ23wff7rnmchqP1a51o2wJ
         R4svsT6K6aFr9i2XTYe+viiSbCp3DQpciCi+EbsCEGb8tXxJ8NrclfeLosvxWsxz+w
         dlVImZnCgu7lSs5VmJFB6qX3RnkGLrTw+eisXLa9yOD2cPs/LtGIThA5lK/obMqUuQ
         BoQ2VHQgAqhZ21TlcDN2g5g1PeTccPCkcxfcT2Hfp6dm13Pdxu1on7cy08nIeaMv/a
         XJMJQkRWXoEib3Qoe3fEYZwIAB069xpc7sk9OuutWoQ4nJ1TiOdx92BRnkymli8cu/
         gdG133kxLbhxw==
Message-ID: <271f0be0-9cb2-0c74-c112-33020e9a7342@kernel.org>
Date:   Wed, 29 Mar 2023 10:05:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: usb: tps6598x: make interrupts optional
Content-Language: en-US
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     vigneshr@ti.com, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230324131853.41102-1-rogerq@kernel.org>
 <20230324133741.43408-1-rogerq@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230324133741.43408-1-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki & Rob,

On 24/03/2023 15:37, Roger Quadros wrote:
> The driver can poll for interrupt status so interrupts
> can be optional. It is still recommended to use the
> interrupt line. Polling should only be used for debug
> and prototyping.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> index 348a715d61f4..8c2db282735a 100644
> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> @@ -35,8 +35,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-names
>  
>  additionalProperties: true
>  

We need this patch as well along with the driver changes [1]
Could you please Ack. Thanks!

[1] - https://lore.kernel.org/r/20230324131853.41102-1-rogerq@kernel.org

cheers,
-roger
