Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B525662F832
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbiKROuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241997AbiKROuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:50:20 -0500
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751CB903B1;
        Fri, 18 Nov 2022 06:50:14 -0800 (PST)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 58D2A7FD25;
        Fri, 18 Nov 2022 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1668783013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/rePAaj+Om/SnbzekquTM/6DwN9lHDTUpeQeQgkp3dc=;
        b=ALBdruPCG8kg8CYj1aspn86VITy01IRFclshjVb2AwcDl8G1yzf4K5Al5ZT9tY/bLaEOSI
        QsMHqTCpnef89BxB9MMnSY/wCPcrIvjcjZ5mJA8LKIvl6KxgNX7xPS0qv/ppW8FPu7/tx4
        eCJz6Qib+sZYvXRMc4qBPho+BTcxdi2fdvtlmWDxwFr76oz/tOzM+/wEl7iVU0TUuAvcAS
        y37bI7Ut0k3jwPo5FGYoCaeNY3CP6r0OmiZfq2faMsDntPF8BEGakXmwuxMKILpFwPA/kD
        NHSeR/x3vn1v7ocZstjtUz52mhlyjyIOK6vcILJwqyxMGV6b6OrE8YS19P4CsA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Anastasia Belova <abelova@astralinux.ru>,
        Steve French <sfrench@samba.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Aurelien Aptel <aaptel@suse.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] cifs: add check for returning value of SMB2_close_init
In-Reply-To: <20221115142701.27074-1-abelova@astralinux.ru>
References: <20221115142701.27074-1-abelova@astralinux.ru>
Date:   Fri, 18 Nov 2022 11:51:31 -0300
Message-ID: <877czsjoy4.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anastasia Belova <abelova@astralinux.ru> writes:

> If the returning value of SMB2_close_init is an error-value, 
> exit the function.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 352d96f3acc6 ("cifs: multichannel: move channel selection above transport layer")
>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  fs/cifs/smb2ops.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
