Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F7868B09C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 16:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBEPee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 10:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEPed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 10:34:33 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB9C679
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 07:34:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id eq11so9401275edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 07:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ShtkLTPjNrJzQ0L8SVzCHY/1C+Lm1Un3JR+RBALXC6w=;
        b=ZYRSlffZ7dkgtXVrG3qS2GJdi/lX3qhPKeTobB5VVgCtg4Ka0a4GV/csaSwI0r/mHt
         oF3GQDFZi8deEprWblO7oRt6xZ8vjSqa16EVHzpxGhcR7s7JVLTlJOKseJ0NjsaRRsib
         Cyu95WUFtQUq5GcZq9YDuFgDe7aMR/q7cvE7hLYMZdaxGGUqDwVdzC/AMIuHlgrz6sXW
         0Z+qmv94pwuK4SM3EAh7YSjYqUXKkC0j6MCPO2RUOmso4L5zQdLM9DVh14/a31rzFv0K
         S7eHCMu3sLdV4UxvdRJ/wqMAaTRUAC03/y43nbl3P7vCdYEpuaMQO/w9+x0dx9G6zmwZ
         /5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShtkLTPjNrJzQ0L8SVzCHY/1C+Lm1Un3JR+RBALXC6w=;
        b=N+S8e7q8AtDFNaKqFAvIXjrqtcgFfRdupNFd9oVOUzGU9nSHjM6Cu4lIsknBQTeZto
         kJeG5WMaY52YEb/7tQ+202nHTLqycYU8Kk2j4WOCD0bhGecWc4CW+8fmJTFR9MSLJdMC
         GUTAPnXf1RQ3k1C/FQhkj6niTZG0Iiz0DV6m6wWva1zlsQj7+I2y5N0TLIdHCc5aL2Vn
         14aq/QPIDjQF0Tqkbxa/KFc/gN1adI3kt5tH/tamEPd5iK8eYGekajBzxZG9lPxI8QI5
         qfl+k//QIcsrxYSevh12gVksFGs+ZOaOglV5aWciG56KGn16oJyzNPvmiH6WvpStJrWo
         Q+wQ==
X-Gm-Message-State: AO0yUKUrwZJK05mciL+lrKvYBozqHE8Opd6TNormAi+2zTBJhfmieKc+
        3EDat+QLuEy0yruQi0YUIhLIhOfaW4Q=
X-Google-Smtp-Source: AK7set8Sjcre6BymbpRvgzUlDPHHfWmar7l0fJB1FSQ/FOPgrAhR7OsE4wVC/rNTuhP+dzQ5un6uPQ==
X-Received: by 2002:a50:f69a:0:b0:4aa:a3b5:522 with SMTP id d26-20020a50f69a000000b004aaa3b50522mr4894358edn.12.1675611270936;
        Sun, 05 Feb 2023 07:34:30 -0800 (PST)
Received: from nam-dell (strongswan4.tue.nl. [131.155.9.107])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7de8a000000b004a21c9facd5sm3865601edv.67.2023.02.05.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 07:34:30 -0800 (PST)
Date:   Sun, 5 Feb 2023 16:34:29 +0100
From:   Nam Cao <namcaov@gmail.com>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <Y9/MhS3pJ/Es0sGa@nam-dell>
References: <Y9+qMqYD2zGWRurD@combine-ThinkPad-S1-Yoga>
 <Y9+sFw0rviTAJNMf@kroah.com>
 <Y9+vkwYfQzYTbIIo@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9+vkwYfQzYTbIIo@combine-ThinkPad-S1-Yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 02:30:59PM +0100, Guru Mehar Rachaputi wrote:
> On Sun, Feb 05, 2023 at 02:16:07PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Feb 05, 2023 at 02:08:02PM +0100, Guru Mehar Rachaputi wrote:
> > > This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> > > as '(iobase)' to avoid precedence issues"
> > > 
> > > ---
> > > Changes in v3:
> > > 	- Whitespace error from checkpatch fixed
> > > 
> > > Changes in v2:
> > > 	- Macros with one statement that is to call 'iowrite8' function changed
> > > 	to inline function as reviewed by gregkh@linuxfoundation.org.
> > > 	In relation to this, names of the callers of macro are also modified
> > > 	to call this function.
> > > 
> > > Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> > 
> > Try to take this patch and apply it to a tree, and see that everything
> > below the --- line is thrown away, including your signed-off-by: line :(
> > 
> Sorry, should not a patch contain signed-off-by: line?
> I did not understand.

Patches must include signed-off-by. However your patch has it below the
--- line, and git will throw it away. You can try "git am <your patch>"
and see for yourself.

Best regards,
Nam
