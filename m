Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81B36B4BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCJQFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCJQEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:04:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2CC1514E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:01:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j3so3710371wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678464088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCSTFN7mHgYxqSe921dWL62i2uQGD0s88NiYVgn9G08=;
        b=osPTfAiC5HcnDd9ph3ekTh6WI1G27RKdxywNkX5VeLNk24rrwgmPDg1zfL+HAhSc6W
         RHAdS6C9Or3N5+xLYOQ0t75d+rkQMXZGMovBiFEoCfUa4tL39re7+ShvJVhJIZ/Ye2/M
         ZOPsq+ucc7Emp7FHits70eOi7L5/Jjlz+2iaBnX8wOMCTKVzNojEgvyb+auP4shpEngu
         RDp+dtBuDF5+jo7Vx89OJBo90bI6zybcjyTgegMTM9tiiD+mO2pjhanLiqBaOGBnEQk/
         NHFp4b1qSuXM+Dsmn4nsecC9jPc8CimhdjwXrQnDgJZEzGY/kD6ePnDb2NHuWCg+B8Uh
         9W9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678464088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCSTFN7mHgYxqSe921dWL62i2uQGD0s88NiYVgn9G08=;
        b=eFvJ8DRIIl8NuCJruraJtbSutic73Bg1qMIXQhaPijNyr49N+5XPUrHxRaNIiqfRg6
         3Odedtb+8FgHzeOO2I9FDpVIYU7yTu3ta+5Ey6O9y6FOqtPl+zL5xXSMmAQrhNmb1uOt
         FFKBwzq9epahiGfILH2rM63pXbWt2+UUyXr8afbuXcOT4aPOyOw3xeZ0GZaXl6oBc53U
         WO9goc98sw8EPUU0FqUvpjjwDsWkAosHfUkVe1vQHns+KsTTQEhA+Fxlm+Y9ZQ15v0oH
         VQOHaLJuONwkfUKSlcP9hf0Nys0rL6iidRtpSRmOrAR0GXDAYtWUt7I85A095dayZDmr
         C4pQ==
X-Gm-Message-State: AO0yUKVw3ZWByRilAfNMXNT1yOIzzPhOj/HIiwqTE7m5W8F3cTqBY3WD
        C3k2M8//MQMnQh5B6Hr4wdsCalRGKwqtUzuc
X-Google-Smtp-Source: AK7set+ScHzGOVj25/070zjmtWV+caFfAtH10FVf+Rg4IsndE27XAGe7wxc7BiNXhzYLuUjVk5Lzlw==
X-Received: by 2002:a05:600c:1c28:b0:3de:1d31:1042 with SMTP id j40-20020a05600c1c2800b003de1d311042mr3132413wms.23.1678464087576;
        Fri, 10 Mar 2023 08:01:27 -0800 (PST)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003e204fdb160sm360234wmn.3.2023.03.10.08.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:01:27 -0800 (PST)
Date:   Fri, 10 Mar 2023 21:01:24 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: alignment should match opening
 parenthesis in axis-fifo.c
Message-ID: <ZAtUVBbyMw7ine2e@khadija-virtual-machine>
References: <ZAZSmPpB6fcozGa4@khadija-virtual-machine>
 <alpine.DEB.2.22.394.2303062202500.3050@hadrien>
 <CACcTnM5GR0ZM5WBaL+BDEK_0QJGr6h2t4tnsnjerHta_nq6Tmg@mail.gmail.com>
 <ab0fd80-22c-d982-2f4-6fa5f43f858@inria.fr>
 <CACcTnM4OHFiGrEez6dMzd4jO4YuQZzqpUK86UBMzhd+nFDWezA@mail.gmail.com>
 <e06f57e6-2a3a-7fde-742d-9d5dd8dd49b0@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e06f57e6-2a3a-7fde-742d-9d5dd8dd49b0@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 09:13:49AM +0100, Julia Lawall wrote:
> There are actually two similar issues in axis-fifo.c.  You could fix them
> both at once.

Hey Julia!
I have a question. Should I send the two fixes as a patchset of two
patches, and should I send it as [PATCH v2]?
Thank you.

