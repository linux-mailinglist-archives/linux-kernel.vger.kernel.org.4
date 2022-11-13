Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7736E626DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 07:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiKMGeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 01:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMGeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 01:34:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01598DFA3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 22:34:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9346FB80B24
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 06:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8FAC433C1;
        Sun, 13 Nov 2022 06:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668321240;
        bh=hzl62ZDmVbJ9+az2Dx/Rrye4SlLQXn5fe4FKPuII4B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCVkSdlRWBGYkQarFJSz2VtSYO4wP3johKo4djqoXVsV7VWmst9XwEjLbq6zATbLk
         9NpHF9kcD5TQeBPbNrKQKhhdTHs8mS6zKJgt+lIIDJYZ6VaRVLfLzc9mgCMyxfJHQa
         5ETKGrY3eTZJ4uVr+zmfTG5kodj1x1FqFouuciMduxZRHF/IcONG+PC7ZBHBiJUkfs
         yF+ItYiD47gPq8IXPxNLDOhnm6nvpWlPMnWjdmcjLNiGPKtt9PJb572iJsHABQIB0F
         5leQhF9FNAw3J0YR5ndn6NoE2WhtVZqq8Dd9yGvfF5p7lfVRqNc8xYCKwdKSGvMo39
         KySxbYd6MiBGQ==
Date:   Sun, 13 Nov 2022 00:33:43 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging/wlan-ng query: convert to flexible array member
Message-ID: <Y3CPx0IFf1la7Zy0@work>
References: <Y2px+zOGjkpGh6qC@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2px+zOGjkpGh6qC@qemulion>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 08:42:59PM +0530, Deepak R Varma wrote:
> 
> Can you please suggest how should I approach correcting the zero element flex
> array implementation here? Can these structs be removed if they are unused?

You can try using DECLARE_FLEX_ARRAY(). See this[1] patch.

--
Gustavo

[1] https://git.kernel.org/linus/6e4a53ee7989c8a2b9fc3b14cd90f6e2d613ca76
