Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB060BB13
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiJXUqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbiJXUom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:44:42 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646EFAEA1D;
        Mon, 24 Oct 2022 11:52:34 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j188so11794477oih.4;
        Mon, 24 Oct 2022 11:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxLrsbh3hBSrr4/Sxj8CZwRvl9/DN20xuRs3+14Wfdc=;
        b=l65p20+6HfZKS0NufMXHJS6xlBmFSVDhPGaQvFdEj33R0Y0nrMaZqiW8tVj29a9FYI
         dIuxD+SICiuK/Bd4+EJuS697YdNGYf3jffzuBOh58n08TNtZnBRCcAyDEPWVLOWnQDwt
         Qh2qkzjkxlcNcHOvp9jAlF7hKEyR3m3goFH9yRoxrLp5sj9vQjQylS2HFViar7wYACQK
         QO0FVEuIxyC9f45Dt5IJnOR1V19I3mVepo1ns+O4Erc3xML3rtRU8qZ4jD1zfmJU6pUH
         siwcJnG7vFo/uWBvwCTVEZ+/WjM+DKIStgW53CS0DU56xQFH5oXvgWxme0K9A199WdgS
         +r7g==
X-Gm-Message-State: ACrzQf1CBf2Kr2dOSUsz0IjXCPTRJkDgMfCmDMCri0Psj2q3ZmjVidDb
        HfSuRLM1FtQF48WEdhCWvDbYrb8mmg==
X-Google-Smtp-Source: AMsMyM7OYpTOLvZhhil0+AbrvroJzFzQW6OgIZeO7JMyBGqL7Dmz7qIyWl/Xo0aFP/idnbp62Yy7Ew==
X-Received: by 2002:a05:6808:d53:b0:355:4c55:2384 with SMTP id w19-20020a0568080d5300b003554c552384mr18019406oik.190.1666637448253;
        Mon, 24 Oct 2022 11:50:48 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h7-20020a056870c18700b00130e66a7644sm327864oad.25.2022.10.24.11.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:50:47 -0700 (PDT)
Received: (nullmailer pid 2036884 invoked by uid 1000);
        Mon, 24 Oct 2022 18:50:49 -0000
Date:   Mon, 24 Oct 2022 13:50:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/1] dt-bindings: rtc: convert hym8563 bindings to
 json-schema
Message-ID: <20221024185049.GA2034297-robh@kernel.org>
References: <20221021170605.85163-1-sebastian.reichel@collabora.com>
 <a5db8a34-acd0-e262-36f0-0b904468bd1f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5db8a34-acd0-e262-36f0-0b904468bd1f@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 07:59:26PM -0400, Krzysztof Kozlowski wrote:
> On 21/10/2022 13:06, Sebastian Reichel wrote:
> > Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
> > Schema format.
> > 
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
> >  .../bindings/rtc/haoyu,hym8563.yaml           | 55 +++++++++++++++++++
> >  2 files changed, 55 insertions(+), 30 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> >  create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> > deleted file mode 100644
> > index a8934fe2ab4c..000000000000
> > --- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -Haoyu Microelectronics HYM8563 Real Time Clock
> > -
> > -The HYM8563 provides basic rtc and alarm functionality
> > -as well as a clock output of up to 32kHz.
> > -
> > -Required properties:
> > -- compatible: should be: "haoyu,hym8563"
> > -- reg: i2c address
> > -- #clock-cells: the value should be 0
> > -
> > -Optional properties:
> > -- clock-output-names: From common clock binding
> > -- interrupts: rtc alarm/event interrupt
> > -
> > -Example:
> > -
> > -hym8563: hym8563@51 {
> > -	compatible = "haoyu,hym8563";
> > -	reg = <0x51>;
> > -
> > -	interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> > -
> > -	#clock-cells = <0>;
> > -};
> > -
> > -device {
> > -...
> > -	clocks = <&hym8563>;
> > -...
> > -};
> > diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> > new file mode 100644
> > index 000000000000..b0b6126b12dd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license please. I don't think you copied any content from original
> bindings... unless the example?
> 
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/haoyu,hym8563.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Haoyu Microelectronics HYM8563 RTC
> > +
> > +maintainers:
> > +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: haoyu,hym8563
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#clock-cells":
> > +    const: 0
> > +
> > +  clock-output-names:
> > +    description: From common clock binding to override the default output clock name.
> 
> You need maxItems for this.
> 
> > +
> > +  wakeup-source:
> > +    description: Enables wake up of host system on alarm.
> > +
> > +allOf:
> > +  - $ref: rtc.yaml
> > +
> > +unevaluatedProperties: false
> > +
> 
> Would be great if you could also correct DTS using these bindings (see
> warning from Rob).

It looked to me like 'clock-frequency' should be added to the schema.

Rob
