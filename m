Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F06AB721
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCFHd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCFHd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:33:27 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435EE900D;
        Sun,  5 Mar 2023 23:33:25 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id g19so5782288ual.4;
        Sun, 05 Mar 2023 23:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678088004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwT3eldxo/iPkI6KVTduFAN5XrNMFKHna3JySQ6zjpg=;
        b=UlbV2lIFjWa2GbmRsXwvUfabN12EMRWLp5vigUKs7Zb/+0CVmvtVjJskLmRyMjAv+T
         X9wP2JBMF2Im7B+0Azpb3wcP2nOwac+DuFXQnQq3HOD05caNSvz0KF06t5l4EOma555l
         XJ9L9ZlMfNTY1TeX2YXyDNpFx491B1sTv9hL3YlCTUjY7wKImKanN1c5WP5gh1pJFfS/
         RYLQ7bLME0QNtRKsUtwh0TgcsPgQ0bs4eljI4+qUxhhZ6NG9iNwkNg1uI/sXQiEKhVOT
         zXnWGoVcXB+1yBffe6NPUkums0oAdC/9+TvzpLL9a1eg/jqNmeV1w09+1tzpTHcikeDF
         1xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678088004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwT3eldxo/iPkI6KVTduFAN5XrNMFKHna3JySQ6zjpg=;
        b=4suBfVwuNo+sKhYtBQ95Wq6ClKldaZGfm1Pz8nye7ByKbqQpWCKQKgpAZYNf3uSjta
         KyKhz/pmVAP2zUyRoNl0tkQKnjzDR/pn2oEw/nn5/BbKKIODkLViH4eQLO+Bf/HXNsms
         vwuJEYa3tQoHm1CkgOHPJXbgPxhclCirF93BRn/sqP0+DKDSkKr0DFGYqaUI2afZ88F9
         +q3FkkPfwomcLf3qaCEtlhCa/j7LQ7iuAwv3ibd31TT1hwM1WW0+MFHI7LUU11cVeRQQ
         jC7JhQzLGQm2X1jXXG2dlOE3aETeqpN4t8vLWElOvf/uhfDzNRKvH9+amUToAJI3Tf4+
         aZ+A==
X-Gm-Message-State: AO0yUKUdNGZme2H/iJ04Z4o6ReTFmpNl529H4RtIaRfYQZcrN0w8Nebb
        XwxNdD+z196365zzCLnHvYboKuNnyQJR323rlIiXxDrDBYY=
X-Google-Smtp-Source: AK7set98sNsa3iImK3NXtj2PY5UoUo0QqQyGXvqndN7K7nelgRBglTlvrpxQ0H4twZHpNASiQRcJqMGtXBw4Q/xdVvY=
X-Received: by 2002:a1f:1888:0:b0:401:8c72:4cf4 with SMTP id
 130-20020a1f1888000000b004018c724cf4mr6264627vky.1.1678088004199; Sun, 05 Mar
 2023 23:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20230306060446.414986-1-chunyan.zhang@unisoc.com> <fecb3d5c-86b7-f052-6cba-f92b45714665@linaro.org>
In-Reply-To: <fecb3d5c-86b7-f052-6cba-f92b45714665@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 6 Mar 2023 15:32:48 +0800
Message-ID: <CAAfSe-vNR_c-Uf9_Yay6rC63s3EK2dQs7G2jd6qp+u7SCmB2xQ@mail.gmail.com>
Subject: Re: [PATCH V3] arm64: dts: sprd: Add support for Unisoc's UMS512
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Mon, 6 Mar 2023 at 14:43, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/03/2023 07:04, Chunyan Zhang wrote:
> > Add basic support for Unisoc's UMS512, with this patch,
> > the board ums512-1h10 can run into console.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> > Changes since V2:
> > * Removed redundant gpio.h from ums512-1h10.dts
> >
> > Changes since v1:
> > * Addressed comments:
> >   - Removed earlycon bootargs;
> >   - Moved up gic reg as second property;
> >   - Moved two sdio nodes under to the apb bus node;
> >   - Renamed node name of all fixed clocks;
> >   - Fixed warnings reported by dtbs_check.
>
> Please always mention  under --- why you do not send a binding for new
> board compatible.

Actually, the patchset including dts and bindings changes got merged
before, the dts patch was reverted due to compile issue[1] at that
time.
And after that I had a very long holiday, so resubmit the dts changes
after such a long time.

[1] https://lkml.org/lkml/2021/10/11/1349

Thanks,
Chunyan
