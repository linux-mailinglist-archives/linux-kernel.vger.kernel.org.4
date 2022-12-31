Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0D65A491
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiLaNKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiLaNKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:10:02 -0500
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB16266;
        Sat, 31 Dec 2022 05:10:00 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 3EA6C14F3;
        Sat, 31 Dec 2022 14:09:59 +0100 (CET)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=dkim20160331; t=
        1672492196; x=1674306597; bh=86F8i+swfGUSse77eSUBIUmqadoRU+Zu6kC
        CWs1ZFNM=; b=WRXoM6mHpoL8RVfq+FZMHaBtldLabg6n6ot5DSsHL7o40Yr8ClE
        Av5SOyG2lH5I2q+0eBJ2xPN6oFO4stSUM0Q08OYbqbOPoYiXVebHLXNnmR2iJrwN
        x0rp/j7hERSDOJwecRTfJlVWivH2gfuf6Sxo3IqVwaF9cJ6V8uTfYZ/uEP23pH+S
        zPZs9BwsGQKv6tZUDYLn5wqDGewqOBxofLrjPwaNW37OFlC9bwjxd6OIOyPRGNMz
        RNx4coJ6ZXafdpSJTTFj9si0oQhYBMvRHX+m5s8Q+O3RaCUMShzJOA9gVT+wHdfy
        cGZdZlPNFIEmjF3aJIHaIIBB6hNQwU8qS8a6Cl8yfYYV67K9tztg8EYiSK01bhWz
        g16OlidjE0Mxsq/1qfeuNSOIu81ofaS44KsaQw72O2u0sZQiuJM3SzPAr9XDjM/Q
        2U1OHkjhlHYNi+fHkogTWU6uvSLhUAXp1Wu+FzYYMa44b0/y9d3roUJ1DQpX/uPy
        jV+bbAB1VyltBvPqWOIFIUjitYXvBWqwL/2QcyRtt1Ws0B/Oa2QJxuvArkaJfXCu
        sQbkejeoWo/nSxC0ZRWhqhaT4j69W0oWP5PsMGjFhbuuueupFO7dwyHdapQTymif
        OuuwXucBJimBgURx78wMKtfKkQQhrAUbfMbhbnbINx3MSQFY/XW/9/Q8=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9g1yDPVIblbg; Sat, 31 Dec 2022 14:09:56 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id B86C36C8;
        Sat, 31 Dec 2022 14:09:55 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 4732D224E;
        Sat, 31 Dec 2022 14:09:55 +0100 (CET)
Date:   Sat, 31 Dec 2022 14:09:52 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] doc:it_IT: align Italian documentation
Message-ID: <20221231130952.4rynxmoaliwfgntb@numero-86.vaga.pv.it>
References: <20221230173127.59553-1-federico.vaga@vaga.pv.it>
 <3e30ecf7-ebf5-c2cd-f6b6-dc5d6e5cdb71@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3e30ecf7-ebf5-c2cd-f6b6-dc5d6e5cdb71@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 09:17:22AM +0900, Akira Yokosawa wrote:
>Hi Federico,
>Minor nit on embedded latex code. Please see below.
>
>On Fri, 30 Dec 2022 18:31:27 +0100, Federico Vaga wrote:
>> Translation for the following patches
>>
>> commit da4288b95baa ("scripts/check-local-export: avoid 'wait $!' for process substitution")
>> commit 5372de4e4545 ("docs/doc-guide: Put meta title for kernel-doc HTML page")
>> commit 4d627ef12b40 ("docs/doc-guide: Mention make variable SPHINXDIRS")
>> commit 7c43214dddfd ("docs/doc-guide: Add footnote on Inkscape for better images in PDF documents")
>> commit 615041d42a1a ("docs: kernel-docs: shorten the lengthy doc title")
>> commit cbf4adfd4d19 ("Documentation: process: Update email client instructions for Thunderbird")
>> commit e72b3b9810dd ("maintainer-pgp-guide: minor wording tweaks")
>> commit ea522496afa1 ("Documentation: process: replace outdated LTS table w/ link")
>> commit 93431e0607e5 ("Replace HTTP links with HTTPS ones: documentation")
>> commit e648174b53f1 ("Documentation: Fix spelling mistake in hacking.rst")
>> commit 602684adb42a ("docs: Update version number from 5.x to 6.x in README.rst")
>> commit 489876063fb1 ("docs: add a man-pages link to the front page")
>> commit 0c7b4366f1ab ("docs: Rewrite the front page")
>>
>> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
>> ---
>> V1 -> V2 fix typo in footnote link
>>
>>  .../translations/it_IT/admin-guide/README.rst |  2 +-
>>  .../it_IT/doc-guide/kernel-doc.rst            |  2 +
>>  .../translations/it_IT/doc-guide/sphinx.rst   | 14 ++-
>>  Documentation/translations/it_IT/index.rst    | 93 +++++++++----------
>>  .../it_IT/kernel-hacking/hacking.rst          |  2 +-
>>  .../translations/it_IT/process/2.Process.rst  | 15 +--
>>  .../it_IT/process/7.AdvancedTopics.rst        |  8 +-
>>  .../translations/it_IT/process/changes.rst    | 11 +++
>>  .../it_IT/process/email-clients.rst           | 67 ++++++++-----
>>  .../it_IT/process/kernel-docs.rst             |  4 +-
>>  .../it_IT/process/maintainer-pgp-guide.rst    |  4 +-
>>  11 files changed, 127 insertions(+), 95 deletions(-)
>>
>
>[...]
>
>> diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
>> index e80a3097aa57..5dd751349adc 100644
>> --- a/Documentation/translations/it_IT/index.rst
>> +++ b/Documentation/translations/it_IT/index.rst
>> @@ -1,13 +1,11 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>>  .. _it_linux_doc:
>>
>>  ===================
>>  Traduzione italiana
>>  ===================
>>
>> -.. raw:: latex
>> -
>> -	\kerneldocCJKoff
>> -
>
>Removing this latex code would make Italian translation pages in
>translations.pdf one-half spacing (when built on systems with
>necessary packages for CJK translations), which would make them
>look sparse.
>
>Please keep it.

My mistake. I've sent a V4

>For your reference, here is a list of related commits in this are:
>
>  - f7ebe6b76940 ("docs: Activate exCJK only in CJK chapters")
>  - 77abc2c230b1 ("docs: pdfdocs: One-half spacing for CJK translations")
>
>        Thanks, Akira
>
>>  :manutentore: Federico Vaga <federico.vaga@vaga.pv.it>
>>
>>  .. _it_disclaimer:
>
>[...]

-- 
Federico Vaga
