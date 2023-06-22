Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA573A524
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjFVPfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjFVPfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:35:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E04118;
        Thu, 22 Jun 2023 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=FWm6Ou+XiA/ohiDuXPBpDKbRm8uKEnIfhkeJA7otrE0=; b=mLEzHttfxz1Wu4sSWVkI4R0XU7
        y9I9+Q3la23W+EQ48ez/hujf4GJCTqisOWONMm57HAp4aVIeAElccdyZb29xqgiJa5NbmMMSqmX9v
        KFqIT5JiYi0Lja+rbCl29bKgUbhCvaGVVp29hyLPaMLCc4NRF8hbPWtHDcik2a9JUaGMsYak2rSYD
        f2B2nOVV7hFOcyERGVb1vuE1GYmWAOEqstuITqVP/i5PNVitQkCnsk2VHsOqVxEg2EQ5KlHG6v1ye
        Xv+SRILFDCpNvYgbC1rlYHwiQ9AdXhuWK/iEM/RIz9wQUu9x4ayRxXnjIbQM/8M5RQ8/14UOUSjGF
        qhYRU0DQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCMKx-0018ld-0w;
        Thu, 22 Jun 2023 15:35:07 +0000
Message-ID: <a0e8aba6-b28f-c460-9bab-5695000727fb@infradead.org>
Date:   Thu, 22 Jun 2023 08:35:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] docs: consolidate core subsystems
Content-Language: en-US
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     open list <linux-kernel@vger.kernel.org>
References: <20230622071004.2934698-1-costa.shul@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230622071004.2934698-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/22/23 00:10, Costa Shulyupin wrote:
> to make the page more organized as requested
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/subsystem-apis.rst | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
> index b67a1b65855b..8664b05777c3 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -10,6 +10,20 @@ is taken directly from the kernel source, with supplemental material added
>  as needed (or at least as we managed to add it — probably *not* all that is
>  needed).
>  
> +Core subsystems
> +---------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   core-api/index
> +   driver-api/index
> +   mm/index
> +   power/index
> +   scheduler/index
> +   timers/index
> +   locking/index
> +

In general I am OK with this grouping, except for 2 nits:

a. I'm not sure that locking is a subsystem (it's a core API IMO).

b. I often have trouble finding "filesystems" and I think that it should be
   given a higher location in the TOC (somehow).


thanks.
-- 
~Randy
