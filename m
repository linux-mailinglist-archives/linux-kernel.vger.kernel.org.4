Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F79C648882
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiLISdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLISc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:32:58 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F3D3F07A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:32:57 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q190so2488631iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIG9ipb7HtnriQ+TcgmMj4D0kC7XhqX3aqXqdd/X99g=;
        b=auKVOem6aBdFc8RxIknWHg7aSAN8Bdc+VKexH0OEhPdLbC0w0mOnTFh19z+COMvFWr
         0BkCpoSVCK8ogW+FLkzJ2RT3Z97nuHU+du/GU1zRd1SgyuZfLXlGq+EKG3dcnFEMOaNx
         0dZHFJrOct60WGR/16g24H54uXRD8uJK7PSCfTbbDZ0zLxl8ozfdQ0lZgp/k/pBxf2RP
         tr1oKN63Sg4suroJrOnH/kCxcTQOiaHEjSwEUzNYNazUhJICtgvknWA/DWD/gmJnzn2W
         fXVacleBeX956BJw8XlOyk0QckyfQ6DW0GeBHyIVX1kuR3HSrLnGQMyFQqbTt/9kpkod
         nS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIG9ipb7HtnriQ+TcgmMj4D0kC7XhqX3aqXqdd/X99g=;
        b=h3JUHGyOeozSZNfJNgJkJgJL/YrL5aIKxka7cZIDBrvFHc9My+bBlKBW9JKJkX91Z5
         POkrMkqdSkB/5svg9+rq8e3Sqd5HV7mZdgH663YkU+EOYdERG7paFl80MO6vl6D+Tt2h
         kOVe12WLrCwNCdtLEPm1CLIyMWbKtENGitaWEUKhHhBaj+r0SrzaC4RMRBzoUyb5g4q5
         McYpopnoOd5lfpGzOtOQx/NlcKwmU+g0r1+PZhVrjAOrHlPvaHitzJq9ZLGCk12n3Ckh
         RuFDwablBO545p3ebPhCW7iSYIIie3S7NxyWvznGaiNYYv0FG55u8m5G9osBUWRyyd3J
         qJ1g==
X-Gm-Message-State: ANoB5pn+w7Jf0lACWliQpJrCxzAWfjLI12rPIDvtUvS7wJistw1nUW5L
        TrfUWidNGZlDKkxPaXoIhfurJQ==
X-Google-Smtp-Source: AA0mqf6dakxIHk+c37zOgvZFcUw775ncTPf0XKVyMmF8m8aWyN/T9I6SmrdFBa/1ST/MvNP6fJzrTA==
X-Received: by 2002:a5d:96c3:0:b0:6df:3e46:ab2b with SMTP id r3-20020a5d96c3000000b006df3e46ab2bmr3974784iol.6.1670610776568;
        Fri, 09 Dec 2022 10:32:56 -0800 (PST)
Received: from google.com ([2620:15c:183:200:a53b:fb2d:b8a1:f544])
        by smtp.gmail.com with ESMTPSA id o134-20020a02228c000000b0038a6b67befbsm662169jao.178.2022.12.09.10.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 10:32:56 -0800 (PST)
Date:   Fri, 9 Dec 2022 11:32:52 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Handle resize in early boot up
Message-ID: <Y5N/VM1u+Funtm0M@google.com>
References: <20221209101151.1fec1167@gandalf.local.home>
 <Y5NpDF0AnY9ibwEl@google.com>
 <20221209131357.5e4f6d01@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209131357.5e4f6d01@gandalf.local.home>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 01:13:57PM -0500, Steven Rostedt wrote:
> On Fri, 9 Dec 2022 09:57:48 -0700
> Ross Zwisler <zwisler@google.com> wrote:
> 
> > > +			if (cpu_id == smp_processor_id()) {
> > > +				rb_update_pages(cpu_buffer);
> > > +				migrate_enable();
> > > +			} else {
> > > +				migrate_enable();
> > > +				schedule_work_on(cpu_id,
> > > +						 &cpu_buffer->update_pages_work);
> > > +				wait_for_completion(&cpu_buffer->update_done);  
> > 
> > I ran with this patch on my test VM and hit the same Oops from the original
> > report.
> > 
> > I think the problem is that we're still trying to enable interrupts via
> > wait_for_completion():
> > 
> > wait_for_completion()
> >   wait_for_common()
> >     __wait_for_common()
> >       raw_spin_unlock_irq()
> >         _raw_spin_unlock_irq()
> >           __raw_spin_unlock_irq()
> >             local_irq_enable()
> > 
> > I'm testing on a QEMU VM with 4 virtual CPUs, if that helps WRT where work is
> > being scheduled (cpu_id == smp_processor_id).
> 
> Can you show the backtrace with that. Because when I triggered it, the
> other CPUs were not up and running. I'm testing this on a VM with 8 CPUs.

Ah, apologies, I think I got confused in my testing.  It is indeed working for
me now.

Thank you for the fix!

Tested-by: Ross Zwisler <zwisler@google.com>
