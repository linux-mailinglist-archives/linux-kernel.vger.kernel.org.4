Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3A67C306
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjAZDKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjAZDKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:10:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5CA64D88;
        Wed, 25 Jan 2023 19:10:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 227C0616D6;
        Thu, 26 Jan 2023 03:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B8FC4339B;
        Thu, 26 Jan 2023 03:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674702645;
        bh=gGU2qpf4E6IYabatWz+DP3c6588TlcC/e2M83ROhCic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MsOPlr9Rb/H/5VmKtdtdlTkUTSOQofVg6vPe8Y7Tf6Go15vD4p+eybE5/mjkeGNBz
         O3HdHHi8nXLi2hDlqfBTvnAAckGGENGcxW/L0tEsfhcfJ1gVSrlTn5fAwZi886xlrt
         82LY89HJDSDImVzsnaLIBPUcGfbVFAtE8h7hrVkncPNSuVJzP69s9g13knj1c9e0RY
         SN+dXlkoivUqq/No6iv2IJsUzj1LRqRlpNtO6gTlcdrO7axvejybEke5bMdoUUxNyi
         KW25SMXuj7bHL3ttVwYXXAMsfDms3fBSMs5/5YOq+kAlYJWupWUaMGw1X1hp9pKmst
         ZbMNMALKiJNJA==
Received: by mail-ua1-f42.google.com with SMTP id b11so93122uae.4;
        Wed, 25 Jan 2023 19:10:45 -0800 (PST)
X-Gm-Message-State: AFqh2koLoFPLTzcB68O+tnq5AhTIzLs9GDx+kcjRzST/6TgPhCQYxL+X
        ynsXPEMuq84HL02BJYJJ+wW5K58AR6myPdnYpw==
X-Google-Smtp-Source: AMrXdXsrbCxPJ7pRSKrwmGEY3aP3Gqd9JPRr21bno+D9U9+C5qfGQguRknCJYb8IskL9zBCz+i0/4LxufKgAw4323Ak=
X-Received: by 2002:ab0:e03:0:b0:617:ca9e:e9fd with SMTP id
 g3-20020ab00e03000000b00617ca9ee9fdmr3139356uak.54.1674702644462; Wed, 25 Jan
 2023 19:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20230125221416.3058051-1-robh@kernel.org> <Y9Hce2OqJOB/uiyM@nixie71>
In-Reply-To: <Y9Hce2OqJOB/uiyM@nixie71>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Jan 2023 21:10:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJACct1J2T357V6CSQWsRP1P7bFpNCmippbYf2rYdd2Rw@mail.gmail.com>
Message-ID: <CAL_JsqJACct1J2T357V6CSQWsRP1P7bFpNCmippbYf2rYdd2Rw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: input: azoteq: Fix differing types
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
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

On Wed, Jan 25, 2023 at 7:51 PM Jeff LaBundy <jeff@labundy.com> wrote:
>
> Hi Rob,
>
> On Wed, Jan 25, 2023 at 04:14:16PM -0600, Rob Herring wrote:
> > 'azoteq,ati-base' and 'azoteq,thresh' properties are defined in multiple
> > bindings, but have differing types defined. Both 'uint32' and
> > 'uint32-array' are used. Unify these to use 'uint32-array' everywhere.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Thank you for the patch. While this is a step forward in moving toward
> a common binding for this vendor like we have discussed in the past, I
> do not agree with this approach and will instead propose an alternative
> that accomplishes the same goal.
>
> For all of these devices, a single sensing channel takes a base and a
> threshold property. IQS626A is unique in that a fixed number of channels
> form a trackpad, and I decided at the time to simply define the base and
> target properties for all channels as a uint32-array.
>
> For all other existing drivers, as well as others coming down the pipe,
> base and threshold are uint32s. I find it confusing to redefine all of
> those as single-element arrays, especially on account of one device.
>
> In hindsight, a better design would have been to define a child node
> for each channel under the trackpad node, with each child node accepting
> a uint32 base and threshold. That would follow other devices, be more
> representative of the actual hardware, and keep the definitions the same
> across each binding.
>
> So, that's what I propose to do here instead. I happen to have a fix in
> review [1] that addresses a bug related to this parsing code, and would
> be happy to build this solution on top assuming it can wait until the
> next cycle. Does this compromise sound OK?

Shrug

How exactly are you going to change an existing property and not break
existing users? Or are there not any users?

We have the same properties with 2 definitions. At the end of the day,
I just want to fix that...

Rob
