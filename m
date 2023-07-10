Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9961974CF44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGJH6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjGJH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:57:49 -0400
Received: from out-42.mta0.migadu.com (out-42.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E88183
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:57:48 -0700 (PDT)
Date:   Mon, 10 Jul 2023 16:57:38 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688975865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmxfhYvXhyXByIplUMH+bsWAK/iM0XTwFftsOttP81Y=;
        b=jHxWhdPICtDSqmC0j7U6Fs4fGlkUOY9UHeADGl4hCOWNdHM9AfHz/t3F9nVJV10hKxrd6z
        UEWtkCAEhZtSnnJpui0mZa4Nnba9rRicLBmlJ5JmI/S4SGmlAfzDcH72tiZHX/bGnYMrZh
        t+7xE7/BASGg+JKEsJuph39C9KQlZqs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] mm: memory-failure: minor cleanup for comments and
 codestyle
Message-ID: <20230710075738.GF1686200@ik1-406-35019.vs.sakura.ne.jp>
References: <20230708085744.3599311-1-linmiaohe@huawei.com>
 <20230708085744.3599311-7-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230708085744.3599311-7-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 04:57:42PM +0800, Miaohe Lin wrote:
> Fix some wrong function names and grammar error in comments. Also remove
> unneeded space after for_each_process. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
