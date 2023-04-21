Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8EE6EA1D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjDUCuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjDUCuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:50:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1F4C01
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:50:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b50a02bffso1592569b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1682045410; x=1684637410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC3uz3gEeDwUT9qANCoJYl9NnUOABJ1f95MOH7VMpuc=;
        b=Gn3pgLGPLd8mPkp8WDMhV9L0EQppCPrSzFzx78KyV7+CMkiFXte/ID6qSfuysmUgsY
         LGVmrEU5TOfMIXuKixliS53AqXX4GGeNnJmrb1iahHjPyTNt6xEtN9PUnh6gbM2x68a8
         bJa9xCo8jgnKA8X8bJeIvAMWjfPTin8edMh7cvtAp2X5a8ZKLdGhhOELyUjBbatw/2pm
         ZYuU3zT83UGQsriXMTsCt3Ow9Nww1Kirpn3PEI7L1zo+sxPAcA1hDkCAH1XQ7n9M6c9r
         HlOMy+myeWHzNvu9L1Blfhed/YTzCLplOOioNEEhgqluUvRvBYWymoRCkgqRdONp4I1V
         pP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045410; x=1684637410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FC3uz3gEeDwUT9qANCoJYl9NnUOABJ1f95MOH7VMpuc=;
        b=dHueLo2kqk4gPq0FPkF5W+cstGsK5pzPEObSqydEpKbpkedl5lpt7CmjM7E8sIrj4G
         O5QP6RQ8Knwq9FaT4QBCMlGTIfnKfS3fcNzqug1BRZWR0FShg9TPWBVqT05bc30+Xlrg
         8Y6FLPH/8hKcq5odHqMViifMOlvgmsJhR6dV+OMB38UdjIEbsF8evxYrIgSN/bKc69S5
         ljK0z8vRCTdPZ+lUGSB7WJhWs7ysOdiO2gBrfT2Dh3YIs9o36tUrPkmfgVodPp0hPvkj
         FfQrxDkwSFfpq3cU4Mcst0X8JSGQcDsCTjFMW4b5Vlf+gov9La5zluy4tt0vcxZo4Jeg
         wiWQ==
X-Gm-Message-State: AAQBX9e8R98vrmFMqDLlEL3MpNSVIkkxor5jw+4sqqIfU0CKWvATqOAs
        Kaz5sk95aZyMo4fKOoGqpNiCrQ==
X-Google-Smtp-Source: AKy350abRoxn9hoVKqrd0a1mSwIQEclVpA+RFqLfmeqBum2hJpyrR0S38xVe43j7OUGJzFCY/aRbEg==
X-Received: by 2002:a05:6a20:748c:b0:f0:fa9b:d4c7 with SMTP id p12-20020a056a20748c00b000f0fa9bd4c7mr5033510pzd.55.1682045410027;
        Thu, 20 Apr 2023 19:50:10 -0700 (PDT)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id q10-20020a65624a000000b00524b02ff569sm1667671pgv.64.2023.04.20.19.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 19:50:09 -0700 (PDT)
Message-ID: <2b0e06e0-5dd4-8ca7-6d85-b492468fd71a@shopee.com>
Date:   Fri, 21 Apr 2023 10:50:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] vfs: clean up d_backing_inode() function
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     mszeredi@redhat.com, bigeasy@linutronix.de, mcgrof@kernel.org,
        xiubli@redhat.com, linux-kernel@vger.kernel.org
References: <CAOssrKfCiByavRNekRUOCv==AEvWAO6B6=tAASyYdvWj9XRhBw@mail.gmail.com>
 <20230419104704.243950-1-haifeng.xu@shopee.com>
 <20230420204545.GN3390869@ZenIV>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20230420204545.GN3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/21 04:45, Al Viro wrote:
> On Wed, Apr 19, 2023 at 10:47:04AM +0000, Haifeng Xu wrote:
>> d_backing_inode() does the same thing with d_inode(), so using
>> d_inode() to get the inode of dentry instead of d_backing_inode().
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> Fine by me, but generally that kind of search-and-replace is
> better done differently:
> 
> 1) patch replacing the definition of d_backing_inode() with
> #define d_backing_inode d_inode
> 
> 2) mail to Linus, asking to do mechanical search-and-replace
> just prior to -rc1; see e.g. 7c0f6ba682b9 for example of
> that being done.  In this case the script would be
> sed -i -e "s/\<d_backing_inode\>/d_inode/g" $(git grep -l -w "d_backing_inode")
> sed -i -e "/#define d_inode d_inode/d" include/linux/dentry.h

Thanks for your suggestion.

The file "include/linux/dentry.h" doesn't exist, do you mean "include/linux/dcache.h"?

By the way, why we need to add a definiton first and delete it later instead of replacing 
the "d_backing_inode" directly?

In addition, there's another patch need to be reviewed.
link: https://lore.kernel.org/all/20230419072736.172593-1-haifeng.xu@shopee.com/

Thanks!
