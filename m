Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D554D66874C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbjALWtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240314AbjALWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:49:45 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D48E5EC06
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:49:36 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id s3so12374565pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWHx2ArszmWOMvOmL9HMTqeLRyXml8x4aecIK4J1xfM=;
        b=T2d6xQChtkuCRaI870QbrNhFwwVCxfB/ltmBQERjU/+oJfBXhY/cz1RHeYyjIdraiI
         0RZZ1XMlhfo7B3NY4rKRaaxKLRWCZVgiVPgtgr17CgwOgHSIpYEu4zv+lpmlbvU88r6e
         jK9fILTLJRz6ovtajskEvsL9o5FUM/PTks/iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWHx2ArszmWOMvOmL9HMTqeLRyXml8x4aecIK4J1xfM=;
        b=JKTF4HjKQhWxsw91L0Jv5j/bHoIkPiYFVCLMQqxScDL5iehqK1Ya9o3zn+yFMQ2SM5
         bBQj7TsqPkgicDdLnwez7HihIxCS6mp+PnkFUpfkz5C5JVDABcoTVptcqK3rJGouOBWQ
         lVtHn6W3ZnLoCa26yibSiMzMB9OxIMswn+2dBv8G+VYjPTpOClwElRcCbwn1fNLk0lin
         Wcy8xnAVMMZdAmTWfheCt0fJat76VrQOHS9fh5Fx03bS4lR7DxgwRkLvQZ4s1hBdQK1A
         lbkf8U+s63XKnuB13BgQPB2qQLK/BQuxfG/vDGwYbswoKNOf7Diz0GdsfOTMAVfEn1Nw
         BmMQ==
X-Gm-Message-State: AFqh2kpD7BoeZvrbGq3sV4BmzyL40pif1X/gYCQWWb3SIo7eoja6Ka/+
        YWpmxOwCsR3uj0MLYa1x6DdtnA==
X-Google-Smtp-Source: AMrXdXtrkkqEGE9cFZZR5OGma23Ht+dZor8UGc1LpcFDNVZF1aHL808lC/1ioJhhRsAmf4y/+tUmZw==
X-Received: by 2002:aa7:99c4:0:b0:589:69ec:c6bc with SMTP id v4-20020aa799c4000000b0058969ecc6bcmr8245382pfi.21.1673563775884;
        Thu, 12 Jan 2023 14:49:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x14-20020aa79a4e000000b005811c421e6csm12220412pfj.162.2023.01.12.14.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:49:35 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:49:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau/nvkm: Replace zero-length array with
 flexible-array member
Message-ID: <202301121449.EE489AA@keescook>
References: <Y7zB0q2pr7lEpHGs@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zB0q2pr7lEpHGs@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:39:30PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> array declaration in struct nvfw_hs_load_header_v2 with flex-array
> member.
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
