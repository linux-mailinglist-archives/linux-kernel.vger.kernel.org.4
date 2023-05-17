Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1C8706E37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjEQQdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjEQQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:33:02 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048372108
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:33:00 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-561d5b34e10so5356747b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684341179; x=1686933179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seiQZ9YiOuM9ev2SDnncT8dHc6tNpiemL2yol+RQQmc=;
        b=rARhUCmEST2pQfbq/THE9kQrsVUKD5cL8fz4mXj7808tMytYuZe7snXExsaIC0DinJ
         r9gp+0RQBbC+st99eMXxz+oXJPzKNXaMQZohevPlt6IJR1f1ziqr22locJ6EsLGMVw/1
         s+EMTIB0qyD6ZMGffR4ZeD2WQ0swHln2rxkCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341179; x=1686933179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seiQZ9YiOuM9ev2SDnncT8dHc6tNpiemL2yol+RQQmc=;
        b=KiIH/FNhJ0YmkLV7hLXU0xqjo53poGej0PFb1AMmKIzhGTm2HEfdyHclrLoM1Nwjx5
         cFnV5KrC7k2zIFvFDbozcCpNVNWIMvA5y5+ho2W2v6tIDgBAH9aFDsB3QaDzPuMDhnAk
         kfdDdT5B6CFxiJLMHP3JI5Pib7lbQGwVbzyzAIppqJNhChyc0i0VFIe6oTcIPvxOS5wX
         T1W/V3EkdMdQgy7j2y6IAAgg7BwXgqq9bwz1NJbXFZV4DuRreG1fcJ9hzQxQX9b/nged
         GewRTT3J4cKfcHA5Nl8baB9AaXA7X8+K81uwPbMrB32coz4zmC8NP6aNGuw/DyHcb6HO
         8oCg==
X-Gm-Message-State: AC+VfDyveqdyoUZ+27EkM0AgzcOqPivlXMy/aLB79+SkW6sbfl1cKxJ0
        Tm7dF3NL7uUd096fE4eaK5szyYYeR64MlA9kqA2eKw==
X-Google-Smtp-Source: ACHHUZ5G6ubA44duLT/TEAQihOcSC/J+UBoHnxsofv8biC5kLtL6cO4NiUzdIWWkBRLS62id8kmDPVQbLVllmNv99s8=
X-Received: by 2002:a81:1b4c:0:b0:55a:776e:95f3 with SMTP id
 b73-20020a811b4c000000b0055a776e95f3mr1957775ywb.25.1684341179202; Wed, 17
 May 2023 09:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAO9szn18KsR0c+U8EEY1=xnmsKMxy6SEArMUic0z=aYJDVwWCQ@mail.gmail.com>
 <023f6cf9-0f08-f27e-d203-5ff78faf110f@linaro.org> <CAO9szn1EsbuPSRrOW8CLqhp+QUcL=9NE93FAwsg2n3htd_aJTw@mail.gmail.com>
 <CAMty3ZCAP6CRsJWMUZZ6+hd5igX3NgyNfhdEv2FwuDtqj4iaaA@mail.gmail.com> <HB0TUR.1IPEEV2C5LMB1@gmail.com>
In-Reply-To: <HB0TUR.1IPEEV2C5LMB1@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 17 May 2023 22:02:47 +0530
Message-ID: <CAMty3ZCSUx-81m4SQcJZvUq3NyhzZbe8ow+LiV7iyUmVLCmNYQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: display: panel: add panel-mipi-dsi-bringup
To:     Paulo <pavacic.p@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        neil.armstrong@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, sam@ravnborg.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please don't post, use inline replies.

On Wed, May 17, 2023 at 6:34=E2=80=AFPM Paulo <pavacic.p@gmail.com> wrote:
>
> On Wed, May 17 2023 at 05:50:22 PM +0530, Jagan Teki
> <jagan@amarulasolutions.com> wrote:
>  > Just to add a few pieces of information for you to understand better
>  > on the context of dsi panels. DSI panels can be part of
> panel-simple.c
>  > or panel-<vendor-part>.c DSI panels whose init and exit sequence is
>  > generic are suitable to add it in panel-simple and have bindings on
>  > panel-simple.yml.
>
> This panel doesn't fit that well into panel-simple.c since it has
> initialization sequence. For that reason it would fit more into
> panel-sortofsimple.c which didn't exist so I have created new driver
> and called it panel-mipi-dsi-bringup.c.
>
>  > Some DSI panels have specific init and exit
>  > sequences in terms of power, reset and DCS then those have separate
>  > drivers to handle and whose driver name must be panel-<vendor-part>.c
>  > or similar and bindings also follow a similar naming convention.
>
> I have made a driver exactly for that purpose. Driver that allows
> adding new panels which have specific init sequences (and of course
> timings and other stuff). fannal,c3004 can be seen as a working example.
>
> Here is code snippet from the driver:
> ```
> static const struct brup_panel_info brup_fannal_c3004_panel_info =3D {
>  .display_mode =3D &brup_fannal_c3004_display_mode,
>  .num_of_dsi_lanes =3D 2, //how many wires are connected to the panel
>  .video_mode =3D BRUP_VIDEO_MODES[BRUP_SYNC_PULSE],
>  .mipi_dsi_format =3D MIPI_DSI_FMT_RGB888,
>  .mipi_dsi_mode_flags =3D
>   MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_VSYNC_FLUSH |
>   MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_NO_EOT_PACKET,
>  .bus_flags =3D DRM_BUS_FLAG_DE_LOW | DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE=
,
>  .panel_enable_function =3D &brup_panel_fannal_c3004_enable_function
> };
> ```
> where enable function is function with init sequence and other values
> are values that might be different for different displays.
>
> All the inputs are appreciated as this is my first time submitting
> patch. If you see anything that is odd to you please reach out to me.
> All in all I believe I now understand how should device tree look and
> the reasons/ideology behind it.

So, the driver has to be panel-fannal-c3004.c and binding to be
fannal,c3004.yaml.

Thanks,
Jagan.
