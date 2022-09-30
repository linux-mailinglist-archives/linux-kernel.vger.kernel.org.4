Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7B25F1307
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiI3TzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiI3TzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:55:08 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A8C7F11D;
        Fri, 30 Sep 2022 12:55:07 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id n83so5778853oif.11;
        Fri, 30 Sep 2022 12:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mhBjWFFTxH/l4HE/1rEJYkS22XnxP7DvbO1wKoQGgbc=;
        b=V/oE/vnt2bYm3aZ9VTOhnwNpK/w3joFpMxwT66lDP/NDI5WfmLazaF73Y2yIbEMUdn
         dCjUWhl8GcMnTbfQ/asBCBQURQv9BfKZ/oCrLIO+NeH2VNbMT4ySMs1NfjA/qZrTy3I6
         FdEh95pjeNZbIsi5tW3QT0MbaR6m5MGk4jlrmmIntb0Ki5qsm/BDAgUJhX5YCg9sNF4e
         WVsTJX6R5PWyIFeJxpFNHfp0+bNnVXx6mYyb3z5jNXqftnJlsXGMkhcMN4ZJh1AO8M8X
         9AsZgfm6QThG4kBAGd+ityjURLyymPrL5QS2bCWXguKBTBDHbKEFmgDdGeJW1YXHXnqZ
         Ar6g==
X-Gm-Message-State: ACrzQf0tnCKm0GWGhT1yiBJ7+4cfCL3zns3ylXlvZR9sUnBllSU4D1YA
        5DMfX5dnGGh6+hdefxsZvg==
X-Google-Smtp-Source: AMsMyM6D9XCOqU00dMtXL1n1avBsiKPbPiVJemqTZCSbe94plaS9Dy5WCyaBewx19Mmf+1WIPKsCNA==
X-Received: by 2002:a05:6808:1986:b0:350:8c87:c5a2 with SMTP id bj6-20020a056808198600b003508c87c5a2mr4569098oib.57.1664567706612;
        Fri, 30 Sep 2022 12:55:06 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p84-20020acad857000000b00345cce8083dsm716549oig.33.2022.09.30.12.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:55:06 -0700 (PDT)
Received: (nullmailer pid 776953 invoked by uid 1000);
        Fri, 30 Sep 2022 19:55:05 -0000
Date:   Fri, 30 Sep 2022 14:55:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com, wxt@rock-chips.com,
        kever.yang@rock-chips.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/2] ARM: dts: rk3288: add the interrupts property
 for PWM
Message-ID: <20220930195505.GA774897-robh@kernel.org>
References: <6eba6c10-9c96-b40f-937a-e02d43b04cd7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eba6c10-9c96-b40f-937a-e02d43b04cd7@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 04:04:06PM +0200, Johan Jonker wrote:
> The Rockchip rk3288 SoC has 4-built-in PWM channels.
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
> Add interrupts property to rk3288 PWM nodes.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> ---

Please thread your series properly. That's replies to the cover letter 
or patch 1 if there isn't a cover letter. git-send-email does this by 
default.

Rob
