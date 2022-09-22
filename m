Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4B55E64D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiIVONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiIVOMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ECAF3105;
        Thu, 22 Sep 2022 07:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18F91634D5;
        Thu, 22 Sep 2022 14:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73E7C433C1;
        Thu, 22 Sep 2022 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663855954;
        bh=Xb4aKt4yRKii/ZJsTP4k75RDysJecWdTr3F2rUxcCIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5IcslA4SCgY7Kb2fTZO7lPli/MFFNZurd/TJkl80n3dUGNYKuwAI3o1L3AqTD9gK
         3ICU3cjuwY+ePo4pttqkoirLB1xNc4snbHMWT8Ow+2vZvGtzCHGaIOM1mbsBNH1VJi
         KAI7j/y8RVZMg9nOgZMIdIDAwnIFcWhhvsF8Ldy0=
Date:   Thu, 22 Sep 2022 16:12:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: Re: [PATCH 1/5] tty: remove TTY_MAGIC
Message-ID: <YyxtTxyHJMVZiqBi@kroah.com>
References: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 03:54:59AM +0200, наб wrote:
> According to Greg, in the context of magic numbers as defined in
> magic-number.rst, "the tty layer should not need this and I'll gladly
> take patches"
> 
> Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> Whole series: amd64 allyesconfig builds; amd64 Debian config boots and
> appears to work; naturally, the HVC stuff is S/390 only, but it's a
> constant offset

Many thanks for this cleanup, now queued up.

greg k-h
