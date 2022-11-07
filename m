Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0443E61ECF6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiKGIcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiKGIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:32:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F55B14030
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:32:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E063360F2D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4556DC433C1;
        Mon,  7 Nov 2022 08:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667809921;
        bh=E2CAmNWc1i/lldUC81pYDu25n01lOqzSyUn9jSOWOuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IyriKM544ca1GornZx99FSgYcxtzLNfRelwBFTNXwJFtrKzxo1fwBkDSKld8QkaK7
         NV9ogS0TcVdx7u59S32PPX2DAOQ4yfK01EuPaz/wf+HPOSBRRLaleGbuSlDGS5nWO7
         Fu3zXSQGk/IVb/OB6Qq1GyjTBQ/zNxzugkGe3OShGMswZk3da5u6nr1yCMhD1w4mj3
         xdJXK7LjZFhfblNTVCVWaCgzpKlCSGqOl80k4OV41vWvD16xSYzjz7kGTBBF2xg4YS
         T0Zi+kuSFwg474FqyDZ+4eI1an3cY3zC4o/EAWn2TV62kODSroi0Ar94OpjhyzHje3
         I6WtnH9v2aXHg==
Date:   Mon, 7 Nov 2022 08:31:57 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: mc13xxx-spi: Fix typo ("transfert")
Message-ID: <Y2jCfVxIaOCvmONN@google.com>
References: <20221101165045.1017822-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101165045.1017822-1-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Nov 2022, Jonathan Neuschäfer wrote:

> That spelling is only correct in French :-)
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  drivers/mfd/mc13xxx-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
