Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F1161E8D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiKGDFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiKGDFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:05:30 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC155DFA7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 19:05:25 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667790323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIx4i6pObocFNzXbeoE4pSq5DVyynY/Lm8s58LJ7UO0=;
        b=CclYp24GeT1121zYFWnCbLO9Vyc9IgSni0MiGLV9rcD0+aVdlUKc9/+1i/eQNyRsW8EnTc
        Z6msyylgBkR04NlhsiJGYkngYuV6aBBt++pEBNsZbymc5VF3mAyrt3qg4xBNgmUXwMF8g8
        zkwtnO2KEK1i74TGzvlJwoBjjrNB/C0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH] hugetlbfs: inode: Remove unnecessary (void*) conversions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221107015659.3221-1-zeming@nfschina.com>
Date:   Mon, 7 Nov 2022 11:05:08 +0800
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8C051BD7-7728-440F-9C02-68D1EE53785E@linux.dev>
References: <20221107015659.3221-1-zeming@nfschina.com>
To:     Li zeming <zeming@nfschina.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 7, 2022, at 09:56, Li zeming <zeming@nfschina.com> wrote:
> 
> The ei pointer does not need to cast the type.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

