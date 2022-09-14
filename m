Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE485B81AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiINGwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiINGwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:52:15 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF66872682
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:52:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663138328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdcxFVPfL3oNvUbsts76ibZFxG9H40u/DZs2oEJmCVQ=;
        b=cuxhsptteKa/Nl693vjyLcG8c5CWcdmBhSrzS84Nzc+mCdRjPQdjYL5elpfmwksIgsHdBI
        LYLI6nRAAI/ytLRypX2h+sJioeGsa3ob3TI3my7tqVW6AHmRF1Qsi+egTZfwNTkycoNv+v
        n8KsqMKlsbQ3TrC6bD90gMxEvl332+s=
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/hugetlb: Remove unnecessary 'NULL' values from
 Pointer
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220914012113.6271-1-xupengfei@nfschina.com>
Date:   Wed, 14 Sep 2022 14:52:04 +0800
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2866AFF1-FDA3-4A44-8542-3D74228577DC@linux.dev>
References: <20220914012113.6271-1-xupengfei@nfschina.com>
To:     XU pengfei <xupengfei@nfschina.com>
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



> On Sep 14, 2022, at 09:21, XU pengfei <xupengfei@nfschina.com> wrote:
> 
> 
> Pointer variables allocate memory first, and then judge. There is no
> need to initialize the assignment.
> 
> Signed-off-by: XU pengfei <xupengfei@nfschina.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

