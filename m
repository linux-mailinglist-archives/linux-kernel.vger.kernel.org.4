Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EB26C5040
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCVQLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjCVQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:11:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003474A1C9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:11:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x15so8620588pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679501473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pv7FuMQ8/Qu4bRSfat32quqa3YIevC6kP+hxjl6WaNE=;
        b=f0uU6xw0F4uhIhnCzbxUOwqOkZ6zZ1n07hiIjc0U1hpEM8FuT8+qTMduh236MrQcYZ
         MZsVAqTzmaqvS+2H80Yomx1Tj6fg+29rDeeP7tIEcKcWRTlMj+iMq0c9Jxo+uIbjK3Tl
         rSyuJw2jQcNLM6B3QXkHNvLo1r35JMRIYG1t6R8Ufjwu4ECnVsSuRhtoTzB9lbMl6cz6
         rdJOGE6rFf9ajqKE58fUaKSD0458mLELpkFuKBI0orgRHLO44eySSZSvjA/WRiB8ZmfM
         e0A2mye2x2jGu1HOkwrts4fftHK9rP47ABYgzk+CnhLCSBmrtCfVkgAAd8v8ad9I0UlV
         acWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pv7FuMQ8/Qu4bRSfat32quqa3YIevC6kP+hxjl6WaNE=;
        b=jbWxJeO3IMl92bfP2qxBpQzXkeXf8/oY37glOUdOx5zddPdhwaAT1c3R/5NL+C7Pll
         cdTx6gzJ2wyhigSUnixnisGaab9VIv6/rbjrveRkLovX+GYk+4jRuXkD8GrfYlenmGEv
         wP/+TozD5Qvxp+gJHlAKOP6wQA6dwLiWrfBrZSrIr8bTZIz78f4xHWOPaA1OOiCNWP2y
         4j9CJAoDhBVIy14db1izsiHTWgyKmWmiVNii/KEuc1t2XC5GutvScMrApn4NXAhze/aC
         tdTLAwreOeJyVp6McKh9xiViNTanuA85dvZIW4/suaWmfreVH+TyzxzovENrqE0FkQq2
         ReRg==
X-Gm-Message-State: AO0yUKV8lvigC7ewlEJc9TdDYnQwMkqz2XcwqVe9zzbzGL3cPnfxO6RN
        LLuC0v4ex27ZpvqiF18pIs1JmYSd388syWxEYqQ=
X-Google-Smtp-Source: AK7set9tY6ywFhXe0FxOPUwJ6rLmVd1oFMqc+l4BurXbPkuYsw7k7YwyKLHVAUuXXaWu+/uXVsAHVg==
X-Received: by 2002:a17:902:d2cf:b0:1a1:918e:4129 with SMTP id n15-20020a170902d2cf00b001a1918e4129mr4104549plc.30.1679501473024;
        Wed, 22 Mar 2023 09:11:13 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2eb7:bf6c:83a2:9d2f])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902b70400b001a1c2eb3950sm7530457pls.22.2023.03.22.09.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:11:12 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:11:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Tanmay Shah <tanmay.shah@amd.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] remoteproc: get rproc devices for clusters
Message-ID: <20230322161110.GC2821487@p14s>
References: <20230322040933.924813-1-tanmay.shah@amd.com>
 <20230322141215.ygicmrppqaawlgeb@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322141215.ygicmrppqaawlgeb@ripper>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 07:12:15AM -0700, Bjorn Andersson wrote:
> On Tue, Mar 21, 2023 at 09:09:32PM -0700, Tanmay Shah wrote:
> > This series extends original patch and makes rproc_put() work
> > for clusters along with rprog_get_by_phandle().
> > 
> > v1 is here: https://lore.kernel.org/all/20221214221643.1286585-1-mathieu.poirier@linaro.org/
> > 
> 
> What changed since v1?
>

Path 2/2 was not part of the original submission.  Speaking of that original
submission, you did not follow-up on my last comment, something that would be
much appreciated in order to move forward with this fix.

Thanks,
Mathieu


> Thanks,
> Bjorn
> 
> > Mathieu Poirier (1):
> >   remoteproc: Make rproc_get_by_phandle() work for clusters
> > 
> > Tanmay Shah (1):
> >   remoteproc: enhance rproc_put() for clusters
> > 
> >  drivers/remoteproc/remoteproc_core.c | 41 +++++++++++++++++++++++++++-
> >  1 file changed, 40 insertions(+), 1 deletion(-)
> > 
> > 
> > base-commit: e19967994d342a5986d950a1bfddf19d7e1191b7
> > -- 
> > 2.25.1
> > 
