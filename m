Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13263CC88
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiK3Afp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiK3Afn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:35:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0F427925;
        Tue, 29 Nov 2022 16:35:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 889026198C;
        Wed, 30 Nov 2022 00:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6F8C433C1;
        Wed, 30 Nov 2022 00:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669768541;
        bh=1y4VZS9W80vlMy1UNi9moghtDPF4ssMv9lqkGlxsRbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=diqPyKUCpxdUaaFaQXU7fsMHHpcJXS0BxI+zk9Umkm0qUqAuVnjasDHasbCynDQLq
         mqpzLAMJU2LZ6fdlxtCQ7+SHAN5pvLu2b/At7zlyeMDmMeGSYKeVhQiB0ow108Zuyp
         BGCL/ikf0GrBZnNtlEiS/moWAgkcMf4pI2j8q+g07bYpal1pSAuCSUirAMEi9vlaw3
         w2knzOu79Pp45a1Kp9GpXBZ1impyThd1q0zb4kwCpc3FlGrQTS5E/8ycQUMdAXFpqa
         F4GlD+vJrq9xRYKrQEJ9NqDJ35X2aJXz6xGCS8YYX8HdgnUWcP0h6Ki/fkG+P8BC2L
         NtDfCmPGuaDzQ==
Received: by mail-vs1-f48.google.com with SMTP id 128so15734286vsz.12;
        Tue, 29 Nov 2022 16:35:41 -0800 (PST)
X-Gm-Message-State: ANoB5pnOwUYyam63dXEbDai/4v1HrshMyk1W8AjhyEfO2CDhADOD9o5t
        Klzjo7zv/etGHG9X1ugCm+KIAius1sNezu303Q==
X-Google-Smtp-Source: AA0mqf6olQ2hZD+/mxO78tqVS8rUleLaYbZ18kt7CNqh+XmOT9dT633GD3mlJbp6kjXBLdvaMhVIv57ZgZPwBO5JRcE=
X-Received: by 2002:a05:6102:3003:b0:3aa:2ac7:5956 with SMTP id
 s3-20020a056102300300b003aa2ac75956mr25754133vsa.6.1669768540824; Tue, 29 Nov
 2022 16:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20221129174906.97749-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20221129174906.97749-1-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 29 Nov 2022 18:35:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLpN+CORV8ys3yijB=qHqKF1LjrF=Rrb6AkOEuKc608YA@mail.gmail.com>
Message-ID: <CAL_JsqLpN+CORV8ys3yijB=qHqKF1LjrF=Rrb6AkOEuKc608YA@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: leds: Document commonly used LED triggers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        pavel@ucw.cz, Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     jacek.anaszewski@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, thunder.leizhen@huawei.com,
        festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:49 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Document the commonly used LED triggers by the SoCs. Not all triggers
> are documented as some of them are very application specific. Most of the
> triggers documented here are currently used in devicetrees of many SoCs.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>
> Changes in v4:
>
> * Removed the sorting of triggers
> * Removed the "items" as they were not needed
> * Reworded the description
> * Dropped Zhen Lei's tested-by tag as the patch has changed
> * Added kbd-capslock trigger
>
> Changes in v3:
>
> * Rebased on top of v6.1-rc1
> * Added WLAN Rx trigger
> * Added tested tag from Zhen Lei
>
> Changes in v2:
>
> * Added more triggers, fixed the regex
> * Sorted triggers in ascending order
>
>  .../devicetree/bindings/leds/common.yaml      | 40 ++++++++++++++++++-
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
> index 3c14a98430e1..68da651f29a8 100644
> --- a/Documentation/devicetree/bindings/leds/common.yaml
> +++ b/Documentation/devicetree/bindings/leds/common.yaml
> @@ -98,8 +98,44 @@ properties:
>              # LED alters the brightness for the specified duration with one software
>              # timer (requires "led-pattern" property)
>            - pattern
> -        # LED is triggered by SD/MMC activity
> -      - pattern: "^mmc[0-9]+$"
> +            # LED indicates mic mute state
> +          - audio-micmute
> +            # LED indicates audio mute state
> +          - audio-mute
> +            # LED indicates bluetooth power state
> +          - bluetooth-power
> +            # LED indicates activity of all CPUs
> +          - cpu
> +            # LED indicates disk read activity
> +          - disk-read
> +            # LED indicates disk write activity
> +          - disk-write
> +            # LED indicates camera flash state
> +          - flash
> +            # LED indicated keyboard capslock
> +          - kbd-capslock
> +            # LED indicates MTD memory activity
> +          - mtd
> +            # LED indicates NAND memory activity (deprecated),
> +            # in new implementations use "mtd"
> +          - nand-disk
> +            # No trigger assigned to the LED. This is the default mode
> +            # if trigger is absent
> +          - none
> +            # LED indicates camera torch state
> +          - torch
> +            # LED indicates USB gadget activity
> +          - usb-gadget
> +            # LED indicates USB host activity
> +          - usb-host
> +        # LED indicates [N]th MMC storage activity
> +      - pattern: "^mmc[0-9]{1,2}$"
> +        # LED indicates activity of [N]th CPU
> +      - pattern: "^cpu[0-9]{1,2}$"

This will conflict with Pawel's tree because I already added this.
Mine covers 'cpu' and my 100 core system with 100 cpu leds. ;)

> +        # LED indicates power status of [N]th Bluetooth HCI device
> +      - pattern: "^hci[0-9]{1,2}-power$"
> +        # LED indicates [N]th WLAN Tx/Rx activity
> +      - pattern: "^phy[0-9]{1,2}(tx|rx)$"

And these are pending from Geert[1].

Rob

[1] https://lore.kernel.org/all/a85c256af01f64389a078c2b37c3b72a27d97536.1668005062.git.geert+renesas@glider.be/
