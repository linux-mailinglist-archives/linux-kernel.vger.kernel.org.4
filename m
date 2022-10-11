Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA35FAA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJKCIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJKCIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:08:01 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB41775CC1;
        Mon, 10 Oct 2022 19:07:59 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E7AAA401B5;
        Tue, 11 Oct 2022 02:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1665454078;
        bh=cHcNseQwUTp3FPcIMTHgHU83y+HrOU+Ge3hY4Xs+g0A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=hnkDwRENocAnksmik2JMbNCXm77AT1LQP2otJZV+LQTAXQ62FvJU2zDv6fhQRSD0g
         2mEBYG+3Pgo5WP1pZBhi0nrQY0q9C5voFBJ3Mhk+R/eGpEf70hhSNQI9NQn+GFl0XX
         CmZIfI1Djy8JEKElAdTK15J1gUw+MU+AU/c4pZ43L5t4O2zzLZ5gX31vMSwM09gDsc
         cdNz7putiNbecsAsReUT881PjGE4PFJWkmoAdEbQQllGqVR0SSS05c7kesvFGc/oob
         4GDgk6BfYMHbO50mQluWR3vmIySEG8D8O4msi8S15ThouSZ9UBY/3kKW0uYjoVlbQs
         k0lv/UClv725w==
Message-ID: <5225f90f-eb9f-c3c3-c266-f1e52b29ba34@canonical.com>
Date:   Mon, 10 Oct 2022 19:07:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/3] LSM: Fix kernel-doc
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20221008063411.14829-1-jiapeng.chong@linux.alibaba.com>
 <20221008063411.14829-2-jiapeng.chong@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221008063411.14829-2-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 23:34, Jiapeng Chong wrote:
> security/apparmor/lsm.c:753: warning: expecting prototype for apparmor_bprm_committed_cred(). Prototype was for apparmor_bprm_committed_creds() instead.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2338
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>   security/apparmor/lsm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index cc83cbf2ce20..c56afd1307c1 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -746,7 +746,7 @@ static void apparmor_bprm_committing_creds(struct linux_binprm *bprm)
>   }
>   
>   /**
> - * apparmor_bprm_committed_cred - do cleanup after new creds committed
> + * apparmor_bprm_committed_creds() - do cleanup after new creds committed
>    * @bprm: binprm for the exec  (NOT NULL)
>    */
>   static void apparmor_bprm_committed_creds(struct linux_binprm *bprm)

