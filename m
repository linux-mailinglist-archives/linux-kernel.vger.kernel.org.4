Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2B068224F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjAaClC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjAaClA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:41:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA7112849
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:40:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 88so12915335pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=alDr8rnuCdi5UnNlDrRyh+KO4l3lmqdwsUiDHxjRReQ=;
        b=oEXi8wHoUktKmI2sc94o06ppFw5nran23Th+8v7ax2OM+x+0k2Zp2IdQICC9xdWg/B
         nIZBwEYj8h1E6/9ezOas2DcYAg8xv8K/Rn2/yJGB7L+WdAvIL0RbepDl4SFd2m1yrUqq
         os0+09i9UcvmWNRpLvQJk8LdNGIWOW3whXxU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alDr8rnuCdi5UnNlDrRyh+KO4l3lmqdwsUiDHxjRReQ=;
        b=hlVvS+6IZ/vpop0nbjAjwrTuGWyHse77rJQYq0i6oaUOOcjVH+bzUTQFu/dU7PDD6D
         0HKGtkjDUelel3B50vHK2fO34XH2/2xviZTx/f7khwdCaFzba1GDfAQTawaTUTH1RE1v
         LHtDK0rpzhYADYoAP+DBe60Bfg0647MNaJDrM05tuQdltQqf052Oc5B27Op97PMyRErt
         caFarKZBPTK9ZmaUxLjoHOQY5OWQ+EoLFNbgR2iMdQQemx/wvvjWaYcTQ3tiGWgNyyQS
         awe/rNlVm/UY3G+EMgABtGRgVWu5jG+kpTAP0stcN2AK93PtKBTJc1L5i62DJiWE/sK2
         Y6JA==
X-Gm-Message-State: AO0yUKXo03ZePQK7xefnbLKNPDacV67SqN/n5+P9OwQY5ZkdHRysDwqX
        XA6CXuvzqjXrnWKJNbyjIH3aEg==
X-Google-Smtp-Source: AK7set8KEiRNB4VK5ujMQHqAkva5XQPwI7xJP2sI9JcJ39lI8c2XRJiSLWH/d+PHXTKmQp7rsnmsKA==
X-Received: by 2002:a17:902:e2c5:b0:196:86ce:ab6b with SMTP id l5-20020a170902e2c500b0019686ceab6bmr4266853plc.3.1675132858898;
        Mon, 30 Jan 2023 18:40:58 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id ik7-20020a170902ab0700b00194ab9a4fecsm8435934plb.138.2023.01.30.18.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 18:40:58 -0800 (PST)
Date:   Tue, 31 Jan 2023 11:40:54 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, hyc.lee@gmail.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] ksmbd: fix typo, syncronous->synchronous
Message-ID: <Y9h/tt7Au7EUUqZU@google.com>
References: <20230115103209.146002-1-set_pte_at@outlook.com>
 <TYCP286MB2323A6AB80B9EFE1CAB86003CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB2323A6AB80B9EFE1CAB86003CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/15 18:32), Dawei Li wrote:
> 
> syncronous->synchronous
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

