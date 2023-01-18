Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0796672B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjARWoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjARWom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:44:42 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38F35F395;
        Wed, 18 Jan 2023 14:44:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mp20so1097768ejc.7;
        Wed, 18 Jan 2023 14:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5rDVfmGaTHq7SddtJNWhZM8yAn31bV4+g6pAERHOpLg=;
        b=loLOq4wYdeeCrYxIj7EUgXtnLj1TNav8NpjXyEPBSllezfA0igfvQj1eoLL1+bLNH+
         wU1YQpXqxikSAjwD4urWorUYTDg6wplMfFVQn61BLel4F79Xhm5agvj+ya2rc/K94vdv
         LlVlQtou3hPA7WpYBpFSIXFhVj8UxSajSA8eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rDVfmGaTHq7SddtJNWhZM8yAn31bV4+g6pAERHOpLg=;
        b=NQl2/VB1lm42hceKhbGuHUvGK583oH93KRr+6lpbJmwB0Xu4aSsXeWll/uHzBbHMH2
         W53czvwoHK6KpD26IOHt5hTkcqTqYsfucckWMX3l+vS3aErtsjLQL+ickmyFRRoasPpQ
         jYkspx8jhbywfSoCcsK1F81hECkok7JNmsDNh9PhuOPGWHBhtprH1p5TesaTZlGu502h
         yRH1EC7uLXVqOUU3b4t4oytEBlVcTnDcNAqBGXcMfpwI8ptvRmfJGzbwGUg7IwYLC3Ox
         jrGZVEQbs2xDfyoEod1TJiBJNCyP4ZgYzO3ZZR404S6q2/86gQ3v/vpg6UsphBLFkdcD
         RtXg==
X-Gm-Message-State: AFqh2kocvZkU19SSSV/mbLc1U0C4u+uFYsxe6prJG/nqNSXKcAS6P8s5
        WD1ONQCKCFmbjlaqHstcgPqh69wY5mNFIxmWtST1g39tDvI=
X-Google-Smtp-Source: AMrXdXuuvLFNYm7lHWC2rdR13oc2fxERzfgrom2b9EwLGCHFygtP/ioTmhiGnTiBauTyAzigAvc19/AK3d7UvVu5/tc=
X-Received: by 2002:a17:906:9394:b0:7c4:efcf:3bc8 with SMTP id
 l20-20020a170906939400b007c4efcf3bc8mr1125299ejx.702.1674081879203; Wed, 18
 Jan 2023 14:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20230118150030.2079226-1-aaelhaj@google.com>
In-Reply-To: <20230118150030.2079226-1-aaelhaj@google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 18 Jan 2023 22:44:27 +0000
Message-ID: <CACPK8XeAX8de_J7px2R2Bc0V7m7hMgGEfB1xpkwFKDzDDr73Og@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: aspeed: tyan s8036: enable kcs interrupts.
To:     Ali El-Haj-Mahmoud <aaelhaj@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        osk@google.com
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

On Wed, 18 Jan 2023 at 15:00, Ali El-Haj-Mahmoud <aaelhaj@google.com> wrote:
>
> When the BIOS is built with kcs interrupts enabled, not enabling
> interrupts on the BMC results in very poor IPMI performance.
> The other way around (BIOS with interrupts disabled, BMC with
> interrupts enabled) doesn't suffer degraded IPMI performance.
> Enabling interrupts on the BMC covers both scenarios, and should
> be the default.
>
> TESTED: manually verified IPMI performance when BIOS is built with and
> without KCS interrupts.
>
> Signed-off-by: Ali El-Haj-Mahmoud <aaelhaj@google.com>

Thanks, I've applied this for 6.3.

> ---
>  arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts
> index 708ee78e4b83..f6c4549c0ac4 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts
> @@ -364,6 +364,7 @@ &kcs1 {
>  &kcs3 {
>         status = "okay";
>         aspeed,lpc-io-reg = <0xca2>;
> +       aspeed,lpc-interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
>  };
>
>  /* Enable BMC VGA output to show an early (pre-BIOS) boot screen */
> --
> 2.39.0.314.g84b9a713c41-goog
>
