Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EFA64FE16
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 09:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLRIma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 03:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiLRIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 03:42:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99AAE4B
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 00:42:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBD6D60C55
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 08:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0725CC433D2;
        Sun, 18 Dec 2022 08:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671352947;
        bh=RJRMwGNC2KkNxDOd92oyiIHJr6kFRzCBX0VaGVpYj+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tgtvvzfx0Jv3GuAy+iQyuLZB/WRdy9xi3JdZ5qjbyKpXjujlA0aaNA5G/1Gle3Gdz
         3FbtE0qYWnGHojk/Llm60NrG7yEd2fqnknRG2zUdLq/oD4q4h2fAwGtWGocE2QHd6q
         agsXpJ3Uf5YeJLizLJ/CASF3KfvC9aDp35Xj/afQ=
Date:   Sun, 18 Dec 2022 09:42:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y57ScAuGZ3PYnO7n@kroah.com>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
 <CAPDLWs_GZaL7m2YqyfRgJE_s8RaQ4fyWbJKF8iDWzWJs84SJiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDLWs_GZaL7m2YqyfRgJE_s8RaQ4fyWbJKF8iDWzWJs84SJiQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 07:14:14PM +0530, Kaiwan N Billimoria wrote:
> :-) Got it.

Sorry, but you didn't answer any of my questions, which makes it
impossible for me to answer yours as my answer depends on your answer.

Also, top-posting is bad, as you know, you just lost all the context
here :(

thanks,

greg k-h
