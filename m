Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A686C6799
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjCWMF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjCWMF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:05:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A649D50B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:04:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w9so85441990edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679573050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AnbYtNnlzzUQXg+5sh9fvVtP5rpKDt1j7cHIJ/Ccm7A=;
        b=MEqxckmFA/t4XUBdp7zkwHodfWMJSzg9HH1+3fxAvT3VK8JdReO8kpSSUrBjeQ9A16
         Aaz/ZD27sm9R9MVs4cE4K/J4EFql8L/ZtjfvIQrazHph1bKcS/WZvLszbIcXgelgTxHr
         q4A3vctN8FT677qsn/7aTH+m7BbC1XymXwf3ixpFaUU4CL6IA9jjc6hSn3a7QwCkV2J1
         fNI/iqiRkYRSWNdXDi+fHIMZPne9WdNmRHbVWlO+ZVQpxZtUWFdIjzHTh7mWCoEcaGFT
         gwT0HbTa9pV+tj0pjrzM/f7k2YGBh/GCP2gwLAJudKOhOEIb5vfFMlPIn1WogObkvybO
         6aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnbYtNnlzzUQXg+5sh9fvVtP5rpKDt1j7cHIJ/Ccm7A=;
        b=QhIADVAuESB9DhTspA7gHeJI4/8A6Bvw9WYZpzML1PQax0vp34E24n6TiRXoHyHiX1
         uI92FOJCEjXXVqBmK4BRbaz8LMc05vVW0Xk90l2aRaddnZCKG9Bif4ZkOGtNwFdp1gVH
         YEEdbUGiauUM/G/ToUOBddo337IiGLxaURCpIMfqVZeIXxVztLD4O+oHOh00aFrBxHI1
         rFuWqJslZw6KaKMFHhnP4pUTJ+sj911HWU+e2/7Dx/p3gSLz2N02YzHgz8gfXalE001J
         HWEabKCmqAstLbigSzuNQQT7BvhwSf5sSzgDSLkgPb0Ce7ESU8MaXf3SR97a/EZNrzBW
         xBkA==
X-Gm-Message-State: AO0yUKWtvR2UQTiy6LwaDR7aZVYap6Rlq5mQ8geLRnNJjtPa5tAF0qR+
        no16hf2ErxLVLnw2aaC7aWEDsqipubojF8f6
X-Google-Smtp-Source: AK7set/IfY5+JeNps0uY0WIhutpb2BPEBr0Ch8GjVZHmOhLHZm85AnDwXsyBuClOvu0pWT4tei3dhA==
X-Received: by 2002:a17:906:8553:b0:928:d4f6:6f77 with SMTP id h19-20020a170906855300b00928d4f66f77mr12226869ejy.29.1679573050392;
        Thu, 23 Mar 2023 05:04:10 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b008bc8ad41646sm8465454ejb.157.2023.03.23.05.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:04:09 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:04:07 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Khadija Kamran <kkamran.bese16seecs@seecs.edu.pk>,
        outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] staging: rtl8192e: code cleanup patches
Message-ID: <ZBxAN0YkVQ2xSkZi@khadija-virtual-machine>
References: <cover.1679521517.git.kamrankhadijadj@gmail.com>
 <9cdfab96-ee7d-db11-4bde-71648a640385@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cdfab96-ee7d-db11-4bde-71648a640385@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 06:56:32AM +0100, Philipp Hortmann wrote:
> On 3/22/23 23:07, Khadija Kamran wrote:
> > Fix several cleanup issues reported by checkpatch.pl in module
> > staging/rtl8192e in file rtllib_rx.c
> > 
> > Khadija Kamran (4):
> >    staging: rtl8192e: remove extra blank lines
> >    staging: rtl8192e: add blank lines after declarations
> >    staging: rtl8192e: add spaces around binary operators
> >    staging: rtl8192e: remove blank lines after '{'
> > 
> >   drivers/staging/rtl8192e/rtllib_rx.c | 73 +++++++++++-----------------
> >   1 file changed, 29 insertions(+), 44 deletions(-)
> > 
> 
> Checkpatch:
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Khadija Kamran
> <kkamran.bese16seecs@seecs.edu.pk>' != 'Signed-off-by: Khadija Kamran
> <kamrankhadijadj@gmail.com>'
> 
> Is this wanted?
>

Hey Philipp,

Sorry about this. 
Let me resend the patch and fix this problem.

Regards,
Khadija 

> 
> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
