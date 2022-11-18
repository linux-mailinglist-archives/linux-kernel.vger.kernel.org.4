Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0F62F82D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiKROuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241828AbiKROt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:49:59 -0500
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ECB12607;
        Fri, 18 Nov 2022 06:49:59 -0800 (PST)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id BC4AE7FD25;
        Fri, 18 Nov 2022 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1668782997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yr8fQqxOuxgfsh7aSNnZ2DOYglECy5/Eal4thUcsDrg=;
        b=SMUz7ChDot1X5TtFeHknvJ01g7SHxh3GY2WPHCNbCbPifrwZqCZWO7jJv09cn16Gs4V9M0
        2O7DUoDkVO+m+jyMRCiThIAgIPEa9dXhYT1ced9lQ8QH8VGI0Vyyb1a88awHuQQpt+S2YD
        M3XcR7B3JEJIDXXgCCYk5h22tM1bWgdT3cFxM25z3bN0rrmufMaB+fKKX2Pjbs+oW863dG
        XEQsBEubSCE9OtwQUhGV+CT5mtHo3qhmpJkwhuXZYnn9Y3xmrU9fOv1u5WySEZjpe42kT9
        MicDg1HVWZrMrd2IeupQwOjG7ALu5A4WmhWjFxfYfpi7IWWwusj+rMMR6yPSZQ==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Anastasia Belova <abelova@astralinux.ru>,
        Steve French <sfrench@samba.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] cifs: add check for returning value of SMB2_set_info_init
In-Reply-To: <20221116141027.10947-1-abelova@astralinux.ru>
References: <20221116141027.10947-1-abelova@astralinux.ru>
Date:   Fri, 18 Nov 2022 11:51:15 -0300
Message-ID: <87a64ojoyk.fsf@cjr.nz>
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

> If the returning value of SMB2_set_info_init is an error-value,
> exit the function.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 0967e5457954 ("cifs: use a compound for setting an xattr")
>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  fs/cifs/smb2ops.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
