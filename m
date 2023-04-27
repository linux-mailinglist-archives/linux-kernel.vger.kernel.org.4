Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5CC6F09C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbjD0QWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244318AbjD0QW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:22:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73CA4494;
        Thu, 27 Apr 2023 09:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63C0A631B5;
        Thu, 27 Apr 2023 16:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060FCC433D2;
        Thu, 27 Apr 2023 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682612541;
        bh=NoC/metQtWxNwH0RosbcVrJNpcQq74+J/8p742KjPbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ByACusj3r6+++FnuK3u3nUrdfts8io0ExE9wtpf/gAkvoqsg6OCeMgjZxQthXepX/
         OAOIoMLodUPtiz9i9GPdhwqHck/61yT4YHGIzZyQKvpoeQUzq0L8+esJJ2t9Buu7dM
         RZJPcQbK3JPo6Ko0ZuaDcZ3hfqNGehi5Jxu1EWi4KWXe2/H3iB54cIZXs1oSuZqHE4
         MSXoklDQeSomJOmMgRxlcEPMGzP2sKgdq9a02uVmwCR8Kco0CPVjFtFRFxBmopojWK
         xcpLY3ugbnyeOuECZbRIrDxCE2LO67mgKfl8ZVs7pIkom1mOeRKo6uIYICRF02VQdE
         tZehBWygtJwqQ==
Date:   Thu, 27 Apr 2023 17:22:17 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: dln2: Remove the unneeded include <linux/i2c.h>
Message-ID: <20230427162217.GE50521@google.com>
References: <baf28e7f0fb57e918b76eaa92b94a2ae1a02cce0.1682318879.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <baf28e7f0fb57e918b76eaa92b94a2ae1a02cce0.1682318879.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023, Christophe JAILLET wrote:

> This driver does not use i2c, so there is no point in including
> <linux/i2c.h>
> 
> Remove it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/mfd/dln2.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
