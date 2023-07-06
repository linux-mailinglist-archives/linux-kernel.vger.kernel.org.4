Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87AD749A57
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjGFLNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjGFLMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:12:55 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A6419A7;
        Thu,  6 Jul 2023 04:12:52 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1688641970; bh=xgKgNWy4nEmc+hEQwsmN7MH//WVy6dUyusJwtV1VA7U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ue/GFQ6l7jRnGGmdA/Wj2sqeZbgnF9j5fZW4CxuflsyldM1Jq6x/3mAZ93wvwQjLS
         c6U2bTDGdfUc7G5mRWOipCq5TCMB6HOW3nYEct6mkxbmnJpVojRGEF+dktWPNhtrT6
         RABYSONbBDCW1ObaQCZLX7/KoNGjnX0edws7+Pi+Evkmsc+tplyRa9MbRSKaSDNC/M
         QXmwVKiOv3sa+G0v3hzjGRfmfWaDkzfgQ5H24bzZzMJ678/i4WLzxylRrO/gO8G2Al
         Ozj2Y9nH1frBheBLiNwCzKmw5mfNw3gzl2GiAZEiHj1c56UMo1QF1Sh5/8mcnbN7Yb
         yhrP0014qKTDA==
To:     Dongliang Mu <dzm91@hust.edu.cn>, Kalle Valo <kvalo@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath9k: fix printk specifier
In-Reply-To: <20230706040214.62324-1-dzm91@hust.edu.cn>
References: <20230706040214.62324-1-dzm91@hust.edu.cn>
Date:   Thu, 06 Jul 2023 13:12:49 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87lefts37y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Smatch reports:
>
> ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
> ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer
>
> Fix it by modifying %lx to %p in printk.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v1->v2: modify %px to %p

But now the patch uses %px :)

-Toke
