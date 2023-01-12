Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5B667E59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjALSqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjALSpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:45:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C661C118
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673547446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDXFj5hdnKEo0Ma8q/gACMhNgB1M01IuG8WyERS0f3w=;
        b=fP9th42cLzTdOXxy34eWZh+z9lIB5o9j2d2QCYjrrQtLTnlBst+Z9EcFK3pVRwYuIcZIa8
        lsl2P4+JreVKgwNnjGLV3vefd8nUeH72mzaZd4RIRyURLr4wEOYFOilliqLWAETphMCkjz
        bUqfv+VI4iPEQsLyvZ36Ibu4fIKZTTQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-dAmrjTUgPge2Yj9UyCVVYQ-1; Thu, 12 Jan 2023 13:17:21 -0500
X-MC-Unique: dAmrjTUgPge2Yj9UyCVVYQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7257D380670E;
        Thu, 12 Jan 2023 18:17:20 +0000 (UTC)
Received: from [10.22.17.189] (unknown [10.22.17.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16B6F492C14;
        Thu, 12 Jan 2023 18:17:20 +0000 (UTC)
Message-ID: <8b69165c-054d-dad6-9801-7767d40d37ce@redhat.com>
Date:   Thu, 12 Jan 2023 13:17:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] acpi: add support for the NBFT
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Charles Rose <charles_rose@dell.com>,
        Doug Farley <Douglas_Farley@dell.com>,
        Lenny Szubowicz <lszubowi@redhat.com>
References: <20221208232536.591347-1-stuart.w.hayes@gmail.com>
 <CAJZ5v0jq_z3H5Uw7vM1998pgtUyHE0M19aOg+mf1O=UgApf7cg@mail.gmail.com>
From:   John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <CAJZ5v0jq_z3H5Uw7vM1998pgtUyHE0M19aOg+mf1O=UgApf7cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Rafael.

To clarify: this patch was developed by Stuart Hayes. So there should be no need for that additional Signed-off-bys.

Sorry for the confusion...

John A. Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Group
jmeneghi@redhat.com

On 12/30/22 12:45, Rafael J. Wysocki wrote:
> On Fri, Dec 9, 2022 at 12:25 AM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>>
>> Add support for the NVMe Boot Firmware Table (NBFT) to facilitate
>> booting from NVM Express namespaces which are accessed via
>> NVMe over Fabrics (NVMe-oF).
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> 
> Tentatively applied as 6.3 material, but it was unclear what the S-o-b
> tags below mean, so I've dropped them.
> 
> If you are not the original author of the patch, you should add a From
> line pointing to the original author to it and the corresponding S-o-b
> tag along with your S-o-b.
> 
> If you have developed the patch in collaboration with someone, there
> should be a Co-developed-by tag pointing to the other author along
> with the corresponding S-o-b tag.
> 
> S-o-b alone is meaningful only if you are sending a patch from someone
> else, for example as a code maintainer.
> 
>> Signed-off-by: Doug Farley <Douglas_Farley@dell.com>
>> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
>> ---
>>   drivers/acpi/tables.c | 3 ++-
>>   include/acpi/actbl1.h | 2 ++
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 47ec11d4c68e..f390c5883b56 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -545,7 +545,8 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
>>          ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>>          ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>>          ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
>> -       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI };
>> +       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
>> +       ACPI_SIG_NBFT };
>>
>>   #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>>
>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>> index 15c78678c5d3..6ec43410288a 100644
>> --- a/include/acpi/actbl1.h
>> +++ b/include/acpi/actbl1.h
>> @@ -49,6 +49,8 @@
>>   #define ACPI_SIG_S3PT           "S3PT" /* S3 Performance (sub)Table */
>>   #define ACPI_SIG_PCCS           "PCC"  /* PCC Shared Memory Region */
>>
>> +#define ACPI_SIG_NBFT          "NBFT"  /* NVMe Boot Firmware Table */
>> +
>>   /* Reserved table signatures */
>>
>>   #define ACPI_SIG_MATR           "MATR" /* Memory Address Translation Table */
>> --
>> 2.31.1
>>
> 

