Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5784664CF49
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbiLNSVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbiLNSVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:21:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02804DF12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671042031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=acJcsFYYGOxT3I4W6yrXWSMVZjGUyRCz1b5bHtTbPho=;
        b=LlEOaZ78j/jXLGHP9G3d4zDKiDIDyJmm1jL5wsYt4SAOXavM+k6jAEfFlWIdqeAV7qE9Bb
        5/gyQ4dNdQ8xUQBGRFmYoKiGrRZYsFzYaKhRzGPZALpMn2ua3IdiwjlRJd6LTFYf7QNf3T
        RK3k48Ml1EYcGwlTl9Z2SxcDDueMPXA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-RaarspO4PLaxV09CWMnRiw-1; Wed, 14 Dec 2022 13:20:24 -0500
X-MC-Unique: RaarspO4PLaxV09CWMnRiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74C693C0F676;
        Wed, 14 Dec 2022 18:20:24 +0000 (UTC)
Received: from [10.22.16.93] (unknown [10.22.16.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08DCE1121314;
        Wed, 14 Dec 2022 18:20:24 +0000 (UTC)
Message-ID: <841281bf-75eb-e12d-c531-7d50805fc8d1@redhat.com>
Date:   Wed, 14 Dec 2022 13:20:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] acpi: add support for the NBFT
Content-Language: en-US
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Charles Rose <charles_rose@dell.com>,
        Doug Farley <Douglas_Farley@dell.com>,
        Lenny Szubowicz <lszubowi@redhat.com>
References: <20221208232536.591347-1-stuart.w.hayes@gmail.com>
From:   John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20221208232536.591347-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: John Meneghini <jmeneghi@redhat.com>

On 12/8/22 18:25, Stuart Hayes wrote:
> Add support for the NVMe Boot Firmware Table (NBFT) to facilitate
> booting from NVM Express namespaces which are accessed via
> NVMe over Fabrics (NVMe-oF).
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: Doug Farley <Douglas_Farley@dell.com>
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> ---
>   drivers/acpi/tables.c | 3 ++-
>   include/acpi/actbl1.h | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 47ec11d4c68e..f390c5883b56 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -545,7 +545,8 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
>   	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>   	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>   	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI };
> +	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> +	ACPI_SIG_NBFT };
>   
>   #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>   
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 15c78678c5d3..6ec43410288a 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -49,6 +49,8 @@
>   #define ACPI_SIG_S3PT           "S3PT"	/* S3 Performance (sub)Table */
>   #define ACPI_SIG_PCCS           "PCC"	/* PCC Shared Memory Region */
>   
> +#define ACPI_SIG_NBFT		"NBFT"	/* NVMe Boot Firmware Table */
> +
>   /* Reserved table signatures */
>   
>   #define ACPI_SIG_MATR           "MATR"	/* Memory Address Translation Table */

