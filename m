Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9A268B114
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 18:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBERRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 12:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBERRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 12:17:11 -0500
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3601ADF7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 09:17:09 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 0DA775F820;
        Sun,  5 Feb 2023 18:17:06 +0100 (CET)
Date:   Sun, 5 Feb 2023 18:17:05 +0100 (CET)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: External USB disks not recognized with v6.1.8 when using Xen
In-Reply-To: <Y9+tDmLAlqg37TS+@zn.tnic>
Message-ID: <8f0f9275-be8e-1155-d06f-240cd33a8702@nerdbynature.de>
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de> <f22551ea-0694-2838-4a3f-f60d8d93fa64@leemhuis.info> <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de> <0f441adb-f565-7a37-d9e5-3b14f6f7aea6@suse.com> <f02c49da-0377-97b9-9438-9e0ddbfbcc6d@nerdbynature.de>
 <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com> <Y9+tDmLAlqg37TS+@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2023, Borislav Petkov wrote:
> See below. I think it should be this way but I might be missing an
> angle...

Thanks for taking a stab at this, Borislav. With this applied to v6.2-rc6 
(and 90b926e68f50 still reverted), the machine boots just fine, no new 
errors and the USB disks show up just fine and appear to be usable. If 
this ends up the final fix for this, feel free to add my Tested-by to the 
same.

Thanks again,
Christian.
-- 
BOFH excuse #176:

vapors from evaporating sticky-note adhesives
