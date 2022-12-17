Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227AC64F8E9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 13:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiLQMHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 07:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQMHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 07:07:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F163881
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 04:07:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h10so4805441wrx.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 04:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpNFXXFL69ndIoEgbS5lBM2ElXTRVqEor6edUWSntXM=;
        b=Y8TtUr4wFHKXkFj0immup8NKR0AwYJjBJ3BFuOxTrBlT+aVsVPaUa3nqnYVAmlklcz
         MGQV9UuzDByAGD670+r+Szf2jGPvGt9KJbJM9wSkrXRHfKhvK/kwr3IaJs9OukAZnbLg
         wlzqxDY2m9EkSZqVNrLNWQHSHxYnbsMATxWzvnpmoLfjq4h82xmkrNCRPfGidecNAYwO
         yzsJKFG63ZeSplFhgtyAWJiHWb9eQO6INsTQPbqu/xVSQj163/sWtxa0EP7MnL1+eMS2
         dMkEKbnGadk9C7/PcnXur3L8TOfyF5xtg1EpdhAQxKKe8iva8KSvg0kShEI1YnrR9Elb
         keeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpNFXXFL69ndIoEgbS5lBM2ElXTRVqEor6edUWSntXM=;
        b=LWVVyBwg9tPDaAz7VxARDklWr2zc0+WY0hUIGtyYgYQbuZ2forthOIfuK+9Odgogp8
         1/tKDwnSSZ3vbyZFpWr0Z4Qb3oGvDgSyNrO8nbmsgcaiWfRL6iePJSQxAd2yhNZJPyHU
         T1o7AzmSWAP8pIvHAKM/gXp9jFh3XkphacftWC3XmP4EjZADU1goIltJFcbebGJtDQ7m
         KbGvhVbP0uchmWSvqM0DjInY0kCT8n1o9cGSPD+A/CwX6Hy1mmdxR6rBsAUpPZUpbMx4
         Mi/82silzM4OAh9Owx9qGGTg5mL2hvYDkAa2St0L19fCo2gQr2JXjX7CGksO7a9Gwoni
         HTjA==
X-Gm-Message-State: ANoB5pnpfGg0dNxJNvylQQkpsr0J68wUPWO5Qy0MjdlKQDpreeqX4TYv
        LQvh/muTVc30n06dg0L3scg=
X-Google-Smtp-Source: AA0mqf5WcLYYg56e9RSOHdx8GzTZ8XCuimdDVsra1khNAyBHH8mhO3U7SUwxP3wQadIQHpNZuVGcYQ==
X-Received: by 2002:a05:6000:1e02:b0:242:6aad:879e with SMTP id bj2-20020a0560001e0200b002426aad879emr24265849wrb.7.1671278848265;
        Sat, 17 Dec 2022 04:07:28 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id y5-20020a056000108500b0023657e1b980sm4824492wrw.53.2022.12.17.04.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 04:07:27 -0800 (PST)
Date:   Sat, 17 Dec 2022 12:07:27 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 5/7] mm/vmalloc: skip the uninitilized vmalloc areas
Message-ID: <Y52w/w3IqJ0SCI6I@lucifer>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-6-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217015435.73889-6-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 09:54:33AM +0800, Baoquan He wrote:
> @@ -3617,6 +3617,11 @@ long vread(char *buf, char *addr, unsigned long count)
>  		if (!vm && !flags)
>  			continue;
>
> +		if (vm->flags & VM_UNINITIALIZED)
> +			continue;

This comes immediately after asserting that vm _might be null_. This surely must become:-

if (vm && vm->flags & VM_UNINITIALIZED)
        continue;
