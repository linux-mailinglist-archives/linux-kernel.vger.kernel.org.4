Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA297060AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjEQHEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjEQHED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:04:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF72708
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:03:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96b0235c10bso60251566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684307027; x=1686899027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skuWGLhcahKcfpI9gv7EyAfzwDHEZGuI7n4LLTizb9I=;
        b=xcgAb9uPdAdq0nlFzp3iDfOIwtyGfWnBk7u2+E71JkslkOFLtAD8fhA4D1h/k5gZsI
         WvNeZoWUuFqtS2GIo8vRwKh5qoZqTDJ6KP5BrDGj+VXcEK6ZudfdBgeH6Yztu1GeAzOr
         jIFb0Va1Kg9/B97T61jibpyEXt72R6RE7uo+qJYo+as8nb42gGtPc/4l8B6Loyv+qXT2
         zjE0ftbDZGIAa2AulDsP67AumuvGQucK/et8shEU5UN0G1Po/YYUxz3vyLxxNCLy/qL+
         4Tw4+o8uh1wk9ReW5FpREZFG/TWzY3vPJDBKDvj/9MatKtEMmwWJo1J8IdEi/6lwrOvW
         4Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684307027; x=1686899027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skuWGLhcahKcfpI9gv7EyAfzwDHEZGuI7n4LLTizb9I=;
        b=O+NsE5hnfzkSY2nbDskcgDQXgNP6Dl3KnqMHCcpZwbTip1jz5DKf04WXB3WwYgLIDp
         IKORyVfOf6HxeNN86NSi3CLKLV/lsrbUCJzQs1G70wDLTm9ioC/7nWHRIMQcoB8kvDOw
         lEMwMSgXGxKMke9fNslHk8eKUjzJOrcVea4ZGZPNZDbmtB+XQCYFbkIC3+rlYJ8bvSwH
         K3aa4q0zl03Ic0H0jT0flkU0KrIq8jro7WhBqCrP8yKxALqZ5uLmS+UIL02HFBDCOpf9
         o+fSZibat/ZVYxfAuDDUrDdtNZZ8qukjGzs5q6g/5uD6vC7MpaglcchryjEvvMMfeUx8
         FpGQ==
X-Gm-Message-State: AC+VfDxN4GSEpQJPyp0EkrFrjZ5UYk6rmC6tFUqqRIhrnqfNfIDJZmI3
        RDNY9zfWFvazokIXEc0EQzaTrg==
X-Google-Smtp-Source: ACHHUZ7PbnK+4EsSURGPM2BgTIgsWuRJr6EknCyxYT2iu2yURY/Jp855T0yFgP+syLZqbCRC0hNxLw==
X-Received: by 2002:a17:907:3ea5:b0:96b:559e:7f2f with SMTP id hs37-20020a1709073ea500b0096b559e7f2fmr8394708ejc.38.1684307026625;
        Wed, 17 May 2023 00:03:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id hv7-20020a17090760c700b00965be665811sm11871346ejc.2.2023.05.17.00.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:03:46 -0700 (PDT)
Message-ID: <97124cb1-4f45-22d5-418f-568f8a68deec@linaro.org>
Date:   Wed, 17 May 2023 09:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: display: panel: add
 panel-mipi-dsi-bringup
Content-Language: en-US
To:     Paulo Pavacic <pavacic.p@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        robh+dt@kernel.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAO9szn18KsR0c+U8EEY1=xnmsKMxy6SEArMUic0z=aYJDVwWCQ@mail.gmail.com>
 <023f6cf9-0f08-f27e-d203-5ff78faf110f@linaro.org>
 <CAO9szn1EsbuPSRrOW8CLqhp+QUcL=9NE93FAwsg2n3htd_aJTw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAO9szn1EsbuPSRrOW8CLqhp+QUcL=9NE93FAwsg2n3htd_aJTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 00:13, Paulo Pavacic wrote:
> Hello, thank you for your time to review this patch and sorry for not
> addressing all of the concerns, it was done unintentionally. This is
> my first contribution to the Linux kernel and it is quite a process.
> I have run those two scripts and haven't received any errors I have
> latest master cloned so I will check what I did wrong.
> 
> The thing I would like to get approval on before I try anything else
> is the name 'panel-mipi-dsi-bringup':
> 
>> Still wrong filename. You did not respond to my previous comments, so I
> don't really understand what's this.
>>
>> Judging by compatible, this should be fannal,c3004.yaml
>>
>> If not, explain please.
>>
>> Missing user of the bindings - driver or DTS. Please sent patches together as patchset.
> 
> 
> I wasn't sure how to name it and this name seemed fit. I'm not sure
> how to be concise about this, but here is the full story as to why I
> have done that:
> 
> I got a task to enable panel for which working driver wasn't
> available. I have started testing raydium driver and modifying parts
> of it until I got it working.
> Driver was modified quite a lot, new functions, macros and structures
> were added which resulted in a new driver.
> Therefore I have made a simple driver which I have submitted for a
> review which will probably be rejected now due tomany reasons I have
> noticed after sending it:
> https://lore.kernel.org/lkml/CAO9szn03msW6pu37Zws5EaFGL10rjp9ugPdCuDvOPuQRU72gVQ@mail.gmail.com/T/
> 
> While talking with manufacturers of the panel I have figured out that
> they aren't that familiar with the Linux kernel.
> They had previously only enabled  it on bare metal (PLA?) and provided
> me with the initialization sequences. Initialization sequences are hex
> values sent over MIPI DSI to initialize panel controller.
> Initialization sequences sometimes also require delays after certain
> commands and for different panels it can be very different.
> I believe I have simplified it so that someone can follow comments
> inside of the driver and try to enable mipi dsi panel by copy pasting
> initialization code from bare metal system and doing minor
> modifications.
> Since I have targeted this at people who need to enable their panels
> for the first time name seemed okay. I thought that since there is
> panel-simple.yml that panel-mipi-dsi-bringup.yml would be acceptable
> name.

Bindings are for hardware, not driver, so they describe the hardware panel.

Best regards,
Krzysztof

