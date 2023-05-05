Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A46F8424
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjEENe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjEENer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:34:47 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC3B20744;
        Fri,  5 May 2023 06:34:45 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6DC352E0;
        Fri,  5 May 2023 13:34:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6DC352E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1683293684; bh=w04Zo7BcX+6Af1rwKux5ePS/r/kQhsU0gpGtqtR4SZw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=C1VF1ZUvQF8OvDl6RXc5JnI0y/YZ3Yeu2BFssQEuo3t3GpDzJl/+O4CRyhrsQzwbq
         16J2Ig9CWlMXsx/kCJxpOxNXIGNIfuxCJ34XMlugCMB9DaWSjduEPFNJQl1fDvoGuO
         aKqZioqs7bKpKZm/8LDqYCreaDDnguGIW/XAlYf8AlBi8LJnx6iZM24JZf/4sW2ntQ
         DOHeyt/2qEfFMhUjwGxoDypaQT79FrScdyeZt4dCQVNKd+BmxrkW5WN+IkRJOCThnm
         G7vOBdXldsN1qL+nyxzrbJoCwhKtc+S53ZqyiYg1TBsrN75RUDgAPFIqL9aw1Adl7M
         Z6J7TKVL2eH2A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Finn Thain <fthain@linux-m68k.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 3/3] Documentation: scsi: dc395x: Remove reference to
 2.4 driver
In-Reply-To: <d919a2e1-5749-13f8-7867-1f17277190f4@linux-m68k.org>
References: <20230505082704.16228-1-bagasdotme@gmail.com>
 <20230505082704.16228-4-bagasdotme@gmail.com>
 <d919a2e1-5749-13f8-7867-1f17277190f4@linux-m68k.org>
Date:   Fri, 05 May 2023 07:34:43 -0600
Message-ID: <87pm7enbpo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finn Thain <fthain@linux-m68k.org> writes:

> On Fri, 5 May 2023, Bagas Sanjaya wrote:
>
>> The 2.4 driver link returns 404. 
>
> It's still potentially useful:
> https://web.archive.org/web/20140129181343/http://www.garloff.de/kurt/linux/dc395/
>
>> As no one runs 2.4 kernel anymore,
>
> Would it make a difference if someone does run that? Were you planning to 
> delete the source code for the 2.4 kernel too?

Most of the 2.4 code has indeed been deleted *from current kernels*.
It's not clear to me why 2.4 documentation should be immune to that same
process.  If we keep every 20-year-old reference, our docs will be even
cruftier and less useful than they are now.

Thanks,

jon
