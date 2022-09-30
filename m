Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4936C5F11BD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiI3SnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiI3Sm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:42:58 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715B41B7D81;
        Fri, 30 Sep 2022 11:42:57 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id c24so4703164plo.3;
        Fri, 30 Sep 2022 11:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aFuTCSgiQ1q3axsguxuz+z/zfzJxetBKH5EU8cOHNE0=;
        b=8SIAVzwT9wehcB5zg4cImwVG3BTRacWVc/GxAnPKJumy3K/DSuI5xyYncJWYho7qnK
         sVBD8mXkdofs+9A6PFm6p4lCQt4PpRbwIb8hk+a+t0O8nCiAej2lalNeTo3fEGPwD6Hn
         aRdQwmrHilSnjA/ZmKxHF4p/cxVYIvJfAinVQPv0noHW/QIJCWF52nBphGrVLlRxZ83H
         Ks+3lGJXRD9puB53J77UNhmwVmqYRt8Gn5YDf/GRfLQoFYIv3jc4SCEr8ALbMu7eVe9l
         WAMmWpTMFb7GJdlSHfcvC6PRA1f9PVmOa+FKyjZgB1eojNEkVoS0gqAr0bi04893/GyX
         UArg==
X-Gm-Message-State: ACrzQf3HP3Fo590v4TspFyXqYYFaR7DzSK5XxactKwuAKIOQYK8Iltgq
        uHQwa89fkKszAnZ2BZnoKtU=
X-Google-Smtp-Source: AMsMyM63hj0JZwb61O8N3SA/97MjlXhh7TAt954QlO2qGZP4zZRlJKTN9QDiw/tHJI3V9Tc4QCy9vw==
X-Received: by 2002:a17:902:7897:b0:178:9292:57b9 with SMTP id q23-20020a170902789700b00178929257b9mr10403947pll.102.1664563376850;
        Fri, 30 Sep 2022 11:42:56 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:56f2:482f:20c2:1d35? ([2620:15c:211:201:56f2:482f:20c2:1d35])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090301ca00b00172d9f6e22bsm2291650plh.15.2022.09.30.11.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 11:42:56 -0700 (PDT)
Message-ID: <2a25bce5-aad2-cc01-5879-73005cafb371@acm.org>
Date:   Fri, 30 Sep 2022 11:42:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 05/16] ufs: core: mcq: Configure resource regions
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, mani@kernel.org,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_cang@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com, quic_richardp@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        avri.altman@wdc.com, beanhuo@micron.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <4d4df6ad6353b93253fb22deefb772dc59f5c84e.1663894792.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4d4df6ad6353b93253fb22deefb772dc59f5c84e.1663894792.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 18:05, Asutosh Das wrote:
> +/* Resources */
> +static const struct ufshcd_res_info_t ufshcd_res_info[RES_MAX] = {
> +	{.name = "ufs_mem", .resource = NULL, .base = NULL},
> +	{.name = "mcq", .resource = NULL, .base = NULL},
> +	/* Submission Queue DAO */
> +	{.name = "mcq_sqd", .resource = NULL, .base = NULL},
> +	/* Submission Queue Interrupt Status */
> +	{.name = "mcq_sqis", .resource = NULL, .base = NULL},
> +	/* Completion Queue DAO */
> +	{.name = "mcq_cqd", .resource = NULL, .base = NULL},
> +	/* Completion Queue Interrupt Status */
> +	{.name = "mcq_cqis", .resource = NULL, .base = NULL},
> +	/* MCQ vendor specific */
> +	{.name = "mcq_vs", .resource = NULL, .base = NULL},
> +};

Please leave out the members that are NULL (.resource and .base) since 
the compiler will initialize these for you.

>   /**
> + * struct ufshcd_res_info_t - MCQ related resource regions
> + *
> + * @name: resource name
> + * @resource: pointer to resource region
> + * @base: register base address
> + */
> +struct ufshcd_res_info_t {
> +	const char *name;
> +	struct resource *resource;
> +	void __iomem *base;
> +};

Please remove the suffix "_t" since that suffix is typically used for 
typedefs and not for data structures.

Thanks,

Bart.
