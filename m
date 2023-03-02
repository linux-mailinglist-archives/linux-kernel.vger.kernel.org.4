Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C586A85D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCBQHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCBQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:07:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E66E51F8D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3E7615E6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 16:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AE8C433D2;
        Thu,  2 Mar 2023 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677773249;
        bh=nxkadWvFrgekWnWaByNPgJdkpKjK3dgnKN1qdEfhPls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5CEmP5rKBy7ivKN3jEibNATOkqeOIiYY0ZCY/0k8uRNkRQsZlCrHKozj6CJ32a3M
         K9Y7yVShgZNF2BheS0KAI6U8CJsODayvqYzQxRxlXjUfzfgoKwLrMfz/yK4PaC8i2A
         v++Rm85GQ82SaR+2Cxzjm/krSaZFbyxzf6kWYTrh/QpK1dlIhmSpzfQj5SCW16kQTW
         4dFIY6VKyerxo9F48YECQO4SQFTrxe8pWfVc+QqqBHsBGBOcHYLiNZ72yAvmztuRZH
         gqsmASZo1g8cLoj07rb7OwONdQKOo4joY3gG7VRSLPD/dQch/3DON11Wv21Ihw3RmW
         8tAM6YRfLg9Jw==
Date:   Thu, 2 Mar 2023 16:07:25 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     linux-kernel@vger.kernel.org, liuyun01@kylinos.cn
Subject: Re: [PATCH] mfd: si476x-cmd: fix codespell
Message-ID: <ZADJvSPfpmiB3hBO@google.com>
References: <20230206032231.3208296-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230206032231.3208296-1-liu.yun@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023, Jackie Liu wrote:

> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> Fix some typo, find by 'codespell drivers/mfd/si476x-cmd.c'
> 
> succsess -> success
> interace -> interface
> comand   -> command
> failre   -> failure
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  drivers/mfd/si476x-cmd.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
