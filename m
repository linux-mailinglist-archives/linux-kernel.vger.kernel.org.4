Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47F63ED0C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiLAJ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiLAJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:56:51 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF6989AD6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:56:51 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s196so1230667pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqsJUdWwznGqXZHtZVA2Lf6JtI1sIvSq0mnVMZoABzU=;
        b=gsrd5EKpo1Q9NB6hMks9e6ZGYCv1uY68U5vZVd2eFVDz8q7XPgalNkYRTRms1M1Nu1
         LxPS6fDtQlB1/ZFgiAsmdzCLKttKqSPo0mCUohzEzTXGCSBfusrJbLInZ1gI+SerCj6s
         fB9TOiy/g0wszX1Nga30ZozDsydc70/tfH9THTfjAqjFui3cVB0bL3DiWY6UfQebfTzH
         wJnTxpAj+pc4MdbGJGEJ8QdkaTaMdgB33MDAT0hZrrA9sV9c80LYdO925YYOl320V9HE
         Hiz8li0/4LB4bEoVlmUoI13X6SxWyo9CKeMY9qb+zQzaHLWkjUVOyja1b9rYf/0f6X/H
         6T5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqsJUdWwznGqXZHtZVA2Lf6JtI1sIvSq0mnVMZoABzU=;
        b=Gvvym0GzXOtBKLgD/lE12jMMyVhVrsEc128/IWEVWUksl2wN1U8x6lxH2bQX9I9wQK
         c9IBVICp17QS1ePfo+I6wJvqVEARPRzJwa2+VetaBFtLTwi2HNkF6L3ibWKUkT6ftf8P
         QskjWyXu1GUxaI++tNXUjoVZsV4DCJX37eiUbSrPfo1GQfpy+vbIOWqYdlZ+rsB7gHQW
         248QKMMTAAsOxhXgViwgJYy6KIcZGMRLLQ6xKYR+p0aeRMwdkhz0cmnMI1XnZuz3Y6Ja
         wO9YTCsZpCh11hUbsejVnuPWyblC0+6o8Z5V72/jjPrdu44QYBvvzcfNxnzltjsv4sl3
         cvvw==
X-Gm-Message-State: ANoB5pmkAoxXWSJPmjlMjol+6k6zppNlm8g8+E2p4fY8/gBFXbTNNAtW
        pGio7kg3x3GC3Z+8rtiaZGA=
X-Google-Smtp-Source: AA0mqf7RghXXlO8gRxDwp+ChtvGd5wJmrCaV36gfvsTBJxWevgcV9b+c8L2dYgEjI8Zhy2pPbdvdsw==
X-Received: by 2002:a63:de4a:0:b0:429:983d:22f8 with SMTP id y10-20020a63de4a000000b00429983d22f8mr38963195pgi.165.1669888610601;
        Thu, 01 Dec 2022 01:56:50 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b00178143a728esm3130114plb.275.2022.12.01.01.56.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Dec 2022 01:56:50 -0800 (PST)
Date:   Thu, 1 Dec 2022 18:01:02 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: update documentation
Message-ID: <20221201180102.000011a4.zbestahu@gmail.com>
In-Reply-To: <20221130095605.4656-1-hsiangkao@linux.alibaba.com>
References: <20221130095605.4656-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 17:56:05 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> - Refine highlights for main features;
> 
> - Add multi-reference pclusters and fragment description.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  Documentation/filesystems/erofs.rst | 35 ++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
