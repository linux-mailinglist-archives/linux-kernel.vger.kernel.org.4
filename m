Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2467F191
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjA0W6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjA0W6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:58:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4067BBF2;
        Fri, 27 Jan 2023 14:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SJZ+A2OL+Vg6dtfC1j/ujgXrKkOduxhhQrMqb42By6o=; b=n3f2+ScPxrf179PWoH5j30R2lL
        7/+KjQ8XTMa085+Cd9jHNfJmbKf2KtJRxqKXUuWTsWKpkA98Q73fJ6GSeZUZrX9VuIH/Ic6cHZzIy
        XdIrcRBSykbl3yJRzNhM3xYii9DqKvOkroFu6ILh8lJwSsmCKExPkR7iyAxqStFNlzx8uS91KQjm3
        vJJEWWpag8Le5OcFF1bk9ZX+FWULv2SqJ9gkSTNyS3fXS/BQTPvPzTSNT0PZ/Tr8b1LZS6QjbIgm7
        MJ2DooRvTu7LrK8kzCxORHbjelCP16T6YmH9PVirTaCkICqapc9s4uzB352xw523PAV46i2js26d7
        HHvsQGFg==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLXfh-00GlSz-50; Fri, 27 Jan 2023 22:58:13 +0000
Message-ID: <f88f03c9-06c6-dbf2-d67e-111b875b3c58@infradead.org>
Date:   Fri, 27 Jan 2023 14:58:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 03/35] Documentation: block: correct spelling
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-4-rdunlap@infradead.org> <Y9OL+iyaQtXLSCKc@debian.me>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y9OL+iyaQtXLSCKc@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/23 00:31, Bagas Sanjaya wrote:
> On Thu, Jan 26, 2023 at 10:39:33PM -0800, Randy Dunlap wrote:
>> diff -- a/Documentation/block/data-integrity.rst b/Documentation/block/data-integrity.rst
>> --- a/Documentation/block/data-integrity.rst
>> +++ b/Documentation/block/data-integrity.rst
>> @@ -209,7 +209,7 @@ will require extra work due to the appli
>>        sector must be set, and the bio should have all data pages
>>        added.  It is up to the caller to ensure that the bio does not
>>        change while I/O is in progress.
>> -      Complete bio with error if prepare failed for some reson.
>> +      Complete bio with error if prepare failed for some reason.
>>  
> 
> So if prepare returns error, bio is completed not successfully but also
> errored?

I think that
>> +      Complete bio with error if prepare failed for some reason.
says that the caller of bio_integrity_prep() should treat the bio as an
error condition. I don't see any guarantee that the bio is completed
as far as adding an integrity payload to it, any more than what the bio
was upon calling bio_integrity_prep().

But I could also be wrong.  :)

-- 
~Randy
