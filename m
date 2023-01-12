Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9063F668743
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbjALWtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238392AbjALWtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:49:18 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F815E644
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:49:18 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id d10so13772967pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKQGCZPzZbd3ZAVje9DUWvZ/4P5iphI9r4/knWYs2KI=;
        b=DqAvkM/R4fERKLDz4NsatM9cNHz4ENrtbMNuDlDhe6+SGgtZcJOpGDV1NtZy8D6g11
         OG5MQlC4G4CQtZ+DZ+a8I3j4rQU+HtZiuJn5XS2rsQaIq1AajCNHB56JdLJjBsPKSLRB
         fZEngltDARzgtGJ4/vaZiCTBMTQBVOED+B2RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKQGCZPzZbd3ZAVje9DUWvZ/4P5iphI9r4/knWYs2KI=;
        b=WQv4IGZOFN1Hc56VL0el/FdKgyeZbc2k8BF1yKAuTb5C3KZGa3BNl2P41kC4s+dXSb
         NehtrL2cgcI4OM3kzXXOOsWSlWRQ7JYHYCpWpFyfmcC14HY63qr7wFsv0JPOLrdIoMCV
         phUuTzw1s79VCU+E/vNllrBDuGisqfx98Uhx4kv3tzgoOjNj/8k8h6w2NoxhHtFfF+2w
         /wqaijPBsgNnp9p+aAQMB8nI9fO2DPYpZGS0+ktT4p2kjFZ2fv6CTyyzn64huHImvzp3
         ikla9v9RHVJL6jpZfldCnJYm0mflj4iKl4ppm+k34+kA7CbT5yUw96HTR4vcdF6hFBeo
         Mskg==
X-Gm-Message-State: AFqh2kpNMOOPYAVNcCFH/ceZFxFYLnAjAB4o6o/+sHP/iDYzBa8rYGbN
        YO2Mr0QyXoTY+6R2rrUZThGgWg==
X-Google-Smtp-Source: AMrXdXvY/M7blTARbqw81Mw7A+JAPU1y/bg5507VAhxOjDjcAmqvxizBDYZ6yXfrGoYG/Y4sBpyBDA==
X-Received: by 2002:aa7:8599:0:b0:588:eac0:b05b with SMTP id w25-20020aa78599000000b00588eac0b05bmr14527982pfn.27.1673563757683;
        Thu, 12 Jan 2023 14:49:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h19-20020aa796d3000000b005825b8e0540sm12371171pfq.204.2023.01.12.14.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:49:17 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:49:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] cifs: Replace zero-length arrays with
 flexible-array members
Message-ID: <202301121449.1C2AEFC2E7@keescook>
References: <Y7zBtCZ/eRJCpjBf@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zBtCZ/eRJCpjBf@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:39:00PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> arrays in a couple of structures with flex-array members.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [2].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
