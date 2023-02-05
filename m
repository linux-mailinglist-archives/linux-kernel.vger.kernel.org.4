Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D56C68B12E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 19:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBESNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 13:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBESNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 13:13:23 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEFD17CE1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 10:13:22 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p26so28281343ejx.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 10:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MADvd4KXk+Pnv+BnuUONBLxS8C2Yx/vqJbKEF2lRq+I=;
        b=M+cWHvWkpsU8P1Dpa6MInG0nswK3denIMCrzJ4taB2EHkck0MFw71A8T2Evn/SqEjs
         VDTjTo1HOKz6HnYk8UEkBQdVDaErUF7ecz1M8gsqPZ5PgdotNDwdoUX2d/hBgDXn8ty+
         J1rZGJEePTeFteNJbouBt0tQt3fyDpDVl+MkvfXXZhOfg1a0JUMaZbP4xeYo57lR4pfU
         PoGmuglPHWrT+2IKL1+1rMcZeKW9WstJlXah9UXKeCFV7yQreH52i7tqOeiL0Sn6lTzm
         ordkl1H8uJMLqepzPKDpkD7VyXUDviMu8RnOoY2dZ05NVhJyDHKcTv5+1XjI9Vjm6bUi
         vy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MADvd4KXk+Pnv+BnuUONBLxS8C2Yx/vqJbKEF2lRq+I=;
        b=rgws9TBLGGgB7qzbAtxIo0PWcn7ZBHVfEgo3tmh2e2c1XnfO29ldVjl2ddeqMusqIm
         jNypU2IV4RV3J7tElth0jcx7fVSugJCVFpZBbuWwwSHZZokybkyrOWmryRPqfiAsVxeM
         ft+Ee1IO/KvMDvjG1Lm8O/AV8uPS7lh9bDnEB51Y0yVxsEZU0jcWIXWAqDrwilTPf0CU
         NGc1bLQ8LhzYf8E7JJdcN+8mXwNonk467GE/vYKKoN9CuEMiol8XmoIE52v4P/+399ix
         YJEa0fyvr9igrfepLIohWl0HlvPnQT0hRSWVobqZmHDRrg2j7sO+B6dRWBbCvUi6qiiV
         J1PA==
X-Gm-Message-State: AO0yUKUDUMx/wd3dM2p0tcAvAwmusZVSkQqWTcjHMDrp1QJR8dOYXjvo
        OtdBXoXKbe/keqHhKdMxBQ8=
X-Google-Smtp-Source: AK7set/CRN2+pSypVmV/volOfAyQuzaPZtEf6TefJnBoxmJfkzTXBPRMsnG4JkjBF46b/4H+UxxqQg==
X-Received: by 2002:a17:906:60d1:b0:886:6f92:2bd2 with SMTP id f17-20020a17090660d100b008866f922bd2mr16913839ejk.21.1675620801081;
        Sun, 05 Feb 2023 10:13:21 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id gw1-20020a170906f14100b0087bd4e34eb8sm4335679ejb.203.2023.02.05.10.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 10:13:20 -0800 (PST)
Date:   Sun, 5 Feb 2023 19:13:18 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <Y9/xvjlxufB700Kc@combine-ThinkPad-S1-Yoga>
References: <Y9+qMqYD2zGWRurD@combine-ThinkPad-S1-Yoga>
 <Y9+sFw0rviTAJNMf@kroah.com>
 <Y9+vkwYfQzYTbIIo@combine-ThinkPad-S1-Yoga>
 <Y9/MhS3pJ/Es0sGa@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9/MhS3pJ/Es0sGa@nam-dell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 04:34:29PM +0100, Nam Cao wrote:
> On Sun, Feb 05, 2023 at 02:30:59PM +0100, Guru Mehar Rachaputi wrote:
> > On Sun, Feb 05, 2023 at 02:16:07PM +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Feb 05, 2023 at 02:08:02PM +0100, Guru Mehar Rachaputi wrote:
> > > > This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> > > > as '(iobase)' to avoid precedence issues"
> > > > 
> > > > ---
> > > > Changes in v3:
> > > > 	- Whitespace error from checkpatch fixed
> > > > 
> > > > Changes in v2:
> > > > 	- Macros with one statement that is to call 'iowrite8' function changed
> > > > 	to inline function as reviewed by gregkh@linuxfoundation.org.
> > > > 	In relation to this, names of the callers of macro are also modified
> > > > 	to call this function.
> > > > 
> > > > Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> > > 
> > > Try to take this patch and apply it to a tree, and see that everything
> > > below the --- line is thrown away, including your signed-off-by: line :(
> > > 
> > Sorry, should not a patch contain signed-off-by: line?
> > I did not understand.
> 
> Patches must include signed-off-by. However your patch has it below the
> --- line, and git will throw it away. You can try "git am <your patch>"
> and see for yourself.
> 
> Best regards,
> Nam
Oh I see. Thanks for that. I changed it now.

-- 
Thanks & Regards,
Guru
