Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A540C65DC7D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbjADTBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbjADTBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:01:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BC21B9ED
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:01:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC0F6B818B5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C653C433D2;
        Wed,  4 Jan 2023 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672858878;
        bh=2nLH32jl9VfNp+e3sCxrHKhnvOFv0oumZfB90nDYMHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQiMOahgw+gOeLIm2dxNBpgNEl7jYZhkr1PKy3x9nxiGdRt3opn8OQQfyx0n5/Q+T
         1LS0uWQDtEJOTtoGTi0/OfkSfSor6dqTk9XSVJEIU5Di5B+mL3KAq84xwvKs7mM5UF
         EHTYcbUmDgf6kUoJIpZaz80je1Qs2UFLTClXvLh7Je6cUWo6OuQkxFC97CCxJKKh/k
         gosonTTuTV25mb1XyDfYT5pPMe+w0gTWgLXr8QDhlCfDwZ7qiePUrgNhlD+1xunWd9
         aasib3OWBqs7y01YMG8Lnl84tzafgV97cvACpVG0QTIwbTX+msLlwQIADB1hm8HSA3
         SrUIW6K/eN4Jw==
Received: by pali.im (Postfix)
        id 8F80AA3A; Wed,  4 Jan 2023 20:01:15 +0100 (CET)
Date:   Wed, 4 Jan 2023 20:01:15 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <20230104190115.ceglfefco475ev6c@pali>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! This 6.2-rc1 release is breaking support for CD-RW, DVD-RW,
DVD+RW and partially also DVD-RAM medias because of pktcdvd driver
removal from the kernel in this release.

Driver is still used and userspace tools for it are part of the udftools
project, which is still under active maintenance. More people already
informed me about this "surprise".

Any comments on this? Because until now nobody answered why this
actively used driver was removed from kernel without informing anybody:
https://lore.kernel.org/lkml/20221224095353.w32xhmyzlft6qi4v@pali/
