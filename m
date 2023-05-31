Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228537176C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjEaGXh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 02:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEaGXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:23:35 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391529F;
        Tue, 30 May 2023 23:23:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E454A63CC10C;
        Wed, 31 May 2023 08:23:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id L1MW3AYx1K1h; Wed, 31 May 2023 08:23:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9E3CC616B2CF;
        Wed, 31 May 2023 08:23:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sVKUU-jUg0rd; Wed, 31 May 2023 08:23:20 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7EB866081100;
        Wed, 31 May 2023 08:23:20 +0200 (CEST)
Date:   Wed, 31 May 2023 08:23:20 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Kees Cook <kees@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        oe-kbuild-all <oe-kbuild-all@lists.linux.dev>,
        linux-hardening@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <103925562.158061.1685514200368.JavaMail.zimbra@nod.at>
In-Reply-To: <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com> <202305311135.zGMT1gYR-lkp@intel.com> <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Replace all non-returning strlcpy with strscpy
Thread-Index: /e3HVPBWZ39oPFmlPQoqSK9b5wqRFQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>>>> arch/um/os-Linux/drivers/tuntap_user.c:149:17: error: implicit declaration of
>>>> function 'strscpy'; did you mean 'strncpy'?
>>>> [-Werror=implicit-function-declaration]
>>     149 |                 strscpy(ifr.ifr_name, pri->dev_name,
>>     sizeof(ifr.ifr_name));
>>         |                 ^~~~~~~
>>         |                 strncpy
>>   cc1: some warnings being treated as errors
> 
> Ah, yeah, this is another "not actually in the kernel" cases. Let's ignore this
> strlcpy for now.

Well, actually it's another case of "not even compile tested". :-(

Thanks,
//richard
