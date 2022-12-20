Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0F56521D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiLTNy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiLTNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:54:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832521AF37;
        Tue, 20 Dec 2022 05:54:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16D016142D;
        Tue, 20 Dec 2022 13:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72381C433F2;
        Tue, 20 Dec 2022 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671544485;
        bh=51j3DYi8PZsu2ybBFHEAX2nCHXBMVEEWlcDfMcYe4e8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pU6+zDkb5cKgDWZhuAi9MjT8WLszi9Lp07cU4XVZnD+0Tg14V3BB0/q+QyaD8XTWc
         3orwrwUMh78gDLH6b5vozEXSD/EKiYXt9xBkP9D0mbI+GUmahT4wNxp6MnigbwwoNQ
         xPWk7rN0ri0YI0hUIGBiVxfNTf2GCjG/sIrA1OWR48GiXc9W9N8Y3omYn8U02Yw9k+
         qEMA0lO64KDyxB4heR7MkFBxCPRA+KUOGcQgqGZ06Zyqx4541oEqpsHVyqsd/ijVdc
         EJjAVSKOTyt0mYfUvKaf7iNGngQ8tO4EqEiREcBbV2jKwJuQdckbazPOyV4kNvImDH
         NAKmRpBo6gLBQ==
Received: by mail-vk1-f170.google.com with SMTP id r3so5755388vkq.13;
        Tue, 20 Dec 2022 05:54:45 -0800 (PST)
X-Gm-Message-State: ANoB5pmqed35NOwzQHq7GopWwSJocef2EotyntFWCvsAglr7JNMjyIah
        w1vuqamwXpg4FZ+Z+EiZAmHHdAMaOVHuyVOwjA==
X-Google-Smtp-Source: AA0mqf4CTiHHWgyBY3CrYkE5S3j+xNstE0jPZU+DdqZ/nO+EaBdB9F5/87UaaeM+5CRZufhy9UOUFvc3xxEixGezAio=
X-Received: by 2002:a1f:2c01:0:b0:3c1:1c3b:c4d9 with SMTP id
 s1-20020a1f2c01000000b003c11c3bc4d9mr3491939vks.19.1671544484430; Tue, 20 Dec
 2022 05:54:44 -0800 (PST)
MIME-Version: 1.0
References: <20221219191038.1973807-1-robh@kernel.org> <20221219191038.1973807-2-robh@kernel.org>
 <87bknya5lv.fsf@balbi.sh>
In-Reply-To: <87bknya5lv.fsf@balbi.sh>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Dec 2022 07:54:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLo4qZRTOu7UR_AN_jHNgiFZp39dsXYwWnD_njyDQfmAA@mail.gmail.com>
Message-ID: <CAL_JsqLo4qZRTOu7UR_AN_jHNgiFZp39dsXYwWnD_njyDQfmAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: usb: rockchip,dwc3: Move RK3399 to its
 own schema
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 1:37 AM Felipe Balbi <balbi@kernel.org> wrote:
>
> Rob Herring <robh@kernel.org> writes:
>
> > The rockchip,dwc3.yaml schema defines a single DWC3 node, but the RK3399
> > uses the discouraged parent wrapper node and child 'generic' DWC3 node.
>
> Why discouraged? Splitting those two separate devices (yes, they are
> separate physical modules) has greatly simplified e.g. power management
> and encapsulation of the core module.

Sometimes they are separate and that's fine, but often it's just
different clocks, resets, etc. and that's no different from every
other block. If there's wrapper registers or something clearly extra,
then I agree a wrapper parent node makes sense. Otherwise, for cases
like RK3399, I don't think it does, but we're stuck with it now.

Also, we have this pattern pretty much nowhere else and DWC3 is not special.

Rob
