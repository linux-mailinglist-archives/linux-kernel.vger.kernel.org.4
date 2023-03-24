Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95946C76F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCXFR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXFR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:17:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527575BA9;
        Thu, 23 Mar 2023 22:17:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t10so3277214edd.12;
        Thu, 23 Mar 2023 22:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679635044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgMJhwS2Xnu1dujWwQicC1P6s4ScU/HJCaTYtsPNp0M=;
        b=okXU+HSHoIR7zcb6P9r1xoc+cx3fT2BGV5Y7hEwzORYAzynz7H9Tq3+8rg4CrV+SYM
         gJ9P7yRdq40mjMrKZbzRUqPvpNXT5SdboO/sOO58FrxHsGzughp1KohcBJNZNXKhVmlj
         veGilEGD5ds1nSdcNJpEpSM9mGBi4v9Q/t/4rcZDzc6QEsxJjn6dHX5VfZ9H+akaSo3r
         d7oqekKcRJYqaqrRu41AozNCtMpmIQAy2zjvcjWPnW67pKh9nUEdmGxpy6M1sYoMBr6P
         SkwsMHbhT/tW4mc7yTj8Na1Oky00vh+B9eIux0PntL4XwqLmvZI2gnNz0ymW1lu8PAqg
         OrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679635044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgMJhwS2Xnu1dujWwQicC1P6s4ScU/HJCaTYtsPNp0M=;
        b=7lFOgGNesPJT4oec+4NYvxthaRVMLMx6DlSHO2JtwzNkYH00Y58HKOh6/geMr2fiLy
         qnLdoEpzh1ZkLlkB1/ZQ9s+R1PnLV9VsHUAU8WYTheZ/VGkSd5tLZj/k2X+L4M99DE+K
         bYylImQbdypUQT4bUgZWdDKFpOWyLqUNls820p73WzU58gpMX68dSsulVlJvO7DfEC6F
         Xma5vvnMwX47kyA9nnWQb4XfTMxuMk4ESL51uIFfvPYXB2z/xaw1M8Hs7ME5DANq7Nir
         2zWcIR7KweqWqL1zuyl9awH1qW3R7afuBcRhDWoPehGLdrX+AxudO4of/YscVWnL8Pcj
         3fbQ==
X-Gm-Message-State: AAQBX9cuBHvXshMbvugeTCWFYtVPK5h/9rvRpSpJCSuF2nZgEko4ohlP
        hzCe3g9uXe1biN5oMctNlPk=
X-Google-Smtp-Source: AKy350ZEzKVGkJLb1S+S7d1usg+6eblDIHjBC1JPcD6F69c5Qh2DRYPW87iMC6HXoiq8ghYOmhMYOA==
X-Received: by 2002:a17:906:9512:b0:92f:1418:27f0 with SMTP id u18-20020a170906951200b0092f141827f0mr1415192ejx.34.1679635043810;
        Thu, 23 Mar 2023 22:17:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a25-20020a17090680d900b008e3bf17fb2asm9759278ejx.19.2023.03.23.22.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:17:23 -0700 (PDT)
Date:   Fri, 24 Mar 2023 08:17:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        hust-os-kernel-patches@googlegroups.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
Message-ID: <adcd6c67-cedf-4831-9a9d-53c3ee2ebb88@kili.mountain>
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
 <ZBxy9LYz+JyNW6GY@kroah.com>
 <8271c37c-4995-445c-89b7-90848f7ef3cc@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8271c37c-4995-445c-89b7-90848f7ef3cc@hust.edu.cn>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:46:40AM +0800, Dongliang Mu wrote:
> 
> On 2023/3/23 23:40, Greg Kroah-Hartman wrote:
> > On Thu, Mar 23, 2023 at 05:53:10PM +0800, Mingxuan Xiang wrote:
> > > platform_get_irq() no longer returns 0, so there is no
> > > need to check whether the return value is 0.
> > How did you find this issue?
> > 
> > How was it tested?
> 
> Hi Greg,
> 
> We found this issue by Smatch. Our team is trying fix some true bugs found
> by Smatch, with the help of Dan.

LOL.  What did I do to get thrown under the bus like this?

> 
> Since this is a dead code removal, we only do compilation testing.
> 

Just v3 and mention in the commit message that the issue was found by
Smatch and the warning message that Smatch prints.  Put under the ---
cut off line that it has only been compile tested.

Also we needed to send a v3 anyway to remove the {} curly braces.

regards,
dan carpenter

