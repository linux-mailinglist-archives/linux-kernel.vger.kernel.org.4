Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3678B6562A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiLZMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLZMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:43:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0372DDB;
        Mon, 26 Dec 2022 04:43:11 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t15so1110182wro.9;
        Mon, 26 Dec 2022 04:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tnj5SsI95MjQUidBq1LKnLQZ8dpy3MP0SAOacrmbBMQ=;
        b=ZIiZhQvBsrWvx1hdEGZfT2ocMYyjKCS3B6cIfPET0W5rHEDKO9EANz5Bnj8UocwGxs
         Lm83C3blpWPXOTChmLAY6/xg2iovpq6FD/XD9ewtyx/LJTGUtyvwXqLbl4QHijWodKBs
         pWv57H6uMcf3XfJtnEPytEnxMP1QJ+bgrQNon9n1qcUep0Q4deDbp1TbfkAc9RhPBqt3
         bBWnEi7gmegKtzHc2d6BznXGD+XApXm9pbZFhkV1oyeU5y7vqT/y84XqLJOvA9Bpecqk
         e1HFJDTW5yrjB54ajZbsywHOwLtFC+ExvG6FGpYgvP7PASbr6JqzNsjo8jXIoWQv1ziI
         uEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tnj5SsI95MjQUidBq1LKnLQZ8dpy3MP0SAOacrmbBMQ=;
        b=0fciS/g4tA0kXZOF2954sHCkQ6478h3CNGijobgifR/jAjBcsiiynzxpY1+ofr5TAD
         Lf12iZywIbgHLPrIqxzTMATlTYd6XTVp011OJdDnjTJKRniYX7BCmkKSnGKIufy37eIB
         yO2uIdR4MP2+UG82Qybi1X64cyzawfCOM0MifSm34fnbuKoRDC1lMCuQdei8eABP1YHt
         YKHME4xslswMP9rY+KmBeevdEE9eAaSevlMOEdMaI06M4sstcBC1IvbYVNPoZ2NzmRDO
         AK+2+BA5cTibNN9Wr87Zu5BOryuP1zBqAsgfCWpuNxPvvrUsmyoFKdqCT1BUuaGs114U
         O/Xw==
X-Gm-Message-State: AFqh2koOPTHmB/GTSePztEOJFZFzxgzIJSwKeZNL+mNUL2CUf9eLy0qB
        HngWSVUrLNcCpbeMbQoZkIQ=
X-Google-Smtp-Source: AMrXdXshV3v94R0ghdyyjA99tfZWYTzC+OpiVzewoJXQGBsxADeNHflnwPuBtJt4JZmVvlyMUIS0kQ==
X-Received: by 2002:a05:6000:80b:b0:274:c846:4211 with SMTP id bt11-20020a056000080b00b00274c8464211mr8564616wrb.54.1672058589986;
        Mon, 26 Dec 2022 04:43:09 -0800 (PST)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b002365730eae8sm10273895wrm.55.2022.12.26.04.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 04:43:09 -0800 (PST)
Message-ID: <9ba1d5781ee43096c2660799321b43184e9a0c76.camel@gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: iio: pressure: bmp085: Add BMP580
 compatible string
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Dec 2022 13:43:08 +0100
In-Reply-To: <6b533031-e46c-3c7a-9d7b-3118c5ab7219@linaro.org>
References: <cover.1671986815.git.ang.iglesiasg@gmail.com>
         <778a9d07ad1d88e036cc1ddd9c3fa53390b906a3.1671986815.git.ang.iglesiasg@gmail.com>
         <6b533031-e46c-3c7a-9d7b-3118c5ab7219@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-12-26 at 13:05 +0100, Krzysztof Kozlowski wrote:
> On 25/12/2022 17:59, Angel Iglesias wrote:
> > Add bosch,bmp580 to compatible string for the new family of sensors.
> > This family includes the BMP580 and BMP581 sensors. The register map
> > in this family presents significant departures from previous generation=
s.
> >=20
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
>=20
> I did not receive anything else - no cover letter, no rest of patches -
> so difficult to judge whether driver is implemented the same way.

Sorry about that. I'll need to send an updated version with a few correctio=
ns.
I'll be sure next time to send the complete patchset your way.

Thanks for your time!

> For this patch only, assuming it matches the driver:
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Best regards,
> Krzysztof
>=20

