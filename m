Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3846A67A1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjAXStr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjAXStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:49:45 -0500
X-Greylist: delayed 282 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 10:49:43 PST
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC37D2BF13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:49:43 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A671168B56;
        Tue, 24 Jan 2023 13:44:59 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=AvTluNuENanAf5sP6aXs8crnBcrQDFXOJ1k/i2
        sPFEE=; b=pS9mlMFBh7Z6nSTBx6O0dFvH47cGL4PYFIKO8D4hIWka6RwI+SeZ9b
        RXuDu2F+siYAhjOrbrMR/lhYo6iom0GWalBHegGGpyKMukHKQuV+GTvFeu/qslyI
        3v5fE6ZF4V1NcFR0JP9BguujELiFghMFPg/CTpKKtlGTWCxutlQHk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23102168B55;
        Tue, 24 Jan 2023 13:44:59 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=AvTluNuENanAf5sP6aXs8crnBcrQDFXOJ1k/i2sPFEE=; b=AeB4Lo1/HXvrX7/sIjesLwn9Y9N+Htr4LbV4ZtxZq3h04fbxRvOM5AFMlpTfmoewms2J110A9Yn+cGZEtTSKJin2DQu23kfRiY2ieqGLvwRGASZwzffjFWLE/MH5li9lCadTnVbp8uhU1otO7gcpcNpR40c5K3986qeeU47cKWc=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81C40168B54;
        Tue, 24 Jan 2023 13:44:58 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 751E15FE453;
        Tue, 24 Jan 2023 13:44:57 -0500 (EST)
Date:   Tue, 24 Jan 2023 13:44:57 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs: Kconfig: fix spelling & punctuation
In-Reply-To: <20230124181631.15204-1-rdunlap@infradead.org>
Message-ID: <o440q1r7-r77p-o55q-1507-ron5spo7288o@syhkavp.arg>
References: <20230124181631.15204-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 33CB5CB6-9C17-11ED-B82A-2AEEC5D8090B-78420484!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023, Randy Dunlap wrote:

> Fix spelling and hyphenation in cramfs Kconfig.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

cramfs is very low volume in terms of changes so please take this along 
with other trivias directly.

> ---
>  fs/cramfs/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/fs/cramfs/Kconfig b/fs/cramfs/Kconfig
> --- a/fs/cramfs/Kconfig
> +++ b/fs/cramfs/Kconfig
> @@ -38,7 +38,7 @@ config CRAMFS_MTD
>  	default y if !CRAMFS_BLOCKDEV
>  	help
>  	  This option allows the CramFs driver to load data directly from
> -	  a linear adressed memory range (usually non volatile memory
> +	  a linear addressed memory range (usually non-volatile memory
>  	  like flash) instead of going through the block device layer.
>  	  This saves some memory since no intermediate buffering is
>  	  necessary.
> 
