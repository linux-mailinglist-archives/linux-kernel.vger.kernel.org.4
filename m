Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37674CADF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGJDxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJDxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:53:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C361D3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 20:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pC+jLlRok1m8LyflTFO+wh0bHqbInLWKiGFRR2IUaqg=; b=LWg65d8rhiBofiot9Ay1FyP5V4
        shcxg9oRitwGFI8g2ggt64fs8hYapacS8Xlv2Rti7+NQ4EJDfQF4XjvsIJLReuloayOAQlUYjoIHH
        DhsGHzjBZOx9zqsmAC9Gp0o8SRpXX8TcZW8daCncpOGxbheCT9YtMteMzrb1ickI206BOa4IQGSPX
        cpVb2kHYdsFxpQKhPhJURZx3Jw2Tqch5T2d7lGDl/uGVby09jEmPcen3F/i5hLUxNDSdGwvLcBuhW
        faDkmI1vJgD0LTVGm8g2TIWrsZv+Ik+nWlapD/xRMMVcL3EnRDkpmHYPAD0k2WBx+ChAIlWR6PWWj
        ZCarBqcw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIhxq-00AKAH-2w;
        Mon, 10 Jul 2023 03:53:30 +0000
Message-ID: <6d8593f4-3dcd-7db8-899b-2f96e02a09a0@infradead.org>
Date:   Sun, 9 Jul 2023 20:53:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_kernel=3a_reboot=3a_Remove_unnecessary_?=
 =?UTF-8?B?4oCYMOKAmSB2YWx1ZXMgZnJvbSByZXQ=?=
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, rafael.j.wysocki@intel.com,
        kai.heng.feng@canonical.com, dmitry.osipenko@collabora.com
Cc:     linux-kernel@vger.kernel.org
References: <20230711202145.5138-1-zeming@nfschina.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230711202145.5138-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/23 13:21, Li zeming wrote:
> ret is assigned first, so it does not need to initialize the assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.


> ---
>  kernel/reboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 3bba88c7ffc6..e00a02a74694 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -702,7 +702,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>  {
>  	struct pid_namespace *pid_ns = task_active_pid_ns(current);
>  	char buffer[256];
> -	int ret = 0;
> +	int ret;
>  
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!ns_capable(pid_ns->user_ns, CAP_SYS_BOOT))

-- 
~Randy
