Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B3D626E1D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 08:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbiKMHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 02:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMHi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 02:38:27 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52FB85
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 23:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1668325092; bh=/gqu1lsWyTjcfCcPlDZtf0bO+X7rcloTRYdvV60b/js=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=F6j3S/v+ZrbH1u2ep8mmyhsuXJbjKU90OlBPoCbXD7QETQdxQyEoKS25ASxiB+Yxx
         veeKmmQ2EDrdZ3A1ehTBZG5YTejc7slf6nR3cl2sHueKtNBGe6QBqcrldeb3YLXkIn
         iv8hAzdXBXq8gWVV7mL9FoRn+ZKOUhcdv4KWr25E=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 13 Nov 2022 08:38:12 +0100 (CET)
X-EA-Auth: Pzg4gb5ovajsndCtuD3467EUPzyaWs80Yp+bfsZep4qberlSPWrmpI3lxe9viaQ0qdL+22fwfib7RcSfIlDxFp46GjhvThYV
Date:   Sun, 13 Nov 2022 13:08:09 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging/wlan-ng query: convert to flexible array member
Message-ID: <Y3Ce4TochNsaiT6J@qemulion>
References: <Y2px+zOGjkpGh6qC@qemulion>
 <Y3CPx0IFf1la7Zy0@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3CPx0IFf1la7Zy0@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 12:33:43AM -0600, Gustavo A. R. Silva wrote:
> On Tue, Nov 08, 2022 at 08:42:59PM +0530, Deepak R Varma wrote:
> >
> > Can you please suggest how should I approach correcting the zero element flex
> > array implementation here? Can these structs be removed if they are unused?
>
> You can try using DECLARE_FLEX_ARRAY(). See this[1] patch.

Thank you very much for the quick reply. The link you provided is very helpful.
I will review it in detail and correct my patch proposal accordingly.

ps: Also. thank you for including the cc list. I has already made a lot of noise
with on the lists, so did not copy them intentionally in my email to you.

./drv

>
> --
> Gustavo
>
> [1] https://git.kernel.org/linus/6e4a53ee7989c8a2b9fc3b14cd90f6e2d613ca76
>


