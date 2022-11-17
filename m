Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591E262E2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiKQRXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiKQRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:23:34 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C95ACE16;
        Thu, 17 Nov 2022 09:23:32 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id u7so1617930qvn.13;
        Thu, 17 Nov 2022 09:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+f0ffGwOscTxbM5U9SLOAxGKC3QE85aGvCaHj4K1HE=;
        b=Qtay/nV+Fn/OluEZAkqL3DtU1cTzGVtUoh/fy4laciv4EN4q2903mYrHY7xH5OZ0+4
         TrlzSOD1HEkR5yW0uIw5njCKSmUzyo6CMRgTXmtopnuizMMgI+ZYDjXTIfUCQE95aQVk
         0+X1gduCe9vwSdzTTqaBvs1gy5OhcOpQqDslAU4HFAbc0vld1k9jKGc14zruXxgJj9HF
         mpJyaCG8FcBe6Yp+SUUZCQz1EuBDelVq8qH1/veBGxbQsj8zWLj22nfAWeF4s/PHID/4
         CqVbpZsdF80PzZ1b/kS/utcQPyduVyLM8gwJ0KKkznvumSfgg/YEGPu5YVjq+7U0d9n2
         PG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+f0ffGwOscTxbM5U9SLOAxGKC3QE85aGvCaHj4K1HE=;
        b=ojpu4i4hbczgqW4rYV23JSjNDiN2uX7pad+KveIC6PLIWxee4xUoQKL101V5R5o0Yy
         ijKc4ubM2ne5DwjYcyEvM6dfJfAAmMCCMlAl4yUChFpX3x5UN0Ooirl3rlKlPeXmS9oH
         VJ4xS7g3snJYi7mVJN3OdD/Lwqa8LjLEHEUy7zviobC4JB7UGiHNFIvMyBZShRix7IJL
         +4ZCUuVsZX6kEKIchGGUoVpnarrlfWZSdvAFuT40ibUACzGQP48sVsyoG+U3OrNb0LsU
         Z5bQxAqcJ653HrXPdfFFmt/p0nGTlkfwPuvmHlmLnuIrpslOZFSseFJZlDsaYNnlXFSz
         hV/g==
X-Gm-Message-State: ANoB5pl6FJgwEy49oLLZBVdcKkLifxZ26lbx8z8okxEOqvEPdEIWmUR+
        dCUO3Yyd/88oai4oqnLEVWo=
X-Google-Smtp-Source: AA0mqf6rRVszZklBI/GCUbRqW0jDJ1ToOyToBlqN9UW3khvWOHk9/0j5v1R2PxV/AjguZ+4U3saxQw==
X-Received: by 2002:a0c:fe11:0:b0:4bb:64d5:486d with SMTP id x17-20020a0cfe11000000b004bb64d5486dmr3452021qvr.1.1668705811335;
        Thu, 17 Nov 2022 09:23:31 -0800 (PST)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id bs42-20020a05620a472a00b006b61b2cb1d2sm809875qkb.46.2022.11.17.09.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:23:30 -0800 (PST)
Date:   Thu, 17 Nov 2022 12:23:28 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] math64: favor kernel-doc from header files
Message-ID: <Y3ZuECdzBqUjAUlN@shaak>
References: <20221117023510.2338176-1-liambeguin@gmail.com>
 <e2948e8b-6e00-abbb-0948-017e7fd584f6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2948e8b-6e00-abbb-0948-017e7fd584f6@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Thu, Nov 17, 2022 at 09:01:11AM -0800, Randy Dunlap wrote:
> Hi--
> 
> On 11/16/22 18:35, Liam Beguin wrote:
> > Fix the kernel-doc markings for div64 functions to point to the header
> > file instead of the lib/ directory.  This avoids having implementation
> > specific comments in generic documentation.  Furthermore, given that
> > some kernel-doc comments are identical, drop them from lib/math64 and
> > only keep there comments that add implementation details.
> > 
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> 
> LGTM.
> 
> Could you also fix these 2 warnings?
> 
> math64.h:126: warning: No description found for return value of 'div_u64'
> math64.h:139: warning: No description found for return value of 'div_s64'
> 

Sure, I'll look into that!

Cheers,
Liam

> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
> > ---
> >  Documentation/core-api/kernel-api.rst |  3 ---
> >  include/linux/math64.h                | 12 ++++++------
> >  lib/math/div64.c                      | 15 ++-------------
> >  3 files changed, 8 insertions(+), 22 deletions(-)
> 
> -- 
> ~Randy
