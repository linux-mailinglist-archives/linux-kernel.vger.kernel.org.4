Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2276C0AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCTGeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCTGeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:34:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442171913A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:34:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so42358035edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679294047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pJHvlqs1E3IZOSc4LBd6IECUObELcDFGMeYOHFWKVto=;
        b=PZX5bAk5F6ckB7vcIs0wXMYn3xd1BCWiPDcpO505/DzkuonoNu61w897NeC3Xqzjh7
         8fWoHyhZHRy/UhnnrHSLwq9ENl/u38XBpy+xH1TRiuQr+rVySX8lcD21W33oWGjwIU3x
         jJXgWfemlwOqaaEdIqCuF7TlHa/0QGV2mrgnXEZhUYA1nczCuMAPkXp3DdWWsRKVhFPD
         mwUm+SJzlrNRziw/l3PB1D71fd1QHGECXVAWSRZ0uyMiOQePPBxJdwZU9CoaCzIAkfm2
         cXebc6yESJcKFN/g29qlrlXW/EsWY5uKuMJ8R8+LW4grkmP+tw1qInQnbc8IyQz44+OG
         rF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679294047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJHvlqs1E3IZOSc4LBd6IECUObELcDFGMeYOHFWKVto=;
        b=jEh8cWXdTiUngv4t1tEp5Cp0zSVyCe9Wler1zugv3FM/WdwNsjuGukhePt2DxivH6/
         xvEDrqbMuzYS15EzAFHGAOGji3w1QeiuWisobWQJ8u25hSoKDWXBWdr1JHtwkZaQPtYK
         d7wWKiMCw3+6lm6H2v0yRnI2gxATZ/RQ48jXfyPNGDSIfYl+MZ6sGUm2SmMtAE5zD3+P
         Nd/yd4dlgds3IjioUPxTJ4DwIY7ho9ZeZ9CoW/voO3lg2ZjNXCi+5++hL0tmPsNp01q8
         J7rpfz3O/OYQuHzuecUbOc5XRfMs2Z6FoucWEDDbbBao25w6F54KBBUUcxlKLL1SeEth
         lzKw==
X-Gm-Message-State: AO0yUKW3t+RbyNMbGm1MHbRRai5TYCAdQAZ/3xNh5ZZHUF5xp9Wh6Vpo
        LUAMud0Ej46Qs5v3gKTMXq7IY4FmgDAhAn7J
X-Google-Smtp-Source: AK7set+WxSEvQ70ODVjdrp9oA75w+1BbD9UJRq8rtQsh9SLt6a6szK+v8GKc/pyvBL5X1wRW53oJQQ==
X-Received: by 2002:a17:906:538f:b0:92d:44ca:1137 with SMTP id g15-20020a170906538f00b0092d44ca1137mr7753076ejo.43.1679294047321;
        Sun, 19 Mar 2023 23:34:07 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id p25-20020a50cd99000000b004bf76fdfdb3sm4341043edi.26.2023.03.19.23.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:34:06 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:34:04 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] staging: axis-fifo: initialize timeouts in init only
Message-ID: <ZBf+XDN8GM0xDDCq@khadija-virtual-machine>
References: <ZBN3XAsItCiTk7CV@khadija-virtual-machine>
 <2222576.3ZeAukHxDK@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2222576.3ZeAukHxDK@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:29:25AM +0100, Fabio M. De Francesco wrote:
> Khadija,
> 
> Congratulations for having your first patch in Linux, via Greg's staging tree.
> 
> It will take some time before it reaches mainline, although it is already on 
> its way to get upstream.

Thank you! :)

> 
> On giovedì 16 marzo 2023 21:09:00 CET Khadija Kamran wrote:
> > Initialize the module parameters, read_timeout and write_timeout once in
> > init().
> > 
> > Module parameters can only be set once and cannot be modified later, so we
> > don't need to evaluate them again when passing the parameters to
> > wait_event_interruptible_timeout().
> 
> Greg made you (and indirectly me notice) that the statement above is a kind of 
> short-circuit because it misses to make the readers notice that you are 
> dealing with specific permissions granted to these two module's parameters.
>
> Please take a look at the permissions associated with those parameters:
> 
> module_param(write_timeout, long, 0444);
> module_param(read_timeout, long, 0444);
> 
> Can you understand what '0444' stands for? What if their permissions were  
> instead something like '0666' or '0664'?
>

Hey Fabio!

I understand that 0444 shows read permissions only.
I am trying to make sense of this. As the permissions do not allow
write, so the value cannot be configured afterwards. 
Instead of saying 'cannot be modified later', we should talk more about
permissions here too.
Am I getting it right?

Thank you!

Regards,
Khadija


> (I'm not asking you to answer these questions, instead I am only asking you to 
> learn how it works if you don't know it yet).
> 
> Fabio
> 
> > Convert datatype of {read,write}_timeout from 'int' to 'long int' because
> > implicit conversion of 'long int' to 'int' in statement
> > '{read,write}_timeout = MAX_SCHEDULE_TIMEOUT' results in an overflow.
> > 
> > Change format specifier for {read,write}_timeout from %i to %li.
> > 
> > Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> > 
> > Changes in v8:
> >  - Fixed a spelling mistake
> > 
> > Changes in v7:
> >  - Fixed a grammatical error
> > 
> > Changes in v6:
> >  - Initialize module parameters in init instead of probe function.
> >  - Change the subject and description
> >  - Change format specifiers of module parameters to "%li"
> > 
> > Changes in v5:
> >  - Convert module parameters datatype from int to long.
> >  - Link to patch:
> >  https://lore.kernel.org/outreachy/ZBMR4s8xyHGqMm72@khadija-virtual-machine/
> > 
> > Changes in v4:
> >  - Initialize timeouts once as suggested by Greg; this automatically
> >    fixes the indentation problems.
> >  - Change the subject and description.
> >  - Link to patch:
> >  https://lore.kernel.org/outreachy/ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine/
> > 
> > Changes in v3:
> >  - Correct grammatical mistakes
> >  - Do not change the second argument's indentation in split lines
> > 
> > Changes in v2:
> >  - Instead of matching alignment to open parenthesis, align second and
> >    the last argument.
> >  - Change the subject and use imperative language.
> >  - Link to patch:
> >  https://lore.kernel.org/outreachy/ZAxNYw2rFQkrdtKl@khadija-virtual-machine/
> > 
> > Link to first patch:
> >  https://lore.kernel.org/outreachy/ZAZSmPpB6fcozGa4@khadija-virtual-machine/
> > 
> >  drivers/staging/axis-fifo/axis-fifo.c | 28 ++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/staging/axis-fifo/axis-fifo.c
> > b/drivers/staging/axis-fifo/axis-fifo.c index dfd2b357f484..0a85ea667a1b
> > 100644
> > --- a/drivers/staging/axis-fifo/axis-fifo.c
> > +++ b/drivers/staging/axis-fifo/axis-fifo.c
> > @@ -103,17 +103,17 @@
> >   *           globals
> >   * ----------------------------
> >   */
> > -static int read_timeout = 1000; /* ms to wait before read() times out */
> > -static int write_timeout = 1000; /* ms to wait before write() times out */
> > +static long read_timeout = 1000; /* ms to wait before read() times out */
> > +static long write_timeout = 1000; /* ms to wait before write() times out */
> > 
> >  /* ----------------------------
> >   * module command-line arguments
> >   * ----------------------------
> >   */
> > 
> > -module_param(read_timeout, int, 0444);
> > +module_param(read_timeout, long, 0444);
> >  MODULE_PARM_DESC(read_timeout, "ms to wait before blocking read() timing 
> out;
> > set to -1 for no timeout"); -module_param(write_timeout, int, 0444);
> > +module_param(write_timeout, long, 0444);
> >  MODULE_PARM_DESC(write_timeout, "ms to wait before blocking write() timing
> > out; set to -1 for no timeout");
> > 
> >  /* ----------------------------
> > @@ -384,9 +384,7 @@ static ssize_t axis_fifo_read(struct file *f, char 
> __user
> > *buf, mutex_lock(&fifo->read_lock);
> >  		ret = wait_event_interruptible_timeout(fifo->read_queue,
> >  			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> > -				 (read_timeout >= 0) ?
> > -				  msecs_to_jiffies(read_timeout) :
> > -				  MAX_SCHEDULE_TIMEOUT);
> > +			read_timeout);
> > 
> >  		if (ret <= 0) {
> >  			if (ret == 0) {
> > @@ -528,9 +526,7 @@ static ssize_t axis_fifo_write(struct file *f, const 
> char
> > __user *buf, ret = wait_event_interruptible_timeout(fifo->write_queue,
> >  			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
> > 
> >  				 >= words_to_write,
> > 
> > -				 (write_timeout >= 0) ?
> > -				  msecs_to_jiffies(write_timeout) :
> > -				  MAX_SCHEDULE_TIMEOUT);
> > +			write_timeout);
> > 
> >  		if (ret <= 0) {
> >  			if (ret == 0) {
> > @@ -948,7 +944,17 @@ static struct platform_driver axis_fifo_driver = {
> > 
> >  static int __init axis_fifo_init(void)
> >  {
> > -	pr_info("axis-fifo driver loaded with parameters read_timeout = %i,
> > write_timeout = %i\n", +	if (read_timeout >= 0)
> > +		read_timeout = msecs_to_jiffies(read_timeout);
> > +	else
> > +		read_timeout = MAX_SCHEDULE_TIMEOUT;
> > +
> > +	if (write_timeout >= 0)
> > +		write_timeout = msecs_to_jiffies(write_timeout);
> > +	else
> > +		write_timeout = MAX_SCHEDULE_TIMEOUT;
> > +
> > +	pr_info("axis-fifo driver loaded with parameters read_timeout = %li,
> > write_timeout = %li\n", read_timeout, write_timeout);
> >  	return platform_driver_register(&axis_fifo_driver);
> >  }
> > --
> > 2.34.1
> 
> 
> 
> 
