Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E983715BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjE3Kbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjE3Kbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:31:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEBDC9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96F3561452
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B97C433D2;
        Tue, 30 May 2023 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685442694;
        bh=xyF8joDwixLawKSqQb0FU3minFU7X9SzJwYpvx5aXjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YsDYCzfuopLj/FT6+68H8IxeB4bAklo7wWIQMxFzvWu3AIWDWwmldEjRlXTwjtEd6
         zAlpN10utnKUklxvXfAVw42uo4lrtKupx8/tIbNVS1afTRLEgkOZ9g+AOs8nMmYd96
         TDegtBYcnZ00DDEQBEga0p2BhbzqtFu8HipH9STI=
Date:   Tue, 30 May 2023 11:31:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Revert "serial: allow COMPILE_TEST for some drivers"
 partially
Message-ID: <2023053023-absurd-angrily-0e65@gregkh>
References: <20230518055620.29957-1-jirislaby@kernel.org>
 <8dbf6d6c-50eb-d0b0-9345-bdc266abd1f2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dbf6d6c-50eb-d0b0-9345-bdc266abd1f2@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 09:49:30AM +0200, Jiri Slaby wrote:
> Please take these fixes instead:
> https://lore.kernel.org/all/20230522082048.21216-1-herve.codina@bootlin.com/

Will do, thanks.

greg k-h
