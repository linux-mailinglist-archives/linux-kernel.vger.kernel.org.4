Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA865502E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiLWMPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiLWMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:15:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EB5227;
        Fri, 23 Dec 2022 04:15:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19C12B82042;
        Fri, 23 Dec 2022 12:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20006C433EF;
        Fri, 23 Dec 2022 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671797724;
        bh=3qHrdzo0yiyM+k5ftk9PiRWr0PqN2y7NcelN5zpN6yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuhgSf5JAAohkzwz/zeYz95wIN0BlJjcRRBwt7yIESfunUIFKvSJYH1Bev9NJ18h3
         D81u8v+99iaq77b8Njj0lX8apCHNJwUW8bu9bMBi4rHxs/vjZ0eSfG2eUwPTfvUuiu
         cyN8ERoppGzVYXfJlQTnI/hdLz8vaLTgUH0sgEX+Gb/SsX7oQ8Ixb0CEEDkq+Og4ag
         OgtaPW2SgwZzNUJ7QlroTrOCRgcFT4avRvR73IsmQyCVYN7Jip49OHy5NWqNMNY4rw
         /CRtqaE58Dj7GGjbvEcLEpSKfyz6fk5udLb3w+uNp0GzY3+1XnDQEqvRcEdYc5Cv6s
         HjbS0r/RKc+Rw==
Date:   Fri, 23 Dec 2022 12:15:19 +0000
From:   Lee Jones <lee@kernel.org>
To:     Joseph Strauss <jstrauss16@proton.me>
Cc:     pavel@ucw.cz, jansimon.moeller@gmx.de, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Add multicolor support to BlinkM LED driver
Message-ID: <Y6Wb1+VrutfKtGIo@google.com>
References: <20221214222428.7518-1-jstrauss16@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214222428.7518-1-jstrauss16@proton.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022, Joseph Strauss wrote:

Would you mind composing your mails such that my Key Manager doens't ask
me for a password in order to view them please?

-- 
Lee Jones [李琼斯]
