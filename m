Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD507680D83
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbjA3MUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbjA3MUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:20:30 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D1416318
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:20:28 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gr7so6561652ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FL2dHGJjEYE8OY//NcFpWWsenwt6CU6e+9LYkJshbe4=;
        b=f+d4H8f65ho5m5JIBQtXtySS9zntSA7sF6OHMQ8GhfQAmDn9yu0oJpE5PNiLTNOKV4
         pTi63x5+EsQTU3DJNTyMucRghLGhySOZlltfPKN14A4gq1jugBkyhxPrqdu7rHphv03y
         m6yBcfgo0BIK4BIwFAdlJdyQTtaCVxMQBKWBzkE5IzurnCkx0JOEnnd/mX4R6eIDcE7h
         NbHv2TsH08CU3VXVgLwwfUmdcOq0lWrRctrJhvS3MTXVLJLfKYwA525Dy5WUxDNFDcHJ
         nv83wjq3aosXh42vdc1Jp3rkt3odVOuYPu/yF1lrp8r870EuMdC9rabLWXoLZFtzJ05Z
         oUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FL2dHGJjEYE8OY//NcFpWWsenwt6CU6e+9LYkJshbe4=;
        b=5+JiWQ1ofgvJZ6eDmOzka5H5QvkF0zdkn48VmvtYS6d8Xp8968VfmGtz2EF668Gimu
         DfYCQQ3jir2zie3B5S+Zjui325rWYoBVutQAt2BEmqliriuhqxJ4D/RPh/vwVmaLkOYM
         FtZtHOOhf1ejxw4CeeA7L9OWyY5FAzg0MIDI1K9xzU2dslF9bLYWnbosqEXu4aJOeSk5
         DNkRfM5LZbhLCl3I7Z9trcaO1O7lXJk7Qkh7O3zNgcw0j2xT0BMs3WuEPTC5yf00LHMd
         KtRNcxc3hG/1NQJuwzi+17y/3+nN8O5B1sDGVlDxi21Yby6/qLi5HfapCPZEgg8kcpP0
         t7BA==
X-Gm-Message-State: AO0yUKX9HtmWZOywlu9fVWXTOXbGo0u+MjhRXzEjvBA5Sfa5DZECM70r
        rFamUUiLLTAwN0H64wqSLZt1wKUpJqWocsrc4KhcqQ==
X-Google-Smtp-Source: AK7set9g61hpeeb4JnsWVEtBrmZIj2cvkjEsVbxUu4DjJ4fLFNlWw0qfr3//ipZzw08rjXbZqJnPCkhrLHT8XTfmgFQ=
X-Received: by 2002:a17:906:eced:b0:878:4ea8:6c2f with SMTP id
 qt13-20020a170906eced00b008784ea86c2fmr4214308ejb.115.1675081226939; Mon, 30
 Jan 2023 04:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-3-bchihi@baylibre.com> <20230126161048.94089-1-bchihi@baylibre.com>
 <5ec49108-6ad8-daf7-54ec-104f0923a31d@linaro.org> <CAGuA+opQboxH8qoNv4GG+raX=ZZAyRVLC9VLjVCzbT_cUQWWTA@mail.gmail.com>
 <b4bec164-5986-718e-b9cc-290dfc995edb@gmail.com>
In-Reply-To: <b4bec164-5986-718e-b9cc-290dfc995edb@gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Mon, 30 Jan 2023 13:19:50 +0100
Message-ID: <CAGuA+ooSK-rzeqbFoTX3Bnnp_TH=0Uiu7Nxs_1YiTiKK4w5qtw@mail.gmail.com>
Subject: Re: [PATCH v12 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers dt-binding definition
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Mon, Jan 30, 2023 at 12:18 PM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 30/01/2023 11:40, Balsam CHIHI wrote:
> > Hi Krzysztof,
> >
> > Thank you for the feedback.
> >
> > On Sat, Jan 28, 2023 at 11:48 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 26/01/2023 17:10, bchihi@baylibre.com wrote:
> >>> From: Balsam CHIHI <bchihi@baylibre.com>
> >>>
> >>> Add LVTS thermal controllers dt-binding definition for mt8195.
> >>
> >> Subject: drop second/last, redundant "dt-binding definition". The
> >> "dt-bindings" prefix is already stating that these are bindings.
> >
> > fixed.
> > The patch title has been fixed as you suggested :
> > "dt-bindings: thermal: mediatek: Add LVTS thermal controllers"
> >
> >>
> >> Plus two comments at the end.
> >>
> >>>
> >>> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> >>> ---
> >>> Changelog:
> >>>    v12:
> >>>       - Fixed subject prefix
> >>>       - Fixed licences GPL-2.0+ to GPL-2.0
> >>>       - Added dual licenses
> >>
> >>
> >>> +    };
> >>> diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-bindings/thermal/mediatek-lvts.h
> >>> new file mode 100644
> >>> index 000000000000..902d5b1e4f43
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/thermal/mediatek-lvts.h
> >>
> >> Same filename as bindings.
> >
> > fixed.
> > rename :
> > include/dt-bindings/thermal/mediatek-lvts.h =>
> > include/dt-bindings/thermal/mediatek-lvts-thermal.h
> >
>
> I think it should be
> include/dt-bindings/thermal/mediatek,lvts-thermal.yaml

OK,
I will change it like that.
(".h" and not ".yaml" I believe (just to be sure).).

>
> Regards,
> Matthias
>
> >>
> >>> @@ -0,0 +1,19 @@
> >>> +/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
> >>
> >> Although this is correct, any reason why not using exactly the same
> >> license as bindings?
> >
> > fixed.
> > both files are now using the same license :
> > "SPDX-License-Identifier: (GPL-2.0 or MIT)"
> >
> >>
> >>> +/*
> >>> + * Copyright (c) 2023 MediaTek Inc.
> >>> + * Author: Balsam CHIHI <bchihi@baylibre.com>
> >>> + */
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >
> > I'll send the changes soon.
> >
> > Best regards,
> > Balsam

Best regards,
Balsam
