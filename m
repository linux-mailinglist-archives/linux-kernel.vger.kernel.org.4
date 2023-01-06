Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0313465FE14
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjAFJe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjAFJdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:33:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A5969B3E;
        Fri,  6 Jan 2023 01:25:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5F8A2CE1C69;
        Fri,  6 Jan 2023 09:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35326C433EF;
        Fri,  6 Jan 2023 09:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672997119;
        bh=QHmR1i1xKrKcwTzIjJxIvmmAPckAFiixJhZc1hmGvf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EiiXHX8Lmbn/vftAyRE5sQeXtaKaVHL9y/iY+7h8tIeWx59VwgeIXhngAYbX6p4tI
         X7ip4P4eiI74B6mtAqpedGfuAUpUhr5DNaFK1FPJPHjTw5VL2bebEwHRXaEwagMI2f
         EgS4O3t/AXl8YzX12PKVQe2crB7K3NgKSe//RWAW0fzi5em7Fs0h4Ctz68cpCryTZn
         KHIczZBmC5Z7rkuNF5BUOQfdxViHSbLl0ooURoy0a7ddh3Ca4mTVwovIpJOgpZGuNM
         DQAvcL9xrYn/V6lzTER+eTnhJUmcJAncuFzWyqSqy5E24hzktM99hTnEIY2MyrO9km
         uH+tX/jVEbfVA==
Date:   Fri, 6 Jan 2023 09:25:14 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the backlight tree
Message-ID: <Y7fo+tMnkSndJNXV@google.com>
References: <20230106113509.5c101b53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230106113509.5c101b53@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jan 2023, Stephen Rothwell wrote:

> Hi all,
> 
> The following commits are also in the backlight-fixes tree as different
> commits (but the same patches):
> 
>   44bbdb7e3a67 ("backlight: ktd253: Switch to use dev_err_probe() helper")
>   c0e09423bbb4 ("dt-bindings: backlight: qcom-wled: Add PMI8950 compatible")
>   73516cbcf8d9 ("backlight: pwm_bl: Drop support for legacy PWM probing")
> 
> Forgot to push out an updated backlight-fixes tree?

Don't think so?

88603b6dc4194 (HEAD -> refs/heads/backlight-fixes, tag: \
  refs/tags/v6.2-rc2, 					\
  refs/remotes/mfd/mfd-fixes, 				\
  refs/remotes/leds/for-leds-next, 			\
  refs/remotes/backlight/backlight-fixes, 		\
  refs/heads/mfd-fixes, 				\
  refs/heads/for-leds-next) 				\
    Linux 6.2-rc2

-- 
Lee Jones [李琼斯]
