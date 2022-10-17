Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F86601B08
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJQVKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiJQVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:09:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4C21D32A;
        Mon, 17 Oct 2022 14:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBF53611EF;
        Mon, 17 Oct 2022 21:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B54AC433D6;
        Mon, 17 Oct 2022 21:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666040989;
        bh=nhxavo8RpMYLFsWqg39tCn8fm9MCY9/SKFHfqalsN6M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Kmf2LSpuHihQpDKiEGVHoQ17A9lCtTmwjD/7xULJ8dd+qQqnSb9VhigC7j74E9F/p
         3SR0Fx0pZ8BFrgjiN9M6M6zyG56p3rCv4mWS9DCgFTmNQfY8GZ0nmrYbqDsiN0XOiX
         sqTT9iQXjK70eCRygmESup9OUyvnhxXp+ywhzBhe2PnVFJ7JEEefKH9Imqy5U92R81
         g2qwxfpcG7Kf8P8SyFyNOo8u2dm68gO8GYsYcs5MsLlctlMG/0EZhlxby8Ixn8Wsu4
         SS0tobJiMuv5PRoE3+fbALiQJUN/14cj1b7j2LQIaJsD4AvGWntGFHX9wAZ559IHWK
         Mt9j+vahB/Z4g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220823033414.198525-1-seanga2@gmail.com>
References: <20220823033414.198525-1-seanga2@gmail.com>
Subject: Re: [RESEND PATCH] clk: ls1c: Fix PLL rate calculation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Yang Ling <gnaygnil@gmail.com>, linux-kernel@vger.kernel.org,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Du Huanpeng <dhu@hodcarrier.org>,
        Sean Anderson <seanga2@gmail.com>
To:     Sean Anderson <seanga2@gmail.com>, linux-clk@vger.kernel.org,
        linux-mips@vger.kernel.org
Date:   Mon, 17 Oct 2022 14:09:47 -0700
User-Agent: alot/0.10
Message-Id: <20221017210949.1B54AC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sean Anderson (2022-08-22 20:34:14)
> While reviewing Dhu's patch adding ls1c300 clock support to U-Boot [1], I
> noticed the following calculation, which is copied from
> drivers/clk/loongson1/clk-loongson1c.c:
>=20

Nobody has provided a review for this patch. If it is still important,
please resend. Thanks.
