Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA80665BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjAKMr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjAKMr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:47:29 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E51E56
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:47:28 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id bj3so12555568pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOeVnxO+fE7bo4EmMWsOcdPE11gX4zgt6EQ8dlbpp8U=;
        b=Yi2qmkmv+mRzCarqDHjfD0S7azXhXzNqIGQB3u4MZ1VHuMgth/v8reC34x22ORPAth
         ZlvST6EHMkvSGBt3DyA40G2CmhWVUy8bRpzmhEh5EtVJf6vqHTRwRjBZcjowCtPpV8Jy
         ewaRREFW/LIFxuifjg24jB+ervuVlFAZ68CRFuJsneP0mjtvRHixBnGGZEBT9c5bLntM
         4oZakGimJYWUHJmdOnnZqYKMPly70jS3Dfdav/BjutSaasrEpkPmyVelG4xmrjc7vJUm
         4+3fvKi5sDBWBm0CRhcnMPEvQjKDE4z9J586zmnE8kDFKGjzUtomphpshjsH74cRk6dm
         NqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOeVnxO+fE7bo4EmMWsOcdPE11gX4zgt6EQ8dlbpp8U=;
        b=oSDJfNIDT9nKuH9V27fG2jelHgszDFdVTF5IRyDibA0o5PSzM0s7/AUL8CnF3NLVRs
         RIlqdZ+SxzeRh6UL0A9z7x0KOXDMYSLPMY8v1/8hvq+synTtjNPBoHSzoTZzdKezMetI
         fEcMwoBC/mNm+BD2rb4//dDUB9EeydOBLhFxsuUb5TWKa5TOH7hn5IjjSLlKKbqXmzAQ
         /4PIHdmF48bckYjXWP2jwVbTrGGT+ZSn0Uq23MvhDatIYYlSpnYcbqwtSX6Z5cEmzWv7
         w3Aka0s46spRgUQ8zEj9kDs8X1WXOGGUhyj9UKB0KDeRvmyhVxZFkksXDrEZB3Zz2vnd
         y0uw==
X-Gm-Message-State: AFqh2koEFvfXSpxCu5m2ZC0Msg4TqCai+F5+erazVSBJipMdcHuyRQ7n
        9z12+w+Q6nNp/bROBgcOmyg=
X-Google-Smtp-Source: AMrXdXsg06VXz/Zz0HN6/K+KyjOZvQhnmMAl9dKpDyzZlSXH7uoabAmRViaVEtHhl3xJ8+IzVkBfEQ==
X-Received: by 2002:a17:902:a60f:b0:188:8745:35af with SMTP id u15-20020a170902a60f00b00188874535afmr2218809plq.63.1673441248315;
        Wed, 11 Jan 2023 04:47:28 -0800 (PST)
Received: from vernon-pc ([49.67.3.29])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b00192a96f4916sm9990241plg.259.2023.01.11.04.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 04:47:27 -0800 (PST)
Date:   Wed, 11 Jan 2023 20:47:22 +0800
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: fix comment of unmapped_area{_topdown}
Message-ID: <Y76vr/24l8Vfv27R@vernon-pc>
References: <20230110150320.1676299-1-vernon2gm@gmail.com>
 <Y72yC04t03AOHQNI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y72yC04t03AOHQNI@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 06:44:27PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 10, 2023 at 11:03:20PM +0800, Vernon Yang wrote:
> > - * @info: The unmapped area information including the range (low_limit -
> > + * @info: The unmapped area information including the range [low_limit -
> >   * hight_limit), the alignment offset and mask.
>
> s/hight_limit/high_limit/

Okay, thanks you for review.

>
> > - * @info: The unmapped area information including the range (low_limit -
> > + * @info: The unmapped area information including the range [low_limit -
> >   * hight_limit), the alignment offset and mask.
>
> ditto
