Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2393C67B895
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjAYRau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbjAYRas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:30:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10A437573;
        Wed, 25 Jan 2023 09:30:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95F2D6159C;
        Wed, 25 Jan 2023 17:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06045C4339C;
        Wed, 25 Jan 2023 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674667837;
        bh=doO5B7lVAEUM4IZ60baaHsFh7f5V2tq0ZYza3D65Lpk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kWE3AN6tbPb7c+n/nTbhk/PlOIyEndZGB9vYOts3hGoTV30wQj49MvudqcM0qok1o
         OIN2uNK/dviBas0fvUe4sZ3ht1bl5WqpUAsyd+CPHwzlK0Shtd2wNcDtGGWqdL+wJR
         8GmWTQ37JmHQCshCjNSsWAizxu/EjsfcYgtcoyHVvf5u9lyHcybuIivTCzycjLwHoD
         unNLaXYGGQoOrXL2HYmxrRaw9meyRU6Lq+Hd3wO1FEvGzH9bv/JbWb7I7AL11NDB1i
         BosqYYqdBt61+xYmMqJhXOo1Nv0cQh0zQ4793mM/UHR7c0KbE4p4jddIhmI3DwU2wx
         4n4lAMt+EQ0CA==
Received: by mail-vs1-f45.google.com with SMTP id k4so20477666vsc.4;
        Wed, 25 Jan 2023 09:30:36 -0800 (PST)
X-Gm-Message-State: AO0yUKVKKk6Em1rH8OygHClywbRVbj5eiT0683ncFvXLh51/Gd+tYCfZ
        HDFuwu1EMqZ86iWx/PMGM2idwoJYhtMfgGJ7iw==
X-Google-Smtp-Source: AK7set+1oK/DUMFfhX8xs4Oazj4O0yxp2K04oiLSaHoBwKIZJJpMkvGK98H2tuPZIysvuISWwVghNg0L89SfNiN4fos=
X-Received: by 2002:a67:fe41:0:b0:3ea:c8c:48a5 with SMTP id
 m1-20020a67fe41000000b003ea0c8c48a5mr99015vsr.53.1674667835932; Wed, 25 Jan
 2023 09:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20230124222023.316089-1-robh@kernel.org> <Y9EyB+OO7MyGy20w@e120937-lin>
 <20230125141113.kkbowopusikuogx6@bogus>
In-Reply-To: <20230125141113.kkbowopusikuogx6@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Jan 2023 11:30:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2DbC88kEb-r=6WxJ=m+v3UO9n6h_HKkQNoAAW6h-hWA@mail.gmail.com>
Message-ID: <CAL_JsqJ2DbC88kEb-r=6WxJ=m+v3UO9n6h_HKkQNoAAW6h-hWA@mail.gmail.com>
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

On Wed, Jan 25, 2023 at 8:11 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jan 25, 2023 at 01:43:48PM +0000, Cristian Marussi wrote:
> > so now that the catch-all protocol@ patternProperty is gone in favour
> > of the 'protocol-node' definition and $refs, does that mean that any
> > current and future SCMI officially published protocol <N> has to be
> > added to the above explicit protocol list, even though it does not
> > have any special additional required property beside reg ?
> > (like protocol@18 above...)
> >
>
> If there are no consumers, should we just not add and deal with it
> entirely within the kernel. I know we rely today on presence of node
> before we initialise, but hey we have exception for system power protocol
> for other reasons, why not add this one too.
>
> In short we shouldn't have to add a node if there are no consumers. It
> was one of the topic of discussion initially when SCMI binding was added
> and they exist only for the consumers otherwise we don't need it as
> everything is discoverable from the interface.

As you might guess, I agree.

We need to keep 0x18 I suppose, right? I assume it is already in use.
Are there any others that didn't get documented? We'd need to keep
them because old kernels would still need them.

Rob
