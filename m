Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A449D603D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJSJCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiJSI72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:59:28 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5E52BE1D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 01:54:50 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso19831407fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5L2p0wiTIye73Ieybraxk3J6TT5B0mEvC2Vws56UVJk=;
        b=l+r+f0vUiVDd+Bfz1YRm6DlhrxoPFcCXdKFyRCC76XU+70uzhGrGLF5tWEB8Lw1pxH
         5LUrZ9rcze2+IAwhR8vBu4/oL/VCAxVsvK6xF03dkB9pATbvYTD+pzoVfPshj9w7/ySx
         rtW0jjLYfmTZ0bHWOmx9NvW9W5/na8rJaOfWVU5/l4RldT3o/1hqtFdbmwAZ48BDBGZj
         Rl5eoVuCz8ZcVsgAMWu6ASDChiYHghHr2Dogwt6ZzqO4w/NT+KtVA2+DMc7kbZh5yAzy
         BvgYHBY4Ko8IUHni28UkIrhJu339pyiCCLQZ2QHvozC2K4esEB/6QgHHRDoMU8Sj0IEc
         6Zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5L2p0wiTIye73Ieybraxk3J6TT5B0mEvC2Vws56UVJk=;
        b=G4JdzsoldMk21k0oiwrJ+azBw4FeVjFB2MQeuBBvfxNfo2/+C+Aj9BI+6NQ3zp782e
         CukWngxiPqDPz5tBkLSbdp0ZHpsxqpQ7jg/eCWuEUGrx/RtfR+9g301PXX1NfBnrAQDA
         xhxa7UUDzoeFyxxwNa5gTX9bDO4i9cafBPUUAZqEzy1uDWci1OXkUXW3qnj37b8QuFTC
         dZzbQgsBV6oJiWyqBOpzrIBpyEVGJfEFhbRPzt0hVn9aQgoL0giQck955bYXfBMWq1lN
         lfhvR0P7fK3ColB1LPezIKfrdkrxlvMMi8f5bxwxRQ+m1j/NtDkOmdZVGYqtC+4x3qI9
         bEWA==
X-Gm-Message-State: ACrzQf2iKjMAUmOXt8IM3Hj/4l2ajWEJHuVIFR6zSrM4ItK15tHjEYZ5
        Nfamjb3QazeJ8bFO/WfPMw9RHF+2kR0/yhxdmfs=
X-Google-Smtp-Source: AMsMyM77gP3xxGPpPS/CNxNrJ3ojX9c/hCy2hcYAvIVxCPRhks0fKb9DCvzDjBjq5vNo3if6DjlalA==
X-Received: by 2002:a17:90b:1648:b0:20b:f0ae:2169 with SMTP id il8-20020a17090b164800b0020bf0ae2169mr43009113pjb.173.1666169003001;
        Wed, 19 Oct 2022 01:43:23 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-199.hinet-ip.hinet.net. [211.75.219.199])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090a840900b0020d51aefb82sm9656742pjn.19.2022.10.19.01.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 01:43:22 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:43:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH v9 13/13] perf test: Add relevant documentation about
 CoreSight testing
Message-ID: <Y0+4pLpUTsjhu05I@leoy-huanghe.lan>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-14-carsten.haitzler@foss.arm.com>
 <yt9dr0zex1j4.fsf@linux.ibm.com>
 <46328b62-d948-a5c2-25c6-f5caec123412@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46328b62-d948-a5c2-25c6-f5caec123412@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten,

On Wed, Oct 19, 2022 at 09:16:03AM +0100, Carsten Haitzler wrote:
> This is weird. This shouldn't be making its way into any man page at all.
> It's just a file pointing people at other parts of the kernel tree for docs
> (because when I looked for docs - i found nothing for any kind of getting
> started guide - I put something here as this was the obvious place for perf
> related docs for testing - but was told to put the docs elsewhere in core
> kernel documentation, but I put a reference here for those who follow after
> to be able to more easily find it).
> 
> There is some rule somewhere it seems that makes anything perf-*.txt into a
> man page. I need to rename this file it seems.

Adrian has sent a patch for renaming the file, see:
https://lore.kernel.org/lkml/a176a3e1-6ddc-bb63-e41c-15cda8c2d5d2@intel.com/

Thanks,
Leo
