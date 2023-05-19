Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A8E709A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjESOyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjESOyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:54:22 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E363A1;
        Fri, 19 May 2023 07:54:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E8AC0536;
        Fri, 19 May 2023 14:54:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E8AC0536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684508061; bh=oNbOGv1xjVLFnW6KJA63GPZAraF5NOo+pmhg3kzx/HI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZwN+2dqZUfSW6qkr3JijTAq1vjG3EkSJBGJYmNrAAANhwOZMmErBnUCPLYza+Be8r
         JWrsr5yhP91NOjuDosf5RFRhXeejQDLubRkCidrB0UKJ7ZYU0SEN890v80SLTrjBq0
         IPLRNA0NgFBGUpU2NVTCzruZJ84+zm3+4MU98ZM+616KIHx+McoXktsTpcYdUj88Vh
         1J60cnl3q05pDtu5TEo6N3Eh785Mksii9eL/1gjlBMdxLRl8HqINjWFy8oBNsc4Kwl
         0CKu91wlLTGpDX7Ml4dLAxrDIqazOmVXOMc4Ht73YLFF5l2gVkX5SEl+4eVXYY+u16
         GZjAu0sbj1vTA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] docs: consolidate human interface subsystems
In-Reply-To: <20230502015040.329394-1-costa.shul@redhat.com>
References: <0754e279-ae06-9b57-f655-cc7cc9eb6ecb@infradead.org>
 <20230502015040.329394-1-costa.shul@redhat.com>
Date:   Fri, 19 May 2023 08:54:19 -0600
Message-ID: <87fs7snzhg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> to make the page more organized as requested
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
> Changes:
> - fixed typo
> - fixed underline
>
> ---
>  Documentation/subsystem-apis.rst | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Applied.

Thanks,

jon
