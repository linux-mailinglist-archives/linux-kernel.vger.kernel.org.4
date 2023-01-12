Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6966842C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbjALUqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjALUpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:45:34 -0500
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EC57A907;
        Thu, 12 Jan 2023 12:14:08 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 458EB46DF4;
        Thu, 12 Jan 2023 21:06:08 +0100 (CET)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=dkim20160331; t=
        1673553965; x=1675368366; bh=6zcjIRJx465Q6OpjvfkHXvmQdiMUyLWxSUQ
        tX/wjdiA=; b=bjC6xd7HKbR/WIR48R3+qallwJZy7fUJOkn0qMUZcEfVMxco3DM
        92CABtNWZFu0veoOYkvbrjJ+ubpL2yr/dEmn5MB3tR66hbDhUGWR90lM+ROJqBUR
        iC3ORIn11ZA9747/l9vXHp7nFFqPmNz96vBTSYv54Y2jjUFnP2BCot5SAuovGYC5
        aTy+lj2G06SfKOE6N1uIu2HPLWyPlDi6bg9MZeD0SOBzZqriZjB7vQZuAn93khCm
        DoPnQrqwju9JeEcr/BDYIJ0MfmG4DpVA0piNDjTFxkLl6iOxFNwfElDOb7wlL1q4
        XgOwaDcLDcEetqVi588lkKPgKC6iZV4ofGRAzDAqz+gPeLei4DwKaDYA6bR8TzZS
        pxwapt8U1O5pBhH9ZyCtFZ4uXVsYvl46r3pdqEcHDcaZa8J4Q+efQLbxk/7xlQPl
        2f0elg5eewo4NGZzjQVdqqBnyk9MHY3r6TDNQyOo7D981WWcnB0NBObGnyf8913T
        BgPB9ObcOBHU8qZcHHbgd7omXTW4zdxYekBl/eLka1XOhTFXDBrZim6XcU+iPcQP
        7tT2SeJZITdk65piYpgXAJRekTsB9AMudW0mfiUX1UTn6C+/2i811h5YfGT4Fosq
        SrimOBLAM4BUcQVYK8S/3UtaLsn5l3CTvV16VtbsLfquhlwtdyVLWL0k=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TzkxRMVme_s2; Thu, 12 Jan 2023 21:06:05 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id CBA9E464FF;
        Thu, 12 Jan 2023 21:06:04 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 79A164E24;
        Thu, 12 Jan 2023 21:06:04 +0100 (CET)
Date:   Thu, 12 Jan 2023 21:06:01 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] doc:it_IT: add translation for botching-up-ioctl.rst
Message-ID: <20230112200601.lnbutkmjy6rm5nnw@numero-86.vaga.pv.it>
References: <20230102183716.9698-1-federico.vaga@vaga.pv.it>
 <87zgaovfli.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87zgaovfli.fsf@meer.lwn.net>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:03:37PM -0700, Jonathan Corbet wrote:
>Federico Vaga <federico.vaga@vaga.pv.it> writes:
>
>> This patch adds the translation for the botching up ioctl document.
>>
>> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
>> ---
>> V1 -> V2 use the kernel-doc mecanism to link functions in documents
>>
>>  .../it_IT/process/botching-up-ioctls.rst      | 249 ++++++++++++++++++
>>  .../translations/it_IT/process/index.rst      |   1 +
>>  2 files changed, 250 insertions(+)
>>  create mode 100644 Documentation/translations/it_IT/process/botching-up-ioctls.rst
>
>I've applied this, but I have to ask:
>
>> diff --git a/Documentation/translations/it_IT/process/botching-up-ioctls.rst b/Documentation/translations/it_IT/process/botching-up-ioctls.rst
>> new file mode 100644
>> index 000000000000..91732cdf808a
>> --- /dev/null
>> +++ b/Documentation/translations/it_IT/process/botching-up-ioctls.rst
>> @@ -0,0 +1,249 @@
>> +.. include:: ../disclaimer-ita.rst
>> +
>> +:Original: Documentation/process/botching-up-ioctls.rst
>> +
>> +==========================================
>> +(Come evitare di) Raffazzonare delle ioctl
>> +==========================================
>
>Is "raffazzonare" the right verb here?  Something like "pasticciare"
>seems closer to me, but I'm not the expert here.


Raffazzonare: there is the intention to do it right, but the result perhaps is
not the best

Pasticciare: the result is not the best, and perhaps there was not even the
intention to do it right

In a way they are synonymous: there is no guarantee that the result is the best :)


>
>Thanks,
>
>jon

-- 
Federico Vaga
