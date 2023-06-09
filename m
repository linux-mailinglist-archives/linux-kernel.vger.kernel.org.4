Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4097372901E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbjFIGjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbjFIGjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EAF30FD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADE64653E8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C223C433EF;
        Fri,  9 Jun 2023 06:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686292743;
        bh=rlmD3FizMVpwgfr4E8jU37pfei9MDvw1ODpEsN/nfTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lf5uNDli+WbWMR2shDgwvVSAJRB+ZsXZnahNmKgwhxQfaakzHOzqH5+zZ2YTATfls
         CZsSym5qnAXUpBRBujEbLcN04wLI9SXf/tIFDm1Am6QcGsxnfn1nwVbbLb/oZBDaHe
         Mi3zwrwORvS5dXg5AC4VAj1r8j4eU4FjAuA6fMFbII1NAEVTB1D/nuAxpz/PRsO+IE
         W4+BaSoRPzkl6Ii4ApG8op4nLhHzCpPa+9BYvZFJ/yigHgZEW5DBtJakP9Z34Cpqzp
         zQ0d9JEF7iwzRnifqbtTxmPUtR/CcMdnumvqlYkowbmLA5tzZ3rV3CxZvPvOIcyXzW
         ceKGST7XlnaFA==
Date:   Fri, 9 Jun 2023 07:38:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Add missing check for
 platform_get_resource
Message-ID: <20230609063859.GC3635807@google.com>
References: <20230609014818.28475-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609014818.28475-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023, Jiasheng Jiang wrote:

> Add the missing check for platform_get_resource and return error
> if it fails.
> 
> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Replace "-ENOMEM" with "-ENODEV".
> ---
>  drivers/mfd/intel-lpss-acpi.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
