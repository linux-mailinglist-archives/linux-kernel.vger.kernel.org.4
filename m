Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5785FAA76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJKCHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJKCHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:07:45 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17BD754BC;
        Mon, 10 Oct 2022 19:07:43 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1C587401B5;
        Tue, 11 Oct 2022 02:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1665454059;
        bh=YhGmLBEzGnw2BU3ecsBkuHOHWJmHOdBpaqjMHif3Ps8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bSCqcbH1FII0CwcPsw8We/01oY0wab5jxrZZ+9abqcR4NhSYrUbCYn2EoQua33aYr
         O4OzLpx2OZXxExOW8xD350hSUduYi6mwn7BrwHqLaR8DclyhMRdi9QYvDuyR7AQnYH
         CquY4TBEmz3ut67vx8iWHay2EmKQvhh8JFPj64LOQLZ731bZe/tnfh9qj2CCpAHaqo
         gFS/p42KBCOgIHrunNVzZ2ot4zJRsTfjihortNVnNjgcZ9eObEkk9RNTDWHd7Kg6+E
         n/hWN8aoDmIWaca0pOgIrl56MKqdgyX+3s2LkBG6Nlh8aSaYhax2S7J6thzEc7+XP+
         Z4B8ejjT4pudA==
Message-ID: <aa1e5177-157a-4ec3-0da0-cb30a2337b3b@canonical.com>
Date:   Mon, 10 Oct 2022 19:07:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] AppArmor: Fix kernel-doc
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20221008063411.14829-1-jiapeng.chong@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221008063411.14829-1-jiapeng.chong@linux.alibaba.com>
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
> security/apparmor/audit.c:93: warning: expecting prototype for audit_base(). Prototype was for audit_pre() instead.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2339
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>   security/apparmor/audit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
> index 8dfdda98fbf1..5a7978aa4b19 100644
> --- a/security/apparmor/audit.c
> +++ b/security/apparmor/audit.c
> @@ -83,7 +83,7 @@ static const char *const aa_class_names[] = {
>    */
>   
>   /**
> - * audit_base - core AppArmor function.
> + * audit_pre() - core AppArmor function.
>    * @ab: audit buffer to fill (NOT NULL)
>    * @ca: audit structure containing data to audit (NOT NULL)
>    *

