Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA773C3C8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjFWWIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjFWWIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:08:32 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5401739;
        Fri, 23 Jun 2023 15:08:32 -0700 (PDT)
Message-ID: <56200b7e7f5a8852869814ff1f9f0fa7.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1687558109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tiY6seF1Cj834PsEkvde+98dbGnHtQYeTBKK+mvVmLo=;
        b=mKM5w6+sTDptDrxZ1a5xHvJG/R+G3R1MCbuJyrlKqQ006K4/KVxlahine5g4MJqu6ov6NR
        wXdpXr+sNXzU8vAPfpr6AXcOnInO7lzhKTksa214YXdHvkWst1vWnXOWLVX8BPNWjlez3j
        V+ioRGJlzQH/wW5piJEmJPSQDMBVWs1+Kgo16BLEQdJkDj4Qiz5LkuKxaxrl293MHuHvdo
        lli0NUHJE77DPvKAWleiqVH05urmTlQFlLvHhqqcEncVsw4HryKui2WiHD3F7QDF/t8KvL
        iOI2qPU5P9gw+e6mY3MmBLkwSF4P7dz+tv4/N0pdYX4dnpFbps/FJByvLlFs+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1687558109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tiY6seF1Cj834PsEkvde+98dbGnHtQYeTBKK+mvVmLo=;
        b=NKku6EEST9xPwFhlgtVm2321CRN84eUn9ujTiJGSN5gC+lzUNCLqwyjyZohtTDI9773N6X
        g6Fsk2WB/CtepRIc7wu00Dm+MLyrqqZH1MUvF3IWwc6LYmC8ocbUVCHbeATVtV/BmiShIT
        xQPEDoYky5Ae56dBvEf5BfX7LA3UipcofXbUUvquSR8WmOZxcgrW2rdKIxwyzYgezQaV1n
        ntHGq8L7IQAE/6XXKSxKMTDwkS7XRTsDtz3jPCg2v+pRp35i6jWqIDbM7KLghMOrzd7AUi
        zhvbrNYRNGmFio2gsqV5TJVIzZkISdOsv1rb7BWQdUs+I1qwCZkquBF3yjtfgA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1687558109; a=rsa-sha256;
        cv=none;
        b=Vj11e3ltI00XP1GCyYK2woQXJ8pfRzxOP1P/vIVuprT5Oou64ZTohk45xnAcw7ahXE/Z+S
        +r6u8iZDyvS9T4DwuuTB10xVbNS6tnu84zFpOf8MM4uiX01Y+m0OrlLHdXbUz67LNPEKl+
        Rs591Fc34dh7S/sciJ/tSC7X1LMdrwfH6iOxug2WLUD0Dln+BHIfgDS0t4Yca2ukJCNote
        KxGiZbYQ3kx1p+HGvsk1gDrtKE1iqV1700MOBUoG/Zoh3Dbhbr+grCRNksI16lHFzuPefo
        K+GeJx8fiAS0I00FrTnXaRvqx5159n6mGdRz8i6LzlZNMZt7MdcFLXxbxbS1zA==
From:   Paulo Alcantara <pc@manguebit.com>
To:     Rishabh Bhatnagar <risbhat@amazon.com>, gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, Rishabh Bhatnagar <risbhat@amazon.com>
Subject: Re: [PATCH 5.4 0/5] CIFS DFS fixes for 5.4
In-Reply-To: <20230623213406.5596-1-risbhat@amazon.com>
References: <20230623213406.5596-1-risbhat@amazon.com>
Date:   Fri, 23 Jun 2023 19:08:22 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rishabh Bhatnagar <risbhat@amazon.com> writes:

> We are seeing deadlock in cifs code while updating volume in
> cifs_reconnect. There are few fixes available in stable trees
> already. This series backports some patches back to 5.4 stable.
>
>  __schedule+0x268/0x6e0
>  schedule+0x2f/0xa0
>  schedule_preempt_disabled+0xa/0x10
>  __mutex_lock.isra.7+0x20b/0x470
>  ? dfs_cache_update_vol+0x45/0x2a0 [cifs]
>  dfs_cache_update_vol+0x45/0x2a0 [cifs]
>  cifs_reconnect+0x6f2/0xef0 [cifs]
>  cifs_handle_standard+0x18d/0x1b0 [cifs]
>  cifs_demultiplex_thread+0xa5c/0xc90 [cifs]
>  ? cifs_handle_standard+0x1b0/0x1b0 [cifs]
>
> Paulo Alcantara (SUSE) (5):
>   cifs: Clean up DFS referral cache
>   cifs: Get rid of kstrdup_const()'d paths
>   cifs: Introduce helpers for finding TCP connection
>   cifs: Merge is_path_valid() into get_normalized_path()
>   cifs: Fix potential deadlock when updating vol in cifs_reconnect()
>
>  fs/cifs/dfs_cache.c | 701 +++++++++++++++++++++++---------------------
>  1 file changed, 372 insertions(+), 329 deletions(-)

Looks good, thanks.
