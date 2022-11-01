Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C156151B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiKASoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKASoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:44:02 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6141C41D;
        Tue,  1 Nov 2022 11:44:01 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 16-20020a9d0490000000b0066938311495so8989759otm.4;
        Tue, 01 Nov 2022 11:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSHjG8R+iiHh2t0Y9q4ozqcAUQJpgtDmFSxaww2RfC8=;
        b=uASvZW38bDgTnlvGxwMg1kKk0vMX0RXDp94yA82vk4NEPditN1M9PQB+FtijloJZpI
         VgImiiZ+a+GUZrraVGHioukX1j+e7jvFbXR/49pD0pTnBZ8EZZXwYBAeaTJ/PPxzN9KG
         3joFKJHHB9CLic4RcquZUzzs8t37IALrvjMGjPtYVSlNRgRUmaWUoKUdHvGuCVWpSrCc
         UdxHExo0wOgZN8te4BCmpsDFwVu+MRGuKMHsBpXzfa1/pJpPi48K2GfFohT50YJbtMm8
         CnkJCEt1aRmnOOLULXdSGru+RjmvhCRv8PCXnG4sereXbjfVLgTdy+V9KZnOoebc7tQL
         RoUg==
X-Gm-Message-State: ACrzQf2KNdD/ttjM9c4rNbPFfEU3XM1Y4gIOdqwcyc+fC7oP9s95jZGM
        m7ULlXYjGmbeQJa47XuT3g==
X-Google-Smtp-Source: AMsMyM7njngmvGBqaNI0hmbLeI8J7D+m/590yz6hTr4SjGyLiI6TWv5Y6OvH5D0/4/fg0G6fuj+qdg==
X-Received: by 2002:a05:6830:33e1:b0:655:e771:f572 with SMTP id i1-20020a05683033e100b00655e771f572mr10516595otu.245.1667328240601;
        Tue, 01 Nov 2022 11:44:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x32-20020a05683040a000b0066aba96addbsm4144151ott.81.2022.11.01.11.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:44:00 -0700 (PDT)
Received: (nullmailer pid 1887453 invoked by uid 1000);
        Tue, 01 Nov 2022 18:44:02 -0000
Date:   Tue, 1 Nov 2022 13:44:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Message-ID: <20221101184402.GA1884153-robh@kernel.org>
References: <20221013094838.1529153-1-Naresh.Solanki@9elements.com>
 <20221013094838.1529153-2-Naresh.Solanki@9elements.com>
 <20221024161806.GA1855651-robh@kernel.org>
 <dcd22f70-e51c-290e-c11f-9a5ce32748c1@9elements.com>
 <CAL_JsqKT52ULEZjKo9emEAt74nH2OpMO8ymLLKM_T-NzAwqGog@mail.gmail.com>
 <3152c290-8aca-b91a-df20-335c33395835@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3152c290-8aca-b91a-df20-335c33395835@9elements.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:35:09PM +0530, Naresh Solanki wrote:
> Hi Rob,
> 
> On 26-10-2022 07:07 pm, Rob Herring wrote:
> > fanc: fan-controller {
> >    #pwm-cells = <3>;
> >    ...
> > 
> >    fan {
> >      pwms = <&fanc 0 500000  PWM_POLARITY_INVERTED>;
> >      ...
> >    };
> > };
> > 
> > 0 is PWM number and 500000 is the PWM frequency. The 3rd cell are per
> > consumer flags. See pwm.txt for more details.
> 
> Did the implementation & while testing getting the below err:
> [63.626505] max6639 166-002e: failed to create device link to 166-002e

Does turning off fw_devlink help (fw_devlink=off)?

Rob
