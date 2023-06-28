Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DD9740899
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjF1Cpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjF1CpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:45:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68112D78;
        Tue, 27 Jun 2023 19:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=L76VZ91OVxXdwnLJdS7G18nznY7rXCAAn1nL79jHPjU=; b=Py2UebBZU5bpgPz6KjPaSNl/r0
        KYLiQqIYr76VpSGoSCdNeiHY0+zN5GtmqLesnenyHzdcQS2ksq2k5IyWVtncOLmnsatQ/OKpuW+y3
        sEXzNj4lKPXschWNvk87+7+1z4r4r2V8aatmaAXCEY4oT+D+QTgf6MZLSF7pxbQwlcBr47sJuEcmJ
        c0RuBrRchbn3PEeLMPTcu7zgKmkzsZrLnRN6qxp3GqmYD5/k+hu8yQ92FZlY7eAF+kef5GgaLmxTJ
        RDOr7wsnzbchE8rHU8Tj8oLp+xxkdiqiQLdmbhNhcT8kI8nq6iq8ojnhlcYvyWkGiBEfhZwGQTgMI
        Bbh4vQQA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qELAx-00EcFr-1P;
        Wed, 28 Jun 2023 02:44:59 +0000
Message-ID: <c8976472-ab01-de64-ff1d-9224b6c65633@infradead.org>
Date:   Tue, 27 Jun 2023 19:44:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] MAINTAINERS: Update ocfs2-devel mailing list address
Content-Language: en-US
To:     Anthony Iliopoulos <ailiop@suse.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20230628013437.47030-1-ailiop@suse.com>
 <20230628013437.47030-2-ailiop@suse.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230628013437.47030-2-ailiop@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 6/27/23 18:34, Anthony Iliopoulos wrote:
> The ocfs2-devel mailing list has been migrated to the kernel.org
> infrastructure, update the related entry to reflect the change.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4545d4287305..2e95a8eb924e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15969,7 +15969,7 @@ ORACLE CLUSTER FILESYSTEM 2 (OCFS2)
>  M:	Mark Fasheh <mark@fasheh.com>
>  M:	Joel Becker <jlbec@evilplan.org>
>  M:	Joseph Qi <joseph.qi@linux.alibaba.com>
> -L:	ocfs2-devel@oss.oracle.com (moderated for non-subscribers)
> +L:	ocfs2-devel@lists.linux.dev

So the kernel.org admins know about this and have updated
lore.kernel.org for the new mailing list, right eh?

>  S:	Supported
>  W:	http://ocfs2.wiki.kernel.org
>  F:	Documentation/filesystems/dlmfs.rst

thanks.
-- 
~Randy
