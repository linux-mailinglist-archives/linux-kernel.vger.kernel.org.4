Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC91659066
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiL2Sar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiL2Sai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:30:38 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491FBBA;
        Thu, 29 Dec 2022 10:30:37 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id c133so17784887oif.1;
        Thu, 29 Dec 2022 10:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xdAcfpKxTu7PYGnCACWMz2o9LPaeAapSTfB4+aqGA4=;
        b=GkB1ZyaXEkUC55bjqZpj5ME+hgpvvGfN9MkXwaLwo205xZNmGsrsuKtC2qPIokuxZP
         mzjzs4ogAI8ggEGKxvU1EbIHO7LtF0UgHgBMk4bncb/j6W82CU4nMm0tVH/wU/hY4QdJ
         FxkYzFOF3uInQaE7KQyvVZtlz5OBIqV2+MM0Q98N5AxJwEnI6atlrTFkumfkU3Yses0n
         EzlRXvSwihN4oSBd5/pBDCewheqoX7POSJenyAe5qYcwDqrzVDChLB7LBbHL1AjLz2I3
         Ym9nxqJZpVutG8ywOz0z0VLSNnrsI4uBm8yTJV4601iBcMkGQ67W4mPcUiPyKNd1EHwm
         r2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xdAcfpKxTu7PYGnCACWMz2o9LPaeAapSTfB4+aqGA4=;
        b=qJw5YYxfsz1gW2NlNgqBvqiweGSEctAN1QF7Vzv3xV5Gt/ZkRU1gHdtehBvxd9wFzq
         9YTY1uX06tdGkGxKpLFOjKE6+ogTOOMAIsTWrabnep2PD9i6qBxQ7H6YZfYVDjQAY26w
         D/TMxVO+AsW7KtXjwpLQhSbhxnH0QziCtYSryanbuLuCML9rMcj3G+fDXFTt4EcfIlaT
         g7nIYrwARQqNhcCPl+/gXqWaUYfOskoOoteIu1y+d9mKMa7kQ4+JHJDim3HMSartvTLG
         /cF2tg/SqC4OQ5QUXvaqSMj2lehuImZsN16lX+WcNYuXczEk6Ptkd/1EKKjmuC8vkxMB
         nPgw==
X-Gm-Message-State: AFqh2kqISNEDq9iAyfl6NYheNrydFencOEyIWmWQWbjlPaLCMImIIemy
        8QMV7yx7P4pc7TUdlRIa9wI=
X-Google-Smtp-Source: AMrXdXsGlNcSn3qYLZQUeL9Gsgz7KL6dpIcfIqcAyE7rZt/1LLKN8L09OU11w1rhzSS83PE0If0NEw==
X-Received: by 2002:a05:6808:2082:b0:35e:93bf:a9bb with SMTP id s2-20020a056808208200b0035e93bfa9bbmr25489995oiw.13.1672338636883;
        Thu, 29 Dec 2022 10:30:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bl22-20020a056808309600b0035e7d07bf9dsm8412857oib.16.2022.12.29.10.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 10:30:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 10:30:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sinan Divarci <Sinan.Divarci@analog.com>, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: Add bindings for max31732
Message-ID: <20221229183034.GA29265@roeck-us.net>
References: <20221214142206.13288-1-Sinan.Divarci@analog.com>
 <20221214142206.13288-4-Sinan.Divarci@analog.com>
 <386e3717-a063-a2ea-6028-19d11b5838b0@linaro.org>
 <20221229155227.GA22937@roeck-us.net>
 <105cae8a-ba03-ea60-70f2-8a307a26ad14@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105cae8a-ba03-ea60-70f2-8a307a26ad14@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 05:39:30PM +0100, Krzysztof Kozlowski wrote:
> On 29/12/2022 16:52, Guenter Roeck wrote:
> >>> +  adi,alarm1-interrupt-mode:
> >>> +    description: |
> >>> +      Enables the ALARM1 output to function in interrupt mode.
> >>> +      Default ALARM1 output function is comparator mode.
> >>
> >> Why this is a property of DT/hardware? Don't encode policy in DT.
> >>
> > 
> > I would not call this "policy". Normally it is an implementation
> > question or decision, since interrupts behave differently depending
> > on the mode. Impact is difficult to see, though, since the chip
> > documentation is not available to the public.
> 
> Some more background would be useful here from the author...
> 

Indeed. Oddly enough I found the datasheet (as Google employee), but 
it is under NDA which means that I can't say much but "this is wrong"
or "this doesn't work" in some or even all situations. I am not even
sure if I can say that much because saying so implies providing
information about the chip which I am bound to not expose. Sigh.

Anyway, from public information and the driver.

- The chip has one internal and four external channels. Channel
  configuration is per channel (there is an enable flag for each
  channel). This means devicetree configuration must be nested and
  include per-channel information (at the very least information
  if a channel is enabled). Other configuration information, if it exists,
  may also be per channel. That includes both resistance cancellation,
  beta compensation, and possibly other configuration data. One thing
  that came to mind was diode linearity factor. Examples for existing
  properties in other drivers:
	adi,ideal-factor-value (ltc2983)
	transistor-ideality (max6697)
	ti,n-factor (tmp421)
	extended-range-enable (may be dynamic; the driver currently
		disables it)
	ti,extended-range-enable (lm90)
	resistance-cancellation (max6697)
	beta-compensation-enable (max6697)
	ti,beta-compensation (tmp401)
	smbus-timeout-disable (max6697)
	alert-mask, over-temperature-mask (max6697)
		I am really happy with those; I think it should be
		automatic based on enabled channels
	temperature-offset-millicelsius (lm90)

Then there is the question if temperature limits should be provided
in devicetree, in addition to the above where appropriate. After all,
those are thermal system properties.

Examples for channel based devicetree property descriptions:

devicetree/bindings/hwmon/
	ti,tmp421.yaml
	nuvoton,nct7802.yaml
	national,lm90.yaml

Looking into interrupts and interrupt modes:

For the interrupt mode, I'll assume for the time being that its
implementation is similar to that of other chips. I'll use MAX31730
as example, and subsequently refer to it as if MAX31732 would
implement the same mechanism.

In interrupt mode, interrupts are cleared by writing into the
status register. If the condition still exists, the interrupt will
be re-asserted after the next conversion. Clearly, that does not work
with the driver as written - it would fill the log with messages,
and send an endless amount of notifications to userspace.

In comparator mode, interrupts are asserted whenever a temperature
measurement exceeds a threshold value, and is deasserted when the
temperature is back in the acceptable range. This would be equivalent
to an edge triggered interrupt.

The example below configures interrupts in interrupt mode but with
IRQ_TYPE_EDGE_BOTH. No idea how that is supposed to work, because
in interrupt mode the interrupt would have to be level triggered,
not edge triggered, to make sense. Edge triggered interrupt only
makes sense if the chip is in comparator mode, since only in that mode
the edges have any meaning.

The driver would need to know if the interrupt is edge triggered or
level triggered, and that should decide how to handle it. Edge triggered
should result in comparator mode, and level triggered should result
in interrupt mode.

Overall I am not sure if comparator mode even makes sense, since
the interrupt line(s) would become active if a single temperature
is out of range, and only become inactive if all temperatures are
within range. Effecively this mode could only be used on a subset
of channels, but that would require the ability to enable alerts
on a per-channel basis.

Either case, the interrupt handler would need to cache any previously
reported status, since it should only generate a notification if the
status changes, and not for each interrupt and each channel. 

With that, enough for now.

Guenter

> > 
> >>> +    type: boolean
> >>> +
> >>> +  adi,alarm2-interrupt-mode:
> >>> +    description: |
> >>> +      Enables the ALARM2 output to function in interrupt mode.
> >>> +      Default ALARM2 output function is comparator mode.
> >>
> >> Same question.
> >>
> >>> +    type: boolean
> >>> +
> >>> +  adi,alarm1-fault-queue:
> >>> +    description: The number of consecutive faults required to assert ALARM1.
> >>
> >> Same question - why this number differs with hardware?
> >>
> > 
> > Noisier hardware will require more samples to avoid spurious faults.
> > Trade-off is speed of reporting a fault. Normally the board designer
> > would determine a value which is low enough to avoid spurious faults.
> > 
> > Note that the chip (according to patch 2/3) supports resistance
> > cancellation as well as beta compensation, which are also board specific.
> > I don't have access to the datasheet, so I don't know for sure if those
> > are configurable (typically they are). If they are configurable, I would
> > expect to see respective properties.
> 
> If that's the argument behind property, then it's fine.
> 
> Best regards,
> Krzysztof
> 
