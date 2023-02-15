Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09C5697E00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBOOHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBOOHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:07:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A634C3D;
        Wed, 15 Feb 2023 06:07:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D5E9CE2589;
        Wed, 15 Feb 2023 14:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428DEC433AC;
        Wed, 15 Feb 2023 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676470048;
        bh=xeegXyniLjN/JyvhpRgpaIUHBrPfbZ7oSBSNXvLEsY8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jc0TnLftNFLSrn96FT6uG9XSDZWdm9rPMV80gFEptPqUqSh0W9K1Dgg6iucvKDYGD
         kTOYfZ/jcQ+2gklA0JcyLKWXxRHkopC4SmAH9+opzLVb0xqfXmJ9bOY661sOBC0cSV
         yuuePoxXqGjoZUIcV7D/Z7MiOkKAFL3SGcmNKW58/VfsvyZRYggrQNEEY3kU2VFZ30
         3PSLlVKnYlbzAhkSaiC59BRwUkGOF7STRfc0bAGEk7Me9C82FaWg31f43LXiWhj80D
         v8FZjUYv7R6TkgkMz+nrZ7c2GVPz93DebV0TTkSCeldzvt8L1/lpd6fWlgj4DjbVIy
         yhQ30NqjQslDg==
Received: by mail-vk1-f178.google.com with SMTP id b81so9720004vkf.1;
        Wed, 15 Feb 2023 06:07:28 -0800 (PST)
X-Gm-Message-State: AO0yUKX2EEfryIZp6deceNhp08C/rUuvzXKz+Y1bDeCJJTCccv6JXACJ
        Aw5BnP8IJeSnTIfWcv6yPlfQ4CLAIOycveCnGQ==
X-Google-Smtp-Source: AK7set+4FSPMsaLCMaY2lday9xVdSgPFHvGmAOSE6JxhwNnO4k44ff1da6Ut93bInRald2Ju9cba91ktUPzQrsYohUQ=
X-Received: by 2002:a1f:1b83:0:b0:401:42f3:5657 with SMTP id
 b125-20020a1f1b83000000b0040142f35657mr330101vkb.42.1676470047095; Wed, 15
 Feb 2023 06:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20230213231931.6546-1-bage@debian.org> <20230213231931.6546-2-bage@debian.org>
In-Reply-To: <20230213231931.6546-2-bage@debian.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Feb 2023 08:07:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6mvMZ2qWcSwKhuPRk29V2Yrx0_CCywmZd7=y-kzTRNw@mail.gmail.com>
Message-ID: <CAL_JsqJ6mvMZ2qWcSwKhuPRk29V2Yrx0_CCywmZd7=y-kzTRNw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: hwlock: sun6i: Add missing #hwlock-cells
To:     Bastian Germann <bage@debian.org>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 5:20 PM Bastian Germann <bage@debian.org> wrote:
>
> The allwinner,sun6i-a31-hwspinlock.yaml binding needs #hwlock-cells
> which is required by the hwlock type.
>
> Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock")
> Signed-off-by: Bastian Germann <bage@debian.org>
> ---
>  .../bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)

Now failing in linux-next as reported. Please send a fix.

Rob
