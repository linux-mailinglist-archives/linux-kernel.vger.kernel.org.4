Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529EC643CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiLFFgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLFFgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:36:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A635222B5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 21:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=idUF0SyMyxLuCA5ekH2YrK1TeMOY4YMFb123Ffhbph8=; b=Cxh9lfqK18qjtGukR7K15rC83V
        D7JfQBT9J7z6fFlloUQUCCR1o29HBF2vkZ3GFtihvSpQuC3ev2WJ0nEWce7rcaZwx+S6ef8WAm0E7
        Dh1qQLCVouG0uviIEB6Otxzh/RAj+WYJ1bFTPuqOcUI5/VHlqVQVvHvc/zwCUo9xPvlChJxdzFfA7
        7XeSSRn/DfLkDpfTYanJAPQWdCUnbPshulTylszLRWobrLlZrStvmO53udOd/eHtpoDtETHtuOi1P
        gUJwMGlQSVGmxNrvW9tQruwAnh2+cn2s2IDU8iBKmFHlp3gTq9QYFIOkVoyuCxTTvfkpMuip641+L
        MGObk2ag==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2QdI-001Jr2-3y; Tue, 06 Dec 2022 05:36:44 +0000
Message-ID: <ec629996-fcf5-a0da-4c90-ed374f63d012@infradead.org>
Date:   Mon, 5 Dec 2022 21:36:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: PATCH [1/2] gamecube/wii: graphic quantization registers driver
 (GQR)
Content-Language: en-US
To:     Zopolis0 <creatorsmithmdt@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <CAEYL+X_X7OsP3BQ3poK4n+DWEOxAais6d9At9nz2TzLFV2HinA@mail.gmail.com>
 <1716b73b-77f4-da8e-801f-7521872697bb@infradead.org>
 <CAEYL+X8KAg58c32LXL8ksfxnDvPPLwJwBRxMFdu6wB7HU+kXBQ@mail.gmail.com>
 <5c01fe50-a975-f866-87d1-0343ad2ae520@infradead.org>
 <CAEYL+X8SuUvaEG-ouGdCUBpe5DS0j0rPw7XedtcCocn1ZJFX2A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAEYL+X8SuUvaEG-ouGdCUBpe5DS0j0rPw7XedtcCocn1ZJFX2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/22 21:20, Zopolis0 wrote:
>> Other (better) options are to use an email account/interface
>> that does not corrupt whitespace OR use 'git send-email' (which
>> does not require that you be using 'git').
> 
> Git send-email doesn't work with gmail anymore, and I've never had any
> whitespace troubles with gmail inline patches in the past.

(for the latter part:) Do you mean when using the gmail web UI?
I've never seen that protect whitespace correctly.

-- 
~Randy
