Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F89B65D813
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbjADQKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbjADQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:10:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F82E39F9D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:10:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA2D61798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 16:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C620C433F1;
        Wed,  4 Jan 2023 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672848624;
        bh=Bdld+TnKB7WLHBZtlI1+JQyAatjFrzv4FM/6Iffn3tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgaN9Xfj5diNx6ma1YE77y0RNY9RH+CmEXSH6hCKQwIyKEq4cOGDVFivFgL3FmMw4
         hoMhAhw1r5ZzNW0QlEy2DXaACID9Ea2a13xUEO4an7UEqF62N47jX8P0cecajkBlyZ
         upPWShHaNF1GBCOCx5sqx1Yj0AXPQcmyeGTmyq2p9VifiYrwrKsk2Ucqc6RnzFyfwZ
         quOUB3fK4AYgsvX/c13YLaW70IMW1EWqEeDLicbR5pNgvrcZwcVfWciWldcw8VrDAj
         QWMho7+M97CaDLbIKGMH8RfGLgCvn3ehtdsqOTNANTbQltoFQv31yLzFiKO6zeAlui
         2tiptVxXyUUlQ==
Date:   Wed, 4 Jan 2023 16:10:18 +0000
From:   Lee Jones <lee@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: Move MFD from a Supported to Maintaied
 state
Message-ID: <Y7Wk6uruiXpjkq3Q@google.com>
References: <20221206105038.124613-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221206105038.124613-1-lee@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022, Lee Jones wrote:

> No one is funding MFD maintenance.
> 
>   S: *Status*, one of the following:
>      Supported:   Someone is actually paid to look after this.
>      Maintained:  Someone actually looks after it.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
