Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90D95F4562
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJDOXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:23:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA7930F6B;
        Tue,  4 Oct 2022 07:23:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08A432198D;
        Tue,  4 Oct 2022 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664893389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5gUUNgEDhizGEpFxKtQMBGFV8uYs1I5bUDwiFyCdJPs=;
        b=Zt/OhUS5ydTQ9UGifRGK41t6GwEwC9hWteg+uA6BanmdxcmrHSUmnRwaax6muvmAzKKREl
        HvCVf6R1AOho0RNxtGGq8BX7drQ5X+U22DhcXFne3NLKWdoz22LRBr9nP61FvgBdh/CnD2
        lrLR8nF+sDF1Wgk/6b85JyPAcKbmAGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664893389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5gUUNgEDhizGEpFxKtQMBGFV8uYs1I5bUDwiFyCdJPs=;
        b=nnwkZhu5TLtAve4z+S1eE5DR29Ezv4gT6tG61WizYluhc4rs1VB3OA9gmZrHP6yk89nLJM
        fz5UHGvz5kGnMFBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80A1D139EF;
        Tue,  4 Oct 2022 14:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ds5VEcxBPGPpdAAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 04 Oct 2022 14:23:08 +0000
Date:   Tue, 4 Oct 2022 11:23:06 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cifs: remove initialization value
Message-ID: <20221004142306.ysgh45nhgdo4z3ok@suse.de>
References: <20221004062333.416225-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221004062333.416225-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Usama,

On 10/04, Muhammad Usama Anjum wrote:
>Don't initialize the rc as its value is being overwritten before its
>use.

Being bitten by an unitialized variable bug as recent as 2 days ago, I'd
say this is a step backwards from the "best practices" POV.

>Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>---
> fs/cifs/smb2pdu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
>index 0600f0a07628..2bf43c892ae6 100644
>--- a/fs/cifs/smb2pdu.c
>+++ b/fs/cifs/smb2pdu.c
>@@ -879,7 +879,7 @@ SMB2_negotiate(const unsigned int xid,
> 	struct smb2_negotiate_rsp *rsp;
> 	struct kvec iov[1];
> 	struct kvec rsp_iov;
>-	int rc = 0;
>+	int rc;
> 	int resp_buftype;
> 	int blob_offset, blob_length;
> 	char *security_blob;
>-- 
>2.30.2

Cheers,

Enzo
