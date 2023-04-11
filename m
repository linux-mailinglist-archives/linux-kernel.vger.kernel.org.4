Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9D06DE4FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjDKTaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDKTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:30:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408F91B4;
        Tue, 11 Apr 2023 12:30:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ud9so22938129ejc.7;
        Tue, 11 Apr 2023 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1681241430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/djvqI9JsJGvDn3SeW6vm5P6m42AvZNBj0jcHhZnRM4=;
        b=AqRqt8mlFu1EZUsVr+zspOkJ4uOQ+yIr1IjZ1zhhq31AVvWsJDwCtAt3Zht1izog4M
         JkAS3c3Dz882M05M0FLebvBd8mkPB2iX7vvxpWFUGyO03ytitNYxL8S1iEQoY2bj0ZDa
         +T4YaBqXthOb6pr4NxBHo+qgGvGOWorR03SZYGEyN1T/qoHK/W5BJ4hY0OTAuGJ/HmSN
         HqFG1yhc3jSWKxjZoVRVdB32QjkSHh7FhEbk042cb+w3iJEkjA938iglZ9DU3e0jrlRd
         YPvE8VzoQZ0c0wj+7houxZYFRbJfVP/4b3uZ+8JbwAk6hWkGdhSrglTw1ggb6WmcG8LY
         iqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681241430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/djvqI9JsJGvDn3SeW6vm5P6m42AvZNBj0jcHhZnRM4=;
        b=2YN5k/AKl1YLE+cRcbIPPBdhG2uY0jWOe53inFYmhZC5EW+6PfUxMRfh66m5Ad6wk6
         jVyt8rbCB5WexRdN57+OasPzNpIwAC7tDIWWzK8Trt7yM/WBv9MYWXud1moBp2vs9dBa
         jeCXD4bIdacc4puL1aTHc9zVluzMuLvaX7S6CJB4ChznACQHTGhr/IHweOywC0LLTadc
         5TTOutUN1VTXLR+XB4FveIbKZUOsttqEII9itDXAwFWI03i5wmbnQ/L1JJtk+chw/5Hq
         ZLrVjbM86Y4FcJQ/ChYcbJpYKdQT4YXAYatQxqhEDFsViJYCNsraoPcWDTZchpjmAH3L
         K35w==
X-Gm-Message-State: AAQBX9dg+b56x1D+LNA/pMAQqEIgXdkpMe+WA4AlUKMdiP8Cqzun6qyr
        YatgSqKqjJpUnVxinCCwtWar1BJXDr7x2c9nC3c=
X-Google-Smtp-Source: AKy350Z8La4docT1vMFuoXxvI/XsDKC+Hy4e6yD7JK7aCMklvTxvE8XQXPb50PEcBK/AIQfgVHJcGowSXtJlkVPio84=
X-Received: by 2002:a17:907:ea5:b0:94a:972c:c28d with SMTP id
 ho37-20020a1709070ea500b0094a972cc28dmr3782765ejc.6.1681241429546; Tue, 11
 Apr 2023 12:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230410193048.31084-1-exkcmailist@inbox.lv> <20230410193048.31084-3-exkcmailist@inbox.lv>
In-Reply-To: <20230410193048.31084-3-exkcmailist@inbox.lv>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Apr 2023 21:30:18 +0200
Message-ID: <CAFBinCCXYnChN8MfOxGEDSTm4HftpzuwwHwtqm7b1dPH6EdUsQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: meson-gxl: add support for Xiaomi
 Mibox 3
To:     Karl Chan <exkcmailist@inbox.lv>
Cc:     linux-amlogic@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Karl Chan <exxxxkc@getgoogleoff.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Karl,

On Mon, Apr 10, 2023 at 9:31=E2=80=AFPM Karl Chan <exkcmailist@inbox.lv> wr=
ote:
>
> From: "Karl Chan"  <exkcmailist@inbox.lv>
>
> The Xiaomi Mibox 3 is a TV box based on the Amlogic S905X chipset.
I found various websites referring to this device as "Mi Box 3" (so
space between Mi and Box).
Do you know the official name that Xiaomi used?

> There are two variants:
> - 2 GiB/8GIB
> - 1 GiB/4GIB
>
> Both variants come with:
> - 802.11a/b/g/n/ac wifi (BCM4345)
> - HDMI , AV (CVBS) and S/PDIF optical output
nit-pick: no space before the comma

> - 1x USB (utilizing both USB ports provided by the SoC)
Can you please explain this in a bit more detail?
My understanding is that this board has one USB 2.0 type A port. What
do you mean by "utilizing both USB ports"?

Also I'm curious: does the board come with eMMC or (raw/parallel) NAND
flash? P212 typically means eMMC.

[...]
> +/* This UART is brought out to the uart pad on the pcb*/
nit-pick: missing space after "pcb"
Are the UART pads obvious on the board (for example since they are
labelled)? If not: maybe add a hint where to find it

[...]
> +&usb {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +};
This is already inherited from meson-gxl-s905x-p212.dtsi so removing
it should result in the same .dtb


Best regards,
Martin
