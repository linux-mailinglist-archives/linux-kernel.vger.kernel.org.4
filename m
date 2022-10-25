Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBECB60D519
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiJYUCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiJYUCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:02:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52F211A951
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:02:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q9-20020a17090a178900b00212fe7c6bbeso7110468pja.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCSHnie7nbI2FMBFICWqa0omK7VXIgSVZ2dIjG4CBuc=;
        b=aDA7BbR3Ja4cnhevsaBBMfimo/Tqn1gci6sqSUsju2slvTnC1KiNQk9xbZU3gEbdtG
         qI9TpPQQtOxqFWJtSTb3KS8KmocPMKQxjmPQJj59Ulz12ko+3fQFa4taFNfv47qsFZtn
         xF0RUcQ5abUG6fzu5mZ6ezoTn1NEYPmsiKvKdWsW2CRmXdryNnNbkKWd8X20GXv+tq3m
         9IEAc7JzIJICO2ywwtKdaB5Bhw9VSiwWdG/fmlwBQIp+03eAJbpjMKgPQvQSEnnOHY+n
         SbcittWfXdXLk8G9hBut0LT3uIaCaqJ2/Z1/3iigRuYIHx/Of5Ow5GAJVZvZeaXJdDPS
         9klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCSHnie7nbI2FMBFICWqa0omK7VXIgSVZ2dIjG4CBuc=;
        b=M37YOQbr15RITf8/URw+j1ICUxcU91d7LTsXsBUslzLUxOEK1SA1YlsxbrERnkmQ6+
         0LD2ZMwoW3pJy0JJptaa21JHrHQIs9jFMHx5izbNFeeft50f9B3qnmAAZCNxSlUJUIXR
         6bMfcD/Z0gIreKMedS6aLHvew3A0ka7XPNnijobkNGwn4f0FdptopzOjxIn+gnAdX/nH
         287r2U+Gin8mozr4XnBeTxu8SsNQp8RQm7UfLYgqvQ/kZJwlfdW0eI6l5OfZCpoZWlhH
         wOvQc/u4F6E2yCc3zxFBrK+XYG/2B/gaHX3taThXOc9g1Ctf7b5ZNZELgTVlmvxFle0D
         Tt2g==
X-Gm-Message-State: ACrzQf1zjv8lF7ywnrjkIdvRtHqOpiOgfaMyJVUhzWZl3dJ3eALlxLDP
        vpYTDFa3VWNZFB7q4fLwgcqwn2b0YPIICL3g
X-Google-Smtp-Source: AMsMyM7VHjIa+QWIXmuv84bgv56y/nQYtKVdDumpW7B1YOYtnW8N1UD6p4iJ0qgiSeDw4z4Z88LBTw==
X-Received: by 2002:a17:902:db09:b0:184:ba4f:af28 with SMTP id m9-20020a170902db0900b00184ba4faf28mr39823489plx.145.1666728150208;
        Tue, 25 Oct 2022 13:02:30 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id i12-20020a056a00004c00b0056bd737fdf3sm1743129pfk.123.2022.10.25.13.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 13:02:29 -0700 (PDT)
Date:   Wed, 26 Oct 2022 09:02:22 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [next] amdkfd: remove unused kfd_pm4_headers_diq header
 file
Message-ID: <Y1hAzn9zXhQYj1NL@mail.google.com>
References: <Y1eoYDDZWdyLNlBc@mail.google.com>
 <f2b6f0e1-1ae0-21ec-372e-6e90827ccea6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b6f0e1-1ae0-21ec-372e-6e90827ccea6@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:48:33PM -0400, Felix Kuehling wrote:
> Am 2022-10-25 um 05:12 schrieb Paulo Miguel Almeida:
> > kfd_pm4_headers_diq.h header is a leftover from the old H/W debugger
> > module support added on commit <fbeb661bfa895dc>. That implementation
> > was removed after a while and the last file that included that header
> > was removed on commit <5bdd3eb253544b1>.
> > 
> > This patch removes the unused header file kfd_pm4_headers_diq.h
> > 
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> 
> Thank you for this patch and the one that removes struct cdit_header. I am
> applying both to our amd-staging-drm-next branch.

Thanks!

> <snip> I'm also fixing up the
> prefix of the commit headline to match our usual convention: drm/amdkfd: ...

Noted! (and much appreciated too). I will ensure I use the drm/amdkfd
prefix from now onwards.

Paulo A.

