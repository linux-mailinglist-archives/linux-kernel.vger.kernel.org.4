Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD9698D74
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBPG5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:57:51 -0500
Received: from out-40.mta1.migadu.com (out-40.mta1.migadu.com [95.215.58.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E50268B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:57:49 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676530667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CREuUkXH0zLyqA9Ya6iJeDC3Ctp6PljecEFUMxyD9O4=;
        b=riO+GpIyGq9ZXSKszSqfhmxQwFn+BPOisJFawDpd3AnqfBV6qnnMhjpAR75CDpOYW/pNSn
        RpHasDLkV+IxoLNLJpbYDD7Ukvg/pHpVhzBWzXQtF4q2MCE3dMSJPijiorMtTv7Z/yVXj4
        atKTr/+ooj59DM3w2o94ok4R/lHPIsE=
MIME-Version: 1.0
Subject: Re: [PATCH] block: Fix io statistics for cgroup in throttle path
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230216032250.74230-1-hanjinke.666@bytedance.com>
Date:   Thu, 16 Feb 2023 14:57:00 +0800
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9B8073C-5101-4EB8-9C4B-D6EEB6D0739D@linux.dev>
References: <20230216032250.74230-1-hanjinke.666@bytedance.com>
To:     Jinke Han <hanjinke.666@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 16, 2023, at 11:22, Jinke Han <hanjinke.666@bytedance.com> =
wrote:
>=20
> From: Jinke Han <hanjinke.666@bytedance.com>
>=20
> In the current code, io statistics are missing for cgroup when bio
> was throttled by blk-throttle. Fix it by moving the unreaching code
> to submit_bio_noacct_nocheck.
>=20
> Fixes: 3f98c753717c ("block: don't check bio in =
blk_throtl_dispatch_work_fn")
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

