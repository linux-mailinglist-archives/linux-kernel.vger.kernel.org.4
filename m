Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C3A6217F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiKHPSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbiKHPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:18:20 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B872C5F847;
        Tue,  8 Nov 2022 07:17:24 -0800 (PST)
Date:   Tue, 8 Nov 2022 23:16:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667920642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ofc1K6fag3Hze+EjFjV0OZRiW9SfH6RvaP2AiG/EVsg=;
        b=XXKhV3HRUopPUkPt/xgSFdDneCnT5ZCXZ0Ao0fRfRONhMMiXMcKWcmwsfkO4Zhy6fFm7JL
        8vLre5/4jhNGmxdnbBCaOe5DYId+6VhMnar/CaGUHlp8cO+jQ1RefMY6X7mmlfEyXEq3tA
        VICR4QtY6mIqt1lbdo9G9dGv/uciu6U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] docs/zh_CN: Add userspace-api/seccomp_filter Chinese
 translation
Message-ID: <Y2py67n+RMetFVn8@bobwxc.mipc>
References: <20221108112921.312071-1-me@lirui.org>
 <2337a1af-5f8b-602e-f989-351a371387a1@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2337a1af-5f8b-602e-f989-351a371387a1@loongson.cn>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-11-08 (二) 21:02:15 +0800 Yanteng Si 曰：
> 
> On 11/8/22 19:29, Rui Li wrote:
> > Translate the following documents into Chinese:
> > 
> > - userspace-api/seccomp_filter.rst
> > 
> > Also adjust index order according to the original index file.
> > 
> > Signed-off-by: Rui Li <me@lirui.org>
> 
> Miss Xiangcheng's Review tag.

Simply give it again,

Reviewed-by: Wu XiangCheng <bobwxc@email.cn>

> 
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> 
> 
> Thanks,
> 
> Yanteng
> 
> > ---
> > Changes since v3:
> > - Improve translation.
> > 
> > Changes since v2:
> > - Fix some typo.
> > 
> > Changes since v1:
> > - Add a note for Seccomp.
> > - Fix some typo.
> > ---
> >   .../zh_CN/userspace-api/index.rst             |   4 +-
> >   .../zh_CN/userspace-api/seccomp_filter.rst    | 293 ++++++++++++++++++
> >   2 files changed, 295 insertions(+), 2 deletions(-)
> >   create mode 100644 Documentation/translations/zh_CN/userspace-api/seccomp_filter.rst
> > 

-- 
Wu XiangCheng	0x32684A40BCA7AEA7

