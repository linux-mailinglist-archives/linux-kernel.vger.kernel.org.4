Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD855F4997
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJDTJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDTI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:08:56 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF845A2FD;
        Tue,  4 Oct 2022 12:08:55 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 6487080B8A;
        Tue,  4 Oct 2022 19:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1664910050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cvV5XO3ylK5FK1gANSWSwikc0pVYpXVdsUgPuT78aGo=;
        b=a3q3LfgY8Yo+sVRT9GjdQDSTwwwPwiqdHpRUvYQ6jJp9vJEnReR++sGUTQye6hXBl37ezf
        PinXzTjZ5dYJN1Q1Q8H6gEPDwukEZIK0+XE7wUtV1Ao0h7dpL1iNBjmbXffkMOuTMk2tiL
        wDc5sHGkNLPBrPBO2THnYC6Eq7W5rlmOeJKylEQAPIJSs3eHoE+4QfkJ1oEkVAPd3c+0J9
        qMtErMk3G4nU+a7KdlrWeM+q/h4eeTZswV0i3jLu+ySRK1T6f+M0gIyTNSPsOrxdBM0oNQ
        53zVaJ6M/3RykpuPh2NKb39YpMGbQe+AYG8e2YvfyevJ6q7DfkOwVgbqiFkbhQ==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cifs: check returned value for error
In-Reply-To: <20221004062333.416225-2-usama.anjum@collabora.com>
References: <20221004062333.416225-1-usama.anjum@collabora.com>
 <20221004062333.416225-2-usama.anjum@collabora.com>
Date:   Tue, 04 Oct 2022 16:01:40 -0300
Message-ID: <87lepv4dm3.fsf@cjr.nz>
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

Muhammad Usama Anjum <usama.anjum@collabora.com> writes:

> smb311_decode_neg_context() can return error. Its return value should be
> checked for errors.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  fs/cifs/smb2pdu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 2bf43c892ae6..c6e37352dbe1 100644

This patch doesn't apply in Steve's for-next branch[1].  If it still
makes sense, please rebase and resend.

[1] git://git.samba.org/sfrench/cifs-2.6.git
