Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0A264C303
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbiLNEGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbiLNEGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:06:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC2B2793F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:06:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso5876363pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hY72Xdn9gifxeOGEwVJkBQTRe/qRttufPM4JxryG5Nc=;
        b=hnCosuXWj3Jm58xhJLkRcC5izYjig4vTm02LRuRwp6CoaTOJQpVkcib9G5j62bvFnq
         g4rA9VG3DFCAnFqe5+vCxZLB3OHOS3bdOx2XhMC9v/9IwaZ70tClrq9nswKgAypnvCXT
         3v0zHJ23hplGxu6biI/61NqWEvdnvec963RhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY72Xdn9gifxeOGEwVJkBQTRe/qRttufPM4JxryG5Nc=;
        b=G+g5XwE7FPie1fZHiBhFNVAa5ZFM5mkxR5P9JhgEZ3C4NPyfTUrmZFXTYhHKtsDXXZ
         Fy2kdCvmcdq/h6pChNqsMPVSvkVeRwd2TF5ZnCw68NnAzAaU93SCcep7izpnxnMQs44o
         jcSo57hNwMAj7dBkff9w+/LTPMhKgFTaFXMTzDxJKaQYuGplAulI1sM/yr+6Ku0yBHLp
         M60P7Rr7yAWQRYKXC0LSJA0yfdECjgRMRUMr9wpPmNuRUfJ5oOw17JkjMRQdWCvFrswz
         BYtW+F7zi6aLm6hOhGrmu0Fn5I8tltCSo8mbpf+wAFarX9aFh+N0CUuEaXEDS6bCtqGh
         ySHA==
X-Gm-Message-State: ANoB5pkoSOC8BXpLrd/OhgkQ/8zqI/hz6vZ3iEMmCJmtFyQqUrAEJn3m
        e1+/NVzCPz+5dZRarrGuq+VxU4xP4udvyyze
X-Google-Smtp-Source: AA0mqf412usYjXpIYB2lo1hM5Q9K9gGmOT6n2BVm1WR+TraRXD0nwK0Cygldd5STdDCw7wQ9D5dybg==
X-Received: by 2002:a05:6a21:9103:b0:a3:9aa3:c060 with SMTP id tn3-20020a056a21910300b000a39aa3c060mr30005858pzb.53.1670990761987;
        Tue, 13 Dec 2022 20:06:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l7-20020a635707000000b004788780dd8esm7424665pgb.63.2022.12.13.20.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 20:06:01 -0800 (PST)
Date:   Tue, 13 Dec 2022 20:06:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Paul Moore <paul@paul-moore.com>, gregkh@linuxfoundation.org,
        jmorris@namei.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        zohar@linux.ibm.com
Subject: Re: [PATCH] LoadPin: Ignore the "contents" argument of the LSM hooks
Message-ID: <202212132005.A3A0B43D@keescook>
References: <20221209195453.never.494-kees@kernel.org>
 <20221209195453.never.494-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209195453.never.494-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:51:15AM +0800, Ping-Ke Shih wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> > LoadPin only enforces the read-only origin of kernel file reads. Whether
> > or not it was a partial read isn't important. Remove the overly
> > conservative checks so that things like partial firmware reads will
> > succeed (i.e. reading a firmware header).
> > 
> > Fixes: 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Tested-by: Ping-Ke Shih <pkshih@realtek.com>

Thanks for testing!

-Kees

> 
> > ---
> >  security/loadpin/loadpin.c | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> > 
> > diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> > index de41621f4998..110a5ab2b46b 100644
> > --- a/security/loadpin/loadpin.c
> > +++ b/security/loadpin/loadpin.c
> > @@ -122,21 +122,11 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
> >  	}
> >  }
> >  
> > -static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
> > -			     bool contents)
> > +static int loadpin_check(struct file *file, enum kernel_read_file_id id)
> >  {
> >  	struct super_block *load_root;
> >  	const char *origin = kernel_read_file_id_str(id);
> >  
> > -	/*
> > -	 * If we will not know that we'll be seeing the full contents
> > -	 * then we cannot trust a load will be complete and unchanged
> > -	 * off disk. Treat all contents=false hooks as if there were
> > -	 * no associated file struct.
> > -	 */
> > -	if (!contents)
> > -		file = NULL;
> > -
> >  	/* If the file id is excluded, ignore the pinning. */
> >  	if ((unsigned int)id < ARRAY_SIZE(ignore_read_file_id) &&
> >  	    ignore_read_file_id[id]) {
> > @@ -192,9 +182,25 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
> >  	return 0;
> >  }
> >  
> > +static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
> > +			     bool contents)
> > +{
> > +	/*
> > +	 * LoadPin only cares about the _origin_ of a file, not its
> > +	 * contents, so we can ignore the "are full contents available"
> > +	 * argument here.
> > +	 */
> > +	return loadpin_check(file, id);
> > +}
> > +
> >  static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
> >  {
> > -	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
> > +	/*
> > +	 * LoadPin only cares about the _origin_ of a file, not its
> > +	 * contents, so a NULL file is passed, and we can ignore the
> > +	 * state of "contents".
> > +	 */
> > +	return loadpin_check(NULL, (enum kernel_read_file_id) id);
> >  }
> >  
> >  static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
> > -- 
> > 2.34.1
> 
> 

-- 
Kees Cook
