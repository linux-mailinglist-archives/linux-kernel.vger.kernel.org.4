Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B869E26F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjBUOgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjBUOgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:36:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2B627D65;
        Tue, 21 Feb 2023 06:36:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A834EB80EF6;
        Tue, 21 Feb 2023 14:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577EEC4339B;
        Tue, 21 Feb 2023 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676990173;
        bh=2hPS+oTogl/FzHpiV1GOemrkrEWL+AArsdfGzHnq0no=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HG9w4alc9xC/AUJWglXlqE8HVk0CDfdryKKm5jXGSPQw7pHhAm1LBCZ3xdfN4Ti2s
         Ysuiu39wWzK0hbogVA6cMVfsxYFrYIWP+dvBp/01/K+JCmFYTUrxqZUqXD63qETMGX
         E1U9S1xuO2LwmtRtdx+pVynlv0AJSvSC9yq8uXF8dCIF1faXR8onNwOvQMvGi85LUY
         WhjDFgXUIl+UclRsXRz58OwLu2fbToQDGrmkNVYyEJFJqBhMJ4p444kg1BTijNbHsX
         qPTLOQXdx65DniBDIKg5AtkEfc2YhrWIjV0uOuYN8k/71hN14blKnn7Bkf8iAHy8HW
         1AZUhI76nXGAg==
Received: by mail-ua1-f49.google.com with SMTP id p18so718308uad.11;
        Tue, 21 Feb 2023 06:36:13 -0800 (PST)
X-Gm-Message-State: AO0yUKU8HVgPA1Z4X6KIqyOjiqAVFQcpguyFd/S3BCwE9HUrwZ6lyToQ
        vK9rk8a2J2wNziiDFSXAPDSdQRIAWsZSS8RxLw==
X-Google-Smtp-Source: AK7set9W5kKwUx5gjP6pl1nG9l60ZSVXMZ79pnD7g3NGwbmRQKZyPv10ew8NZGs5Mab/a0MHK6llxZLJj6o5ceW3H20=
X-Received: by 2002:a1f:abd2:0:b0:401:42f3:5657 with SMTP id
 u201-20020a1fabd2000000b0040142f35657mr744581vke.42.1676990172209; Tue, 21
 Feb 2023 06:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20221223031012.92932-1-peng.fan@oss.nxp.com> <20221223031012.92932-2-peng.fan@oss.nxp.com>
In-Reply-To: <20221223031012.92932-2-peng.fan@oss.nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Feb 2023 08:36:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLW_YxC+S5Tp-gveHQpksKfzmrpEFXtcdLJ3xMJoX4+qw@mail.gmail.com>
Message-ID: <CAL_JsqLW_YxC+S5Tp-gveHQpksKfzmrpEFXtcdLJ3xMJoX4+qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: usb: usbmisc-imx: add i.MX8MM usbmisc
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, xu.yang_2@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 9:09 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add fsl,imx8mm-usbmisc compatible for i.MX8MM
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> I had a V4 patchset to convert the binding to dt schema, but we are in
> the process of ARM System-Ready 2.0 certification, directly update
> this binding doc is the easiest way for now.

There's been some misunderstanding (within Arm), but this is not
sufficient for certification. There must be a schema. Besides, you've
already done the work to convert and spent maintainers time to review
this. So can you please repost the conversions.

Rob
