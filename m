Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A5275075F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGLMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjGLMAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:00:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A4D1980;
        Wed, 12 Jul 2023 05:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA9876179C;
        Wed, 12 Jul 2023 12:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EBBC433C9;
        Wed, 12 Jul 2023 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689163231;
        bh=wjMYXDzi7/IsmygrOh/l0Xphf4biwgs5qAk18EMlNIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLJhtF2F09V+Nmk0gNVDr4f0z2L4WhjQy0YeMxJtsoIr/mq2PK/GuOxvpAK8iO7xy
         jKx9vwA0HuKF4AaJK2JrnhYIPAzMOynOrn2HMoDW0F77cStsy0s0b+Ofh304nfC9EO
         hRaC+AOSp4epElmgts+AaAo/51kVaQGmC2fIG+Mi/RF/w3AKDdXqTtG+ICPJcamO3B
         dG6wflpsQWAS2aNyoNurtq0j1xSVPwGX3TyFJZTzzFfv3EOY8X3vu/HO3Pf9WiQoDh
         LpMrKpmyKbHYcgB9oioeBQOQxLTazHROhB3w26utciFwdFH5KHScELS6GG38gKpINM
         VEBMXLanJJMmA==
Date:   Wed, 12 Jul 2023 13:00:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Fei Shao <fshao@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: pwm: Fix an error code
Message-ID: <20230712120026.GD10768@google.com>
References: <20230711083055.1274409-1-fshao@chromium.org>
 <CAHp75VfSL5j-ZUYkezELWzq+c_V+CFL6iVQWQ=roPYrZ=h1rSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfSL5j-ZUYkezELWzq+c_V+CFL6iVQWQ=roPYrZ=h1rSw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023, Andy Shevchenko wrote:

> On Tue, Jul 11, 2023 at 11:31 AM Fei Shao <fshao@chromium.org> wrote:
> >
> > Use the negated -EINVAL as the error code.
> 
> Thank you, it seems Dan had been the first one.
> 
> Message ID <a33b981a-b2c4-4dc2-b00a-626a090d2f11@moroto.mountain>

I don't know much about how other people operate, but I have no way to
trivially navigate to this.  Would you be kind enough to use URLs
please?

-- 
Lee Jones [李琼斯]
