Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC106606E26
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJUDKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUDKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:10:12 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF97B5BCB5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:10:09 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q1so1346386pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVDeaTKoSrOeCfd6nCXKEY/GIy0Kyct0/tmYk1UcIUw=;
        b=G7ifq2dkQ3DICOfSgmtHGTZ7dMZQvQ34Tb5+dVJfD2zOpDahc0SV/2oshuQWvCf6pt
         9deeHDnwhW7MiA3yoVmNPYOXnzV4MwmD0GpkGPthCONqn2aTzTJK6wrMlUMhkykGEFvy
         n2v9TZFznNTvYsGiPco24OZ6rOnhZmQStzhFXtETn52/E6Exb/I1FBrTGxQseO7oodpR
         CooPpXLJRSt9+tkD84l6RjAPx+MEb//8Z8BnP7EtIeFZbYXN8/fpyPjGKHIp6DJVhzpl
         e6SaUXP41JKGFksQx2qg3cU4m/93bp1oftck7u/xSdila5m8HCKaJ695CxvY0YofVh6J
         Hxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVDeaTKoSrOeCfd6nCXKEY/GIy0Kyct0/tmYk1UcIUw=;
        b=zsE/2OBZ0JOGMZSwARO10AknKROumqksPcceOVNBClXFc1gFHNlWgQwvj8ymEk9vfu
         boQHFnPzlmkTPnv7TdVW4z3vomkmemZXtXVHq35IZ+6c9LjyesVdRWUZAYJs0PKh9rNc
         Aw1SymdlSRj4N5oopfHBVtu8dgUFlnAIV91c3bWzJZ4WAVPowPVOGyivin32sYgc9TWy
         WHVlxd85X/Xso61rbuiBBH2AkOXZ9EkUDywJV4zPtlhTaOinaIN4mmV9CGWm9/UR+mNv
         ckgck744di7R4XZ6lH3yGs5DjXnB1rPdBztr206RcDan1ztHZXDFf2lnbZudVaJdJSWf
         Wm5Q==
X-Gm-Message-State: ACrzQf27rSxbUvR+9DewtX8w1NtI/1PVPPiziOsWFtKTdAYsh/UmzqQs
        3UBgkJZSpCpmUBVbJz6ee8M=
X-Google-Smtp-Source: AMsMyM6nZwydnbhiGjYYOg1vjURXDJppqkZDoIFpqjmqd3F6r8dH8h2ooGiNvrvceeA+xaHFsi1eUw==
X-Received: by 2002:a63:8841:0:b0:461:24b7:a621 with SMTP id l62-20020a638841000000b0046124b7a621mr14679280pgd.277.1666321809230;
        Thu, 20 Oct 2022 20:10:09 -0700 (PDT)
Received: from localhost.localdomain ([111.203.234.211])
        by smtp.googlemail.com with ESMTPSA id f26-20020aa7969a000000b00561879b0f3asm13743395pfk.203.2022.10.20.20.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:10:08 -0700 (PDT)
From:   Jintao Yin <nicememory@gmail.com>
To:     phillip@squashfs.org.uk
Cc:     bagasdotme@gmail.com, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        mirsad.todorovac@alu.unizg.hr, nicememory@gmail.com,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        srw@sladewatkins.net
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through 6.0.0-rc7
Date:   Fri, 21 Oct 2022 11:09:24 +0800
Message-Id: <20221021030924.687-1-nicememory@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <41ef4b22-eea8-2d67-99d8-6aaae7d25ac1@squashfs.org.uk>
References: <41ef4b22-eea8-2d67-99d8-6aaae7d25ac1@squashfs.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 04:45:53PM +0100, Phillip Lougher wrote:
> On 20/10/2022 14:55, Jintao Yin wrote:
> > Hi all,
> > 
> > After review the details of page actor, the tail bytes may be written to
> > a temp buffer instead the last used page. So before diff would wrongly
> > memzero a page which is not the tail bytes in.
> > 
> > In this diff fixes it by caculation of the real index the trailing bytes
> > in and check if the last used page matches this index. If the page is
> > the real tail bytes in, then memzero the trailing bypte of the page.
> > 
> > Please help test and any feedbacks are welcome.
> > 
> > Thanks,
> 
> This is a rediculously complex patch.  Sorry, but, absolute NACK.
> 
> Additionally, it is poor etiquette and pointless to fix an
> already fixed issue with a _more_ complex patch.
> 
> Phillip
>

Dear Phillip,

I'd like to apologize to you for my serious breakages of code of conduct. And
I had no intend to offend you. I'm new to this community and I will do my best to
follow the code of conduct and keep with good etiquettes.

Best Regards,
Jintao
