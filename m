Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B856635F42
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbiKWNWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbiKWNWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:22:12 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7351CB4805;
        Wed, 23 Nov 2022 05:01:10 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id n186so18891819oih.7;
        Wed, 23 Nov 2022 05:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D8iNsY38chO/HqPmklDMe6KMcfnGGpO+SfN25u2MR9k=;
        b=fe6HirGOUDK4nqPF1BFgY1lmrm30/fCj8oi73BGLRuy7chtWit372NNZOCRvH8nsAx
         CIsFes5MpzAdzt1LCqTErH0eG6JXlo944wFSHTL+SMiKb3w/adeTWloYj4LRAONDTlPf
         5hsgIt6+otyfavu7LrGylkto+jDSS29+OPmAG7j1cdO3pFA3moX0pxEylcY24DNrVdtt
         JxI2MffvwraF1TbxK2VDp2DOdZ+XdE+VrpVGcvox/ArDzWmTwXUeg2qjxck/nFnEqR/y
         8LZxd9tEVGgO2rk6J0nH81iIJnCvN0uvuNzNzxAP6KW/jWgtMKRq7R7QYP1KIllBHGpt
         jnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8iNsY38chO/HqPmklDMe6KMcfnGGpO+SfN25u2MR9k=;
        b=G3RHCsIIggwiJKbxm8PhQnkC8syyfKP34IW6hKIEDcqNZmp9f+GmZVdNZr7GPDNeLk
         0fzEbZPgBVeOE0pNKa0GgKBRlorE3StFXk6HUT2245j6kEAJTFa09kzFPior0Geu0Z2n
         6o89s/wcms484ATTopoPMc5OpOmpRVNaQZ8edG2a42zPAxFUcfs+6W0J1DMqYXDLXgpo
         FgcUSoj4DU3YyVOaO+Y80pTBn/9+LzOVOHzxjbkpqagjuklPdk+xNr9tmjFXjfFuCiGq
         RipL1bh6clIO21X3ttYt9abGWHhjOtLgITPNL8JW092pZQ4w5HdqGFCRgVlPmh7cjKyh
         HWYA==
X-Gm-Message-State: ANoB5pkWvaSJEdxi+l2S1xYORMlypGOSBTiA2nmJ2zse7JIDYxAYa95R
        CDBDIdeXBcgtlTEDN43/nXcIAdjQ/Ekj4bCBRIc=
X-Google-Smtp-Source: AA0mqf5xNBOot5wGFrpujJ4FWWy2MHxMhw7SnCOf6Jrue4uTFZvRmZ83x0rBa8NZBvW1D92mdfQnd8YAo7ubu5u00GE=
X-Received: by 2002:a05:6808:284:b0:35a:e9d:925c with SMTP id
 z4-20020a056808028400b0035a0e9d925cmr13280366oic.260.1669208469849; Wed, 23
 Nov 2022 05:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-3-linux.amoon@gmail.com>
 <3e4e601b-e7f8-e9df-0ec5-4f4b629d9c0c@wolfvision.net>
In-Reply-To: <3e4e601b-e7f8-e9df-0ec5-4f4b629d9c0c@wolfvision.net>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 23 Nov 2022 18:30:50 +0530
Message-ID: <CANAwSgTbTziSY-5=V3_WJG9-SaTY4R0JM4hkohLFE-q1bERcdg@mail.gmail.com>
Subject: Re: [linux-next-v2 2/5] arm64: dts: rockchip: Add support of external
 clock to ethernet node on Rock 3A SBC
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Michael, Heiko

On Tue, 22 Nov 2022 at 16:48, Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Anand,
>
> On 11/16/22 21:01, Anand Moon wrote:
> > Add support of external clock gmac1_clkin which is used as input clock
> > to ethernet node.
>
> Indeed this operating mode is defined in the schematics, thanks for the fix.
>
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
>

Actually, I wanted to drop these changes since looking into clk_summary
gmac1 CLK gets wrongly configured with PLL and the reference count is
not correct.

Plz do the patches, I will send the correct changes next version.

> Best regards,
> Michael
>
Thanks

-Anand
