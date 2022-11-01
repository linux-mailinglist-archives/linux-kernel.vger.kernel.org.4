Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E894615093
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiKARZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKARZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF965178B6;
        Tue,  1 Nov 2022 10:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF2961640;
        Tue,  1 Nov 2022 17:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D31C433D7;
        Tue,  1 Nov 2022 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667323531;
        bh=8+n4wVebR2DVuEojd5dP66y68blMgawXTlygiHM3C3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VwC1XIFZ/6uv0ZpIYTUWUsrPvE1JXB/r6SNROi2qkbPIsLwxBcscmulwu6trYeRpu
         p9okHSDGs3VJT+v5l3Wmo8NRhB1HZAFi7F+qWWc4E6xgC7im4J2begb3ugdQNta32J
         0hZnktyZz3xC40Rs7OIbA4GDjW4scoxf2xktW/MZEUCUb/l1wxI5RNM27NGwwGZOLY
         ZCUOzujCkavRzvrLHpZezmZXRdIPWG39t/nmWcBzTD6DYaYItZDJ6F+q6nBJ4vG1TX
         fBt6xSxepbFXEWlrQRpcy27oSzP0Kc+pCMD0SL5UxIVRR3iJq+La8wKB7J6S9L3Zuq
         zN9AhImTjDWhQ==
Received: by mail-lj1-f170.google.com with SMTP id z24so21899695ljn.4;
        Tue, 01 Nov 2022 10:25:30 -0700 (PDT)
X-Gm-Message-State: ACrzQf2ck3qZy5yP3ZeXltyDH90VLoccnT6BOh9/ldUHFBTfu51ZYMPW
        w4NF0KCNMcVykkZIv682ZofrlmsLIsfFNwtHfA==
X-Google-Smtp-Source: AMsMyM76Gx3gpIDmB0YWloxakt3kNIrl0ft6hshAFByvsLqfn6Hp/4L00+ft8BqwrQoWEk8oeG8xE59btzfpwteVooE=
X-Received: by 2002:a2e:b16b:0:b0:277:3946:7611 with SMTP id
 a11-20020a2eb16b000000b0027739467611mr8104831ljm.392.1667323528960; Tue, 01
 Nov 2022 10:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221028231309.565451-1-krzysztof.kozlowski@linaro.org>
 <Y1+MNL+fCfreAqMh@google.com> <20221031192658.GA3286587-robh@kernel.org> <Y2D0As4ezi/031lL@google.com>
In-Reply-To: <Y2D0As4ezi/031lL@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 1 Nov 2022 12:25:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJUx2FtpYWSkx3cOFcywSux7P2sPpvbVmaryMdo1+xA_Q@mail.gmail.com>
Message-ID: <CAL_JsqJUx2FtpYWSkx3cOFcywSux7P2sPpvbVmaryMdo1+xA_Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: Expect specific type for monitored-battery
To:     Lee Jones <lee@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 5:25 AM Lee Jones <lee@kernel.org> wrote:
>
> On Mon, 31 Oct 2022, Rob Herring wrote:
>
> > On Mon, Oct 31, 2022 at 08:49:56AM +0000, Lee Jones wrote:
> > > On Fri, 28 Oct 2022, Krzysztof Kozlowski wrote:
> > >
> > > > Core schema does not define type of monitored-battery, so the schemas
> > > > are expected to reference proper type.
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/mfd/ene-kb930.yaml      | 4 +++-
> > > >  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 1 +
> > > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > Applied, thanks.
> >
> > NAK. Please drop or revert.
>
> Dropping is not a problem.
>
> Would you mind providing some context?

I did elsewhere in the series, but simply we don't want to define a
type for a property multiple times. It should be defined once
somewhere common.

Rob
