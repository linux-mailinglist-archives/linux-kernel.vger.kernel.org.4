Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B09D725A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbjFGJ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbjFGJ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:29:49 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA04AA;
        Wed,  7 Jun 2023 02:29:47 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-394c7ba4cb5so4847492b6e.1;
        Wed, 07 Jun 2023 02:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686130187; x=1688722187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OmfrPg999neWX9s3M1zxfSUyWf/prJhvEaWFAiQaaNY=;
        b=IBsaOvK/uVHM3lREN8AMM9yEVo1Xd6I7yfSEz8mue99kPhB/8t8WanbqtRa7i8BdoO
         SWQf6vsygtojPOj0AQmu6SNrkRD3jyKhTGtw383Qvncs+5gDHvpIcuuEa+rVZXny/IPT
         pb8pAhz3frMOZLENbbZpwlXNlDdsHs00knMr8mSIo1EJWbcs/sR4QABohUkd5ZCftzlB
         uVE8fvWsBdjY9Q0TYwu8Gw7iUWZnPxHbKSpa7VOp6QGqAPukdzLzYL0OWbXZIrOOjsk1
         hPbYfFz+4LzkZPOoQnxQPzj6QmXzc124bK+/T2nKG9MHum1FeZNNMkxT4sLFW1+4d9HU
         tE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130187; x=1688722187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmfrPg999neWX9s3M1zxfSUyWf/prJhvEaWFAiQaaNY=;
        b=X67b93UwcX/0cyMhtDQmtIyvXdMA+Wl46+8aXl8eTDZzDY0ibsL2kGuj2HW/bYL9Ib
         iNxToGWXkVWSoYu8tu/8hzTqYTEVKv7XPrh7vWhNUo+gudzUmVxkLXlGcOKHqpVXYiXm
         djGS/NV5chvBlfh7G7RD0evygo4onsO7zP/Tyf8vC3NYvRICmMzRySLNRAlYC/Xrwy/x
         yA/HBm2s3kSYgLzsg7wsLtBg03DeMzqWWaydLEm9Y7heKpOpqiAvfz/bJxVjfhzKlxs2
         ggVGRX4mUiVIN+nZqofgS7pG5hXPOCGI08CrVK1YU3SLrPlxp1DeIh/ul7/vOqk54jk0
         V9uw==
X-Gm-Message-State: AC+VfDxBbQ/RdoHBW6lgaFLTYomvIGqNjAmCPYRch3SITlgR8Y2QvWXs
        G+o4xyakTofFjNHpe9EUBG+WE1WKFN65cDPWzUQ42ivYmAe+urAy
X-Google-Smtp-Source: ACHHUZ7Qk+jpHAzTBaSr66IffeL7iiuj6egRj7ybLFDxSM222reY+UmlAVuzuWXXi32jct9e4nbPBvG5eT/9JeS1goc=
X-Received: by 2002:aca:2b09:0:b0:386:d4f7:6791 with SMTP id
 i9-20020aca2b09000000b00386d4f76791mr4441087oik.37.1686130186597; Wed, 07 Jun
 2023 02:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230606140757.818705-1-pavacic.p@gmail.com> <20230606140757.818705-3-pavacic.p@gmail.com>
 <cac57af0-aa0f-0a60-3376-234e1da7f4eb@linaro.org>
In-Reply-To: <cac57af0-aa0f-0a60-3376-234e1da7f4eb@linaro.org>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Wed, 7 Jun 2023 11:29:35 +0200
Message-ID: <CAO9szn3+u_yuWb5y_aQGWA8RhW2=qPVcxcZvGWz8MbHH_DamNg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: display: panel: add fannal,c3004
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

uto, 6. lip 2023. u 16:43 Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> napisao je:
>
> On 06/06/2023 16:07, Paulo Pavacic wrote:
> > Added fannal to vendor-prefixes and dt bindings for Fannal C3004.
> > Fannal C3004 is a 480x800 MIPI DSI Panel which requires
> > DCS initialization sequences with certain delays between certain
> > commands.
> >
> > Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
> > ---
> > v4 changelog:
> >   - add spaces between properties
>
> ???

Added empty lines between properties in yml file

>
> I pointed out last incorrect versioning. This is v3, not v4. Or is it v4?

It is v4 of the patch but v3 of the patchset. I wasn't sure whether
somebody would complain if I were to name [patch 2/3] in a patch set
with different version. I will try to edit changelog to match patchset
version.

>
> What about my tag?
>

I have changed in MAINTAINERS file from "+C:
matrix:r/mipi-dsi-bringup:matrix.org" to " +C:
matrix:r/linux-drm:matrix.org". So I wasn't sure whether to add it.
I will add it in future version of the patch.

> What about my comment?
>

I thought you wanted me to have more generalized MAINTAINERS community
URI that's why I have changed it to linux-drm. I will remove community
URI in future version of the patch.

> Best regards,
> Krzysztof
>

Thanks,
Paulo
