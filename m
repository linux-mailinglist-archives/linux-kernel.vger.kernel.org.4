Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763925F7370
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJGDvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJGDvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:51:33 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F0EBE2D7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 20:51:32 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1326637be6eso4353009fac.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 20:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ywOJjC1iAeM1WckDzdDR6XJ9UsRidM3rIQ+Y2hJNDKM=;
        b=Cm8A2XN+mF9SQCfZ8U83Xr2/sdIj3A4gzywnUW/7Rg8Ps6TUj4mhzqhCDtGqP7rbCX
         cR0e5rS0OPRwXdYsVNItxkjYH46iUD/Bd/+KUmlHvltKz67cwSfZ1QPHMg10zi1Iw9bm
         vDZbb+QvIf3iyYRqE/pS19gScSSw1GkfnatsP8vKo8rbOgn6RPhSaNJX1B1SkuM2/vq7
         1ro4NazkBLM0NjJ1s+DFBjBdE1QhYGBWWpOMpKVLCIXLv5L9XAAnJtiRU9u+E/g+SHEl
         qm19+eysnC3NebtYzE6Z6Mi6JCPSiZIIXR689VTSW5J1/AfsM2qmJLQlgJZEeJllTKHy
         aB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywOJjC1iAeM1WckDzdDR6XJ9UsRidM3rIQ+Y2hJNDKM=;
        b=JhMGpN2wO800vbMI5d7IuGY6uZkOKsdl4dOl18kkloEO8VNqoroQboD7hBlwIjvo92
         s3vUUe/OZOaRz6qG4scrZV4cd7nhcs17AJB7UplA/yfAxTzsa2J7EUMMwMFQBbDdpq2Y
         DCVQi52CZixpm7VUgcq+TtzXDYUNJOf1uW2MJ6AnMSEf0etpBoLYpFqhOPQ76lRfZB9s
         0IiADdIUyz7g5FV3W9yVLXUhiKow/N6Qs/7ngFfbo99vC8PB6D3WprH9rxiuhSJThgRw
         Bp28trOdYQpG/gu5Yz8fV2zNEy+wA9zVwm4VcL7QM/dCEbAzhdwkj+wdiVa0w9frpohs
         2wBA==
X-Gm-Message-State: ACrzQf1OsE+vgtnDI+rP8OP1EEp3rhxJvSNcwupvR2vq90A035YaGOU7
        X4eX13c1Pj9KjwMGluYo0uihj5yszivquzQGsjHvFg==
X-Google-Smtp-Source: AMsMyM58r3x61gcQz490WPKR8f7M4ASa5M+2B+LqM+DSCDhS6Ek4QKEKnabKgdcccswhnXNdVIOArInEoUBb8fej4mo=
X-Received: by 2002:a05:6870:ac21:b0:132:f716:1804 with SMTP id
 kw33-20020a056870ac2100b00132f7161804mr4707931oab.248.1665114691420; Thu, 06
 Oct 2022 20:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220829062202.3287-2-zong.li@sifive.com> <mhng-050016e5-0f50-4366-b4bd-98b4b36a56bb@palmer-ri-x1c9>
In-Reply-To: <mhng-050016e5-0f50-4366-b4bd-98b4b36a56bb@palmer-ri-x1c9>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 7 Oct 2022 11:51:20 +0800
Message-ID: <CANXhq0qMuU3-R=5fM6WK28259dBBbM+6Sg6-=ayiSVLuccx9TQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: sifive-ccache: rename SiFive L2 cache to
 composible cache
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 10:58 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Sun, 28 Aug 2022 23:22:00 PDT (-0700), zong.li@sifive.com wrote:
> > Since composible cache may be L3 cache if private L2 cache exists, it
> > should use its original name composible cache to prevent confusion.
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  .../riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml}      | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >  rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml} (92%)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
> > similarity index 92%
> > rename from Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > rename to Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
> > index 69cdab18d629..1a64a5384e36 100644
> > --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
> > @@ -12,8 +12,8 @@ maintainers:
> >    - Paul Walmsley  <paul.walmsley@sifive.com>
> >
> >  description:
> > -  The SiFive Level 2 Cache Controller is used to provide access to fast copies
> > -  of memory for masters in a Core Complex. The Level 2 Cache Controller also
> > +  The SiFive Composable Cache Controller is used to provide access to fast copies
> > +  of memory for masters in a Core Complex. The Composable Cache Controller also
> >    acts as directory-based coherency manager.
> >    All the properties in ePAPR/DeviceTree specification applies for this platform.
> >
> > @@ -27,6 +27,7 @@ select:
> >          enum:
> >            - sifive,fu540-c000-ccache
> >            - sifive,fu740-c000-ccache
> > +          - sifive,ccache0
>
> Looks like Rob's bot had comments and I don't see a v2.  Sorry if I'm
> missing something.

Hi Palmer,
We moved this series to the following patch set:
http://lists.infradead.org/pipermail/linux-riscv/2022-October/020196.html

Sorry for the confusion. Many thanks for considering this series.

>
> Also: I'd guess that we only had the SOC-specific mappings on purpose.
> It's kind of a grey area and I'm OK either way, but I'd definately
> prefer the DT folks to get a chance to review these.  My guess is that
> they're not looking due to the bot comments, but sorry again if I've
> missed it.
>
> >    required:
> >      - compatible
> > @@ -37,6 +38,7 @@ properties:
> >        - enum:
> >            - sifive,fu540-c000-ccache
> >            - sifive,fu740-c000-ccache
> > +          - sifive,ccache0
> >        - const: cache
> >
> >    cache-block-size:
