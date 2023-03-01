Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB516A76F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCAWmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCAWmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:42:16 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F3C4FABB;
        Wed,  1 Mar 2023 14:42:14 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id d30so60306126eda.4;
        Wed, 01 Mar 2023 14:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ty7lQ1Ui5jzeajl0bvEM97XDLLHwPVlD/CL8jh9fOUo=;
        b=jZwjeZGYSSFf757MCnncDvqCzWqr6oKkWEdz2UynB2/o7HqTH4lPfG637csuJDED3k
         ZBZ24eGEhqk2OWbLB+dkOpenGlpj6AfIUUysFQ2AChle6mBe3EmE/8DqOITElLJjIKTs
         aaoChDmMMsfWP670kLe0DjW3S88GQwuGvz0xqnFEamHGi1/y3aVCbT+tNWk53BnY/4b+
         nuTxtVtijEZtvWrEcVx4Dd0cKZpz91dnd5BZfhbZaKnSlUq+xrrU1H2FrL1qpRQDYmoV
         T2Uaui3Ax4Gb2RkztzIdtT8/Hti5hm17UM/iIJwZnH37B4zGwMAguV4IiRr6lPKHbWH/
         hD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty7lQ1Ui5jzeajl0bvEM97XDLLHwPVlD/CL8jh9fOUo=;
        b=kIi6XlwaVllajzH/2qJgjtbl1nVV3Yytbrhp0i07GDH7KZkqqeU4xe2CoPpUbdyv4K
         rAZOOq8P7b4zdArOD/78G1nhO4DwdLa09HEaWJpy+Ls4Kwl0uA0jSzUtCLFVVvhCD5EL
         AjahwYZOkGhMMBLnBI0JSyjj9EL5koY1jd04nriyxRUJYaWNYwFBWph9ZwUkvSQwwtZw
         lRLrJN+7xQspE2nzXrGbcZcDCvQOAVD6oBbL3dDxJH5kn5/Xcj0jYQIG8NjpH0yqkf9q
         BOzSGrHleyIUhv2qXgiMWfqoW+xUIVFYTFEK1owxEXEefGlp9OfIuvgW5ho9JMRcsuVX
         RMAg==
X-Gm-Message-State: AO0yUKX8yswsOkdtv2+LAqqsb6p3VPL8gphGb5I/iVBrpeO3lrO3Pezc
        yJ6OnRmsSSOqboFXicdS36s=
X-Google-Smtp-Source: AK7set9yWQXB1i73RXCyUDfF2Uy7ODNAWWGDuLxoFK9xD/sOCE5drhzbunbkg9QkVnFIWvvzAOezdA==
X-Received: by 2002:a17:906:bea:b0:8fa:43fc:1118 with SMTP id z10-20020a1709060bea00b008fa43fc1118mr7439016ejg.41.1677710532816;
        Wed, 01 Mar 2023 14:42:12 -0800 (PST)
Received: from localhost (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id le13-20020a170907170d00b008c44438734csm6344882ejc.113.2023.03.01.14.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 14:42:12 -0800 (PST)
Date:   Wed, 1 Mar 2023 23:42:11 +0100
From:   Jakob Koschel <jkl820.git@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] watchdog: avoid usage of iterator after loop
Message-ID: <20230301224211.qz4tu7ayq5iwio4q@jm1p>
References: <20230301-watchdog-avoid-iter-after-loop-v1-1-851f583be9f7@gmail.com>
 <1570650d-ea9d-c3b5-801a-60e246947242@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570650d-ea9d-c3b5-801a-60e246947242@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/01 10:31AM, Guenter Roeck wrote:
> On 3/1/23 09:17, Jakob Koschel wrote:
> > If potentially no valid element is found, 'p' would contain an invalid
> > pointer past the iterator loop. To ensure 'p' is valid under any
> > circumstances, the kfree() should be within the loop body.
> > 
> > Additionally, Linus proposed to avoid any use of the list iterator
> > variable after the loop, in the attempt to move the list iterator
> > variable declaration into the marcro to avoid any potential misuse after
> 
> macro
> 
> > the loop [1].
> > 
> > Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> > Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> > ---
> >   drivers/watchdog/watchdog_pretimeout.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
> > index 376a495ab80c..d8c78696eaf5 100644
> > --- a/drivers/watchdog/watchdog_pretimeout.c
> > +++ b/drivers/watchdog/watchdog_pretimeout.c
> > @@ -207,10 +207,10 @@ void watchdog_unregister_pretimeout(struct watchdog_device *wdd)
> >   	list_for_each_entry_safe(p, t, &pretimeout_list, entry) {
> >   		if (p->wdd == wdd) {
> >   			list_del(&p->entry);
> > -			break;
> > +			spin_unlock_irq(&pretimeout_lock);
> > +			kfree(p);
> > +			return;
> 
> Please just make it
> 			kfree(p);
> 			break;
> 
> There is no need to drop the spinlock here and/or to return
> directly.

Ok great, I'll fix that in v2. I wasn't sure if something breaks if 'p' is released if the spinlock is still hold.

~ jakob

> 
> Thanks,
> Guenter
> 
> >   		}
> >   	}
> >   	spin_unlock_irq(&pretimeout_lock);
> > -
> > -	kfree(p);
> >   }
> > 
> > ---
> > base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
> > change-id: 20230301-watchdog-avoid-iter-after-loop-a197bf201435
> > 
> > Best regards,
> 
