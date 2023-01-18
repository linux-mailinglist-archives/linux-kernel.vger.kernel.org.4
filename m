Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5476711B8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjARDTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjARDTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:19:25 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034BA4FCC9;
        Tue, 17 Jan 2023 19:19:24 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id v6so37074911ejg.6;
        Tue, 17 Jan 2023 19:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FgA+6yqUgolw/SqxO1YAy7+szNjmtGYdLu65H2lP81o=;
        b=gFJ6plrGY2qMO2z6gkb3oSWK7AMapIqGWeg4VhsfPJQ3yF5qtcB5TSjijGQibJL8aI
         5ZcYvl4phtUmhwoVVWlnghRSHBf+w4zha54HhzQk8XYYCpLvWRWM5TflHwuCvaT3Ipad
         1PiD+YpN4tNwnLllc4kviZkPn4Uagic+7Cnp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgA+6yqUgolw/SqxO1YAy7+szNjmtGYdLu65H2lP81o=;
        b=Z+rlduZwRbKwR23prWuQBbthEIgeD5oQE5ZwAhpJr5KacDizsYHB0ZWs+jsUVN22iS
         Cj+poQSap3k7N3I0UYjBKAr+GojJ3l/X1XZjPEAiqrebJwvu5PPd4c6XJpFRfsa3CmcJ
         dJPe5dfRGBr1YoVNsj5KkW3lUjFVrcTb2N23oAzkZpaKb9wtNT4Spkw2gpQzJ7sIAJjh
         C/E0aOBjtJq8SYPwKmZTtcrC0w6/0QFb6zNLQ08XxMIKTYXAfAsJsnDgyH1sUdKc+eDD
         GG625xG4HcQp2TxZNBfhwaOaLlAWS1FFlCCLw8XxeX0DmyV0VU4b7WwvKdrLIhN88Gtg
         qwqw==
X-Gm-Message-State: AFqh2krlm/b+bnncJE+vl8tDoI7HwbTdTNlKLQhGL4faqphTvZkJsRZe
        gB71shAA7GUaBdLGLAOwhGGb0Yg5/oBegDa5ONM=
X-Google-Smtp-Source: AMrXdXsF4H3MGnT6GULCJ3IMPm1iznAunBegxShAmG0yJaPN1dHMmR98JqAWtVJ7/AwYH44IZCvxUjrEJny8HwSs1g0=
X-Received: by 2002:a17:907:75e8:b0:872:1905:4185 with SMTP id
 jz8-20020a17090775e800b0087219054185mr362309ejc.651.1674011962419; Tue, 17
 Jan 2023 19:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20221226054535.2836110-1-potin.lai.pt@gmail.com> <Y7SX/6bsztulhw7/@heinlein.taila677.ts.net>
In-Reply-To: <Y7SX/6bsztulhw7/@heinlein.taila677.ts.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 18 Jan 2023 03:19:09 +0000
Message-ID: <CACPK8XdPiHZJo69K99ZL=kWVis_X=JtSAWuYN6FCAVpijcjirw@mail.gmail.com>
Subject: Re: [PATCH 0/2] ARM: dts: aspeed: bletchley: Update Bletchley devicetree
To:     Patrick Williams <patrick@stwcx.xyz>
Cc:     Potin Lai <potin.lai.pt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 at 21:10, Patrick Williams <patrick@stwcx.xyz> wrote:
>
> On Mon, Dec 26, 2022 at 01:45:33PM +0800, Potin Lai wrote:
> > Update Bletchley BMC devicetree.
> >
> > Potin Lai (2):
> >   ARM: dts: aspeed: bletchley: rename flash1 label
> >   ARM: dts: aspeed: bletchley: enable wdtrst1
>
> Series is
>
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

Merged for submission in v6.3.

Cheers,

Joel
