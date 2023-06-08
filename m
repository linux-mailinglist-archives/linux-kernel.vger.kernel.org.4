Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D147289CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjFHVAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbjFHVAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:00:19 -0400
X-Greylist: delayed 344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Jun 2023 14:00:17 PDT
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9DAE61;
        Thu,  8 Jun 2023 14:00:17 -0700 (PDT)
Message-ID: <a664029640828958e152e9a4c11c4b9a.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1686257671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yugc47XhE4TEXrwH5C7vyMDJJHrlVFt40w7KU/PJ/TE=;
        b=GPHoIsc9HOLN9ekZ/lB29IAezz2ZRK7IzZVsNJlbKJytUsqpNdL+QEyg7GvPOmDEcVyR6V
        a10C/Io+PqX7/XHYVrS+t+zAtGyLF2BoVwYWiwn7ro0damxvI8kO/EgC0mIVzAsmT6RybC
        g11SWgP/+LKcDnvV8tv5MG4GuVT6oF5fxeDxG3PVmRL9PQAuRQu/Mla6NO4vXfPexw9dJl
        rUhGDXanSnKSlqfTXz2ajpbuDW7T43Q/g93ZqoJxlvTQN3/9+EmTr0WnbwYbjQanl6YajQ
        CX9baayflBJMeBE7WXN9Bsk/WfTlZ5KoeMwz8/Nix/SqvsAfoOhmk+1L+6EpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1686257671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yugc47XhE4TEXrwH5C7vyMDJJHrlVFt40w7KU/PJ/TE=;
        b=Ola0AhVztQVlxiW8QnBqIgeEsz7JXIzZ9AxPumI6JNANd4+xCT9LcaM05JadYO2aLcAWrT
        uSTDIPU8J1WMv5ydZcWgu1I/KKhsvXj8/eCte0FBpcHReypA/7dOiK/CLYwW+lrPJdQPaQ
        UVytvu0+SnkizGCov1YCk9ymKVIvpgs9x7PUWCBxMHRgbQBnbDTCN+Ti25RAUNFbprkOCc
        WpwK5Wvgp2v0n9KjN3zGJqd63VhdJDiIW1dlyXdAvxTNl6HAM9T4XXZC6SnA64arx9f03+
        fArfQSEufBMWOXlY2iyQHiim/Py4rknDiRifq0Wrw4VSGzdIkfRSZ0mbr/hxIg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1686257671; a=rsa-sha256;
        cv=none;
        b=mJrjHVb1G3xHgnChtFJ8tFhmt7gEcAXrzPlCzB6bigME2q52vJ3yXD+FtgpI4B1ni00V0I
        LZ5j180bD7wjc7BYJkvbmmwvOJXpzljkQdm5O7AHo7Ek5Masob7aM2QyO8VgTScBxQhmVZ
        hkYR068kbz2BwaabirwShxzhKSx0Iau9ABxQagpzLZxvwYlyWUNrRM6yoUWsdUPdPU8doU
        mYl0lECpi2nU/ihL3Svl5de1EdgTnigJBZsm8vTAjETI1owD9esysngHwOcWfjejbqQSb2
        5H2+9SdmpluLXURDDb494BxwwtJ0ubTCEnMP/nYEEuhrutyOnOwtI1TEBc56ag==
From:   Paulo Alcantara <pc@manguebit.com>
To:     Rishabh Bhatnagar <risbhat@amazon.com>, gregkh@linuxfoundation.org
Cc:     sfrench@amazon.com, stable@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishabh Bhatnagar <risbhat@amazon.com>
Subject: Re: [PATCH v2 5.4 0/2] Backport few dfs related fixes to cifs
In-Reply-To: <20230607203333.26669-1-risbhat@amazon.com>
References: <20230607203333.26669-1-risbhat@amazon.com>
Date:   Thu, 08 Jun 2023 17:54:26 -0300
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

Rishabh Bhatnagar <risbhat@amazon.com> writes:

> Recently we have been seeing kernel panic in cifs_reconnect function
> while accessing tgt_list. Looks like tgt_list is not initialized
> correctly. There are fixes already present in 5.10 and later trees.
> Backporting them to 5.4
>
>  CIFS VFS: \\172.30.1.14 cifs_reconnect: no target servers for DFS
>  failover
>  BUG: unable to handle page fault for address: fffffffffffffff8
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 260e067 P4D 260e067 PUD 2610067 PMD 0
>  Oops: 0000 [#1] SMP PTI
>  RIP: 0010:cifs_reconnect+0x51d/0xef0 [cifs]
>  RSP: 0018:ffffc90000693da0 EFLAGS: 00010282
>  RAX: fffffffffffffff8 RBX: ffff8887fa63b800 RCX: fffffffffffffff8
>  Call Trace:
>  cifs_handle_standard+0x18d/0x1b0 [cifs]
>  cifs_demultiplex_thread+0xa5c/0xc90 [cifs]
>  kthread+0x113/0x130
>
> Paulo Alcantara (2):
>   cifs: get rid of unused parameter in reconn_setup_dfs_targets()
>   cifs: handle empty list of targets in cifs_reconnect()
>
>  fs/cifs/connect.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Looks good.
