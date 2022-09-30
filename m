Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287045F130B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiI3Tzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiI3Tz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:55:28 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E9ECAFAF;
        Fri, 30 Sep 2022 12:55:26 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id s125so5809933oie.4;
        Fri, 30 Sep 2022 12:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=WXdH6x0NPtS3zZSDVe1DST+IDEojPhNlnEp+XZLbnsc=;
        b=BFLoPXgZXP8pBIrunlMSayUiA8LPdCB8tMZKyF7OyTlJ2Aw3tga7hYGZSI3faK6bRK
         ns1+xI+4zotnX3LryULsKhtgM5P20qITPbMp8l50Po3d8vzs5zJs9YvP9nI9ZqWXH2F2
         lwWS704FA8DIIwq3Oj1kYh0/n/37RS1MfFPw7my5HOgRJoV7P+cgVtwLJCsXfxk37kL0
         6yEKUZ1pbNZedSLIo7Gy85GM/XwR+dsE0I/wKTiXsI59P7ldZMvO3XzZ1Tc1f6Iag0BM
         l/RbwNbftHpLCfX6y5SWTNvOtMSiGI21dv6yr3dZCeOxlb8VLLPJ8+T75mTlJ+Qc7tL6
         c5rQ==
X-Gm-Message-State: ACrzQf3xN21YcRNhRGNimmIDXOutfR4eHMamvSHeF7UPdnc8zofvAnRr
        fuVk9/hbAarYyjuiSRAs/Q==
X-Google-Smtp-Source: AMsMyM7wPIzWL6a3LEKjW415lN5AtVUXqVOnW4wbyid1Wry6JTsly0Rj50yQaWEAFfqHW+7nD1+SFA==
X-Received: by 2002:a05:6808:130a:b0:350:72d3:ea3f with SMTP id y10-20020a056808130a00b0035072d3ea3fmr4380486oiv.191.1664567725480;
        Fri, 30 Sep 2022 12:55:25 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k28-20020a05680808dc00b00342df642fd3sm710126oij.48.2022.09.30.12.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:55:25 -0700 (PDT)
Received: (nullmailer pid 777338 invoked by uid 1000);
        Fri, 30 Sep 2022 19:55:24 -0000
Date:   Fri, 30 Sep 2022 14:55:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        linux-rockchip@lists.infradead.org, u.kleine-koenig@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, wxt@rock-chips.com,
        linux-kernel@vger.kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, kever.yang@rock-chips.com,
        sebastian.reichel@collabora.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: pwm: rockchip: add interrupts
 property
Message-ID: <166456772354.777288.8174901492888529492.robh@kernel.org>
References: <94bcb278-7bb9-d173-497c-fe12682c4a17@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94bcb278-7bb9-d173-497c-fe12682c4a17@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 16:04:00 +0200, Johan Jonker wrote:
> The Rockchip SoCs have 4 or more built-in PWM channels.
> 
> Configurable to operate in capture mode.
> Measures the high/low polarity effective cycles of this input waveform
> Generates a single interrupt at the transition of input waveform polarity
> 
> Configurable to operate in continuous mode or one-shot mode.
> One-shot operation will produce N + 1 periods of the waveform,
> where N is the repeat counter value, and generates a single interrupt at
> the end of operation.
> Continuous mode generates the waveform continuously and
> do not generates any interrupts.
> 
> Older SoCs have an interrupt for each node.
> Newer models share an interrupt.
> 
> Add interrupts property to the pwm-rockchip.yaml file.
> DT describes hardware. Rockchip PWM driver support for
> interrupts might not available.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
