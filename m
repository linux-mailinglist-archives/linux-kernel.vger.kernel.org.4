Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361FF739822
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFVHdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFVHdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:33:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D051992;
        Thu, 22 Jun 2023 00:32:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C3AD228F4;
        Thu, 22 Jun 2023 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687419178;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgboY+1eKS7Q4R+wwxJQMziAyhb5MWJJWPixvdsi6vw=;
        b=Y+S6cWYXoDMZLa4zgn8fXqN1yVVU4Rc5J3cecl/T4XwUXtc1WEyiOLrpWwehhnLEhKvvNr
        iJsuZ8lnFtBadV/8KQmFkAtExzARtZdpPgvPY6eZL4741HxpQVG8IqMTneY8xBI7WQL445
        eFMxsBMBA/qtt1A9qZEW2rm/+Gd1/PQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687419178;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgboY+1eKS7Q4R+wwxJQMziAyhb5MWJJWPixvdsi6vw=;
        b=pGfxU2eZPdVCvBbg1C/Ohx53ZNQOEgSeTw6YwkthFbsntvmEFx+uZ+uTJQaNElFLRfLkT+
        nZCDJ83OLBp+BAAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E213D13905;
        Thu, 22 Jun 2023 07:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4irjNSn5k2TSZwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 22 Jun 2023 07:32:57 +0000
Date:   Thu, 22 Jun 2023 09:32:56 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        Damien Le Moal <dlemoal@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        "lkp@intel.com" <lkp@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Hannes Reinecke <hare@suse.de>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Christoph Hellwig <hch@lst.de>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: [LTP] [linux-next:master] [scsi] eca2040972:
 ltp.ioprio_set03.fail
Message-ID: <20230622073256.GA482307@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <202306192248.1ece4c29-oliver.sang@intel.com>
 <61f22c1d-6b04-d193-57c9-8cad1c555e4b@kernel.org>
 <ZJLxbwCno-it2xBB@yuki>
 <ZJMYP/CCVviG6IMq@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJMYP/CCVviG6IMq@x1-carbon>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jun 21, 2023 at 02:47:43PM +0200, Cyril Hrubis wrote:
> > Hi!
> > > > kernel test robot noticed "ltp.ioprio_set03.fail" on:

> > > LTP maintainers,

> > > Patches have been submitted to fix this issue. Were these patches applied ?

> > Looks like they are in, at least these two:

> >     ioprio: use ioprio.h kernel header if it exists
> >     ioprio: Use IOPRIO_PRIO_NUM to check prio range

> > And there does not seem to be anything ioprio related haning in the LTP
> > patchwork.

Hi Niklas,

> Hello Cyril, Petr, Damien,


> I just ran LTP master + linux-next and the test case passes for me.


> Although, note that even if you are using LTP master,
> the way that the LTP header:
> testcases/kernel/syscalls/ioprio/ioprio.h
> is written, you will need to run

> make headers_install
> with linux-next kernel source,

> before running
> make autotools && ./configure
> in LTP.

> Otherwise LTP will use the kernel uapi headers from your distro,
> which does not perform the new checks for the IOPRIO_PRIO_VALUE()
> macro. (It requires linux uapi headers from linux-next.)

Yes, it should do otherwise more tests would be often broken.


> Does the linux kernel test robot not run
> make headers_install
> before running
> make autotools && ./configure
> in LTP?

I guess that's the question for Damien (I and Cyril have nothing to do with
kernel test robot). I wonder myself.

> One option, although I'm not sure if we want this,
> is to change
> testcases/kernel/syscalls/ioprio/ioprio.h
> to do something like:

> #ifndef IOPRIO_BAD_VALUE
> # define IOPRIO_BAD_VALUE(val, max) ((val) < 0 || (val) >= (max))
> #endif

> such that LTP does not need to be compiled against the kernel uapi
> headers that match the running kernel.

> But... shouldn't the installed uapi headers match the running kernel?

Yes, whatever kernel version (stable, enterprise, mainline, linux-next, ...) is
being tested, the tester should make sure LTP is compiled against correct
headers.

Kind regards,
Petr

> Kind regards,
> Niklas
