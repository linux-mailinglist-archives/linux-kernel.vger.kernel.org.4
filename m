Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D48D65E250
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjAEBLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjAEBLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:11:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0770933D6F;
        Wed,  4 Jan 2023 17:10:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 870C8617E1;
        Thu,  5 Jan 2023 01:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2922DC433EF;
        Thu,  5 Jan 2023 01:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672881055;
        bh=UBsrnEBCMbR8iYQ08Ki2111e79mLrTvpC7LsomYwPus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVvU+veFZ+mUTx9G8sT4xCBNbpikF5NlRi5S+caJEMnKTvAhHU3QUKR1qK9pqROlh
         KOhx/6GOqm+clkf5W3VTipsPs6TYBM1ZeTMiRGiXXR3h/sWuLztLpUMGkP6FGgNPhf
         IV20uiw5nc902MpY4R+P+yy6GT8CetsSOQKo8F+8TEfrLhReNrI26JfWNV63g/ekZf
         0sTBej+l/kJLeNDnmTz7/52la9n3PC7xzrzLetGnPxYLxiqPze6VAQsWirNxlicNiP
         BNWNPLegWacEyCt8/+yBPJb5ylg+I/BVQfCKB829lgY/XSkJcA95Q0H8ltGyMoCpt4
         sefkje4zsLHew==
Date:   Thu, 5 Jan 2023 09:10:50 +0800
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
Message-ID: <Y7YjmtwByTR+8tbZ@google.com>
References: <20221207104005.v10.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221207104005.v10.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
 <Y7WkeCi7/x/t37JM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7WkeCi7/x/t37JM@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 04:08:24PM +0000, Lee Jones wrote:
> On Wed, 07 Dec 2022, Mark Hasemeyer wrote:
> 
> > From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> > 
> > Add a compatible string to support the UART implementation of the cros
> > ec interface. The driver does not support the reg and interrupt
> > properties, so exempt them from being required for UART compatible nodes.
> > 
> > Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> > Co-developed-by: Mark Hasemeyer <markhas@chromium.org>
> > Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > 
> > Changes in v10:
> > - No change
> > 
[...]
> 
> I changed the subject line and applied the patch, thanks.

Pardon me.  I didn't know you would pick the patch so that I have queued it
into chrome-platform[1].  Would you like me to drop the commit?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/commit/?h=for-next&id=5be8cd61dcddfaee5d92072073672037154e76f5
