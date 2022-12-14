Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15164C919
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbiLNMf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbiLNMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:35:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5398D87;
        Wed, 14 Dec 2022 04:33:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F38A61A15;
        Wed, 14 Dec 2022 12:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC89C433F0;
        Wed, 14 Dec 2022 12:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671021204;
        bh=kilFp2yc3DIasNHlydYkUnoYPRF+M5uLfa1wLSF8qT8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gY4qlG5MnMWqWXmXoAiSIDjXCoDhU/4dc7TOSLCIIqgcFqN+RJZH2bm+cYAKKC3lX
         yPHlMKQe0ohoEmQNYzbDUbHazPtMekhzz0eYC94SuWcmHoAgxGeIB+Q8fQ2sNUirRc
         mYTDfSU9R5r09cZyH7y1WA5YrMCJ0/1A4p+WEI4IY20o1inZ/AuSMd9bw+Kl/jqe5I
         KNOm/5bvm2uoTcrM870QdXMu+h40oCSjA93rOfeHItTtfDyH/7+jAh4PyfN1hMxWb/
         juqRniYwcHDgOafY48G7fwuZVzOVlzWaITRkGDNZjEcA44nDkIs1JvLhm7cSGL15nr
         cHX+4lcWEx+Ng==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: ti: remove obsolete lines in the Makefile
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221209095937.17773-1-lukas.bulwahn@gmail.com>
References: <20221209095937.17773-1-lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167102119784.11672.15846198769228364630.kvalo@kernel.org>
Date:   Wed, 14 Dec 2022 12:33:23 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 06463f6e98df ("wifi: wl1251: drop support for platform data")
> removes TI WiLink platform data, but leaves some dead lines in the
> Makefile.
> 
> Remove these obsolete lines in the Makefile.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch applied to wireless.git, thanks.

01258b62c627 wifi: ti: remove obsolete lines in the Makefile

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221209095937.17773-1-lukas.bulwahn@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

