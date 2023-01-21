Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093C5676A53
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 00:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjAUXbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 18:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAUXbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 18:31:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A620042;
        Sat, 21 Jan 2023 15:31:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B49CB80882;
        Sat, 21 Jan 2023 23:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30121C433D2;
        Sat, 21 Jan 2023 23:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674343902;
        bh=8O7krsn5wVwO+u7aYhAuGYb73mNAd3aEtYdxUn3QPYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N41fZ5QviX1oQq+7+w8t4mtnKDEhvuCtSHN4YJ0AQzD9ZHqo8j2u8DV8gen+j7CgI
         +XsPvUss63kk3QKpqGOd8OqOj3bErHGoNxeK27BuEuXayFh02fjMjzuuDC7brOlXuh
         IlF+L7xdhIG+KJhJjDf2XVB9X1Ni2Jp6GJccYbluSXcKddAPdkpOxq6/og50hRB+eu
         Qp49AvvOLEkRrW2FAoN/kYbiC7WcBWZSoaWr1BW0Gw2o0IhNdPSDQEeQnI1u7Plg1q
         BOx7ChqcaPZcypX+64GUGECPRArZ4d6y551BWkM2kEEoGfgjxBbPXIdhuXQL8aD2zX
         rVz2FEQ5tF1gg==
Date:   Sun, 22 Jan 2023 08:31:38 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yoann Congal <yoann.congal@smile.fr>
Cc:     linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Documentation: kprobetrace: Improve readability
Message-Id: <20230122083138.300ab49e15c7b3de13f0f121@kernel.org>
In-Reply-To: <20230121225304.1711635-1-yoann.congal@smile.fr>
References: <20230121225304.1711635-1-yoann.congal@smile.fr>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jan 2023 23:53:02 +0100
Yoann Congal <yoann.congal@smile.fr> wrote:

> Hi,
> 
> Version 3 of this series of small readability fixes on kprobetrace.rst.
> 
> v1: https://lore.kernel.org/linux-doc/20220915153358.813993-1-yoann.congal@smile.fr/

Thanks for fixing document!

This series looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for this series.

Thank you!

> 
> Changelog 
> v3 -> v2:
> * fix 2 bytes hex -> 2 byte hex typo
> 
> v1 -> v2:
> * Removed all ``markup`` additions
> * Split commits
> 
> Regards,
> 
> Yoann Congal (3):Yipeng Zou <zouyipeng@huawei.com>
>   Documentation: kprobetrace: Fix some typos
>   Documentation: kprobetrace: Fix code block markup
>   Documentation: kprobetrace: Split paragraphs
> 
>  Documentation/trace/kprobetrace.rst | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
