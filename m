Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA5E614094
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJaWUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJaWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:20:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BE113E1F;
        Mon, 31 Oct 2022 15:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2282B8189E;
        Mon, 31 Oct 2022 22:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8935CC43470;
        Mon, 31 Oct 2022 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667254808;
        bh=wT5an7lNQErDM6CTlDnmdsCWbDhlXk0KBFVuzjzBVe0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hR5pddhAgWtHCfBpNPi1p9tL8IKyLC6cqBrd/14w5O5aLJJoFT6xQg2LK/mR189Vl
         QzBkeAY/U0olr89EWMxGuOdeuyMGN/MzWPHfpkDi5TZlL3pxCiC+GPchwIQ2eUi+2n
         GHJKplps8TF6tL1f4UUDaotuh2/s1ns9hvgBr2tKVOMw3AsoSlVeUSrdhFRjlcYEGW
         KGAB1OPTcgyyPW/e+xxGdoT8/aDvF1OhsvRjqIvfocX1ODY76Lq7qM9a5ycqLhOuTZ
         6tu8j3P0aic/Pc+emCvT6PBTwbn0dQCfTz86Jwi0NvibSRTJp0a8etCBfhzNPi5HSz
         M4mqEIyb9o+Tw==
Received: by mail-lj1-f172.google.com with SMTP id d3so18522793ljl.1;
        Mon, 31 Oct 2022 15:20:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf13LUxgAy/UYF8rLo0IsbgPwJ/3Pb0LZSxXR/GhSonSKu5k5CWz
        udV9ezyC+gOkVihMD/YhVMbyEsGoH0DdqJRXgw==
X-Google-Smtp-Source: AMsMyM6KIxI42xsWAtYjOioUEoriYt0qBvh672hZbkcPvXdhDHe0YIoj3PJAOlzyA1IUs0ylKhwlOHkXdMQOa5zrPb8=
X-Received: by 2002:a2e:b16b:0:b0:277:3946:7611 with SMTP id
 a11-20020a2eb16b000000b0027739467611mr6675591ljm.392.1667254806589; Mon, 31
 Oct 2022 15:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221031091918.531607-1-pierre.gondois@arm.com>
 <fac3eae5-687e-9eb0-ddfb-c659d3816d81@linaro.org> <3c54db0a-44fe-ee24-1833-7637e249ec79@arm.com>
 <CAFBinCBi_xT-pgdMSROHyZUfyZZE33S2YXczr9ijE52AfQVYHQ@mail.gmail.com>
In-Reply-To: <CAFBinCBi_xT-pgdMSROHyZUfyZZE33S2YXczr9ijE52AfQVYHQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 31 Oct 2022 17:19:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJMxH9hFo7uXRJ6rFcqhZL0AUhedk7Fq1xMdKcSDe5ciQ@mail.gmail.com>
Message-ID: <CAL_JsqJMxH9hFo7uXRJ6rFcqhZL0AUhedk7Fq1xMdKcSDe5ciQ@mail.gmail.com>
Subject: Re: [PATCH 02/20] arm64: dts: Update cache properties for amlogic
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>, neil.armstrong@linaro.org,
        linux-kernel@vger.kernel.org, Rob.Herring@arm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 4:09 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Pierre,
>
> On Mon, Oct 31, 2022 at 2:33 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
> [...]
> > To avoid cc-ing people to DTs they are not related, the get_maintainers.pl
> > script was run on each patch individually. The cover-letter is at:
> > https://lore.kernel.org/all/20221031091848.530938-1-pierre.gondois@arm.com/
> I think Neil's question is the same as mine: is there a dt-bindings
> (yaml schema) change for this as well? The idea is to alert people (or
> let bots alert people) in future when adding a cache to a .dts{,i}
> where the cache-level property is missing.

There's not one, but it's something to look at adding. I'm not sure
how we'd check for missing 'unified-cache' which is a common problem.
The challenge here is a lot of what needs to be checked is based on
the overall structure. This probably is better checked in dtc which is
better suited to do cross node checks.

Rob
