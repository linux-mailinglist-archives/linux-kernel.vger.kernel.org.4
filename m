Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634CB65F377
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjAESJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbjAESIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:08:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B6DEE5;
        Thu,  5 Jan 2023 10:08:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BFAAB81BA9;
        Thu,  5 Jan 2023 18:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36CDC433F0;
        Thu,  5 Jan 2023 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672942124;
        bh=KWeJ/Y2HrNP/kW3nju3KAeYwi+UU7Gs5Hkp4ECFzZi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0AdBRx9jXzrCaAhxObcdUbsQHtaKw2a3A2VwKHUxmfpz7sQ5G3rQ9KCTRkWp4qwq
         Wg83Nnz1/VbmHug1lQQcSUoP+p6u2CDqJ9Yo0cJ/vSxamyd5Trcx7i8NoW8G/6Hth8
         b89FaYU59CgLFOJ0rA7dw4769QVr+7jMpcTI8sshDsGG0o1Y1txHqZKMk0GzuIzU7q
         jq/wENHz0KZSVz4i4kzhcUSK/xSgSkfXT3lPwJIOKDZReEE50y6m1Fxt8wQ//vAcD/
         I+5blsJraxyny9nVCMSw1t7Wax87KkdgWTL72IzFs4ke2D4+v15thbrt0XXQz2Qd1z
         RVdtoibXSSZhg==
Date:   Fri, 6 Jan 2023 02:08:40 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Mark Hasemeyer <markhas@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 2/3] dt-bindings: mfd: Add compatible string for UART
 support
Message-ID: <Y7cSKFIakdGKKokE@google.com>
References: <20221207104005.v10.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221207104005.v10.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
 <Y7WkeCi7/x/t37JM@google.com>
 <Y7YjmtwByTR+8tbZ@google.com>
 <Y7bdmiZ9lqKZXCfq@google.com>
 <Y7buUdgLfnQqnG+x@google.com>
 <Y7b6dC6dDNO2bVjr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7b6dC6dDNO2bVjr@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 04:27:32PM +0000, Lee Jones wrote:
> > > You should gain permission from the maintainer before you apply patches.
> > > 
> > >   % scripts/get_maintainer.pl -f Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > >      Lee Jones <lee@kernel.org> (supporter:MULTIFUNCTION DEVICES (MFD))
> > >      Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> > >      Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> > >      Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC support)
> > 
> > I see.  I guess for the case, I should get both MFD and DT bindings
> > maintainers' Acks before applying the patch.
> 
> Yes.  The situation isn't overly clear and differs from subsystem to
> subsystem and maintainer to maintainer.  In the MFD case, Rob and
> Krzysztof conduct the first reviews.  99 times out of 100, if they're
> happy, I'm happy and I merge the changes via the MFD tree.  Same goes
> for Backlight and more recently, LEDs.

I see.  Apologize for that and I will pay more attention next time when
handling cross-subsystem patches.
