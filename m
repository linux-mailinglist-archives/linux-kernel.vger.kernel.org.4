Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5F74CFF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjGJIcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjGJIcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:32:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D241C4;
        Mon, 10 Jul 2023 01:32:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 735E521E9B;
        Mon, 10 Jul 2023 08:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688977931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IarH4b8vLfFqiQFb6Jf9NwYggi3gPLDXuEcvUpll3og=;
        b=tNLsvszpSxXGIzZXxdoA58ClQNp5x4HRPGMEu6Ne+XwjmVAAygdRFwl1QBy++tH3CtYGs3
        ZlKn+0KiVMryHHxSDsjIEonk6tWJffGxD6NIY12YITLqJ7rVLlNGiJfZTPqUd8Z/ARwFeX
        LvC6YncUM6E0WQi5gecmKpjG1WoJdtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688977931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IarH4b8vLfFqiQFb6Jf9NwYggi3gPLDXuEcvUpll3og=;
        b=n7gvonMPAYJ/yIBUMmNqT3ZEHCXN7wqIHC0O/oCkd5mVXpM1hBbEaxD6sAktRPt54z3Gdk
        kPYE3+NyeW+8EtDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 650061361C;
        Mon, 10 Jul 2023 08:32:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5QmdGAvCq2QWEAAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 10 Jul 2023 08:32:11 +0000
Date:   Mon, 10 Jul 2023 10:32:10 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 3/3] nvme/{041,042,043,044,045}: Use default
 hostnqn and hostid
Message-ID: <5b5immxsatjshetehvdxociibdsh2n5tgvi66fsi2tehnahv3h@nq2yypbrw2zp>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-4-dwagner@suse.de>
 <38a4e188-239c-a0a8-5204-8e8e001f062f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38a4e188-239c-a0a8-5204-8e8e001f062f@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 07:06:28PM +0300, Max Gurtovoy wrote:
> 
> 
> On 20/06/2023 16:27, Daniel Wagner wrote:
> > The host might have enabled the udev/systemd auto connect feature.
> > This disturbs the blktests for the fc transport. nvme-cli is able
> > to distinguish between the different invocations via the --context
> > option. In order to get this working we have to use the default
> > hostnqn and hostid and not randon generated IDs for every single
> > run.
> > 
> 
> In the bellow tests the hostnqn and hostid are randomly generated for each
> test, so how will it disturb the udev/systemd ?

No, random hostnqn should work as well. The only requirement is that the
hostnqn(s) used by blktest are unique.

> I'm not sure how will this change fix something and not sure why --context
> is mentioned here.

Sorry about that. I should have updated the commit message. A left over from a
earlier version.

> Seems like a good explanation to this patch is to used a dedicated hostnqn
> and hostid for blktests instead of randomly generate it.

Okay, I'll update the commit message to reflect this. I suppose I could also
look into getting rid of the local variables in the tests.

