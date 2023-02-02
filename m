Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D531688588
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjBBRga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjBBRg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:36:29 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDB329409;
        Thu,  2 Feb 2023 09:36:27 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z11so2807171ede.1;
        Thu, 02 Feb 2023 09:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HioFfeJdcxYRSIePrk0xPeneN7bTewVzuuGNUxyF+Q=;
        b=DgYe/MckqiMlJv5lX6qtOy2RdSlf9HWoVcWPf1C5A9ll+SRh7voCyz+NA64bhzh+6/
         s6mvdEEKfye26uhEJ23ipwJr8a1qpBHq2v8E1UNx3Kjua7yEJBM1lVMSWb7l5t4afwPX
         NC8Ngx0j3yd+p+rWO5aBYsOU6K0KVHnSRrS4OC8T+e1TqldTsGc0awMKVV7I7kIlqXM1
         UZDPQrrR0l2mmgiBijgpcJMKDpPzpRpNQ/Dx9ap2wWz77ECUrTvDzHZH/LuGcXempTwQ
         VIYpEcFp/DDcRU0BBLCdKwGsD1XFx66gOy31SAxiBmBrOEU453nRjdZ0cq+Rjhp6xSQo
         KKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HioFfeJdcxYRSIePrk0xPeneN7bTewVzuuGNUxyF+Q=;
        b=WhSXP/43cKwX0nUlJqBKfSMw+iqaujkxI91k92siMj8913saLcyqmyhV/4VrmyYTdv
         30Z/H/pUQ0ocsZQ3Sg8iTTeEhUnzRuLhafAF+9PiM4y7G1C7RsLOm8AGJa6hUehdz3p2
         shuYdtSyP8kp35tRqz5CT8vkgj4fv3j3fIqwxIzFIkNV5N+t0KosZkg9EVmG2/yjiZbP
         HtzuERZ/WCqJYztUfItyeXU660Dg4YpHUBhq6ifv1mlDGPFf09ndp8KQJPdpIydMiHLt
         YfeZhwREDBDE+GYRyFP1OZvrNWPQtOy0tT6J4/ke/leRTnetahbeM1rzLKLXYemw571f
         ackQ==
X-Gm-Message-State: AO0yUKW5vYz33GDrWCc4zCm7MXqAaVPcz1Q5ptiSUiCuFVCHdW7INO9D
        lX3k/ER9JXhOBWmQH80SNCgFfQl3np3xSHP+1lk=
X-Google-Smtp-Source: AK7set8kMxHBzefcTNVdGk+Fp2hvQCwE7N//UbyQQXSrTxuXqDeQbZXJhcbZfUDVjj6ajWFyZn1lL6NGFTaLwf83qvw=
X-Received: by 2002:a05:6402:339:b0:49c:ea59:46b with SMTP id
 q25-20020a056402033900b0049cea59046bmr2368486edw.54.1675359386002; Thu, 02
 Feb 2023 09:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230130085542.38546-1-naresh.kamboju@linaro.org>
 <CAGETcx_411fVxsM-ZMK7j2Bvkmi2TKPbzSuD+03M3cb7WKHfJw@mail.gmail.com> <20230131101813.goaoy32qvrowvyyb@bogus>
In-Reply-To: <20230131101813.goaoy32qvrowvyyb@bogus>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Thu, 2 Feb 2023 20:36:14 +0300
Message-ID: <CALHCpMijXAgQx2qq8g8zdq=6AHwP+g5WVBjjry=v+dKEq9KDLw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        abel.vesa@linaro.org, alexander.stein@ew.tq-group.com,
        andriy.shevchenko@linux.intel.com, brgl@bgdev.pl,
        colin.foster@in-advantage.com, cristian.marussi@arm.com,
        devicetree@vger.kernel.org, dianders@chromium.org,
        djrscally@gmail.com, dmitry.baryshkov@linaro.org,
        festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com,
        geert+renesas@glider.be, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        jpb@kernel.org, jstultz@google.com, kernel-team@android.com,
        kernel@pengutronix.de, lenb@kernel.org, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux@roeck-us.net, lkft@linaro.org, luca.weiss@fairphone.com,
        magnus.damm@gmail.com, martin.kepplinger@puri.sm, maz@kernel.org,
        miquel.raynal@bootlin.com, rafael@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, sakari.ailus@linux.intel.com,
        shawnguo@kernel.org, tglx@linutronix.de, tony@atomide.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

> Can you try the patch at the end of this email under these
> configurations and tell me which ones fail vs pass? I don't need logs

I did these tests and here is the results:

1. On top of this series - Not works
2. Without this series    - Works
3. On top of the series with the fwnode_dev_initialized() deleted - Not works
4. Without this series, with the fwnode_dev_initialized() deleted  - Works

So your nvmem/core.c patch helps only when it is applied without the series.
But despite the fact that this helps to avoid getting stuck at probing
my ethernet device, there is still regression.

When the ethernet module is loaded it takes a lot of time to drop dependency
from the nvmem-cell with mac address.

Please look at the kernel logs below.

The first log corresponds to kernel with your nvmem/core.c patch:

    [    0.036462] ethernet@70000 Linked as a fwnode consumer to
clock-gating-control@1821c
    [    0.036572] ethernet@70000 Linked as a fwnode consumer to partition@1
    [    0.045596] device: 'f1070000.ethernet': device_add
    [    0.045854] ethernet@70000 Dropping the fwnode link to
clock-gating-control@1821c
    [    0.114990] device:
'platform:f1010600.spi:m25p80@0:partitions:partition@1--platform:f1070000.ethernet':
device_add
    [    0.115266] devices_kset: Moving f1070000.ethernet to end of list
    [    0.115308] platform f1070000.ethernet: Linked as a consumer to
f1010600.spi:m25p80@0:partitions:partition@1
    [    0.115345] ethernet@70000 Dropping the fwnode link to partition@1
    [    1.968232] platform f1070000.ethernet: error -EPROBE_DEFER:
supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready
    [    2.088696] devices_kset: Moving f1070000.ethernet to end of list
    [    2.088988] platform f1070000.ethernet: error -EPROBE_DEFER:
supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready
    [    2.152411] devices_kset: Moving f1070000.ethernet to end of list
    [    2.152735] platform f1070000.ethernet: error -EPROBE_DEFER:
supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready
    [    2.153870] devices_kset: Moving f1070000.ethernet to end of list
    [    2.154152] platform f1070000.ethernet: error -EPROBE_DEFER:
supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready
    [    2.644950] devices_kset: Moving f1070000.ethernet to end of list
    [    2.645282] platform f1070000.ethernet: error -EPROBE_DEFER:
supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready
    [    3.169218] devices_kset: Moving f1070000.ethernet to end of list
    [    3.169506] platform f1070000.ethernet: error -EPROBE_DEFER:
supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready
    [    3.170444] devices_kset: Moving f1070000.ethernet to end of list
    [    3.170721] platform f1070000.ethernet: error -EPROBE_DEFER:
supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready
    [    3.419068] devices_kset: Moving f1070000.ethernet to end of list
    [    3.419359] platform f1070000.ethernet: error -EPROBE_DEFER:
supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready
    [    3.521275] devices_kset: Moving f1070000.ethernet to end of list
    [    3.521564] platform f1070000.ethernet: error -EPROBE_DEFER:
supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready
    [    3.639196] devices_kset: Moving f1070000.ethernet to end of list
    [    3.639532] platform f1070000.ethernet: error -EPROBE_DEFER:
supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready
    [   13.960144] platform f1070000.ethernet: Relaxing link with
f1010600.spi:m25p80@0:partitions:partition@1
    [   13.960260] devices_kset: Moving f1070000.ethernet to end of list
    [   13.971735] device: 'eth0': device_add
    [   13.974140] mvneta f1070000.ethernet eth0: Using device tree
mac address de:fa:ce:db:ab:e1
    [   13.974275] mvneta f1070000.ethernet: Dropping the link to
f1010600.spi:m25p80@0:partitions:partition@1
    [   13.974318] device:
'platform:f1010600.spi:m25p80@0:partitions:partition@1--platform:f1070000.ethernet':
device_unregister

It took around 13 seconds to obtain a mac from nvmem-cell and bring up
f1070000.ethernet


And here is the second log which corresponds to kernel without your
nvmem/core.c patch but also with reverted change 'bcdf0315':

    [    0.036285] ethernet@70000 Linked as a fwnode consumer to
clock-gating-control@1821c
    [    0.036395] ethernet@70000 Linked as a fwnode consumer to partition@1
    [    0.045416] device: 'f1070000.ethernet': device_add
    [    0.045674] ethernet@70000 Dropping the fwnode link to
clock-gating-control@1821c
    [    0.116136] ethernet@70000 Dropping the fwnode link to partition@1
    [    1.977060] device: 'eth0': device_add
    [    1.979145] mvneta f1070000.ethernet eth0: Using device tree
mac address de:fa:ce:db:ab:e1

It took around 1.5 second to obtain a mac from nvmem-cell

P.S. Your nvmem patch definitely helps to avoid a device probe stuck
but look like it is not best way to solve a problem which we discussed
in the MTD thread.

P.P.S. Also I don't know why your nvmem-cell patch doesn't help when it was
applied on top of this series. Maybe I missed something.
