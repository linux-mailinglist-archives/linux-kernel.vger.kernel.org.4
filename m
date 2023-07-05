Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421F4748894
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjGEPz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjGEPzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:55:55 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392041BD3;
        Wed,  5 Jul 2023 08:55:33 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7866189cff1so217588839f.0;
        Wed, 05 Jul 2023 08:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572532; x=1691164532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rSoGXzR6xG4D7+xiKVq4hPnm2cmCrDmsuR9LzzxGbE=;
        b=FY2PCz+V1fVgg1YjttWBhuqHB6RP48FQe1n/9dxbsMiMA5+N+/9jXE2/SceKYipfpt
         DYanD3KNUrYvkDuAzDnyauXdO7CHAQn/FARFqRgz3ClJmkLWK8Mjv73UCtUwf5eVP7go
         v47vhjpi2S/FzsoUb+8YuDNw34hDKYUtTqI1xRZG1pUh8qsvxm9niO56dtVKEUOXEDLW
         2P6ddGCmGh3FzPNnggC72+q0fmdaylemmTuJ03e7N79BF1nq2EYGALPfHFQ3BTeH0I/6
         fqOwNHhgPvVp7bpNsRG/ukBM6u3y00aArZF3O0ZHEjw9uw+dYxiDXRwsItlLaynsqZ16
         1k2Q==
X-Gm-Message-State: AC+VfDzRl5W/HxvXfUE+MhQtxJGBbNvuaIeNsCMLWQYaSvkpCbDRCw2q
        +QN4fZDZEiV+WX2A+1hW3Q==
X-Google-Smtp-Source: ACHHUZ4ygrlsf8gFmuXud+DEItzF9RQnCwmml5OJHzkp7JgXz/DC0Wq9IL7lhUkR6Q1E0P5+2IYt6A==
X-Received: by 2002:a5e:8f46:0:b0:786:2706:ecf6 with SMTP id x6-20020a5e8f46000000b007862706ecf6mr18206376iop.11.1688572532183;
        Wed, 05 Jul 2023 08:55:32 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c14-20020a5d8b4e000000b007862c74cec6sm5199631iot.1.2023.07.05.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:55:31 -0700 (PDT)
Received: (nullmailer pid 694283 invoked by uid 1000);
        Wed, 05 Jul 2023 15:55:29 -0000
Date:   Wed, 5 Jul 2023 09:55:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Read max-brightness from
 devicetree
Message-ID: <168857252930.694223.17559633375471869114.robh@kernel.org>
References: <20230703130313.548519-1-astrid.rost@axis.com>
 <20230703130313.548519-2-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703130313.548519-2-astrid.rost@axis.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Jul 2023 15:03:12 +0200, Astrid Rost wrote:
> Normally, the maximum brightness is determined by the hardware, and this
> property is not required. This property is used to set a software limit.
> It could happen that an LED is made so bright that it gets damaged or
> causes damage due to restrictions in a specific system, such as mounting
> conditions.
> Note that this flag is mainly used for PWM-LEDs, where it is not possible
> to map brightness to current. Drivers for other controllers should use
> led-max-microamp.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

