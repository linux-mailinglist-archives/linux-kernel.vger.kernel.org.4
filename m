Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7D561FED1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiKGTlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKGTlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:41:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3261F63A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:41:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8149DB815D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 19:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A38C433C1;
        Mon,  7 Nov 2022 19:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667850067;
        bh=ltJa0cAHBPFM5qJtnkiF01RZmwbbJOWT9zTUJervQYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=roqANr/vkPniSOzZ8XdTA98RghRqORKCFYMEOBaDSnwmpnQW3ThSbRpiPhVu8gE1Q
         pcw7wWX3BTBXYsSF16/traC/QBsvgmLkoxBk2b+On41mE+4AlxoHXFJhn9g7QLmCQq
         E/nS70W/jnkl2Jbt2BCQfJzMIkTiHjJfltdK/96c=
Date:   Mon, 7 Nov 2022 11:41:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     HORIGUCHI =?ISO-8859-1?Q?NAOYA?= (=?UTF-8?Q?=E5=A0=80=E5=8F=A3=E3=80=80?=
        =?UTF-8?Q?=E7=9B=B4=E4=B9=9F?=) <naoya.horiguchi@nec.com>,
        James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hugetlbfs: don't delete error page from pagecache
Message-Id: <20221107114106.ba3e3576326586b26bbe2c91@linux-foundation.org>
In-Reply-To: <Y2k4j2fzQYrW/ptz@monkey>
References: <20221018200125.848471-1-jthoughton@google.com>
        <20221104021035.GA297167@hori.linux.bs1.fc.nec.co.jp>
        <Y2UTUNBHVY5U9si2@monkey>
        <20221107042544.GA436198@hori.linux.bs1.fc.nec.co.jp>
        <Y2k4j2fzQYrW/ptz@monkey>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 08:55:43 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> We have now actually seen users impacted by this issue.  I suggest
> adding the following tags to this patch.
> 
> Fixes: 78bb920344b8 ("mm: hwpoison: dissolve in-use hugepage in unrecoverable memory error")
> Cc: <stable@vger.kernel.org>

I've made those changes.
