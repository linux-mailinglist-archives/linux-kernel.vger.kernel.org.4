Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9007030AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbjEOO4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbjEOOzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:55:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68981FE1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=20UohLkV19ucCZXCTqMhEaDtKzRxSTgptOxs6SuddJ8=; b=TvLK7QrpUgrOAuYtKntrSUzJab
        hmfGsJRcMg6YslBLl0Pb/5bx9O05DwIvYN6v57mbtxZ5Xep0HHcNztWnc0TQ/CrsDUqtNPsP/khIB
        yeP0bQMDXEDY8aEC3K4mJcmjPlwsEx9vyABrU26IWNlq3tc5k8Fg9jHMNoJBBPSBLCN1NCaEp5QB3
        FlhlGWk6ecx3gjzF4ss8u48ws6xK8xTK3kyzUSWvRBXgp/sm1b5OtCVWJDV8WAjA2LU95fE7RXpKV
        9PlTVxK9fkmrVglqco1T9LVQwHhfi3I4NHfGwxrterlUeNaVPy5YROGEyJuUCwrYuSCyXPffgB6MF
        /2d70qiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pyZbi-003XVz-QE; Mon, 15 May 2023 14:55:26 +0000
Date:   Mon, 15 May 2023 15:55:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 03/10] maple_tree: Remove __must_hold() which does not
 work
Message-ID: <ZGJH3s2Z581fcbTs@casper.infradead.org>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-4-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515131757.60035-4-zhangpeng.00@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 09:17:50PM +0800, Peng Zhang wrote:
> The arguments to __must_hold() seem to be wrong so they should not work,
> remove them.

Why not fix them?
