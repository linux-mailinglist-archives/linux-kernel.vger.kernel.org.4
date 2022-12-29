Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB2C6588B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiL2CqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2CqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:46:11 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED87EC760
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 18:46:10 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s7so17705003plk.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 18:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mmvRXkVVtaqaYs2yoaTeEYQ9ctHUESJNG5qerNoqkcI=;
        b=Ix5ubWHKT4dV/qTkpacuNERdaV/pX2Lv0NSwf2hKn2h50Uafq1sCp8pa7hTFkb0rDY
         MPN8DXuZlTc5LCMp72LnzbnXg++UeykvHnCrDI1pyW/oAhGr6pyoeuZuzJ10o/XDQtF/
         LEFK/9LadKv341M6apxIw7uRxGePY5e4mT/Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmvRXkVVtaqaYs2yoaTeEYQ9ctHUESJNG5qerNoqkcI=;
        b=BqT4FvcBF6NRBxa5hrqG9MvaQ/fSfraLZt8s+zoKOSF5XWVJm7aS6Kw24w5iKnttRu
         BRhmjaGTwaPyzNCOVC7yhC1jiM9uFtjK7hnU1dZKV6MDJdTcxcUSQMtU0DrZtxPjdczp
         vyQtUkpoBevoffHN6tRD2TX1RguzyTRsmPprL6ty3tQtk8cS/PM1ISum+1uLTYMk1Wnf
         2W9elBzIS3Zf5EaMGOG8eBfLIF57aCkA5j7tiMo0M+iFQhg5J3XLWwfkL+Hep47HPFgG
         IojrLxd0iRDtejQzs2aVqFdktqte2xOHVnUSptdp+QqMjuDzpAInlRN+ge12yZn9qTii
         Fy0g==
X-Gm-Message-State: AFqh2koHVKP86v4lPmdOHwdwolZHrM+z8ZLX/sNoTo35wTnda4oNPMhi
        jT6Wj94lqLsAwJ26fwVImArY4A==
X-Google-Smtp-Source: AMrXdXtnWdSyX0JgddpSXsDrcnaiUKWgj7lNBDws8U+1KJnJnXqzlQypQYWru2VMcWZWMAQxWFLCXg==
X-Received: by 2002:a17:90a:7443:b0:226:1cd3:163a with SMTP id o3-20020a17090a744300b002261cd3163amr4181143pjk.10.1672281970480;
        Wed, 28 Dec 2022 18:46:10 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090a66cf00b00223ed94759csm12806439pjl.39.2022.12.28.18.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 18:46:09 -0800 (PST)
Date:   Thu, 29 Dec 2022 11:46:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Yunke Cao <yunkec@chromium.org>, Max Staudt <mstaudt@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] media: uvcvideo: Remove void casting for the status
 endpoint
Message-ID: <Y6z/bXckwqvyB5Tv@google.com>
References: <20221214-uvc-status-alloc-v4-0-f8e3e2994ebd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214-uvc-status-alloc-v4-0-f8e3e2994ebd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/12/20 23:56), Ricardo Ribalda wrote:
> Make the code more resiliant, by replacing the castings with proper
> structure definitions and using offsetof() instead of open coding the
> location of the data.
> 
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
