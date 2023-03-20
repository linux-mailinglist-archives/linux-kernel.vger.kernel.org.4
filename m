Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CFB6C132C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjCTNW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCTNW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:22:56 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDC3196A1;
        Mon, 20 Mar 2023 06:22:55 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id bp22so1863039oib.6;
        Mon, 20 Mar 2023 06:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679318574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux14OwgY8H5fgO7IVmMzzrEbv4R7hHF2xiI4gbIKjE4=;
        b=47cxygcLSSkiKTxEBXVGytP8zVfiRnoXJ4WPEKSMmTmEbtQ/vCCCTXWdYw2k+7r4Hh
         Mpwn9OgV5Ues3eg6Wukh8j8QJmrXXOOfOUvie2Vyh1rt/Frkzr3WRvWuoEN3HxCAc6Vl
         C+PLPfRVv/nb6QZPR0BIhL17peH6nkDy85xbXzHUNGTX2PQkOW3BdGZVPOkew76L7V53
         dFHoAoZqEl/dYOo7ePirDTkK09UNWrCmsnoIUFnB6fuiJgmhjT4wuN8MVD7j5dOV1y1+
         rzbHRHV4xzkD5tFFYnWCEan4OM4F/U8ZGjvZ5VtFuqNWkJqwwZHB3ctZteeleX6aNdzm
         u7SA==
X-Gm-Message-State: AO0yUKUVCDnHzLzVe+5qkU13IhW/qj75fkyfjIV9WD60skNJTd1IVSKM
        hIszO8Py1hrY5Ah+ZqgayxFoS2wgdg==
X-Google-Smtp-Source: AK7set9/7tjSuYHC6DcIiwcsDj22kt1OMSA5SOhAI4ceO1Xj3QUhHqYXFl9CsqNcQeqNJy+F7l5qAw==
X-Received: by 2002:a05:6808:6c5:b0:37f:936d:b5d9 with SMTP id m5-20020a05680806c500b0037f936db5d9mr8978153oih.12.1679318573208;
        Mon, 20 Mar 2023 06:22:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 129-20020a4a1887000000b005252d376caesm3777554ooo.22.2023.03.20.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:22:52 -0700 (PDT)
Received: (nullmailer pid 1445818 invoked by uid 1000);
        Mon, 20 Mar 2023 13:22:52 -0000
Date:   Mon, 20 Mar 2023 08:22:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Thinh.Nguyen@synopsys.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, vigneshr@ti.com, srk@ti.com,
        r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: usb: snps,dwc3: Add
 'snps,gadget-keep-connect-sys-sleep'
Message-ID: <20230320132252.GA1440894-robh@kernel.org>
References: <20230320093447.32105-1-rogerq@kernel.org>
 <20230320093447.32105-2-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320093447.32105-2-rogerq@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:34:46AM +0200, Roger Quadros wrote:
> The current USB gadget driver behaviour is to stop the controller
> and disconnect from the bus during System sleep.

What's USB gadget? ;)

> The 'snps,gadget-keep-connect-sys-sleep' property can be used to
> change this behaviour and keep the controller active and connected
> to the bus during System sleep. This is useful for applications
> that want to enter a low power state when USB is suspended but
> remain connected so they can resume activity on USB resume.
> 
> This feature introduces a new constraint if Gadget driver is connected
> to USB host: i.e.  the gadget must be in USB suspend state to allow
> a System sleep as we cannot process any USB transactions
> when in System sleep.
> 
> The system hardware is responsible to detect the end of USB suspend
> and wake up the system so we can begin processing the USB transactions
> as soon as possible.

Sounds like something the user/OS would want to choose rather than fixed 
by your board's firmware.

Is this somehow DWC3 specific? If not, why a DWC3 specific property?

> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index be36956af53b..1ce8008e7fef 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -262,6 +262,11 @@ properties:
>        asserts utmi_sleep_n.
>      type: boolean
>  
> +  snps,gadget-keep-connect-sys-sleep:
> +    description:
> +      If True then gadget driver will not disconnect during system sleep.
> +      System sleep will not be allowed if gadget is not already in USB suspend.

'gadget' is a Linuxism.

> +
>    snps,hird-threshold:
>      description: HIRD threshold
>      $ref: /schemas/types.yaml#/definitions/uint8
> -- 
> 2.34.1
> 
