Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028585FD95A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJMMlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJMMlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:41:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09353FAA75;
        Thu, 13 Oct 2022 05:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABD5DB81D03;
        Thu, 13 Oct 2022 12:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E54AC433D7;
        Thu, 13 Oct 2022 12:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1665664907;
        bh=L7vHRu7Nfct33Mg/nqV/XIIpj1W0hvwJ6tQQTzTRzyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RJWOITw4K2qJhKX6Xa49FVgHfvn8ku69xrqRCtYRYoP7/AsS6o+GYObljl4KLMXEK
         pWgTbd5Im8z/BuumZGM79OngzUBAXuHN8TQnFZEcWTGlUZLUnlOnZKNhjvzkg8t1kl
         uMyGGB8vBQKndChGKbi4j+K45M77BL9LZ7hWZffA=
Date:   Thu, 13 Oct 2022 05:41:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mm-stable
 tree
Message-Id: <20221013054146.a3aea05afd20303f91a3c8fa@linux-foundation.org>
In-Reply-To: <Y0eXYYG4FXbdNbYO@google.com>
References: <20221013104234.11e88852@canb.auug.org.au>
        <Y0eXYYG4FXbdNbYO@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 04:43:13 +0000 Carlos Llamas <cmllamas@google.com> wrote:

> Sorry this was my fault as I used a three-dash line to comment a code
> section in the commit message. Which instead just cuts the commit log
> short when applying the patch. Sigh.
> 
> You can see this in the original post:
> https://lkml.kernel.org/r/20220930003844.1210987-1-cmllamas@google.com
> 
> I believe Andrew noticed this error and fixed the patch.

Partially fixed :(

>  However, the
> Signed-off-by tag probably got dropped in the process. I'm unsure if
> this can be amended in the mm tree?

I have fixed it up, thanks.
