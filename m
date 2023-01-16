Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7F666CF83
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjAPT0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjAPT0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:26:22 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17192B28A;
        Mon, 16 Jan 2023 11:26:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so16869175pjl.0;
        Mon, 16 Jan 2023 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9WAzcJcZo6zUjcHtz9T7SGfeKr+yTltFnDVPkxlv9nE=;
        b=Y8qb/UuyVHOR4IUXV/uo6vhei/WJreF6ZkWZHmxkM6olegkwEECe0Xkiq0S5cHiDg+
         slgfsRV8UUS/5B/wPv7EC+Oz33d6E2Lhsk2caJijr1JvrPtgsQ/xfjyMUa2Ou2TLLO9W
         /hc9gx3z+Ba/dN2zD3xT4wUBlydsL2m0aDURvnUJ8rxuU1W7utPccMSrdcMIKPEgmbYs
         puLLo5h313kg0jyKgg0HKTDg/V9p86whd0Tg5dlWc/0xkqLbZCLc9oLvALzemle01/sh
         KJa6bMAlm4UBzlD4/9F/RFBzem6n9V0FUZWQEbSjnpiHP2RHDujoyUkiiAceDJh5B9LX
         xRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9WAzcJcZo6zUjcHtz9T7SGfeKr+yTltFnDVPkxlv9nE=;
        b=u8C83sGlXTQRTShiObEg12IjAN7xB70vXKYwOC0WWgy0KT7iq+RehAZMa3LuLES2Nj
         j4GaLwJ+Czs3R4FEGdJCSs482TBpenSzmWLnH6j3uGGG1+4B55EE7/jCClYgWOGqKUeW
         mIBhHVK8HYwdDtUJf/McRWozCJAXdVmgMFQs92/SqFj9UdTsB1v2kGZa5dxiJxenPZya
         GX/gUuTDPE9JQLqWZRZdfPfmnm2N2VsxwXUH4/4v7d9dAqMPpzdIqQHIR0PPRavgFoD5
         XiqepqXxOioMZ+ZYBdbmFpJIEfXVt4VCXGROZS66V+aMH4DITyRnvrhF8FNFIertuQT8
         iyZA==
X-Gm-Message-State: AFqh2kqUjlyLJTBLrkwXkkgsc6E6yJa0bMkP+s6voA3s6YteNKsZVnmq
        8b5U6X+HBARTriGkePBSFqUWYirH61BUloqalR89r7b2SPM=
X-Google-Smtp-Source: AMrXdXvTEbxhxYtihhDhFk8bBcXFejSr7YDhMow9T/GDUE6c/HlstUARHthncxnKVe+eTbemGyTkZoMzTss7GUOeOzY=
X-Received: by 2002:a17:903:2c7:b0:194:52ed:7a20 with SMTP id
 s7-20020a17090302c700b0019452ed7a20mr73703plk.67.1673897181220; Mon, 16 Jan
 2023 11:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20230115213503.26366-1-pierluigi.p@variscite.com>
In-Reply-To: <20230115213503.26366-1-pierluigi.p@variscite.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 16 Jan 2023 16:26:09 -0300
Message-ID: <CAOMZO5APGzugbBZf0uAaF3vB61KuWDtAU9OHXVM5p8U8yipuXg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, marex@denx.de, peng.fan@nxp.com,
        marcel.ziswiler@toradex.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        eran.m@variscite.com, nate.d@variscite.com,
        pierluigi.passaro@gmail.com
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

On Sun, Jan 15, 2023 at 6:35 PM Pierluigi Passaro
<pierluigi.p@variscite.com> wrote:
>
> According section
>     8.2.5.313 Select Input Register (IOMUXC_UART1_RXD_SELECT_INPUT)
> of
>     i.MX 8M Mini Applications Processor Reference Manual, Rev. 3, 11/2020
> the required setting for this specific pin configuration is "1"
>
> Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>

Fixes: c1c9d41319c3 ("dt-bindings: imx: Add pinctrl binding doc for imx8mm")

Reviewed-by: Fabio Estevam <festevam@gmail.com>
