Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4E56D98C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbjDFN5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbjDFN51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:57:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442BB83CE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:57:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D6544225FF;
        Thu,  6 Apr 2023 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680789420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JuI7rEXVAd5Io13zAc2gN/AbKEUjXYbUadrLZJs7G7I=;
        b=WoQVQrTyFaKXRHQ6iNlVrkJacxZ6iPuOSlwv8FUO79mXniCR7F9KJ7FZLAnZMg3XfoJo+D
        TQbwwjFidMIJu2OaeaYCg5kZdTzt/UU17Pe9/xutwnGcSUh84GxYzy8SXx/iJS2OBbTnQ9
        tAjLcs8mYcatRmdu3jgboima/pORdq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680789420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JuI7rEXVAd5Io13zAc2gN/AbKEUjXYbUadrLZJs7G7I=;
        b=oQQ8i5x9muTG5IRPWHI/lZ59dWsyEuxxxsZtmpvMsqc+NcJfWSr5ttQUDlnB7X42A/toTH
        wtozsY0g9vbLWfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF57A1351F;
        Thu,  6 Apr 2023 13:57:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AHP4LazPLmRcGwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 06 Apr 2023 13:57:00 +0000
Date:   Thu, 6 Apr 2023 15:58:12 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Petr Vorel <pvorel@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        Tudor Cretu <tudor.cretu@arm.com>
Subject: Re: LTP: list of failures on 32bit and compat mode
Message-ID: <ZC7P9BgW1CTFAMjB@yuki>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <7234b8ab-db5c-4f4a-bb9e-ddef9f1a50d3@app.fastmail.com>
 <20230406124812.GA1589248@pevik>
 <3c2ba6f9-bea1-4510-8fbb-6521fab74a9d@app.fastmail.com>
 <20230406131755.GA1608262@pevik>
 <c2a6d31f-173b-4d08-b377-e31748f33443@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2a6d31f-173b-4d08-b377-e31748f33443@app.fastmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > Thanks! I've just searched in musl as well, because it didn't make sense to me
> > it'd be a code for LTP.
> >
> > "to catch the fault on ltp" I wonder if it's not actually musl bug.
> 
> No, musl is fine here. The problem is that ltp passes an invalid pointer,
> expecting to get -EFAULT from the kernel when that faults in
> copy_to_user().
> 
> There is nothing wrong with musl sanitizing the data behind that
> pointer, but then you get a signal instead of the EFAULT error.

That's actually quite common, usually we fix that by running the test in
a child and treating SEGFAULT as a PASS.

-- 
Cyril Hrubis
chrubis@suse.cz
