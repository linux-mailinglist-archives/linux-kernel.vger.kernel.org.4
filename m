Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4B68D169
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjBGIVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBGIVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:21:52 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5E95276;
        Tue,  7 Feb 2023 00:21:50 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id v189so2056755vkf.6;
        Tue, 07 Feb 2023 00:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qxIrUXBoB2zyDeM1COleyFwtINkoTGd1PktA2wpEmEA=;
        b=pufxl/WHKqM3Y+0cFFtpThhfHYZ9YO609hoMXgC0g4sbYJ47SGU4uKc0cL9tKF0JUB
         wAqlqiBBnq5GhMNTkhJwWC1JFrf8zmtWEqaQymkPNcXS8NsTBSOeaIs0EMaRQhgA9NzF
         AG52xo8CJj1eoX60akdaSUMOgZEipsPi8yRhoo5zEzXYYd77HVcqe/XhwRDK37mxh3/O
         JRQqMG4sm3buj1qlFfbPNQ0QT1Yq4XRGC3mavdrTOFCD7AmOJxzpZtjMrXUt1zLEKcfo
         CR17EuxDAnkqPTxcBWTuqUI4xzvq+KOJx91NIWwJ19TPyJhfjPzBXHynVMRk3LYaU4oE
         c7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxIrUXBoB2zyDeM1COleyFwtINkoTGd1PktA2wpEmEA=;
        b=Kw6wP3f21Wa/CIBoniBFLDNkTOW2fY5xFX0X6kIWlmu5M9413KrKgiPtP7IxL8bBlp
         +5zzbya1RFYNofYpSBerg7un8QMNMqdppQhDiYS9x19rAZYHhkyqRc+n0quYOInR8yBb
         lNRIbWxea1sxuD93eU3j8JIwZL+cIJKhSKF+Ksy4S1zP0WgDe3HPqqLu41CSUXIh6M2f
         ysiSw3J+px9F9XlWD2AUh4CAk/3iXxsdeQl4UedUOJnIisk4EcL6q0TSYE1ukMyt04t8
         wBf0D0jdBLhh8BiOp/zcAHuveI4lhvHyJ/pyzMByCjAEg9I8ybA1lavxoZ5CnmlKWI4p
         OkWQ==
X-Gm-Message-State: AO0yUKW7HmoNPWUGKDqizmdjbTyWJl8unOZWXndeGYWkSmzo2Pw63tVH
        WILAVIWAu1rkL/gKVWizcA7iv47Q+KdVIa9rlw8=
X-Google-Smtp-Source: AK7set/hbAUIeRFf7vEmDRrJAvTgRdEClUK/xn9DykWC9alacrgZNdX2P3lXDER15SOMbwcxFZDK3MBZ2ilktPOQJE4=
X-Received: by 2002:a1f:ab44:0:b0:3ea:53b8:7b08 with SMTP id
 u65-20020a1fab44000000b003ea53b87b08mr274582vke.37.1675758109443; Tue, 07 Feb
 2023 00:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20230118084025.2898404-1-chunyan.zhang@unisoc.com>
 <41fd5c2a-9fc5-8af8-b66e-45bb83b24179@linaro.org> <CAAfSe-v3VW_sE4FwjURoOapMXrGavOK0hzeU-84-U_6xfhYbQQ@mail.gmail.com>
 <b3b9d515-20b1-62a1-3243-b1bc36c306df@linaro.org>
In-Reply-To: <b3b9d515-20b1-62a1-3243-b1bc36c306df@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 7 Feb 2023 16:21:13 +0800
Message-ID: <CAAfSe-tiF4--dYuKWgHUm52bMX3uSwxvWKKNRd=DFJTZZ=1x8A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: Add support for Unisoc's UMS512
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, 7 Feb 2023 at 15:59, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/02/2023 03:19, Chunyan Zhang wrote:
> > On Thu, 19 Jan 2023 at 19:40, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 18/01/2023 09:40, Chunyan Zhang wrote:
> >>> Add basic support for Unisoc's UMS512, with this patch,
> >>> the board ums512-1h10 can run into console.
> >>>
> >
> > [snip]
> >
> >>> +             ap-apb {
> >>
> >> Non-unit-address nodes cannot be mixed with unit address ones. Something
> >> is wrong here.
> >
> > To make sure I understand correctly, did you mean non-unit-address
> > nodes shouldn't be the parent of unit-address nodes?
> >
> > Does that mean the bus node should have a unique base address like:
> >         ap-apb@70000000 {
>
> No. I mean, run dtbs W=1 or dtbs_check DT_SCHEMA_FILES=simple-bus

Ok, I will fix that according to the report.

BTW, where can I see what W=1 means?

Thanks,
Chunyan

>
>
> Best regards,
> Krzysztof
>
