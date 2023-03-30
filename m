Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EED6CFA00
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC3ELf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC3ELb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:11:31 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB3B5245
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:11:30 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id q8so5232968uas.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680149489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlqWzaTFeXNF93oCsw3CKOaZb2BdZ8J89dsRkm+g8nE=;
        b=Jwl8XnBNPHXUrgPWG3nOY/ScmyoA1qdPjqbybFRGhnJG73H8ZIYdkEMyoOxUKr4jy0
         RAMQZs8WujJX7IOJFjv2jXyqqRhX7ZHdmLOsQKgvSc6dI3y8AWEMMyZQKBu+6FM90Hu9
         LeUEchBHwB35VJfRrd9cNQUME4vv23vwGtN+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680149489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlqWzaTFeXNF93oCsw3CKOaZb2BdZ8J89dsRkm+g8nE=;
        b=x2BaZz/Lcd8HM0iSWNct78LD4CP/Xx3DCeDs9EjCFmIxrDtaEjZ54p7BiJiJ3JSKGR
         99Z2dAzWewXuV3IjXKJ06mF3342nx4OI+WzNGNoSzlTIrxR1MeZHz7tQZBlTuWJQu5Ct
         mgTWrpllIF0/CCyiHB+pvaXzx3mKfKgptiY16XCaII4wGT8D6BVZP3ky1MIipb9LP5bq
         szLt/jPyljPPF6g9/JmQvo/VokdoONPLLBDHCjykn6Y+IrzTtJpb80sRTYxb+5ZRqc3t
         NnkRWUascHuGp1O/8trV57WQDjE//Cn7l6MCTF/TFTidIUr1vvWLqEjlgpcaPtajSSd4
         6C0A==
X-Gm-Message-State: AAQBX9esoS5Iee8lOmWnzRuLywn8n3k+nneK0XSa4P2CcH3Pa40XF3vo
        iSqw0SNfIM29GM0c7BttrVFhc9H+ORx3k/meAXvsxg==
X-Google-Smtp-Source: AKy350aOTSTGLpyThgFsYnGIfmpFWfK++5W92pNG1SY5fkfAr3BAjmNQvMlKt6sE5LGDBzYjwJbAbGBsSvz5yHx1Zxk=
X-Received: by 2002:ab0:3d9e:0:b0:764:793a:6618 with SMTP id
 l30-20020ab03d9e000000b00764793a6618mr14789585uac.1.1680149489280; Wed, 29
 Mar 2023 21:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230218111712.2380225-1-treapking@chromium.org> <CAMty3ZD3SY-WCtYK0dexdLxCk8d+2tJ=D9xb5uR06jPGCd=56g@mail.gmail.com>
In-Reply-To: <CAMty3ZD3SY-WCtYK0dexdLxCk8d+2tJ=D9xb5uR06jPGCd=56g@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 30 Mar 2023 12:11:18 +0800
Message-ID: <CAGXv+5HFP-1SFFBsUneyVT-42b3_6BPtQ-CkULmUT6v0pUoLbA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add generic-display-mux driver and bindings
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Robert Foss <rfoss@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 2:10=E2=80=AFAM Jagan Teki <jagan@amarulasolutions.=
com> wrote:
>
> On Sat, Feb 18, 2023 at 4:47=E2=80=AFPM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> >
> > This series is developed for and tested on MT8173 board, and the layout=
 is:
> >
> >                                   /-- anx7688
> > -- MT8173 HDMI bridge -- GPIO mux
> >                                   \-- native HDMI
>
> What is the part number of this GPIO mux? Does mux gpio interrupt
> based and able to switch output HDMI and DP. If so, how this gpio
> interrupt is different than the HPD in native HDMI? I mean does HPD
> have any detection bottlenecks with mux gpio interrupt?

It's a full blown HDMI 1:2 demultiplexer, so DDC and HPD signals are muxed
as well. The anx7688 handles all the Type-C stuff, and our EC talks to it.
If HDMI output from the SoC needs to be muxed over for DP alt-mode, the EC
will signal the SoC.

> I do have GPIO Mux that input DSI and two outputs DMD/HDMI Input and
> HDMI Out. 2x1 with 1x2 mux.
>
> I'm thinking having a generic mux to select the specific out number of
> outputs with associated interface outputs can be a viable solution to
> address all use cases here.

AFAIK DRM doesn't allow dynamically changing the constitution of a display
pipeline, so it doesn't really work out for us.

If you're just muxing between different outputs with passive/dumb bridges,
it may still work for you.

ChenYu
