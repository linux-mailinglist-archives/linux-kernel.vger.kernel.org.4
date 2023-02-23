Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADF76A0C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjBWOxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:53:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F8642BC2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:53:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD87B20C72;
        Thu, 23 Feb 2023 14:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677164016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZnAibGvBZUSdsRc+gyHZnZ2bjXIXW7E6CZE7QOc2dg=;
        b=CDfi/ohnQ776UwyVwUBB5aQ89c0SxndO+pxiJ+a+aOLJiybXanMh53TeZhKfdnAvlUr+x+
        GO+4J241QlNOfd6CkqagGU7m5oidihZjQNwbHukrX3kHi9zRAadBgkKq6rHdYRlnLtCSIx
        pKhF6OKjR08OtUII2AF5UPwlGTPLx0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677164016;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZnAibGvBZUSdsRc+gyHZnZ2bjXIXW7E6CZE7QOc2dg=;
        b=h/bQGKLIS6HIZoZOJbApvOgIJp/gawOmzdMmNLawyYXFRHhBcguWWACSWPb3JHNqg67CF7
        Y/pZI+ctvdb1K2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E557139B5;
        Thu, 23 Feb 2023 14:53:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o6WYJvB992PzKQAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 23 Feb 2023 14:53:36 +0000
Date:   Thu, 23 Feb 2023 15:53:36 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Ivan Rubinov <linuxkernelpatch8234@riseup.net>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Message-ID: <20230223145336.lulowpv3vlr65lwu@carbon.lan>
References: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
 <4b824085a2f4987f4682e3602a0e1a96@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b824085a2f4987f4682e3602a0e1a96@riseup.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 01:28:42PM +0000, Ivan Rubinov wrote:
> Ivan Rubinov писал(а) 2023-02-10 15:10:
> > From 5a8f4f54c85ccb8e06b41b27bcaf19ec4f4d7c85 Mon Sep 17 00:00:00 2001
> > From: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
> > Date: Fri, 10 Feb 2023 14:59:41 +0300
> > Subject: [PATCH] Add quirk for ADATA SX6000PNP
> > 
> > Signed-off-by: Ivan Rubinov <linuxkernelpatch8234@riseup.net>

Can you post the output of 'nvme id-ctrl' for your two devices?
Because the ones in

  https://bugzilla.opensuse.org/show_bug.cgi?id=1207827

clearly have clearly different subnqn.

Although, I have to admint they look suspicious but they are not the same:

subnqn    : nqn.2018-05.com.example:nvme:nvm-subsystem-OUI00E04C2K2129Q696LA
subnqn    : nqn.2018-05.com.example:nvme:nvm-subsystem-OUI00E04C2J4120007707
