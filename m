Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E7B6BD836
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCPSfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCPSfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:35:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE81A8EA7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:35:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w9so11393224edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678991713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V219Z8dtRsvqe0YD78fM8bylZpT8OpKfHaD3Eq5a5T8=;
        b=Q3sdokceiviFjFBFwA5FN8lZYHb8UWtgk7heXSakNwMynv8lrxZc8pwgwYVT0ide+B
         ViCt1dd9aflwOLTsrFgGnzpmaPHsd+21NS90EVkhLO5Qxb8VvzSuf1Xwsn9c1iLqfII1
         54lKAkbQwoe4YO/vJMUoxqHOtzMp5jmIVrUYU09/7AigptjsRJj9FcVMkVGh4IYhW2uA
         lyWOCv46vdY1o3NZ4wMP9UhADIq1cSK5tO76Yn1DEebxQvmkhv8rqmpXt6D+Xeo+Bb1p
         7t7tI/DVSqYGCAdT/mECJgr2XhqzKdiSBCRZB4nNFESou7o0Y71U5geBcSkr1lmA22eU
         xQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678991713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V219Z8dtRsvqe0YD78fM8bylZpT8OpKfHaD3Eq5a5T8=;
        b=LAKp+ryft52wSOsDJWfzqqPWI9QnxOCeocWzxE4XzuT/KGrCWSo6lm6Ptsg6nnUMIg
         foGtSTufRHpVTHPxRd/VSbNKM5aXq/E7jnlhe6wRrkC3XcGp2qmAw0aL56HthBIZ9Jdo
         9xCNvTPfzQ/N6ZYd4l1cJN/MPNHWmjZmoQOs8tGb6lveXCYqCmkZHgCTD1QM2XJS7+rh
         uOVisnYNXieIx2DQXx14HGgFV9Q57GiPUwRHUAdk4YCuksLN804HKTOtqanaJ1YuxKPv
         ZXgjPhjGx8A0rM60Vtoa2c+6ud6mxw6cV27SHWRv+GxVVqutufgS74LBe/oNCq6QGGge
         trkg==
X-Gm-Message-State: AO0yUKXi2hfC6uP0ZvBh1KVwkEqlZe2jOftkDUwZYwuyap4fh9YHu0rp
        DLaye7Qo39CxxyVyn5uiU9egQpm7w0mSpxYf
X-Google-Smtp-Source: AK7set9vsEJ9DXsXEJG/IbGZE/Tu6Qfnn7WF1w4KNehlhmNKgCyJXUzLZPP7Y/ddMzl8UYVBPc2OKQ==
X-Received: by 2002:a17:907:10c3:b0:930:3916:df1d with SMTP id rv3-20020a17090710c300b009303916df1dmr3873105ejb.0.1678991712578;
        Thu, 16 Mar 2023 11:35:12 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090629cb00b008e17dc10decsm4160225eje.52.2023.03.16.11.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:35:12 -0700 (PDT)
Date:   Thu, 16 Mar 2023 23:35:09 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBNhXc3sVVLdibUF@khadija-virtual-machine>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
 <2626731.BddDVKsqQX@suse>
 <ZBMxFLtW2ekCvm/s@khadija-virtual-machine>
 <2162728.C4sosBPzcN@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2162728.C4sosBPzcN@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 05:17:47PM +0100, Fabio M. De Francesco wrote:
> On giovedì 16 marzo 2023 16:09:08 CET Khadija Kamran wrote:
> > On Thu, Mar 16, 2023 at 03:38:03PM +0100, Fabio M. De Francesco wrote:
> > > Khadija,
> > > 
> > > Just saw your v5 patch and Greg's two replies.
> > > 
> > > For v6 you will need to change the subject to "[PATCH v6] staging:
> > > axis-fifo:
> > > initialize timeouts in init only" to indicate that you are doing 
> assignments
> > > in axis_fifo_init().
> > > 
> > > Don't forget to extend the version log with "Changes in v6:" and clarify
> > > that
> > > v5 had a different "Object" (you should probably also add a link to the v5
> > > patch in lore: https://lore.kernel.org/lkml
> > > /ZBMR4s8xyHGqMm72@khadija-virtual- machine/). When the "Subject" changes,
> > > readers may not find the previous versions easily.
> > > 
> > > On giovedì 16 marzo 2023 13:56:02 CET Khadija Kamran wrote:
> > > > Module parameter, read_timeout, can only be set at the loading time. As
> > > > it can only be modified once, initialize read_timeout once in the probe
> > > 
> > > Substitute "probe" with "init".
> > > 
> > > > function.
> > > > 
> > > > As a result, only use read_timeout as the last argument in
> > > > wait_event_interruptible_timeout() call.
> > > 
> > > This two sentences are not much clear. I'd merge and rework:
> > > 
> > > "Initialize the module parameters read_timeout and write_timeout once in
> > > init().
> > > 
> > > Module parameters can only be set once and cannot be modified later, so we
> > > don't need to evaluate them again when passing the parameters to
> > > wait_event_interruptible_timeout()."
> > > 
> > > > Convert datatpe
> > > 
> > > s/datatpe/type/
> > > 
> > > > of read_timeout
> > > 
> > > of {read,write}_timeout
> > > 
> > > > from 'int' to 'long int' because
> > > > implicit conversion of 'long int' to 'int' in statement 'read_timeout =
> > > > MAX_SCHEDULE_TIMEOUT' results in an overflow warning.
> > > 
> > > We don't care too much about the warning themselves: I mean, it overflows
> > > and
> > > you must avoid it to happen (as you are doing with the changes of types),
> > > not
> > > merely be interested in avoiding the warning. "[] results in an overflow."
> > > is
> > > all we care about.
> > 
> > Hey Fabio!
> > Thank you for your feedback. I have understood it and will make sure to
> > send them in the next PATCH v6.
> 
> Great to hear it!
> 
> > > Add also the previous paragraph in the last part of the commit message.
> > > 
> > > > Perform same steps formodule parameter, write_timeout.
> > > 
> > > And instead delete the this last phrase.
> > 
> > Can you please explain the above feedback. I am confused. What should I
> > use instead of this last phrase?
> 
> Sorry, I made a typo in the sentence above and that may confuse you :-(
> 
> I just intended to suggest to delete "Perform same steps formodule parameter, 
> write_timeout.".
> 
> In the previous lines I suggested you to merge and rework your entire commit 
> message. If you like it you are left with the following text (that I put for 
> you between two '"'):
> 
> "Initialize the module parameters read_timeout and write_timeout once in
> init().
> 
> Module parameters can only be set once and cannot be modified later, so we
> don't need to evaluate them again when passing the parameters to
> wait_event_interruptible_timeout().
> 
> Convert the type of {read,write}_timeout from 'int' to 'long int' because 
> implicit conversion of 'long int' to 'int' in statement 'read_timeout = 
> MAX_SCHEDULE_TIMEOUT' results in an overflow.".
> 
> Just three small sentences are all you need (and don't forget to change the 
> Subject - "probe()" -> "init()".
> 
> I hope I have been clearer this time.
> If not, please ask for further clarification.
> 
> Thanks,
> 
> Fabio 
> 
> > > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > > ---
> > > > 
> > > > Changes in v5:
> > > >  - Convert timeout's datatype from int to long.
> > > > 
> > > > Changes in v4:
> > > >  - Initialize timeouts once as suggested by Greg; this automatically
> > > >  
> > > >    fixes the indentation problems.
> > > >  
> > > >  - Change the subject and description.
> > > > 
> > > > Changes in v3:
> > > >  - Fix grammatical mistakes
> > > >  - Do not change the second argument's indentation in split lines
> > > > 
> > > > Changes in v2:
> > > >  - Instead of matching alignment to open parenthesis, align second and
> > > >  
> > > >    the last argument instead.
> > > >  
> > > >  - Change the subject to 'remove tabs to align arguments'.
> > > >  - Use imperative language in subject and description
> > > >  
> > > >  drivers/staging/axis-fifo/axis-fifo.c | 26 ++++++++++++++++----------
> > > >  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> [snip]
> 
> > > >  			
> > > >  				 >= words_to_write,
> > > 
> > > What is this? You haven't yet compiled your patch.
> > > Any further problems with enabling axis-fifo as a module?
> > 
> > Sorry, my bad.  Instead of fixing the menuconfig I used this command to
> > remove the warnings:
> > make -j"$(nproc)" ARCH=arm64 LLVM=1 drivers/staging/axis-fifo/
> > I thought it is compiling my module correctly.
> > But I am working on your feedback. And before sending my next patch I
> > will make sure to compile it properly.
>

Hey Fabio!

Hope you are doing well. After  spending a lot of time on this I am
stuck now. Kindly help me resolve this issueor understand it better.

Following your instructions I deleted my config file and copied one from
the /boot/ directory. After that I enabled the dependencies(CONFIG_OF=y
and CONFIG_HAS_IOMEM=y). I was successfully able to enable axis-fifo as
a module.

I then ran the following commands:
 - make drivers/staging/axis-fifo/
 - sudo make modules_install install(this command took hours) :'(

> When you are done with build, install, and final reboot to test if your module 
> can "modprobe" or "insmod" (i.e. link with the running custom kernel you 
> built, installed and boot), try to compare the output of the following 
> commands:
> 
> # uname -a
> Linux suse 6.2.2-1-default #1 SMP PREEMPT_DYNAMIC Thu Mar  9 06:06:13 UTC 2023 
> (44ca817) x86_64 x86_64 x86_64 GNU/Linux
> 

The above command works

> AND
> 
> # modinfo <name of the module you are testing here>
>

On running 'modinfo axis-fifo' I get error saying module axis-fifo not
found.

> I'm running "modinfo kvm" (but showing only two of many lines):
> 
> # modinfo kvm 
> filename:       /lib/modules/6.2.2-1-default/kernel/arch/x86/kvm/kvm.ko.zst
> vermagic:       6.2.2-1-default SMP preempt mod_unload modversions 
> 
> Can you see that the kernel in "uname -a" and the filename and vermagic have 
> the same "6.2.2-1-default"? Well, so I'm sure I'm running the right Kernel and 
> inserted the appropriate "kvm" module. 
> 
> Furthermore, before rebooting your custom kernel, you may also look at the 
> directory in the Kernel where you compiled your module and search for "*.o" 
> "*mod*" and "*.ko" files. If you have them, you built your module properly.
>

There is a "*.o" file and "*.mod" file but there is no "*.ko" file in
the axis-fifo directory.

Kindly help me with this.

Regards,
Khadija


> Thanks,
> 
> Fabio
> 
> 
> 
