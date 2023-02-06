Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD068C487
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjBFRXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBFRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:23:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FE5D527;
        Mon,  6 Feb 2023 09:22:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD33CB815A3;
        Mon,  6 Feb 2023 17:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856BDC4339C;
        Mon,  6 Feb 2023 17:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675704170;
        bh=b8rf4511dtHgy+Zgh9sXtZqmSmIzFLtIuFjUI+dFlOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JJ22K8vW2CinB+i5RNMEF53ZIpFDl4nUn0N+7s7jqNVaq5fpAmAqeLLh293HXXRyT
         cfjDOdGiQetV1xapWWa5IYfGS011M+t6fOboK0glCd76zk4WNaPVQXId/L6/DirKhs
         Mg06fPEd19QH5pjyiaDpJ7rU9anf9vwJC8W3CTHNm1exVIJRpft50P1zt66wR85CJy
         oHs95xJFHRAxo/56fOyk0n0TKX55ylIN0Wb+S6RYrMsHFCx/ZY5Wf4u0VCIk73FrTH
         YGxGfg/DUEe4CPNkqj4f05frMZWWLzFpXJ06yEbszLUMDLw1LDjacSTLH/ro/24P9e
         Ojnh1qUyjErcw==
Received: by mail-vs1-f48.google.com with SMTP id k6so13435367vsk.1;
        Mon, 06 Feb 2023 09:22:50 -0800 (PST)
X-Gm-Message-State: AO0yUKWBeE7wqr8v4Q6u8FyJkew6XDVej3Qb4zz8GEj9Uu4WyIC/3Z7j
        1RwlC+M8iPcvx3ThCNshmSBSsJNkNntFgoV5IA==
X-Google-Smtp-Source: AK7set8i+DvPEonrvX+TdWWZwDQ+8N1gm5qnjYdkrSC1FOvVs3At48NXFTXuMeOqCPDjO1hrNvijO03m3gRQfH1+J3M=
X-Received: by 2002:a67:cc1d:0:b0:3f3:5ce0:85ab with SMTP id
 q29-20020a67cc1d000000b003f35ce085abmr114195vsl.26.1675704169503; Mon, 06 Feb
 2023 09:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20230124222023.316089-1-robh@kernel.org> <Y9EyB+OO7MyGy20w@e120937-lin>
 <20230125141113.kkbowopusikuogx6@bogus> <Y9JLUIioxFPn4BS0@e120937-lin>
 <20230126144647.6q3qlu5sqz27cmyc@bogus> <CAL_JsqLxBAB103vgCUOwW4SkAApm6_=Ace7EFWMSDFKDzJaKpQ@mail.gmail.com>
 <20230126170412.4ytcky6a7lnll6it@bogus> <CAL_JsqJcrmf2fYVC0TnNY_MZvajJxqXPdVFwLf9MZ2XO=VZ1Lw@mail.gmail.com>
 <20230206104704.xe72srqygepguuk2@bogus>
In-Reply-To: <20230206104704.xe72srqygepguuk2@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 6 Feb 2023 11:22:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK9dzohSW_035Y8F2DRMZLjmwd-Hq=c2sqM95ofWRTj8w@mail.gmail.com>
Message-ID: <CAL_JsqK9dzohSW_035Y8F2DRMZLjmwd-Hq=c2sqM95ofWRTj8w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: Restrict protocol child
 node properties
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 4:47 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Rob,
>
> On Fri, Jan 27, 2023 at 12:52:33PM -0600, Rob Herring wrote:
> >
> > TBC, 'protocol@.*' would not allow anything but the properties defined
> > in the /$defs/protocol-node. So [1] would throw errors without a
> > schema addition.
>
> Right I clearly missed that, somehow I assumed it would allow.
>
> > We should either do that along with dropping 'protocol@18' or we keep
> > protocol 0x18 node and add all other providerless protocols. I don't
> > think we need the latter to just check unit-address vs. reg.
>
> I only argument today it to allow protocol specific transport. So we could
> delay addition of it until someone needs that way. So far we haven't seen
> anyone using it other than performance(even that is not needed with the
> introduction of fast channels that are auto discoverable in relatively
> newer versions of the spec).

I failed to think about 'protocol@.*' would match on every protocol,
so we have to list them explicitly: '^protocol@(18|xx|yy|zz)$'

Anyways, I think the conclusion is the patch should stay as-is and so
I've applied it.

Rob
