Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07437726A29
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjFGTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjFGTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:50:32 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AB22102;
        Wed,  7 Jun 2023 12:50:30 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-33b04c8f3eeso6993845ab.0;
        Wed, 07 Jun 2023 12:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686167430; x=1688759430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxz+VSY3OchR10r0VISpQdXnKAXD7OegfTXcHZuDAYI=;
        b=ZcbNvKvgVRnnJUh/xs4NbqnLSduDa27gDSkVkckszJ/VEM1hoALg9gZYIyf5wxhVAY
         UgAXpFTeuRoe4I8qkvawVJUABAQcHZKJBnCV0550LdNv6kVE3RDYqDjduSBzp7682FiC
         aBOTJAPdHlEgPe9yj9z5n8ASYBXKyGP8eWbUfSBDS5wuUBp5la0geu00j40JAHpLSR7f
         /xARpUx6RdhRNlSpS+tXbvIC85hiTsYZ0oFKWyCRyoL/qg4x25WlkcxFzwRHcdaKeInE
         l3DvyG79OW0R8KfF784VfjFRRjgru06EFzGWvROAvtXZYLlxtCRXifFHuul/MGGhhQyw
         PeVg==
X-Gm-Message-State: AC+VfDxnjOukXzDekcmcTe+iOsHgU/EOmvlhAf8quXGvEacLxUNEWJ4A
        GrvCg3w9npsGpOv6jG0ipg==
X-Google-Smtp-Source: ACHHUZ6tTOede3FtgEtqDJNqsgOvBRsC+XBRPLf51VdMkdKwVWMknIrdONxR0TfLO75XXTRxbToixw==
X-Received: by 2002:a92:d34a:0:b0:33b:820:41ad with SMTP id a10-20020a92d34a000000b0033b082041admr5387661ilh.9.1686167429947;
        Wed, 07 Jun 2023 12:50:29 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h14-20020a926c0e000000b0033af42a969asm3910489ilc.57.2023.06.07.12.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 12:50:29 -0700 (PDT)
Received: (nullmailer pid 3907121 invoked by uid 1000);
        Wed, 07 Jun 2023 19:50:27 -0000
Date:   Wed, 7 Jun 2023 13:50:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v4 01/10] dt-bindings: vendor-prefixes: add bouffalolab
Message-ID: <20230607195027.GA3894404-robh@kernel.org>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-2-jszhang@kernel.org>
 <a45c9193-aa63-650f-dbb3-14b6c3f74eeb@sholland.org>
 <ZGneH+ApaQVvv3SW@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGneH+ApaQVvv3SW@xhacker>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 05:02:23PM +0800, Jisheng Zhang wrote:
> On Thu, May 18, 2023 at 09:53:12PM -0500, Samuel Holland wrote:
> > Hi Jisheng,
> > 
> > Thanks for updating this series!
> > 
> > On 5/18/23 10:22, Jisheng Zhang wrote:
> > > In the following commits, we will support bl808 SoC which is from
> > > Bouffalo Lab Technology (Nanjing) Co., Ltd.
> > > 
> > > Add bouffalolab vendor prefix binding.
> > > 
> > > Link: https://en.bouffalolab.com/
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > index 82d39ab0231b..3566346f2f9e 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > @@ -200,6 +200,8 @@ patternProperties:
> > >      description: BOE Technology Group Co., Ltd.
> > >    "^bosch,.*":
> > >      description: Bosch Sensortec GmbH
> > > +  "^bouffalolab,.*":
> > > +    description: Bouffalo Lab Technology (Nanjing) Co., Ltd.
> > 
> > Have you thought about using the "bflb" abbreviation as the vendor
> 
> I did think about bflb vs bouffalolab. Here is what I thought: I came
> across "marvell" vs "mrvl" sevral years ago, I got an impression
> "marvell" vendor prefix is preferred if I read the discussions
> correctly.
> 
> As for Bouffalolab vendor prefix, I have no preference, maybe DT
> maintainers can provide inputs here.
> Rob, Conor, Krzysztof, what's your opinion?

The general preference is to match the vendor's domain name (minus the 
.com, etc.). Originally, the preference was stock ticker symbol, but 
we've pretty much moved away from that.

So that's 'bouffalolab'.

Acked-by: Rob Herring <robh@kernel.org>

Rob
