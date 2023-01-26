Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B60267D024
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjAZPZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjAZPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:25:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011F44239;
        Thu, 26 Jan 2023 07:25:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F568B818D3;
        Thu, 26 Jan 2023 15:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519C6C4339E;
        Thu, 26 Jan 2023 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674746725;
        bh=Dv/up+8vnnDKxVYL5M82TsxnhihieAipf84F3aqFTBc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aIR5lmX6mCnYcMxN6frGMgpYATYps8ht8NHQCphRnDrit6MakT8jnDmbFxbwAAv38
         WnVfUwIQHZ7PU5ngX2IvGp7Us8dCNNftxqoKX92E6e6u3AtzjxTK17gTXBDzaIwtJ0
         Dn03Klk06Eu2waGPWqLNK6V76Ydlp/6RmkkT6X+4ms1IB1E0YgVJIAR4gkz8zLeb9c
         0u05/x/mi105FvazCEu6IbJJRjAh0OBMf86ZnC03X4vl85g7+gQUP7Nb4mZ0pvIvKc
         Ib69liJEQJXsEXMSsLG3kscLoA3mWVQinadIRuGu2r0owfyl37J+i++syDEdu1YwmQ
         LoK4SN2lY0mOA==
Received: by mail-vs1-f49.google.com with SMTP id t10so2252083vsr.3;
        Thu, 26 Jan 2023 07:25:25 -0800 (PST)
X-Gm-Message-State: AO0yUKUMvWHY95mP979cWKWz/3mh3yHPbiFP3IeN0Bp7u96vZX3G0Vh9
        f6TJOIzejDoBkbadAsoEnvFBoQYK8Sz6s3K/JA==
X-Google-Smtp-Source: AK7set82kQPpMTlyog8X8t8/MQ53pskdfnuSPQEK8B/U+2gBHyhUyhTCsel9OSKXZISSuE7fdiUTRJUY5DL1rJ/8yV4=
X-Received: by 2002:a67:fe41:0:b0:3ea:c8c:48a5 with SMTP id
 m1-20020a67fe41000000b003ea0c8c48a5mr603284vsr.53.1674746724284; Thu, 26 Jan
 2023 07:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20230124222023.316089-1-robh@kernel.org> <Y9EyB+OO7MyGy20w@e120937-lin>
 <20230125141113.kkbowopusikuogx6@bogus> <Y9JLUIioxFPn4BS0@e120937-lin> <20230126144647.6q3qlu5sqz27cmyc@bogus>
In-Reply-To: <20230126144647.6q3qlu5sqz27cmyc@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Jan 2023 09:25:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLxBAB103vgCUOwW4SkAApm6_=Ace7EFWMSDFKDzJaKpQ@mail.gmail.com>
Message-ID: <CAL_JsqLxBAB103vgCUOwW4SkAApm6_=Ace7EFWMSDFKDzJaKpQ@mail.gmail.com>
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

On Thu, Jan 26, 2023 at 8:46 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jan 26, 2023 at 09:43:44AM +0000, Cristian Marussi wrote:
> > On Wed, Jan 25, 2023 at 02:11:13PM +0000, Sudeep Holla wrote:
> > > On Wed, Jan 25, 2023 at 01:43:48PM +0000, Cristian Marussi wrote:
> > > > so now that the catch-all protocol@ patternProperty is gone in favour
> > > > of the 'protocol-node' definition and $refs, does that mean that any
> > > > current and future SCMI officially published protocol <N> has to be
> > > > added to the above explicit protocol list, even though it does not
> > > > have any special additional required property beside reg ?
> > > > (like protocol@18 above...)
> > > >
> > >
> > > If there are no consumers, should we just not add and deal with it
> > > entirely within the kernel. I know we rely today on presence of node
> > > before we initialise, but hey we have exception for system power protocol
> > > for other reasons, why not add this one too.
> > >
> > > In short we shouldn't have to add a node if there are no consumers. It
> > > was one of the topic of discussion initially when SCMI binding was added
> > > and they exist only for the consumers otherwise we don't need it as
> > > everything is discoverable from the interface.
> >
> > It is fine for me the no-consumers/no-node argument (which anyway would
> > require a few changes in the core init logic anyway to work this way...),
> > BUT is it not that ANY protocol (even future-ones) does have, potentially,
> > consumers indeed, since each protocol-node can potentially have a dedicated
> > channel and related DT channel-descriptor ? (when multiple channels are
> > allowed by the transport)
> >
> > I mean, as an example, you dont strictly need protos 0x18/0x12 nodes for
> > anything (if we patch the core init as said) UNLESS you want to dedicate
> > a channel to those protocols; so I'm just checking here if these kind of
> > scenarios will still be allowed with this binding change, or if I am
> > missing something.
>
> Ah, good point on the transport information. Yes we will need a node if
> a protocol has a dedicated transport. No one has used so far other than
> Juno perf, but we never know. We can always extended the bindings if
> needed.
>
> Sorry for missing the dedicated transport part.

So I need to add back 'protocol@.*' or not?

Rob
