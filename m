Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F410685CA9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjBABfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjBABfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:35:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB814FAE0;
        Tue, 31 Jan 2023 17:35:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0EF9CE1F6F;
        Wed,  1 Feb 2023 01:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157BFC4339B;
        Wed,  1 Feb 2023 01:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675215315;
        bh=knDY0XR4EkjmaIgy15F+qM9DAUlql49vNU3peyz0Hek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=An/6iSd5cTu0MUvnoKKcTPuwO1211upjIrUtoCe3ckm/2QyEntUftFmQ5nVZndtdB
         2XsISWuO5IaQ7U/5SvcZgDq8dEKntNJn16okG3TT5OUk77ns9LmH3wH4cVlhhrT4NB
         fkbPlF+NP8IownpmBhSV2rrM4ttaQmRYcNS2tjCM9TEo3Wcw2PXaNRy349sm4r70r1
         vLzFN1qKqgz4h9tSqyaYqqMDLlHfSHHjV8fEHsGjplGWjwhftAehSxqpNFuAyA+M4u
         BWgFriidNL6NLMXeSlnad4zykCCSCvy3Noa4bQ7iHjDD6N1orPWgh+Yz3nqedlj0o0
         7ZRHZuKKxfeJg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-169b190e1fdso677838fac.4;
        Tue, 31 Jan 2023 17:35:15 -0800 (PST)
X-Gm-Message-State: AO0yUKVmm8vtg4eTxfaqqQV4bWzSfxh+3W/QoR2CC8fY2ctpcBEmx0ZW
        /f85lVW2NLiHI/VvCTyv9IzMcZ+Nf3u8kz961t0=
X-Google-Smtp-Source: AK7set8ovKWewUNojM8tT5otQ7+J12ZeiWWmwI48LIYQMiby/06BIbG9cryG7NjOKanNJnfLIjV2s+Dun3VGa7nwsJc=
X-Received: by 2002:a05:6871:441:b0:163:a45a:9e41 with SMTP id
 e1-20020a056871044100b00163a45a9e41mr6476oag.194.1675215314331; Tue, 31 Jan
 2023 17:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20230127150225.18148-1-andriy.shevchenko@linux.intel.com> <167521487245.2279300.8949761709442968191.robh@kernel.org>
In-Reply-To: <167521487245.2279300.8949761709442968191.robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Feb 2023 10:34:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNRgTSXpRou5xvwAdO=UK9Ebed0LXKgaPXgb1x7ODM+w@mail.gmail.com>
Message-ID: <CAK7LNARNRgTSXpRou5xvwAdO=UK9Ebed0LXKgaPXgb1x7ODM+w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] dt-bindings: Fix .gitignore
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 10:27 AM Rob Herring <robh@kernel.org> wrote:
>
>
> On Fri, 27 Jan 2023 17:02:25 +0200, Andy Shevchenko wrote:
> > The tracked files should not be ignored.
> >
> > Fixes: 44ec8b20d1e9 ("dt-bindings: Add running yamllint to dt_binding_check")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  Documentation/devicetree/bindings/.gitignore | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
>
> Applied, thanks!
>


!/.yamllint


please since this file exists in
Documentation/devicetree/bindings, but never in sub-directories.





-- 
Best Regards
Masahiro Yamada
