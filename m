Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE9C69F97D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjBVRD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjBVRDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:03:54 -0500
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Feb 2023 09:03:50 PST
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B2739CF1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:03:50 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D075D200061;
        Wed, 22 Feb 2023 16:56:01 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 93A5880684; Wed, 22 Feb 2023 17:55:30 +0100 (CET)
Date:   Wed, 22 Feb 2023 17:55:30 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Hyunwoo Kim <imv4bel@gmail.com>,
        Harald Welte <laforge@gnumonks.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] char: pcmcia: remove all the drivers
Message-ID: <Y/ZJAoTGbj2uwtXC@owl.dominikbrodowski.net>
References: <20230222092302.6348-1-jirislaby@kernel.org>
 <20230222092302.6348-2-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222092302.6348-2-jirislaby@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Feb 22, 2023 at 10:23:02AM +0100 schrieb Jiri Slaby (SUSE):
> These char PCMCIA drivers are buggy[1] and receive only minimal care. It
> was concluded[2], that we should try to remove most pcmcia drivers
> completely. Let's start with these char broken one.
> 
> Note that I also removed a UAPI header: include/uapi/linux/cm4000_cs.h.
> I found only coccinelle tests mentioning some ioctl constants from that
> file. But they are not actually used. Anyway, should someone complain,
> we may reintroduce the header (or its parts).
> 
> [1] https://lore.kernel.org/all/f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com/
> [2] https://lore.kernel.org/all/c5b39544-a4fb-4796-a046-0b9be9853787@app.fastmail.com/
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks
	Dominik
