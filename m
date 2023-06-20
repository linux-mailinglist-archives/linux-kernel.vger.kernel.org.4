Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622C8736AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjFTL2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjFTL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:28:18 -0400
X-Greylist: delayed 70798 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jun 2023 04:28:07 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E06FE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:28:07 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 83030E8012D;
        Tue, 20 Jun 2023 13:28:05 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 1F86C160075; Tue, 20 Jun 2023 13:28:04 +0200 (CEST)
Date:   Tue, 20 Jun 2023 13:28:04 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, graf@amazon.de, xmarcalx@amazon.co.uk
Subject: Re: [PATCH 1/1] vmgenid: emit uevent when VMGENID updates
Message-ID: <ZJGNREN4tLzQXOJr@gardel-login>
References: <20230531095119.11202-1-bchalios@amazon.es>
 <20230531095119.11202-2-bchalios@amazon.es>
 <CAHmME9pVLD-U+iYfv7=HBufRtaSkBmCRpKLH8pbvPNkgozE3cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pVLD-U+iYfv7=HBufRtaSkBmCRpKLH8pbvPNkgozE3cg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 19.06.23 22:30, Jason A. Donenfeld (Jason@zx2c4.com) wrote:

> Like the other patch, and as discussed before too, I don't think this
> has any business being part of (virtual) hardware drivers, and instead
> belongs in random.c, which might receive these notifications from a
> variety of devices, and can thus synchronize things accordingly.
> Please stop posting more of these same approaches. Same nack as the
> other ones.

Note the intended usecase for this in userspace really has nothing to
do with RNGs. We just want an event that is generated when a machine
is duplicated so that we can request a new DHCP lease, and similar. I
don't see any relationship to random.c for that.

Lennart

--
Lennart Poettering, Berlin
