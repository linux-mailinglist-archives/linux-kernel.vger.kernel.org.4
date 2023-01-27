Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F287967EDDC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjA0Swx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjA0Swt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:52:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164C693E3;
        Fri, 27 Jan 2023 10:52:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CDCD61D76;
        Fri, 27 Jan 2023 18:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7F0C4339B;
        Fri, 27 Jan 2023 18:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674845565;
        bh=aaeD/Iv61VLaubRgkw80QFOlkFRzfjZ5atgB6/ZKe+M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nYmGuQivs18Aojqsk+6aXLqnYonFBgyOMQI2/Jf78q4dRIJ97QDQ+W4py6OdzqE3m
         W5wGhxFlVwmVRAkzhkLjP9R4Ybz3GeFfKyAiMkYzsIJvLZx1SEf8ynA9roo1ZzI+bK
         R/sOq5X/ofMR3tRjik8XQNIW327PMBghyNOapDrTY1nM3IURby9AJdN0RUNFPKesF7
         NxZBu+0WC8WurHzF5PeKouJnMmrZ+NtgE7mwB+ysc2UIU7O6MjtbSdHD0Dl1+Jzml3
         k3ixmpLGRpJ9lg52l4yubbtvz5jX+e27mJTdtYzGqrv3VhrkhGg1QEOe88VHrrFYDF
         ZTD85Mq9KWp4Q==
Received: by mail-vk1-f171.google.com with SMTP id i38so2503101vkd.0;
        Fri, 27 Jan 2023 10:52:45 -0800 (PST)
X-Gm-Message-State: AO0yUKUq0IO5AVgXYM/KtoxEWrJwsNQiiDMnEgBPitc5o9RpqsYAv2cQ
        4FSXTZ0oSl0NXRpxf763VT0S38XWbkWj05L0Wg==
X-Google-Smtp-Source: AK7set/OwHob1WkuyP0d3ylYLvHWRkDREVbAn0kxjp9VXZ/sWUmmMKiZ6od5N9SoHcIJOj9xdGDIFLLljtBB5v8Cv8Q=
X-Received: by 2002:a1f:f8cf:0:b0:3e8:551c:46f with SMTP id
 w198-20020a1ff8cf000000b003e8551c046fmr860203vkh.19.1674845564666; Fri, 27
 Jan 2023 10:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20230124222023.316089-1-robh@kernel.org> <Y9EyB+OO7MyGy20w@e120937-lin>
 <20230125141113.kkbowopusikuogx6@bogus> <Y9JLUIioxFPn4BS0@e120937-lin>
 <20230126144647.6q3qlu5sqz27cmyc@bogus> <CAL_JsqLxBAB103vgCUOwW4SkAApm6_=Ace7EFWMSDFKDzJaKpQ@mail.gmail.com>
 <20230126170412.4ytcky6a7lnll6it@bogus>
In-Reply-To: <20230126170412.4ytcky6a7lnll6it@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 27 Jan 2023 12:52:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJcrmf2fYVC0TnNY_MZvajJxqXPdVFwLf9MZ2XO=VZ1Lw@mail.gmail.com>
Message-ID: <CAL_JsqJcrmf2fYVC0TnNY_MZvajJxqXPdVFwLf9MZ2XO=VZ1Lw@mail.gmail.com>
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

On Thu, Jan 26, 2023 at 11:04 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jan 26, 2023 at 09:25:12AM -0600, Rob Herring wrote:
> > On Thu, Jan 26, 2023 at 8:46 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Jan 26, 2023 at 09:43:44AM +0000, Cristian Marussi wrote:
> > > > On Wed, Jan 25, 2023 at 02:11:13PM +0000, Sudeep Holla wrote:
> > > > > On Wed, Jan 25, 2023 at 01:43:48PM +0000, Cristian Marussi wrote:
> > > > > > so now that the catch-all protocol@ patternProperty is gone in favour
> > > > > > of the 'protocol-node' definition and $refs, does that mean that any
> > > > > > current and future SCMI officially published protocol <N> has to be
> > > > > > added to the above explicit protocol list, even though it does not
> > > > > > have any special additional required property beside reg ?
> > > > > > (like protocol@18 above...)
> > > > > >
> > > > >
> > > > > If there are no consumers, should we just not add and deal with it
> > > > > entirely within the kernel. I know we rely today on presence of node
> > > > > before we initialise, but hey we have exception for system power protocol
> > > > > for other reasons, why not add this one too.
> > > > >
> > > > > In short we shouldn't have to add a node if there are no consumers. It
> > > > > was one of the topic of discussion initially when SCMI binding was added
> > > > > and they exist only for the consumers otherwise we don't need it as
> > > > > everything is discoverable from the interface.
> > > >
> > > > It is fine for me the no-consumers/no-node argument (which anyway would
> > > > require a few changes in the core init logic anyway to work this way...),
> > > > BUT is it not that ANY protocol (even future-ones) does have, potentially,
> > > > consumers indeed, since each protocol-node can potentially have a dedicated
> > > > channel and related DT channel-descriptor ? (when multiple channels are
> > > > allowed by the transport)
> > > >
> > > > I mean, as an example, you dont strictly need protos 0x18/0x12 nodes for
> > > > anything (if we patch the core init as said) UNLESS you want to dedicate
> > > > a channel to those protocols; so I'm just checking here if these kind of
> > > > scenarios will still be allowed with this binding change, or if I am
> > > > missing something.
> > >
> > > Ah, good point on the transport information. Yes we will need a node if
> > > a protocol has a dedicated transport. No one has used so far other than
> > > Juno perf, but we never know. We can always extended the bindings if
> > > needed.
> > >
> > > Sorry for missing the dedicated transport part.
> >
> > So I need to add back 'protocol@.*' or not?
>
> IMO it is better to know what exactly gets added under each of these protocol
> sub-nodes and so better to have entry specific to each known protocols. I
> liked that fact with this change as I have seen some crazy vendor extensions
> adding all sorts of non-sense defining some vendor protocol. For example [1],
> in which case we can catch those better than existing schema which matches
> all. So let's not add protocol@.* if possible or until that becomes the only
> cleaner way to maintain this.

TBC, 'protocol@.*' would not allow anything but the properties defined
in the /$defs/protocol-node. So [1] would throw errors without a
schema addition.

We should either do that along with dropping 'protocol@18' or we keep
protocol 0x18 node and add all other providerless protocols. I don't
think we need the latter to just check unit-address vs. reg. I want to
come up with a better way to do that (dtc does some, but only for
defined bus types).

Rob
