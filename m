Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E76290C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiKODUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKODT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:19:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B75E32
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:19:56 -0800 (PST)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBBCX147szqSRM;
        Tue, 15 Nov 2022 11:16:08 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 11:19:54 +0800
Message-ID: <63730559.8080302@hisilicon.com>
Date:   Tue, 15 Nov 2022 11:19:53 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        <xuwei5@hisilicon.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for hisilicon
References: <20221013214640.31194-1-palmer@rivosinc.com>
In-Reply-To: <20221013214640.31194-1-palmer@rivosinc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.39]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 2022/10/14 5:46, Palmer Dabbelt wrote:
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
> 
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cb5edaad8dbf..6f79bdb4ee70 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2158,7 +2158,7 @@ M:	Wei Xu <xuwei5@hisilicon.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  W:	http://www.hisilicon.com
> -T:	git git://github.com/hisilicon/linux-hisi.git
> +T:	git https://github.com/hisilicon/linux-hisi.git
>  F:	arch/arm/boot/dts/hi3*
>  F:	arch/arm/boot/dts/hip*
>  F:	arch/arm/boot/dts/hisi*
> 

Thanks!
Updated the subject and applied to the hisilicon tree.

Best Regards,
Wei
