Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B95B5EB499
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIZWeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIZWeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:34:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D5C84E4F;
        Mon, 26 Sep 2022 15:34:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r7so12368858wrm.2;
        Mon, 26 Sep 2022 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=ou+iI7nruCTffmoQ0U6U8nomGAjNAmhtpnYz9x5oSao=;
        b=QXEWKgL8iUtWbESsUcXxxNkl37oMTDz1H1HwLk3F7eKAW20/0KhPVUnUGnZ5a2rhfk
         yWvAAyvWxQoKlr5TLr1RtMP1zJ1J9h+wWAWLinW5GP6S1kM+sgyJNiJCCpw+4RZ515v+
         BG4152d11tOZPtF3QQ5Aqt2x2QUxHlAJKvpslustUVZkJoYpDZNi4PzbGX3OTaL7C04J
         WGW9MkvxQRSz/R4wT+u9DsVDFdVBCxMyUvy0aldlh9INhnsKFjH7ZeUPp4o1ivGtlpma
         XKiC8ud5UDsPYBrdi+trW3T2CMZSDmDWQB1ROgNNwZ5kooftP8r3VlKyK9fJQWoO6lLD
         MBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ou+iI7nruCTffmoQ0U6U8nomGAjNAmhtpnYz9x5oSao=;
        b=U198XFOdT39KbM2Fh8yqb02mUW2Upf1YgIDaZD2xOy43VngX+ajDgGJESnyF4D4D9x
         VrmWHMtSm0gcdn9TASFq+CKDXkyr4SuExzP9E11s9DGA7HP5GXL5Sr9zSnrddvmOFsHJ
         z0nksMplx6ruWFPAtvE6tTAmxLpU+NrzkD5/sqbFrjzOCHc/rMPDa2vAwY32lTWo4g7C
         Zsk13+VzOQzePapqnd0nOMPHFbXVI/bvXTySnJX2Hd8ZWL0zfmghk7cWBeEXrnKV2q3m
         QFh5c0Hrm9/mdgrMpspNsuW6Ww8uWQ3y0nMTVQCyshiLaeKfa+pzlfQNU+1DSKi93MWn
         x1Ag==
X-Gm-Message-State: ACrzQf3w9JKMdQoEoV04S0i5Lx8XIg3dzlvdeOQT4dvcr4xbG+B7D6BW
        vf9QUTWe7B+AZ2TpVJkycxaLfh35FeOM3oflFwVt2L3b
X-Google-Smtp-Source: AMsMyM72PThTWxmcyD8joR1b4vRD4oieuwRNO84jzrY9ayZzbzmEbjGd0JXOlSCwcf6zMYJH1mM8yRExqELbDayJiqs=
X-Received: by 2002:a05:6000:1882:b0:22a:f7a2:736a with SMTP id
 a2-20020a056000188200b0022af7a2736amr14777317wri.691.1664231655426; Mon, 26
 Sep 2022 15:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220926183533.1893371-1-aurelien@aurel32.net>
 <CAMdYzYoR2caD2ecN5vGTiHejoE5AhbyKxSgSeU1+SzU7nNVTwg@mail.gmail.com> <YzINPR0htauYppWQ@aurel32.net>
In-Reply-To: <YzINPR0htauYppWQ@aurel32.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 26 Sep 2022 18:34:04 -0400
Message-ID: <CAMdYzYqo9+DjvWTQMrZ=cDceG3KJOwBvSva0aRs_7rooko5f2Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add missing rockchip,pipe-grf to
 rk3568 PCIe v3 PHY
To:     Peter Geis <pgwipeout@gmail.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
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

On Mon, Sep 26, 2022 at 4:36 PM Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> On 2022-09-26 14:58, Peter Geis wrote:
> > On Mon, Sep 26, 2022 at 2:35 PM Aurelien Jarno <aurelien@aurel32.net> wrote:
> > >
> > > This commit fixes the error message
> > >
> > >   rockchip-snps-pcie3-phy fe8c0000.phy: failed to find rockchip,pipe_grf regmap
> >
> > The pipe grf only is used on the rk3588 device for this phy.
>
> Ok, looking at the code in details, I confirm that. Does it mean the
> change should be done at the phy driver level, to only look for
> rockchip,pipe-grf on the rk3588 device?

That would be reasonable, yes.

>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                 http://www.aurel32.net
