Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02EE65B823
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjABXTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjABXTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:19:07 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE93B7E0;
        Mon,  2 Jan 2023 15:19:06 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 33A596D6;
        Mon,  2 Jan 2023 23:19:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 33A596D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672701546; bh=bH7mapEMF0TExSY//IudvrOhQrVeRP0HTaS3ckzrGpQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Kq633BJmkhGz4waKQi0PTtaXPO1JCgGXN2M1is6UHhYemHXmo934FToLbF2uE4p46
         6WYb79T1G8H1Q05caobWEwzqRs3exaiTzyRwuqDP51kkuYs7N/PpWiNNd7Xn61F5/h
         Jeu/uHUW+FvSCimjvQOHpc/a2O4R+7MCHbRdGrhuEqlB6d1+ExCLjlQuQTomR5d13l
         EZqNXlSF5JV4o8G8uIXMB/XgiOe3602+HLjCyd8F6pSuQgWD9PTPyL0tTRwJp3Xdl0
         UTQWC31qr9Vf4puiyTYN9+/zUkiEggSt/vRR/5nPJ1rXkkeuMspD0hRmaKx94fnywo
         NWJwBCUgP09rA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: admin: move OOO entries in
 kernel-parameters.txt
In-Reply-To: <20221204013050.11496-1-rdunlap@infradead.org>
References: <20221204013050.11496-1-rdunlap@infradead.org>
Date:   Mon, 02 Jan 2023 16:19:05 -0700
Message-ID: <87zgb0h6dy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Fix the most blatant out-of-order entries in kernel-parameters.txt.
>
> No changes other than modifying the order of the entries.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
> Do not backport.
>
>  Documentation/admin-guide/kernel-parameters.txt |  122 +++++++-------
>  1 file changed, 61 insertions(+), 61 deletions(-)

Applied - better late than never...

Thanks,

jon
