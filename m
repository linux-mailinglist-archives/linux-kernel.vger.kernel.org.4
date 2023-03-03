Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFB66AA593
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCCXZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCCXZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:25:08 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B45F52B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:25:06 -0800 (PST)
Date:   Fri, 3 Mar 2023 23:25:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677885903;
        bh=ag/eH9YRbFJvItUbxOwLD8EmFE89rLxL3Qgb7rJNvDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UyRHaufx2PKXy+XlMlaI5sTrTukLAD6nNx2ghzBzmz6BwqPlBDV7vnuT6LVtqum1/
         HdGJbNVPTaAGGtnXwwB+Aqx1qna4BmYqNnwTeJOXW7KzdFDNs0MKXyh0J9bLXa2Q0a
         yk3AGelfPLfhhPnrRMhgL9UWAF+oIBbyhlXyNAtc=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Storm Dragon <stormdragon2976@gmail.com>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Message-ID: <ce24d06b-7967-4b50-8913-ad42717e4c05@t-8ch.de>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
 <Y/OacHw6nL/ZtrH3@hotmail.com>
 <00e5aee7-c7b3-4077-8c9f-4f28ec220567@t-8ch.de>
 <ZAJqrfcfoM2eO5VL@mjollnir>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAJqrfcfoM2eO5VL@mjollnir>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 04:46:21PM -0500, Storm Dragon wrote:
> On Fri, Mar 03, 2023 at 09:12:50PM +0000, Thomas Weißschuh wrote:
> > Sorry for the long delay, but this should be fixed in the current round
> > of stable kernels. Can you try the following:
> > 
> > pacman -U https://mirrors.edge.kernel.org/archlinux/testing/os/x86_64/linux-6.2.2.arch1-1-x86_64.pkg.tar.zst
> > 
> > Thomas
> 
> I have installed the package above. My screen reader is behaving much
> better now. Interestingly, however, trying to cat the /dev/vcs device
> still shows the following:
>
> cat: /dev/vcs: No such device or address
> 
> cat: /dev/vcsa: No such device or address
> 
> cat: /dev/vcsa1: No such device or address
> 
> Is this expected behavior?

No it isn't. 

Is this reliably reproducible? I doesn't happen on my side.
Maybe you can provide more detailed reproduction steps.

Just to be sure; did you reboot into the new kernel?

Does this mean the screenreader now works correctly or is it still
broken somehow?

Thomas
