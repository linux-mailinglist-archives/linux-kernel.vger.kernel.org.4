Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0786438E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiLEXCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiLEXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:01:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032881E3CA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=BX0Lslefcg6fepmNW1N+9yNvKypUZZUZD+YrCWByw/o=; b=P4DVWRv7lSkZOebjG8UuG998Ln
        IHc1r5COwCsoP9h1jqUY87hkYQiMukRTmeHSxaIuaVCnICEMhuIOl6Q8wOcbAj9IZ06gdq5Slqyxd
        OdXmZlY7zU7DqrNvEC3R024HSUqG3bSxiL+pyZDHjJe8/kiReh3/oNQb0qEVPMuvcNo/cEkGrn7Hf
        JfRUhOOYBE7rTnrSXesvz83Cjqle5LrVL4IQHYNxatbXVfwFpS+4h3oXYZyI1V58ffKukJDbgtByo
        fcrjRx9tCTtjA1iFeVYavThZ8x3w9IGx2T4Bcb76v80oBOLwawzLwh6WKzpRdyXFI1VoTOfAAXBtM
        +/MpJqbA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2KSl-00Bi2N-DA; Mon, 05 Dec 2022 23:01:27 +0000
Message-ID: <5c01fe50-a975-f866-87d1-0343ad2ae520@infradead.org>
Date:   Mon, 5 Dec 2022 15:01:25 -0800
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAEYL+X8KAg58c32LXL8ksfxnDvPPLwJwBRxMFdu6wB7HU+kXBQ@mail.gmail.com>
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



On 12/5/22 14:15, Zopolis0 wrote:
>> and lastly, gmail has (apparently) munged the whitespace in the patch
>> so that it is awful... or it was never done correctly if gmail didn't
>> munge it.
> 
> In that case, would it be acceptable to send the patches as attatchements?

The maintainers could just ignore it or reply to it that it should be
posted inline so that it can be reviewed and commented on.
It's up to them.

Other (better) options are to use an email account/interface
that does not corrupt whitespace OR use 'git send-email' (which
does not require that you be using 'git').

-- 
~Randy
