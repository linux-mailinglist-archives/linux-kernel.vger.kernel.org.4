Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804A27193CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjFAHA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjFAHAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:00:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAA0A3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:00:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6d01d390bso5176465e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685602849; x=1688194849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OxRrgRUPXLg+KQfV8mbcGNrsYGuYiAw0+HbpYENHkuo=;
        b=Q+U8feg49vDgFpsb7m0jneUFU2dpXKxRfKkHHZWFBk+CsusjfKM/aNSWZ+i2+GVUxe
         8cyfcQlOHPwHOGe3A/jyX6e5eRlq1FsZttHd/EOOGUYLxCCI54gOB8lBZcbneTzUJtzW
         2fA+UH9v3w50bHbp3trMRcnGdZrGrSXCOL95IFPWHjLKUMqdu+KnH3ovQ0AYqMT+XNqP
         PQD9FPbrC32WLKnDuUQ9xfV5A+9VHg2XVTt1lT2pFJa55R0mlNefGiR2GR/eSeRA+kO6
         KvWo5xahIRjnZSjwoNVSVzZU0KRCjuwKCGpP9Bi90PsO3yaaV6ubJ7Wp0N3KAKoClsNv
         rsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685602849; x=1688194849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxRrgRUPXLg+KQfV8mbcGNrsYGuYiAw0+HbpYENHkuo=;
        b=g60D+iRLQowm3V4R2d0wlSQ8U6YLspQuHDzgpDuzRQZXdnqEgaqxb6TX2RYQYP5FXU
         Qf/jx1HOhmt7YLMBkCDz3eHM6lvUyQBHsyEkeHiqnYDUfoSn6fVb6tRVYsGurlF02Frm
         U0yQPhFG5knFqN1h6pU89HYfRRIKJ62IlpndgFFGNF1dluRYDAD1aOz2NDBjabNWnh0t
         s1cMAgG2SdT75pd2Ggq1gzYE/CbPgzSDzePUOVVeqsoqaqjlgAL2aHFLk8a3/2skahpS
         7/RInVSq6JUulSREAS1gE9ygK6SzojanC+6/a+m682YV7EJbkwXuxgV2jKuSDn3AVlQf
         kzhA==
X-Gm-Message-State: AC+VfDzV+ujLf2yZgRXbYBkWnty6e54SzJr7EurZStW9ZLy8fpolHABL
        YW/z98LhN+3VCiUEeTefDyv0fw==
X-Google-Smtp-Source: ACHHUZ7yNt737oU21xIIW2lgNoIdEG8AG9XzKhuCs1zoBCZJWYS4cvQZIp3g+70eVynk7RddIPylHw==
X-Received: by 2002:a5d:4a4d:0:b0:307:8718:7891 with SMTP id v13-20020a5d4a4d000000b0030787187891mr929355wrs.54.1685602849326;
        Thu, 01 Jun 2023 00:00:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l5-20020adffe85000000b00307a83ea722sm9207174wrr.58.2023.06.01.00.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:00:47 -0700 (PDT)
Date:   Thu, 1 Jun 2023 10:00:43 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Sukrut Bellary <sukrut.bellary@linux.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] misc: fastrpc: Fix double free of 'buf' in error path
Message-ID: <22f7e4db-1380-4326-906f-83a85447471a@kadam.mountain>
References: <20230518100829.515143-1-sukrut.bellary@linux.com>
 <9194ebdf-f335-4cd6-bf89-bb4f86a57784@kili.mountain>
 <f47b17c1-1c02-2aa3-ba10-fcef70cb25a8@linaro.org>
 <b0115d7d-d15a-4948-8726-09a8b37f3f36@kili.mountain>
 <4aa42c38-e0e2-4d2d-bfe2-15bc151f7117@linaro.org>
 <ZGf+99vmXpN5nJ2f@dev-linux.lan>
 <ZHgicqL/TKuXHM0o@dev-linux.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHgicqL/TKuXHM0o@dev-linux.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 09:45:38PM -0700, Sukrut Bellary wrote:
> On Fri, May 19, 2023 at 03:57:59PM -0700, Sukrut Bellary wrote:
> > On Fri, May 19, 2023 at 11:39:59AM +0100, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 19/05/2023 11:22, Dan Carpenter wrote:
> > > > > ----------------------->cut<---------------------------
> > > > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > > > index f60bbf99485c..3fdd326e1ae8 100644
> > > > > --- a/drivers/misc/fastrpc.c
> > > > > +++ b/drivers/misc/fastrpc.c
> > > > > @@ -1891,7 +1891,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> > > > > char __user *argp)
> > > > >                                        &args[0]);
> > > > >          if (err) {
> > > > >                  dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
> > > > > -               goto err_invoke;
> > > > > +               fastrpc_buf_free(buf);
> > > > > +               return err;
> > > > >          }
> > > > > 
> > > > >          /* update the buffer to be able to deallocate the memory on the DSP
> > > > > */
> > > > > @@ -1930,11 +1931,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> > > > > char __user *argp)
> > > > >          return 0;
> > > > > 
> > > > >   err_assign:
> > > > > -       fastrpc_req_munmap_impl(fl, buf);
> > > > > -err_invoke:
> > > > > -       fastrpc_buf_free(buf);
> > > > > -
> > > > > -       return err;
> > > > > +       return fastrpc_req_munmap_impl(fl, buf);
> > > > 
> > > > This will return success if copy_to_user() fails.
> > > > 
> > > that is true, using return value of fastrpc_req_munmap_impl does not really
> > > make sense here we should just return err in either case to the user.
> > >
> >
> 
> I have one follow-up question before I send the v2 patch.
> With the following approach, I do see one issue.
> 
> ----------------------->cut<---------------------------
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f60bbf99485c..3fdd326e1ae8 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1891,7 +1891,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> char __user *argp)
>                                       &args[0]);
>         if (err) {
>                 dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
> -               goto err_invoke;
> +               fastrpc_buf_free(buf);
> +               return err;
>         }
> 
>         /* update the buffer to be able to deallocate the memory on the DSP */
> @@ -1930,11 +1931,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> char __user *argp)
>         return 0;
> 
>  err_assign:
> -       fastrpc_req_munmap_impl(fl, buf);
> -err_invoke:
> -       fastrpc_buf_free(buf);
> -
> -       return err;
> +       fastrpc_req_munmap_impl(fl, buf);
> +       return err;
>  }
> ----------------------->cut<---------------------------
> 
> In this, if qcom_scm_assign_mem() fails, the buf is not added to the list.
> But the call to fastrpc_req_munmap_impl() tries to delete the buf
> from the list.
> 
> To avoid this, we can use the following approach.

The list is initialized in __fastrpc_buf_alloc().

	INIT_LIST_HEAD(&buf->node);

So calling list_del(&buf->node); is fine.  It's not necessary but it's
not harmful.

regards,
dan carpenter

