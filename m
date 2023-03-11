Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5E6B58E8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCKGY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKGY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:24:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE45136FF0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:24:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id f11so6938109wrv.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678515863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEAB5UcFKezf78Y1Bog4LTa3d4NoqJ+/Ij4qU9A9IPM=;
        b=qRlBKCXOGW8I0xIQseEgSFEYMVA2cZq4nrO1Y1iZTSKp3cUIe/mIYsvH4wNUEvBWmQ
         /e6Ni0ss8msM+FSMTy+7KUG7xVEHhQ6ANHjr/5uUsSonnjbb/6wa64f4XB9JJ8iZITK2
         OHGtcjGmTnDTGMPfxXrpgLI8y+uDogS9Kpk++e4biWraJnxnbeg6QIfyrEm9huKaDCwz
         iosk6VIuoSS6HOdACj6Sc4mdrQJriqsZySlEnpDr67EZS0klL/1DoIBRJekPh1w7V+ld
         kfPFHb/bii2T/uF1xmZ7WisM37dxYmJrSGQopqatKWutC4Kn4ac9bvJQU7C0GyNH6jS7
         FUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678515863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEAB5UcFKezf78Y1Bog4LTa3d4NoqJ+/Ij4qU9A9IPM=;
        b=uPFyzGZpaLwauAXAtSxuDQmuT/KVEIMyKX4jopVmWW1E8AscoOzfw9RlM4m3WLoyh3
         +IEy98rTBD/s9y6AuwfiYhZa/hsooKnExRVicfhfF1VWXfnfwBqgdJ1rXVxAcL55ei+/
         3UkPMaskeE/WPUFsI2+vlrB5T/mL4XpQ/0D9K72RKgUd6QcCU1sfdIF7XlSBM06PJX82
         j1y9HoW1sxxjQk33EdcqSJxxzDDFYYXRxtQRdao6Wj24au0TvqlJPqTSCzcDXal0kjmi
         BxxY/Fgab75i+0DZkLKf9YKp5OTfBhZJQ1/yiQNHX9kaZEQkN8MLvINfdsAjyXNQGsdI
         b18A==
X-Gm-Message-State: AO0yUKXVmLLEvjloMxP4oLHiTDVRnfauh5K3Yvz0LTzRkl3gHt+Jxjjz
        WQmZ37/Z9QHqVwzURhtpn0wJWE6HVvkObZFu
X-Google-Smtp-Source: AK7set8Jzcnic34saMsxy6VPjJLGDWjdB3YrVpyVGMeXFbMQMcUhMKG2K1kpLHtNqeccy1biBp1AMA==
X-Received: by 2002:a5d:67d2:0:b0:2ce:3a46:cef with SMTP id n18-20020a5d67d2000000b002ce3a460cefmr16390394wrw.3.1678515862847;
        Fri, 10 Mar 2023 22:24:22 -0800 (PST)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d58c7000000b002c55521903bsm1549822wrf.51.2023.03.10.22.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 22:24:22 -0800 (PST)
Date:   Sat, 11 Mar 2023 11:24:20 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: greybus: remove tabs to fix line length and
 merge lines
Message-ID: <ZAwelPOv45zThK6j@khadija-virtual-machine>
References: <ZAusnKYVTGvO5zoi@khadija-virtual-machine>
 <6e9fd119-6566-4778-899e-bc5a7ee7830c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e9fd119-6566-4778-899e-bc5a7ee7830c@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 07:16:19AM +0300, Dan Carpenter wrote:
> On Sat, Mar 11, 2023 at 03:18:04AM +0500, Khadija Kamran wrote:
> > In file drivers/staging/greybus/arche-platform.c,
> > - Length of line 181 exceeds 100 columns, fix by removing tabs from the
> >   line.
> > - If condition and spin_unlock_...() call is split into two lines, join
> > them to form a single line.
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> > Changes in v2:
> >  - Change the subject and log message
> >  - Merge if condition and spin_unlock...() from two lines to one 
> 
> Apply your patch and then re-run checkpatch.pl -f on the file.  You will
> see the problem.

Hey Dan!
When I run checkpatch.pl on my file, I can see that my old CHECK no
longer exists instead a new CHECK is mentioned saying 'Alignment should
match open parenthesis'. I understand this from your previous email.
Should I stop working on this file and leave it as is?
Thank you!
>
> regards,
> dan carpenter
