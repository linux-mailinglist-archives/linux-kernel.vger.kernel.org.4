Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F17F69EAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjBUXFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBUXFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:05:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934212A15D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=V/FR0P0q34fYY2C4I8JwsYHiJiImKNofbwR/g8Tw6JQ=; b=nOhk1GdY86R8cBRBrWZkRzY5BU
        awLFbdp2AkDZGE96EadijkJE32MPK7WSQ9i+RQGvKHexTV2gtBi5MJMBvSDUON58I5ZQC/wFJKECJ
        MUiJa51lC0bhiq9qIojykQs/f4A5nBeARYtaxpbgQ0q0qlEHI454ujTzf90gPpHKwWDBa4Z4otTk2
        SvWHCRAu+zYVcb+T768/pthpVTx8SjbUmODKZBFymONklQdi/eic/CG3OhmUdqow+20ER8FxTmaLF
        B61hUfiCBG+Cu6jHaPfjmOQ6aZ3x3+sZIycbZx2Ba0VIN6NjPQ/7TfaqE6HlEFPJKA27/+QcLETtp
        0ct1SU7A==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUbhD-00A4sf-Nn; Tue, 21 Feb 2023 23:05:15 +0000
Message-ID: <670212bf-469c-c25c-7eea-bb14f74e3ac0@infradead.org>
Date:   Tue, 21 Feb 2023 15:05:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] Documentation: update kernel parameter limit notes
Content-Language: en-US
To:     James Addison <jay@jp-hosting.net>, linux-kernel@vger.kernel.org
References: <CALDQ5Nwfz6z_BxCJnMdTP76M0Y3b9+aSXNjZ04MZisEwSTB-cg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CALDQ5Nwfz6z_BxCJnMdTP76M0Y3b9+aSXNjZ04MZisEwSTB-cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/21/23 10:34, James Addison wrote:
> There does appear to be a limit on the number of parameters accepted by the
> kernel at boot-time, so this changeset updates the kernel-parameters.rst
> documentation to reflect that.
> 
> Signed-off-by: James Addison <jay@jp-hosting.net>
> ---
>  Documentation/admin-guide/kernel-parameters.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.rst
> b/Documentation/admin-guide/kernel-parameters.rst
> index 959f73a32..12cbf46b6 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -204,7 +204,8 @@ be entered as an environment variable, whereas its
> absence indicates that
>  it will appear as a kernel argument readable via /proc/cmdline by programs
>  running once the system is up.
> 
> -The number of kernel parameters is not limited, but the length of the
> +The number of kernel parameters is limited to 32 by default (128 in User Mode
> +Linux), and is defined in ./init/main.c as MAX_INIT_ARGS. The length of the
>  complete command line (parameters including spaces etc.) is limited to
>  a fixed number of characters. This limit depends on the architecture
>  and is between 256 and 4096 characters. It is defined in the file

I agree with your patch, but you will need to Cc: some maintainer on
your (next) email/patch so that they can apply/merge it (if they want to).

Thanks.
-- 
~Randy
