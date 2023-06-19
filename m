Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848E8734BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjFSGny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFSGnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:43:52 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4884F1A6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:43:51 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b13e2af122so2185725a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687157030; x=1689749030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcz5YhvDWo9nMHfrg8LSktuXw46EWE7Cp3QeJgkSwTE=;
        b=LQh3szetdHM+fLNYjwGz+X0VS6/aRK9FnpzfrU51Wz/KPC+7bYIMu6ARsuh5ukHZT4
         fhrs20Btt++OwXu8NMn1Bqb0BsVBd4F6Z1xV5wZk8qaYUNnrqKrTD9c6OToLvqbZKkir
         paXANcxa81+mlAzCCWndqdEBCQ66h0Hd4Z0dR5LTuh+dLVkq5OacNbWHmm92npfg8+ec
         PCk2Avg8kGY8+F9fu8YTWbg3SPIvXWKF2+cOrx6vKoLSUdW1RoYE2T6k6mur2BzTyj+p
         yqYquc3YpaH+3qjiMTgz5UsKWdcNP7XLaTuPI1UU6WEcLe4iSlSPqONB9plGuma6xqTd
         eMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687157030; x=1689749030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcz5YhvDWo9nMHfrg8LSktuXw46EWE7Cp3QeJgkSwTE=;
        b=R9yM/5f+Azihu4i9OHNqlpjM7lviZDc7vFUZ0PSnhjg1Obt3ihpsALVcg8YumyVqz/
         7hsu909mBLBXSn39LYJcks/GryQXlwrzrELe3KxvDsra4s+1UQ3fhYE8LxBN3EG9re4o
         lgHt/pEeIVey8I1oOqw6WVA8hpN1+NNcIhZF2VVUIeZ897DNnBZIc6IgaOy3XJdHWWH8
         bMDmU7buCXRdVGsRFsKuKWvqK3NPvTyLlWnp2D4hMjMYVX7U8KFSKLBbMZUPDDhAZCng
         20mfVEH3bH2pUHZQ4Fh8TDUFRUSe79KxwYc8gnXFkL5US6hcQGUVulfZXhkLYuVVc0H5
         6F1Q==
X-Gm-Message-State: AC+VfDzafjAsa2hnaDjBYnS7CxtlWgjgKNBhMeDVOBZ77prXWP0OguzU
        07bApZUGd3qyO7jZqM69c7Q=
X-Google-Smtp-Source: ACHHUZ7hnsP1SpKLEg4iXqF5ZLMnTU4bawweCSpP8YiMUr6Ed5E6li0w/lVKIhZjxzMVBHbqC0fgZw==
X-Received: by 2002:a05:6358:cd23:b0:129:b96d:1b0d with SMTP id gv35-20020a056358cd2300b00129b96d1b0dmr1286509rwb.1.1687157030454;
        Sun, 18 Jun 2023 23:43:50 -0700 (PDT)
Received: from redkillpc ([49.207.216.186])
        by smtp.gmail.com with ESMTPSA id s188-20020a635ec5000000b005538bf7e3d6sm3513612pgb.88.2023.06.18.23.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 23:43:49 -0700 (PDT)
Date:   Mon, 19 Jun 2023 12:13:43 +0530
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        error27@gmail.com, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        oe-kbuild@lists.linux.dev
Subject: Re: [PATCH v5 1/2] axis-fifo: use devm_kasprintf() for allocating
 formatted strings
Message-ID: <ZI/5H+GZU6/2osGT@redkillpc>
References: <ZIiTL5bzMUgs3L5K@redkillpc>
 <20230616152602.33232-1-prathubaronia2011@gmail.com>
 <2023061750-blog-curse-c1a3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061750-blog-curse-c1a3@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 04:00:02PM +0200, Greg Kroah-Hartman wrote:
> 
> You are doing two different things here, one is changing the allocation
> way, and the other is the name.  If one of those things turns out to
> break something, we have to revert this whole thing.
> 
> So please make this two different changes, one to change to use
> devm_kasprintf() and the second to change the naming scheme, ESPECIALLY
> as you do not mention the name change in the subject line.  And that's
> going to be a user-visible change, so you need to make that VERY
> obvious.
Makes sense greg, will do in v6.

Prathu
