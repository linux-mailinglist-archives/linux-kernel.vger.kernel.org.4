Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249CA5FA630
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJJU3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJJU33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:29:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A93BDB7;
        Mon, 10 Oct 2022 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=BMbzY36+8ww6wrsdbaWxNYcMSlmO1bp/yAVsU2BxNyU=; b=ccUta+uyPGpcVmzwBFHJWeZt9R
        UmW6COD6OsXOF0IqhbYsQjLSMw7qplzfnUtkTL2CrDlKC/FbzzcBUQHd7xi+nO2z2/qXlcRuTko3E
        I9qcdnObgt92HViBUeNHKcr542o6oGsqE2J8qjuAWgbMxS2QyF6yUcFDpDxBgWLkaADnHagGmoNlw
        rW9uX/M2Jg8ksd1XU+V1W6vqPRJNds2ZV0G0NEQAvQf6WsRjGT6oUEhV/WSBRfoUuo4yIgfn/I5YS
        4MWzbiOO+76grXOTYUmwJJADIvfltwszl6/w2LNa9nQxG0ene+/93fzm53dJwDvEB1ZKGuiVgbG7W
        vK3aZvZQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohzNF-002BCV-0i; Mon, 10 Oct 2022 20:27:41 +0000
Message-ID: <55ec854a-69a7-8272-e8a7-93b75577ed0a@infradead.org>
Date:   Mon, 10 Oct 2022 13:27:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] docs/howto: Replace abundoned URL of gmane.org
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
References: <20220930021936.26238-1-akiyks@gmail.com>
 <87r0zfpkbf.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87r0zfpkbf.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/22 12:09, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Somehow, there remains a link to gmane.org, which stopped working
>> in 2016, in howto.rst. Replace it with the one at lore.kernel.org.
>> Do the same changes under translations/ as well.
>>
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> Cc: Federico Vaga <federico.vaga@vaga.pv.it>
>> Cc: Alex Shi <alexs@kernel.org>
>> Cc: Yanteng Si <siyanteng@loongson.cn>
>> Cc: Hu Haowen <src.res@email.cn>
>> ---
>>  Documentation/process/howto.rst                    | 2 +-
>>  Documentation/translations/it_IT/process/howto.rst | 2 +-
>>  Documentation/translations/ja_JP/howto.rst         | 2 +-
>>  Documentation/translations/ko_KR/howto.rst         | 2 +-
>>  Documentation/translations/zh_CN/process/howto.rst | 2 +-
>>  Documentation/translations/zh_TW/process/howto.rst | 2 +-
>>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> Applied, thanks.

Just FYI, news.gmane.io still works via nntp but not the old web interface.
But lore.kernel.org works either way. :)

-- 
~Randy
