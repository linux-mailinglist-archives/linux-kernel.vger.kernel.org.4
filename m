Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72F703000
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbjEOOgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEOOgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:36:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557EE11D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:36:12 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-528cdc9576cso8883191a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684161372; x=1686753372;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntle7Mc0MN09Ld4JSB2zHnjwzKKJ2xLWcbwccUINeWM=;
        b=nmpPkLbkHeWzrNUYIBgGFtDeWZrt9C1ULqbYHO7f3h/8Rozghdl8hEcHeNcKQkbTlG
         zADuBhj4lbPnYGD8y9sfS2D+zwgCOyNhxCHNtW1op6PeVK3aiuq4zlzeYQvUA28CJK6A
         3faxbTFV4s9D85ojUIQ+o+ptrFpllMArk8nNfCl3GnS2e3QJST0XWRxMHnW/0vpfgned
         //KOYuh+4ZkNpexBLsdOZfUrPTcSn276Nmt3xBHXEGTsWs6VRzquyRJHGZvncJT0hSd4
         qCNkxCZ3A9UIDtDzZJrZupk0r8lpurw1ZMdYnFvm5xR+qi/kyrRcfUe1UHTveEBeGVOl
         zU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161372; x=1686753372;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ntle7Mc0MN09Ld4JSB2zHnjwzKKJ2xLWcbwccUINeWM=;
        b=EgdWkix23Y3EKKOVmBv4WS9W8ZIQ8NKoyxgy/SxxlfzH4Oyd0x7kSh5lZxeFgWZ1RC
         3gGDoAzjCZCXqTxWvDU5D+RehQR0H20MZXKC2UE/rLoTSH+jTt+/BJf2OTEN1lk1+lCv
         lT3cI0yp0OI81Z/67rJzFvfgsF7XuNjJKl7Q03KNr5+x/J/ldPdJYNtCs87toxB4MlgE
         EoGK3A+ATZQMtfff3YucpSyVlKVrmmtOXWQgToTfBogfrgVkVvr/6sbH4GUZTSp3QrTo
         26WxbBQA6GetW+LMGEVGq7X3ZvoKuahNkYK9CejbpJkk7LvkDpP1VJiWLnTV/0k3YbLU
         jPQw==
X-Gm-Message-State: AC+VfDwVddXTu+VfriGQomVy8aUG1+IGM1rtEmdSL8eJP4ocwFx52HZk
        UHXis82wXvmROiC3/eAazF4Ux9Na7kuYfQ==
X-Google-Smtp-Source: ACHHUZ5Y1IBpWDwTz6WkQ1oOqRQ0CqOq276XS/52HNucim7sFHfLFQo4MIjL/je6cCeGa2eTmGpHdw==
X-Received: by 2002:a05:6a20:9146:b0:105:393b:5dff with SMTP id x6-20020a056a20914600b00105393b5dffmr9261541pzc.16.1684161371517;
        Mon, 15 May 2023 07:36:11 -0700 (PDT)
Received: from [192.168.0.115] ([113.173.119.15])
        by smtp.gmail.com with ESMTPSA id a5-20020aa780c5000000b006439bc7d791sm11899633pfn.57.2023.05.15.07.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 07:36:10 -0700 (PDT)
Message-ID: <e8a87c2b-a29a-ccf9-49c6-3cfceaa208bb@gmail.com>
Date:   Mon, 15 May 2023 21:36:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Wan Zongshun <vincent.wan@amd.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
From:   Bui Quang Minh <minhquangbui99@gmail.com>
Subject: amd-iommu: get_highest_supported_ivhd_type question
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Since this commit 8c7142f56fedfc6824b5bca56fee1f443e01746b (iommu/amd: 
Use the most comprehensive IVHD type that the driver can support), 
amd_iommu driver can support IVHD type 0x11 and 0x40 beside old type 
0x10. This commit introduces a new function to determine the appropriate 
IVHD type

	/**
	 * get_highest_supported_ivhd_type - Look up the appropriate IVHD type
	 * @ivrs          Pointer to the IVRS header
	 *
	 * This function search through all IVDB of the maximum supported IVHD
	 */
	static u8 get_highest_supported_ivhd_type(struct acpi_table_header *ivrs)
	{
		u8 *base = (u8 *)ivrs;
		struct ivhd_header *ivhd = (struct ivhd_header *)
						(base + IVRS_HEADER_LENGTH);
		u8 last_type = ivhd->type;
		u16 devid = ivhd->devid;

		while (((u8 *)ivhd - base < ivrs->length) &&
		       (ivhd->type <= ACPI_IVHD_TYPE_MAX_SUPPORTED)) {
			u8 *p = (u8 *) ivhd;

			if (ivhd->devid == devid)
				last_type = ivhd->type;
			ivhd = (struct ivhd_header *)(p + ivhd->length);
		}

		return last_type;
	}

As the name and comment suggest, the driver is intended to use the 
highest IVHD type provided in ACPI table. However, looking at the 
implementation, I see that it chooses to use the last IVHD type of the 
first devid appears in the ACPI table. Are there any reasons behind this 
implementation?

Thank you,
Quang Minh.
