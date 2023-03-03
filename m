Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF906AA0E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjCCVNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjCCVM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:12:59 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B760F8A67
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 13:12:57 -0800 (PST)
Date:   Fri, 3 Mar 2023 21:12:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677877975;
        bh=VeQmXoevSEHeXLXwDSjkxV2KAA8j5T4nsyFAOkqBhqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYp+r/Bd562Afswv24ysDhPTFDHM4E2htQjbYLVccigmHdhdwD1otbtY527vxq/Yj
         ckg76yVAVjHbr6VsQ1VSa7cW/CBix+P+KFvwXIItVnIZkT+HqYCbBjDacg0TQxRpIs
         l4lK64pHfS2XmRo3BbfCepgq8ORfq5J9sXdSFJUA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Storm Dragon <stormdragon2976@gmail.com>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Message-ID: <00e5aee7-c7b3-4077-8c9f-4f28ec220567@t-8ch.de>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
 <Y/OacHw6nL/ZtrH3@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/OacHw6nL/ZtrH3@hotmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:06:08AM -0500, Storm Dragon wrote:
> On Mon, Feb 20, 2023 at 06:46:12AM +0000, linux@weissschuh.net wrote:
> > From: Thomas Weißschuh <linux@weissschuh.net>
> > 
> > @Storm Could you validate this patch?
> 
> 
> I am willing to test, but I have almost no experience doing anything
> with the kernel other than upgrading it from time to time. Can you send
> me some instructions for testing this?

Sorry for the long delay, but this should be fixed in the current round
of stable kernels. Can you try the following:

pacman -U https://mirrors.edge.kernel.org/archlinux/testing/os/x86_64/linux-6.2.2.arch1-1-x86_64.pkg.tar.zst

Thomas
