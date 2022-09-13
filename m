Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796065B6DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiIMNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiIMNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:02:11 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9880E4A80D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:02:09 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663074127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1Xbu20q2uc9KYuQMroPlHJBq4c9RUxC8suEQ4+I9qk=;
        b=mXLTY4MtUbFsJuGzIuArIarMlZtfFO87o5bV5f8cgbq4NrikkSVIcJQaKMNk3wJK5dfKAG
        cq3VY8jFqYdaGoAC1vCuleAZ8Gaum0IisfooQtMMJO37c5iDzRqKbDGwnFHyVpMNGx/ZPt
        ktY3YQVEPEqccbTNU7NYkaqcjSVfBw8=
MIME-Version: 1.0
Subject: Re: [PATCH-next] mm/mempolicy: use PAGE_ALIGN instead of open-coding
 it
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220913015505.1998958-1-zuoze1@huawei.com>
Date:   Tue, 13 Sep 2022 21:02:03 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
Content-Transfer-Encoding: 7bit
Message-Id: <138AF259-374E-4FD2-9E81-E442593FE556@linux.dev>
References: <20220913015505.1998958-1-zuoze1@huawei.com>
To:     Ze Zuo <zuoze1@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 13, 2022, at 09:55, Ze Zuo <zuoze1@huawei.com> wrote:
> 
> From: ze zuo <zuoze1@huawei.com>
> 
> Replace the simple calculation with PAGE_ALIGN.
> 
> Signed-off-by: ze zuo <zuoze1@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

