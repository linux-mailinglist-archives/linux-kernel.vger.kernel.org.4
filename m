Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD101668749
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjALWuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbjALWtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:49:49 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A52E5E64C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:49:48 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s8so13353033plk.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3aINzABZ+B32eDJiQaUrol+gjhErI5EOh92lsUgR+o=;
        b=VEG3BOvGNDWwIjkpPBU5exuoMBPFrh+0WzjNCrvcnDKHBaAFzRe+M42kMeMYj/seCl
         mrS/x+qHl+2y4PqXmkB0bkShZY3isMlGPg4lue8PFeTmVdg/Y7wEcSDcLOqIDIUc6pyB
         zMQteSUDAqHwr8buQyP9OpxkMOjM2m7+JuuEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3aINzABZ+B32eDJiQaUrol+gjhErI5EOh92lsUgR+o=;
        b=Jp0WSLDsrm0cJVCR4QbLJnBGfGgPr8pK77yHA/mYmZ301yRjVZkfVQVdAO35bIEKmh
         cjQeJHdYVy40fW40yWYXKRg7lszTJFWb3N4fUUXMbCnk3NrPGLjUJgp0s9LQhSpT6WfP
         3n08gBISF8exd2Q27rE69NBlpM9Bh/JBMBS/Nn/4ns/Cvs9zLhsLvx5szlxlbWX0JtHW
         z4ge24EkMAwpkk1KkxQpleA1b1OBXx2+K6T69hquPl5f59Ar+HlgNeNe3hLbshkTcTuB
         Ox/jqCEftJO6pM5cvUkCwSUwQeM7qLgfisYSWRDvkGL6ZEzp/6NfaH6EGXidaPZz44D2
         1BTQ==
X-Gm-Message-State: AFqh2kplBzfOx0M3R79n7Y62Sb8UgtH9hIjusY3vQxye2XqsPwR5U3Sd
        4Gk2PQiK4pUOalNd024o5DskKOpIv5YyUfSn
X-Google-Smtp-Source: AMrXdXuPKLEaW2H2pNiU4cq1J1wZjDOdMtRcbbPfK1/O/q747uLTjN7/ZyJOOUpn4RAXqtUj1CmkSw==
X-Received: by 2002:a17:902:ef45:b0:18b:271e:5800 with SMTP id e5-20020a170902ef4500b0018b271e5800mr92780134plx.19.1673563787696;
        Thu, 12 Jan 2023 14:49:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902a3c100b001899c2a0ae0sm12719205plb.40.2023.01.12.14.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:49:47 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:49:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nvmem: u-boot-env: replace zero-length array with
 flexible-array member
Message-ID: <202301121449.820DF6D84F@keescook>
References: <Y7zB+s2AC6O+CRR+@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zB+s2AC6O+CRR+@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:40:10PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> array declaration in struct u_boot_env_image_broadcom with flex-array
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
