Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39C86E967B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjDTOAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjDTOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:00:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6724B61A8;
        Thu, 20 Apr 2023 07:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFA4C60B8D;
        Thu, 20 Apr 2023 14:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5153C4339B;
        Thu, 20 Apr 2023 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681999218;
        bh=65k7doVH3SaHC6RwPm/kmxL5Qia06u75ugTrJ/+Kj2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1D+CNzFAveKuoDma3AcWYDYS0Fr2rujDp1LSBfjdGuHkMSkBeDZQqC6A6EznW2Ae
         riuItMHwa6y432te7bWQijt7IH2jzyeMa3REjo7F9pRt3ZNleOcL4FpYuXHzzMkXDR
         lSaPhRNtqhN0Tqkog+aryGtV1LgV8LuaBt2TZ91uIXPczgNHaF6+7VLuHKj5xQmLEW
         v98GfkL5bH71I6wdTc+y3vwmR6AjNwcjsn86TB8xS8ljPZ9Pp93zG17aIUTptgeLQu
         BR9wM490eACQPgz/hF8+rnA7LvrNWxkEKItF6MseJNKWvfyXvQ/+io0kBfo96aGnkJ
         Shz+l6sMm6jXA==
Date:   Thu, 20 Apr 2023 15:00:13 +0100
From:   Lee Jones <lee@kernel.org>
To:     Alexander Dahl <ada@thorsis.com>
Cc:     linux-doc@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Pavel Machek <pavel@ucw.cz>,
        Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH] docs: leds: ledtrig-oneshot: Fix spelling mistake
Message-ID: <20230420140013.GF996918@google.com>
References: <20230418113402.188391-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418113402.188391-1-ada@thorsis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023, Alexander Dahl wrote:

> It's no comparision, but a "first this, then that" situation.

"comparison"  :)

> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  Documentation/leds/ledtrig-oneshot.rst | 2 +-
"  1 file changed, 1 insertion(+), 1 deletion(-)

I fixed your spelling mistake in the commit fixing a spelling mistake.

Applied, thanks

-- 
Lee Jones [李琼斯]
