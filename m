Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45253710036
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjEXVya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEXVy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF9095;
        Wed, 24 May 2023 14:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6116260B20;
        Wed, 24 May 2023 21:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5168EC433D2;
        Wed, 24 May 2023 21:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684965266;
        bh=F88GJ6vAwpF7GaNRxrTGbI4XIS1F/cwKB4bP/M/sqPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nm34SmeRRRuboq2DXC8KAsXOk5fBetJUa8L40dIfrTBG6JNZVc177pxEFd3g/4lHt
         W3H3KUpBSHEbX7a7lS/4gqi+NcoHgYZUgSexLbljemKvn6YyHGyKgCCzfsidsd90ma
         uVVsHKKP/+MC9lwtJVvLr+jUjrmZu9yUhcaa5IlchON1wWrJJJUNk9g7D3k9W8mHKa
         crn0j3rSqC4t4CzXdoI24ItziojE5XpUaIE1M4Ezi4U8NjNMIGwnuGo8N2LlgmRGOh
         k1b2ImKC7HtZkH2nxEgu4S6nHyh8pKmuXqeDqna33zX325Hj0FDqQbPNTk7cfqQno5
         9W7o6/PPQhDAQ==
Date:   Wed, 24 May 2023 22:54:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        bcm-kernel-feedback-list@broadcom.com, justinpopo6@gmail.com,
        f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, opendmb@gmail.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, simon.horman@corigine.com,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH net-next v4 2/6] dt-bindings: net: Brcm ASP 2.0 Ethernet
 controller
Message-ID: <20230524-fountain-icing-eceec8fe6c96@spud>
References: <1684878827-40672-1-git-send-email-justin.chen@broadcom.com>
 <1684878827-40672-3-git-send-email-justin.chen@broadcom.com>
 <20230523-unfailing-twisting-9cb092b14f6f@spud>
 <CALSSxFYMm5NYw41ERr1Ah-bejDgf9EdJd1dGNL9_sKVVmrpg3g@mail.gmail.com>
 <20230524-scientist-enviable-7bfff99431cc@wendy>
 <20230524-resample-dingbat-8a9f09ba76a5@wendy>
 <CALSSxFabgO-YTQ-nzki6h+Y=n3SfzgC4giJk8BySgCErK6zrmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CALSSxFabgO-YTQ-nzki6h+Y=n3SfzgC4giJk8BySgCErK6zrmw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 02:47:59PM -0700, Justin Chen wrote:
> On Tue, May 23, 2023 at 11:56=E2=80=AFPM Conor Dooley <conor.dooley@micro=
chip.com> wrote:

> Gotcha. I got something like this now.
>=20
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - brcm,bcm74165-asp
>           - const: brcm,asp-v2.1
>       - items:
>           - enum:
>               - brcm,bcm72165-asp
>           - const: brcm,asp-v2.0

Yes, this is what I had in mind.

> Apologies, still getting used to this yaml stuff. Starting to make a
> bit more sense to me now.

No worries.

> > > valid fallback for "brcm,asp-v2.1"?
> > > The oneOf: also becomes redundant since you only have one items:.
> > >
> > > > Will submit a v5 tomorrow.
> > >
> > > BTW, when you do, could you use the address listed in MAINTAINERS rat=
her
> > > than the one you used for this version?
> > >
> I changed the address listed in MAINTAINERS from the previous versions
> of this patchset. The current version should match the address that
> this patch set was sent from. Looks like I forgot to add a changelog
> for that in v4.

Hmm, I must not have been clear. You sent it to <conor@kernel.org> and I
was hoping that you would use <conor+dt@kernel.org> instead so that you
end up hitting the right mail filters :) It's not a problem, I was just
added to it in -rc1 so get_maintainer.pl probably didn't spit my name
out for your original revision.

Thanks,
Conor.
