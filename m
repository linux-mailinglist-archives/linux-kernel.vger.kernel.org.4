Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F31738132
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjFUKw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjFUKw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:52:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A365819A3;
        Wed, 21 Jun 2023 03:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26D76614F7;
        Wed, 21 Jun 2023 10:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1B1C433C8;
        Wed, 21 Jun 2023 10:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687344676;
        bh=ruepZViEyvLdgTSowTD3U1gw1j3qplIAbB79+lD5rkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KL3/NR7Jc6MI+J2NkKoJtlgGiREm0c2CGLgfg1SWhEiJVhx9Z9FGYmg/Jt//0Bqr7
         85WZq75h1oEdvWFu3X+3/Z4ivf+U+wj50VymF418QjzUXfYwfJymvYZN3XaEDr5te0
         f2wnaAieERcrBJ26BCmThvG0/ie424GWQddGrVwE=
Date:   Wed, 21 Jun 2023 12:51:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     emma christy <emma.t.christy@gmail.com>
Cc:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Subject: [PATCH] media: rkvdec: removed redundant blank
 line
Message-ID: <2023062136-drench-pasty-79a2@gregkh>
References: <20230621092223.10805-1-emma.t.christy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621092223.10805-1-emma.t.christy@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 12:22:23PM +0300, emma christy wrote:
> Adhere to Linux kernel coding style. Removed redundant blank line.
> Issue found by checkpatch.
> 
> Signed-off-by: emma christy <emma.t.christy@gmail.com>

You might need to write this as "Emma Christy", right?

Also, your "Subject" line has an additional [PATCH] and "Subject:" in it
somehow.

thanks,

greg k-h
