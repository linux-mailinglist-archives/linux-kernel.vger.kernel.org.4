Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CE073A28F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjFVOBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjFVOBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:01:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF27E2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E1686185A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 14:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BF1C433C0;
        Thu, 22 Jun 2023 14:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687442462;
        bh=z7/NrKf78pVSzF93LgcyirSWoE1Vw6K1NkBXiHs5xRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJC+7VJggnkd3EEuT1MK/6WJwYkZgMsImkwXts+v+Fhn5a8CMPGLfzuMPw3DOtyiM
         gwy5303hHEZJdq3j/GbVehgeLtuBfhYOX2wdPwRciNkkUL+L/hzQB4CWNM4tlAejts
         sLz042m0txbVQpvnTYt0NJSRS2E5P5T4MBt2vu0I+QKFOLO9ZRFH1o96WAMQE22eHk
         GtdOU1/MDGMUMorZ2II7lhFfDDrijX7lPqNCsUYoM1gz6AnuRMCc3qTu+odYOm/+5e
         iKxnVgzAVmhEXuaZ1l1BDrA0ZO/43227vo9VmHe0snLH8H/b1LPaUAqJVCp475du4i
         ihfHjyP+XBp9g==
Date:   Thu, 22 Jun 2023 15:00:58 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: ipaq-micro: Use %*ph for printing hexdump of
 a small buffer
Message-ID: <20230622140058.GW10378@google.com>
References: <20230612212007.3621-1-andriy.shevchenko@linux.intel.com>
 <20230621171040.GK10378@google.com>
 <ZJQ/L7+hpCLi7grQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJQ/L7+hpCLi7grQ@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023, Andy Shevchenko wrote:

> On Wed, Jun 21, 2023 at 06:10:40PM +0100, Lee Jones wrote:
> > On Tue, 13 Jun 2023, Andy Shevchenko wrote:
> > 
> > > The kernel already has a helper to print a hexdump of a small
> > > buffer via pointer extension. Use that instead of open coded
> > > variant.
> > 
> > That's not all you're doing is it?
> > 
> > Nice try.  2 patches please.
> 
> I'm not sure it's possible to split to two clean patches that don't overlap
> each other like by 70%. Can you elaborate a bit more on your vision on this?

What does the 'break' have to do with changing print format?

-- 
Lee Jones [李琼斯]
