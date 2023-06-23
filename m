Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0229173BDE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjFWRgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjFWRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:36:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65E011C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fwkt7GZcJRu+CKsHQlV3tkeujS6QKrHOqDg16Czpzic=; b=ZIGCLhy9AirUo7+TCKvbYjEtDX
        9OjWyjhM2tkMD0M1ESUPY3T4gc5MSg63/8506k+0U2j8rX8AWt+x0Ta8D7hxfLjrGeXoT0AxPK8M/
        YeW9pZxsmzeM3xiYNOk+UpPi34kcevoGCNnS+ZUe4tLV4DKLaRuJ/AIr/0WWNm7mxwDj5UnvyoiMT
        DO8FokLVRQNkU2Q2Wq9kQnL47v+x3DsWvTIizZFHCSPGuBxQCQ88IGlwMWM5ZivV3q42kZ5cpYauS
        D4ZKCxkrj4pWWclyzVm5tF285yV32n3H3vTmZ7lXJLcLvUzb6Q3hS2MsowpZM3bODWMKH6rcSk3fm
        h1WPkl7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCkiC-00Gex1-0Q; Fri, 23 Jun 2023 17:36:44 +0000
Date:   Fri, 23 Jun 2023 18:36:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix sparse warnings in backing-dev.h
Message-ID: <ZJXYK6x+Jir53QaY@casper.infradead.org>
References: <20230623170737.3965705-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623170737.3965705-1-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 06:07:37PM +0100, Matthew Wilcox (Oracle) wrote:
> Sparse reports a context imbalance, and indeed _begin() returns
> with the RCU lock held and _end() releases it.  Reassure sparse that
> this is fine by adding appropriate annotations.

Please ignore; I failed to drive my tools correctly.
