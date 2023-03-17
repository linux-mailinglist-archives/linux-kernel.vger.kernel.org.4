Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D312E6BEB25
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCQO2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCQO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D84D366A8;
        Fri, 17 Mar 2023 07:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03E89622D4;
        Fri, 17 Mar 2023 14:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE7EC433D2;
        Fri, 17 Mar 2023 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679063277;
        bh=Ja0gXd3YfBR6uYrUbXl92wXVqvLZJFGUpGHdiwj+ROI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mdwCqXGqNep4EKAupw8jzfhWRrjq79YWH/MMQgK3tQSZC3hiyuYvbCWPTxwxLwpHJ
         FhfR3yNKFqj/NDBbszx/GvZ/J3/VMSeXoWCDwzES0AjdQiL1tvLD0BBMZ//FgxkrFf
         rRZHPmusSP2wcH9FuRjE8NFAqd7RVcTHkYI4fFrxuBQTLwnCSup5sz3Pq3dyCuOkyy
         Yi4E+sbyIKDivzUMuGYa8qkS9ILxgOwMjxYArHb//UyvvSyvqI8tHbgy89AH02HhIV
         agzW+EDeGvYcmM54DsDVhSg7ETaaEAxyM6Q15ke0yOFXafWjNuoaAIC7GScvP7ngF8
         BGyMe2skQ+W4w==
Received: by mail-ua1-f54.google.com with SMTP id s23so3448973uae.5;
        Fri, 17 Mar 2023 07:27:57 -0700 (PDT)
X-Gm-Message-State: AO0yUKWfvo4CBuV82B9uDN/S02GEuAwBoay9st8BnJ+TS9FNh0pWfCJi
        d0KeppyRzNw0E1L6a+yAscYPHCXCFR48c2E4Jg==
X-Google-Smtp-Source: AK7set+opXfvV0KuRUWrTn9+KJEXDQa7roIGehinVec3htJJWc+YaBCYf2jrEie3nmO3df834BaxB7f6VqlHHcNfwWw=
X-Received: by 2002:a1f:2cd7:0:b0:401:73f4:dfe with SMTP id
 s206-20020a1f2cd7000000b0040173f40dfemr8088vks.3.1679063276330; Fri, 17 Mar
 2023 07:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-2-cristian.ciocaltea@collabora.com>
 <20230316203417.GA3833267-robh@kernel.org> <20230316222619.r4jzk3lzdxzamr2s@bogus>
 <d5881d9f-90cc-f7a2-72a3-0701348a03fe@collabora.com>
In-Reply-To: <d5881d9f-90cc-f7a2-72a3-0701348a03fe@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Mar 2023 09:27:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL_EogoKOQ1xwU75=rJSC4o7yV3Jej4vadtacX2Pt3-hw@mail.gmail.com>
Message-ID: <CAL_JsqL_EogoKOQ1xwU75=rJSC4o7yV3Jej4vadtacX2Pt3-hw@mail.gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: firmware: arm,scmi: Document
 assigned-clocks and assigned-clock-rates
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 4:59=E2=80=AFAM Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> On 3/17/23 00:26, Sudeep Holla wrote:
> > On Thu, Mar 16, 2023 at 03:34:17PM -0500, Rob Herring wrote:
> >> +Stephen
> >>
> >> On Wed, Mar 15, 2023 at 01:47:56PM +0200, Cristian Ciocaltea wrote:
> >>> Since commit df4fdd0db475 ("dt-bindings: firmware: arm,scmi: Restrict
> >>> protocol child node properties") the following dtbs_check warning is
> >>> shown:
> >>>
> >>>    rk3588-rock-5b.dtb: scmi: protocol@14: Unevaluated properties are =
not allowed ('assigned-clock-rates', 'assigned-clocks' were unexpected)
> >>
> >> I think that's a somewhat questionable use of assigned-clock-rates. It
> >> should be located with the consumer rather than the provider IMO. The
> >> consumers of those 2 clocks are the CPU nodes.
> >>
> >
> > Agreed. We definitely don't use those in the scmi clk provider driver.
> > So NACK for the generic SCMI binding change.
>
> According to [1], "configuration of common clocks, which affect multiple
> consumer devices can be similarly specified in the clock provider node".

True, but in this case it's really a single consumer because it's all
CPU nodes which are managed together.

> That would avoid duplicating assigned-clock-rates in the CPU nodes.

Wouldn't one node be sufficient?

Thinking more about this, why aren't you using OPP tables to define
CPU frequencies. Assigned-clocks looks like a temporary hack because
you haven't done proper OPP tables.

Rob
