Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3CD5F1537
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiI3VvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiI3VvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:51:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C053106517
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24A7362523
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 21:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3369CC433C1;
        Fri, 30 Sep 2022 21:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664574659;
        bh=vabvEljJEdiGT9O8zYxyDRMm9047G+g1cdOaUIE65I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JzUTqb/L8CteBMUp1uXhPW1P3bk/NVt3DKasySxJLYhdXm+uvfI5sqMWwe+vmrJNe
         Ed4NtLqzUQnv1HFsqvfTdADBFwzJGQcfzYKVlmTYUX0KuiZbE+e0bH5HMfgmZCyam/
         z3tm4GJ79vHrkJEKLPDXo2GNrwFI7xaNFTd1arDmHgtUdvLA00dijb9w9N6xQtPZXL
         05bnlFqFG8Kg+x/e1O9/tKmtOESGdiKuED0JZJStcqm/FsFQAd2mW+HckXEP57aN+7
         fMQiaWbv6I1xLylAUYI6J8QrFpZUTs5v3oPDf7ILo++9QTkcH3NTX9gLDDsLURuntg
         /Zb5mIP0SRyjA==
Date:   Sat, 1 Oct 2022 00:50:56 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas Tai <thomas.tai@oracle.com>
Cc:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        reinette.chatre@intel.co, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
Message-ID: <YzdkwIsNVI7P34ej@kernel.org>
References: <20220928153832.1032566-1-thomas.tai@oracle.com>
 <20220928153832.1032566-2-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928153832.1032566-2-thomas.tai@oracle.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:38:32AM -0400, Thomas Tai wrote:
> Inspired by commit c6acb1e7bf46 (x86/sgx: Add hook to error injection
> address validation), add a similar code in hwpoison_inject function to
> check if the address is located in SGX Memory. The error will then be
> handled by the arch_memory_failure function in the SGX driver.
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> ---
>  Documentation/mm/hwpoison.rst | 44 +++++++++++++++++++++++++++++++++++
>  mm/hwpoison-inject.c          |  4 ++++
>  2 files changed, 48 insertions(+)

Hmm.. no change log.

What was the change in-between v1 and v2?

BR, Jarkko
