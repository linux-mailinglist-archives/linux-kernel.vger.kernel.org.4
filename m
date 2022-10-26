Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0060E226
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiJZN16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiJZN1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:27:45 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234DBC508C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1666790859; bh=3ejE4L3fwNSToRFYb0YslC/TsKHy6FFSXGUoLdwiKOA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WDHsllv1u7ddxqr+prHR+wQ2amFOBA/LnLHmb/Q9x+C5J0qDwkvLubvkBmV0o5j44
         HZv/YuCA/PmQrJ/nzXm+k9z9rkewmnmbrDcNBcvFC7bH8CVsY2xUfEzsZQE4/TbhMh
         1uh/ylQwdzfUWZUjlGS1NKTokMIluywZNhQ5F0f8=
Received: from [100.100.57.122] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 872DD600CF;
        Wed, 26 Oct 2022 21:27:39 +0800 (CST)
Message-ID: <78b76ffd-f668-239c-eb97-654bbe6eccc0@xen0n.name>
Date:   Wed, 26 Oct 2022 21:27:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:108.0)
 Gecko/20100101 Thunderbird/108.0a1
Subject: Re: [PATCH v2 RESEND] LoongArch: Remove unused kernel stack padding
Content-Language: en-US
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221026035501.11986-1-hejinyang@loongson.cn>
 <43126fe8-9040-a574-a149-273844d3073f@xen0n.name>
 <26a42f0c-db3b-9330-de5c-68bf44976201@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <26a42f0c-db3b-9330-de5c-68bf44976201@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/26 21:24, Jinyang He wrote:
> Emm, to be honest, I didn't do tests like LTP. I ususally do development
> on CLFS-LoongArch while kernel has this patch. And it works normally.

For changes touching fundamental parts that make the system work at all, 
like this, "it continues to boot and work" usually is enough for 
confirming correctness. Although some harder test runs would certainly 
be better ;-)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

