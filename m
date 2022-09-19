Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DD5BD4EC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiISSvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiISSu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:50:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B9A474F9;
        Mon, 19 Sep 2022 11:50:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C93221F8F9;
        Mon, 19 Sep 2022 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663613454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wkWuCzKb9bPAoZh8TMHUdjbSwVJQ0FdQlwmfCmRG1vc=;
        b=h5wubktu/QPdcSkVL99adscgeG965muOWbLrXvXw4Glv2agSheRDxG/TcyVQ3ugB6Agdd2
        xKDFI2Tj7M5etZiGWGWqkd0CQpAn0CPVCfNTZ3NXH6XQr+GKsb61oodkHcTSxGMMNRtZ1M
        h14h+0egskkBIG2x6f+uD15xEv+6TRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663613454;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wkWuCzKb9bPAoZh8TMHUdjbSwVJQ0FdQlwmfCmRG1vc=;
        b=csVEK7bVJPDp7SL9ilGGcmxLenSrtm647UCLdnmC4NCogf7ZEk+lpHXQEbI2p4WcxZC9Aj
        5llEGQf+1gXYPjBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCB0913ABD;
        Mon, 19 Sep 2022 18:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SNYHLg66KGPaSAAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 19 Sep 2022 18:50:54 +0000
Date:   Mon, 19 Sep 2022 20:50:54 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Arun Easi <aeasi@marvell.com>
Cc:     Ren Zhijie <renzhijie2@huawei.com>, njavali@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, himanshu.madhani@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [EXT] [PATCH v2 -next] scsi: qla2xxx: Fix build error
 implicit-function-declaration
Message-ID: <20220919185054.bjjsdplthy7alozo@carbon.lan>
References: <20220919133404.85425-1-renzhijie2@huawei.com>
 <dfc510ef-a181-3832-f16c-74f1d7fb5608@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc510ef-a181-3832-f16c-74f1d7fb5608@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 10:54:24AM -0700, Arun Easi wrote:
> NAK.
> 
> Please see these threads for a fix in "trace.h" to address this issue and 
> a related discussion.
> 
> Most recent (v3) patch posting:
> https://lore.kernel.org/linux-scsi/20220907233308.4153-2-aeasi@marvell.com/
> 
> Steve suggesting to take the patch via SCSI tree:
> https://lore.kernel.org/linux-scsi/20220906174140.41b46a5f@gandalf.local.home/
> 
> Hoping this would get a nod soon and can get merged.

Ah indeed. Forgot about this one. I thought this is on top of the above
fix. Note, many folks were attending the Plumbers hence they might still
be traveling.
