Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45764810E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiLIKfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiLIKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:34:51 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41AF1758F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1670582085; bh=DLyo0VzfVniJaOS/SORzW6mc0IFs+ygg1S6r/ejcPuo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TKia6aqTAIMOYNqIn8jM7TMJxqBHjoLEbwsPdbmjj306USg9GPjl7aJmtYUCd5Cvm
         3f90MeTInmcb1L+ormzjFrIHB+90SxOcU8MAEcdpW/8deofqlop/8a8Ao9eKseFF6F
         4DnjB3wEZ7sa1lTWVgFBXJwJ0yxWr6UJU9SzpMms=
Received: from [100.100.35.204] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id EB741600DA;
        Fri,  9 Dec 2022 18:34:44 +0800 (CST)
Message-ID: <a72c0df8-a591-3cf9-add0-92be2e4db095@xen0n.name>
Date:   Fri, 9 Dec 2022 18:34:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Firefox/109.0 Thunderbird/109.0a1
Subject: Re: [PATCH v10 0/4] Add kprobe and kretprobe support for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jeff Xie <xiehuan09@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <1670575981-14389-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H6e2HzXs9PCcdnebPBvGZrx5vRXji1vGXfPwkEihBOiKA@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H6e2HzXs9PCcdnebPBvGZrx5vRXji1vGXfPwkEihBOiKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/9 18:01, Huacai Chen wrote:
> Hi, Masami,
> 
> This series looks good to me now, but I'm not familiar with kprobes.
> So, if you have any comments, please let me know.
> 
> And Jeff,
> 
> As we all know, you are an expert in this domain, so could you please
> help me to test this series?
> 
> If there are no objections, I plan to merge this series in a few days.
> But since the next merge window will be open soon, if there are any
> problems, I will revert the patches to wait for the next cycle.

Sorry for jumping in so late, but due to the imminence of the merge 
window, and Linus having *specifically* asked for readiness of all 6.2 
material upfront due to holidays, IMHO it could be more prudent to wait 
one more cycle. Especially considering some other people's code probably 
already made the respective maintainers more cautious due to the compile 
warnings, and hurried fixes to some other similarly hurried commits...

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

