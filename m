Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002F16093DF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJWOZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJWOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:25:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DFA5592;
        Sun, 23 Oct 2022 07:25:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v1so11803562wrt.11;
        Sun, 23 Oct 2022 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2TGd84mJNKYZWaNw9rSgpYeoRxeJqWopIs81mFX9hM=;
        b=md9aWeGHxax0KdKn3KCysdQBGl/kgf6cCwPGXFAwEDVusPNgVYoIOYrc+MANyQomck
         QJCNOIjpkV7EPUZMYkUSQZpobtjjbvR4TCmixsN5QfyMLpelvx6fFj1Np7ZwAOYyYE0b
         x+23tvXUbnxXMThWdDn5LwrgO6lvL6Q3SYSpLbv8Vl0gPCPFPyDY4Q2JHtze4zUBZiFJ
         83i+fh+JPsN1CCQm6AXcxC7CKKYyvhLMfEI3RIsH4kzxblzv1Tk2xHEu/m2gucZgxatv
         7IJZOB2tPQUt3vYk6HVBrb1Kk9uBODXS8h0os7LhLbGjzh3fUJZacGq1y5O67dlkNfhH
         yeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2TGd84mJNKYZWaNw9rSgpYeoRxeJqWopIs81mFX9hM=;
        b=fJebmoX3xOs84X3a09HEsnmPhjbNsPI9LMzg8R00Fg8N3W6A6GPnrytn9hiktqKki5
         ATYYLL+gnIvoL5t9h4DfO+tR9snmrx8rqDp42VFwRghJbtT25E8WSS5fEqKmINrUfGjc
         /bT9FL2yJALNO7AdrSfxqFUoBeHr/CMdib6av+3tAPjd4/xZRyYEMzL7AnDHbikAF+Gv
         A8+Yyt+AuGt1Rcmei3q4pczVihhOc0KzBF1uJVgltrFUyXJeCQns540BjdGQBlrvva8M
         T8I4WIqp4h2V/w5VAchrJKFfQBfYgMc0tVI/3UTuNsWQmj1lL0kXsvyOecbz5V6B3tID
         xwyA==
X-Gm-Message-State: ACrzQf0V1zsBL096G+n+5ufN/k9w3HVd/D+v5DB9K7YfbXy4yIJ+w6eN
        wUl6sU2XQtzYxjfJyNomvNA=
X-Google-Smtp-Source: AMsMyM5cZ5qYaANvFQtaG8aUeJsUZ/WHs1fwM6KOyo6s+qe6/NWU9ItTeFLX0RH78JM9rSxl4uYKQA==
X-Received: by 2002:adf:f491:0:b0:235:894e:8d6c with SMTP id l17-20020adff491000000b00235894e8d6cmr12064536wro.209.1666535120231;
        Sun, 23 Oct 2022 07:25:20 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003b5054c6f87sm9205046wmq.21.2022.10.23.07.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:25:19 -0700 (PDT)
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
 <ef6a326b-5c61-988b-2ec2-cd8e233e5d28@linaro.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
Date:   Sun, 23 Oct 2022 14:47:56 +0100
In-reply-to: <ef6a326b-5c61-988b-2ec2-cd8e233e5d28@linaro.org>
Message-ID: <GMvEU8xVTkjIoQ518XWAaLkhldSZHlk7@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 22/10/2022 12:27, Aidan MacDonald wrote:
>> This is a new per-DAI property used to specify the clock ID argument
>> to snd_soc_dai_set_sysclk().
>
> You did no show the use of this property and here you refer to some
> specific Linux driver implementation, so in total this does no look like
>  a hardware property.
>
> You also did not explain why do you need it (the most important piece of
> commit msg).
>
>>
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
>> index ed19899bc94b..cb7774e235d0 100644
>> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
>> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
>> @@ -57,6 +57,12 @@ definitions:
>>        single fixed sampling rate.
>>      $ref: /schemas/types.yaml#/definitions/flag
>>
>> +  system-clock-id:
>> +    description: |
>> +      Specify the clock ID used for setting the DAI system clock.
>
>
> With lack of explanation above, I would say - use common clock framework
> to choose a clock...
>
>
> Best regards,
> Krzysztof

Sorry, I didn't explain things very well. The system clock ID is indeed
a property of the DAI hardware. The ID is not specific to Linux in any
way, and really it's an enumeration that requires a dt-binding.

A DAI may support multiple system clock inputs or outputs identified by
the clock ID. In the case of outputs, these could be distinct clocks
that have their own I/O pins, or the clock ID could select the internal
source clock used for a clock generator. For inputs, the system clock ID
may inform the DAI how or where the system clock is being provided so
hardware registers can be configured appropriately.

Really the details do not matter, except that in a particular DAI link
configuration a specific clock ID must be used. This is determined by
the actual hardware connection between the DAIs; if the wrong clock is
used, the DAI may not function correctly.

Currently the device tree is ambiguous as to which system clock should
be used when the DAI supports more than one, because there is no way to
specify which clock was intended. Linux just treats the ID as zero, but
that's currently a Linux-specific numbering so there's guarantee that
another OS would choose the same clock as Linux.

The system-clock-id property is therefore necessary to fully describe
the hardware connection between DAIs in a DAI link when a DAI offers
more than one choice of system clock.

I will resend the patch with the above in the commit message.

Regards,
Aidan
