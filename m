Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4656073CF01
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 09:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjFYHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 03:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjFYHjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 03:39:15 -0400
Received: from out-48.mta0.migadu.com (out-48.mta0.migadu.com [IPv6:2001:41d0:1004:224b::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6599C19F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 00:39:13 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687678750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4wN0oKOWHuCd0fTyy5YavBofFk5HORNO1i9De4tuIU=;
        b=umaE3q0Als9RX48cxcIF2rGGehn1O0+58zR/2OcnTiYwxnAAaB+cnW1pYc9W2CIXE1pD1U
        Ofx98usgryEIaEU1PxwCSLltAAs+Fho7hJC3TBzR5H7lotra4vEh4gNcvHxerbZdmfvNX4
        3ZYHAk6M8BA7rm/by2Pu2UmqjgWwJkw=
Date:   Sun, 25 Jun 2023 07:39:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <4c361d62e0b77242fe4b8592c82c4d90@linux.dev>
Subject: Re: [PATCH] memblock: Introduce memblock_reserve_node()
To:     "Mike Rapoport" <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230625050850.GJ52412@kernel.org>
References: <20230625050850.GJ52412@kernel.org>
 <20230624024622.2959376-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

June 25, 2023 1:08 PM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A=0A> On=
 Sat, Jun 24, 2023 at 10:46:22AM +0800, Yajun Deng wrote:=0A> =0A>> It on=
ly returns address now in memblock_find_in_range_node(), we can add a=0A>=
> parameter pointing to integer for node id of the range, which can be us=
ed=0A>> to pass the node id to the new reserve region.=0A>> =0A>> Introdu=
ce memblock_reserve_node() so that the node id can be passed to=0A>> the =
reserve region in memblock_alloc_range_nid().=0A>> =0A>> Signed-off-by: Y=
ajun Deng <yajun.deng@linux.dev>=0A> =0A> What problem does this patch so=
lve?=0A>=0A=0AIf we set nid and flags in memblock_alloc_range_nid(), we m=
ay not need=0Amemblock_set_node() in memmap_init_reserved_pages().=0A=0AI=
 tested this patch and delete memblock_set_node() in memmap_init_reserved=
_pages().=0AIt works fine. I did not delete memblock_set_node() in this p=
atch just in case.=0A =0A> --=0A> Sincerely yours,=0A> Mike.
