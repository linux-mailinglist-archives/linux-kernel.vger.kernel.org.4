Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE46AC391
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCFOmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjCFOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:41:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D7E2E0CF;
        Mon,  6 Mar 2023 06:41:42 -0800 (PST)
Message-ID: <3efca293-5996-ef3d-b647-63dd2353a7d0@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678113392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4B7jpqaBUGtSAkthLSGXqMTCZUFjueikY2MsrEehFUU=;
        b=u5rOC4h7NwqC0x40UZg9BB4kCpRZgAYqLJ6ySj/A3rtnawYEkkO5QDF98wDyX4zYuy4BiD
        F6F9+Jk+LvjWrYCa9mfEZXni4N1IWUKfTLrRwryO14tn9ArU3qyq6Fv+V27Aw5NXTsoN78
        rDJd9AKW9Ro+uY9wstamsvoBLpt5ymD8iEVQXKcATrWB2fY9IMr0akGEZU83sQxl6kuhQw
        0yhgP+ysxDKjfWp9FQJVAnkf+TtUeE7b1cML4fLbFWQGO6f85KaHfVitxCTgDYOAVLKVKW
        zNSqRORSWEporcthM4Ww79F8E0tma8F4BnPZTpWI1F5LwNUSCWLwbVs1tGrXpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678113392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4B7jpqaBUGtSAkthLSGXqMTCZUFjueikY2MsrEehFUU=;
        b=HfRgq1CN/F6oaY/S8E9hlLqZzWKTFfEFsxYWyJTLAojpvY9/487xB8FULvaoSDrMCc1fwo
        ytYr5uRQNhi4U7Bg==
Date:   Mon, 6 Mar 2023 15:36:32 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/1] kbuild: deb-pkg: default dpkg-buildpackage --build
Content-Language: de-DE-frami
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230305232536.19528-1-bage@linutronix.de>
 <ZAX47xq+eQX41htE@buildd.core.avm.de>
From:   Bastian Germann <bage@linutronix.de>
In-Reply-To: <ZAX47xq+eQX41htE@buildd.core.avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.03.23 um 15:30 schrieb Nicolas Schier:
> On Mon, Mar 06, 2023 at 12:25:34AM +0100, Bastian Germann wrote:
>> deb-pkg's dpkg-buildpackage invocation was changed in v6.2, unnecessarily
> 
> v6.3
> 
>> adding the --build parameter explicitly. Revert the change.
>>
>> Bastian Germann (1):
>>    kbuild: deb-pkg: default dpkg-buildpackage --build
>>
>>   scripts/Makefile.package | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> -- 
>> 2.39.2
>>
> 
> Masahiro prepared a patch [1] for explicitly introducing a 'srcdeb-pkg'
> target, but scheduled its inclusion for v6.4.

Thanks for the pointer. I would still find it nice not to break the use case in 6.3.

> 
> Kind regards,
> Nicolas
> 
> [1]: https://lore.kernel.org/linux-kbuild/CAK7LNAR82ZgvKof9VMXRM4A_h22ZNCyoaKoHW-ONJ+4vctCu_A@mail.gmail.com/T/#m59cc003498dab9b7246198ac3172527256bd1304
