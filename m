Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7802565898D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 06:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiL2Fjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 00:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiL2Fjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 00:39:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87D21275E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 21:39:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ge16so14578214pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 21:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJVgFP9p0T3Lnh/LDN8eGGuBejvROxZ6Og5HwzyTc8I=;
        b=jJCGltsQPX6Qv8TRJHqdAjYUa+IYlO8sR8HEt7JpAKB2smlHkAzRKRZDQ67ES9fPLd
         ik4BsJ9UiY60diSEFkgxhCUwWWr7yyf7X9/1TNwJmnIWqiA+GCmBISklZ0QtgXxmnvrY
         0YHx91srfTMAQTcs7lRFMDvf1ize0O/ThsJHBfdbOm4McBZh54xaszIKPVm2DcyAuAXR
         5CCwtCeTdd4yFmvNmUDbBR+L0ESxQS5j6cDrvtPZ7ulcxmc4z5O+1aDLjp4dCmJk9KF9
         KqCS644yLhFesPEQYjxMKrgV/0S+V9W4DiIHnD52rq2bVtNt1yTIpKoJ3XYYQLoUWUhb
         +a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJVgFP9p0T3Lnh/LDN8eGGuBejvROxZ6Og5HwzyTc8I=;
        b=7Lf0x4+PgXrAInaEUw6L5GDyFTQLxa2TP4Vyt7RXopt8OOQFwS6Iz1AqvNV/apswVa
         z5OMxohOIofH8JpEbmA+XvEdmWj0ALrIdLSt63xYSzYOPI6CrTMPUZt9M3anyJU+HOLC
         l5Xg3qygDa02O3MWoroW5z5ncfs7dm5S0Mb9Jp7H1wZkg/ds0KEJVAAs9VGuLEJX2xbj
         CZIwF5fgD28cPxKSBBW0MDJJA70D7klGkbla6VowSnfGsHXu+od1DLIGemn4lEdzvF9A
         woD0cq9HntYyXLYNS2NBLUacGfm86VECU+iRK6Thvz0iPwQH/noGTi3x2kp3rDHMr7C9
         OyXg==
X-Gm-Message-State: AFqh2kr6mxY8OY5+cdiuIPGd539rxjm0qsjlZh54FmpFRB5K2Ia3tgpd
        yLq+dXRTwSNntbwuh5oXxoNIcd1vmG4=
X-Google-Smtp-Source: AMrXdXvupcNB5sbN99+ycnzo+1JaxtlavecaXAikTG5AYI1kpcxtLY2202qCBA+gLn5ZOJPIX7zR3A==
X-Received: by 2002:a17:903:200b:b0:192:467e:7379 with SMTP id s11-20020a170903200b00b00192467e7379mr24714408pla.49.1672292391188;
        Wed, 28 Dec 2022 21:39:51 -0800 (PST)
Received: from nlap2 ([103.158.43.18])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b00189327b022bsm11796750plz.286.2022.12.28.21.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 21:39:50 -0800 (PST)
Date:   Thu, 29 Dec 2022 11:09:46 +0530
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: Fix slab-out-of-bound write in udf_write_aext
Message-ID: <20221229053946.q5kkllxd6s6m77rb@nlap2>
References: <20221229050142.448537-1-abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229050142.448537-1-abdun.nihaal@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

I just realized that I have been working with an older tree and the
patch I sent does not apply. Please ignore my previous mail.

I'll check if the bug still exists in your latest tree and
I'll send a newer version of the patch if the bug is still present.

Regards,
Abdun nihaal
