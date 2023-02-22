Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7729B69F949
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjBVQsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjBVQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:48:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4C940CE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:48:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 83F013429F;
        Wed, 22 Feb 2023 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677084529;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pdF6HozEruLwiwlS6ezjutM09pV5+PLeOJjU6NoJxD8=;
        b=Fy/nu60XdLy0vTztouBzlStgMP/GCOhzcGljwPNr3mxUUIADPnpLXvRWT1o8g3R/T07Ud8
        Vh84GluEn3Zh2RNatmLoEDudpcSUeZ6NR3+hneWv8W6tNM0qnk1e99Fjqnrzjr8euchKzS
        HwzAypho2DGtfdpqCwftT00GNnGcvqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677084529;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pdF6HozEruLwiwlS6ezjutM09pV5+PLeOJjU6NoJxD8=;
        b=ektmtblbTQVf97FjdMtc6hcW9xs38UT1Xm7w1pIRI40l+1gpMUuXg+15iy5Z5W7lZvAUFZ
        hplVfmuAcGwcF3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DB69133E0;
        Wed, 22 Feb 2023 16:48:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C0IUFnFH9mOsWAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 22 Feb 2023 16:48:49 +0000
Date:   Wed, 22 Feb 2023 17:42:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/2] tty: ipwireless: move Kconfig entry to tty
Message-ID: <20230222164253.GV10580@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230222092302.6348-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222092302.6348-1-jirislaby@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 10:23:01AM +0100, Jiri Slaby (SUSE) wrote:
> The ipwireless' Kconfig entry is currently sitting in char/pcmcia. But
> the driver is in tty/. So move the entry to tty/ too.
> 
> First, it makes sense to have the entry along the driver. Second, whole
> char/pcmcia is about to pass away.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>

Acked-by: David Sterba <dsterba@suse.com>
