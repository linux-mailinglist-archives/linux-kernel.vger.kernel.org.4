Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351FD5FF500
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJNVGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJNVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4931905D3;
        Fri, 14 Oct 2022 14:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD0C961BEA;
        Fri, 14 Oct 2022 21:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1018BC43145;
        Fri, 14 Oct 2022 21:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665781556;
        bh=iwtaw18SgQfyVreOlBjZ/VGlpTVryimlc+lwG/JqXWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WmPSji7sbHqULwD9i+xveomk3mxFQF1QLToed5H4/6Bq4eO0J/0hlUjMNmV9RLmE1
         2WQWqYXzMCzrQL+w873UETyOZsuCkqJ4mGMrqsipYPe1XT/hSo5Q7jVFBZcgAPcsR0
         IPR0fojYFZw1Skvcm2SRc7VqcbvynzA1nJy3HDAxDkr1kdx3O15nWqR5pFBAiMBtwL
         w9kbk5e0apULtTmxRS9OpdcqgXW4l4jdcpO/1qfctr0hQeWJ5cTYtJINgtNA1SQ8+n
         vpD/9biCHXLGUGb3Xup7nCbrjoJvHd3nUiwdWljsv8gINI7OgJw45q0HMEQxqNtgXf
         u+aWp1dtngDow==
Received: by mail-ua1-f48.google.com with SMTP id t26so2363834uaj.9;
        Fri, 14 Oct 2022 14:05:55 -0700 (PDT)
X-Gm-Message-State: ACrzQf2TWtV7h9putW9uZsVu66ZgRQPCP6i+ySni3WfbuwlFwprLImIS
        1oT3EYN1Tr2faeENuLM61xO0Eduf3jmNodm/AA==
X-Google-Smtp-Source: AMsMyM4Twm//j07Dxsd28ylIM+PiFANjOaPsp/7z1ebAU3rElAWScDtRAc1ozOv1uTQH68YDbmQAED/5lcAdhLB039o=
X-Received: by 2002:ab0:166f:0:b0:3e8:af59:df81 with SMTP id
 l44-20020ab0166f000000b003e8af59df81mr3610910uae.36.1665781554888; Fri, 14
 Oct 2022 14:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221014183459.181567-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221014183459.181567-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 14 Oct 2022 16:05:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKC_BJDJLLFck_0CbQ-0rZ0oVWMAdiwwGep23nh2pP19g@mail.gmail.com>
Message-ID: <CAL_JsqKC_BJDJLLFck_0CbQ-0rZ0oVWMAdiwwGep23nh2pP19g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] media: dt-bindings: ov5645: Convert OV5645 binding
 to a schema
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 1:35 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Convert the simple OV5645 Device Tree binding to json-schema.
>
> The previous binding marked the below properties as required which was a
> driver requirement and not the device requirement so just drop them from
> the required list during the conversion.
> - clock-frequency
> - enable-gpios
> - reset-gpios
>
> Also drop the "clock-names" property as we have a single clock source for
> the sensor and the driver has been updated to drop the clk referencing by
> name.

Driver requirements are the ABI!

This breaks a kernel without the driver change and a DTB that has
dropped the properties.

Also, with 'clock-names' dropped, you've just introduced a bunch of
warnings on other people's platforms. Are you going to 'fix' all of
them?

Rob
