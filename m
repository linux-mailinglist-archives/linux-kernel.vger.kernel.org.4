Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232DD723731
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFFGIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjFFGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:07:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE5E40;
        Mon,  5 Jun 2023 23:07:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BFCEB1FD5F;
        Tue,  6 Jun 2023 06:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686031668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5pd4LJ393MH2zbaS3t5GhZsJobD7uMEtaVcs7FxZFz4=;
        b=CFi7uHJq+bc/MQQP+AOnEXYMOq7WaP9XVZPWFIQ8m8FN/2uXOCdvGc1shzscPvnxDH+0YG
        Fjv6JVVQmVJPhLl1RPGtlL5w7tcdGmOoz9SPxqwA8Z5of8r3DU/WhFaeFCxf4lhdKXJVaP
        8WSXTQLHOuJplgxnwRDTDnPGjKhLYyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686031668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5pd4LJ393MH2zbaS3t5GhZsJobD7uMEtaVcs7FxZFz4=;
        b=ORwIyJATjZ8EeUcFEzqSKJPOHIgQfeaK43R9+ErjXCDfaGYI+9gAjcXZosmO0MXV0I2Zvv
        HQPYe0XjRCW3ttBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A671913776;
        Tue,  6 Jun 2023 06:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZBUfKDTNfmRgZQAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 06 Jun 2023 06:07:48 +0000
Date:   Tue, 6 Jun 2023 08:07:48 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 0/2] nvme_trtype=fc fixes
Message-ID: <kk2ijfx4dwdih274niskq3yi4mcsnnfveus36pu6wagjklx7fc@hprfzp7pi2wz>
References: <20230503083816.18792-1-dwagner@suse.de>
 <ydocewz6ls4bjow726voiqlk3hi3nziss7ppmao6a7c5v4yv6s@t24bkmsjcm6a>
 <ffazxcr66mlu2wecsr2tdsd2fugz425gqplu66cczbchub4kwa@j4ug5w37aefz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffazxcr66mlu2wecsr2tdsd2fugz425gqplu66cczbchub4kwa@j4ug5w37aefz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 05:24:22AM +0000, Shinichiro Kawasaki wrote:
> On Jun 01, 2023 / 11:01, Daniel Wagner wrote:
> > These patches are necessary to get to get the FC transport off the ground. At
> > least with those applied, blktests should be in shape and only the kernel part
> > needs to be addressed from then one.
> 
> Sorry, I missed this v3 post. I've just applied them. Thanks!

No worries. Thanks!

Since we have all in place now, I'll rebase/repost the fc patches again.
