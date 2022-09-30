Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AF35F118D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiI3SXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiI3SXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:23:19 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D805128A31;
        Fri, 30 Sep 2022 11:23:18 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id h10so1936939plb.2;
        Fri, 30 Sep 2022 11:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NZe80/zTgMqnxaX4R7r16UgMLE6glhJPyTnx+OtT0xk=;
        b=2be4OfpPZGAZ6XoZEwOtZHioDlfmjHy4BXGSJFox3fiYhhF8cqHSFFA9NBM3vrnZha
         kMmrEIIBb9g+f5iG3F9Hc5c02L+Irjgu/FX1IjPXGkzZTrg5ElKYu3ppzO9W6oSehWeZ
         MxL6xSMO0qgiqr/4WRuoioKevgHtPpFgE5v6OqDG+LCNTNwi8S1QOmPfAe84KLzNPArR
         wtf2hUxgtqSiEHfh2ABNgMUfTqN/6XYJiIeY5Gfu8nosDiAKYtiyfXPDFXCDmmf2j3Sy
         XMUHWDXmDsmoE/ScONSCsTzNK48JTnJ1g2w2OZBJQXZymNzb6fzY6sQHP1Zn5l/yVp1Y
         v0jQ==
X-Gm-Message-State: ACrzQf1UZq1OUtD1mek8tC6MN5JSLOLxN4hHohp3S6HjbpWgCsM3abr2
        dno2W7l14Fc/p73ABWh2yas=
X-Google-Smtp-Source: AMsMyM55IZv799oNZvH6mNiV43YPr5wp4G3loeXCfRQxQVutt4Q0JGulW2iD/+AcbGjDMSs9TtA7cA==
X-Received: by 2002:a17:902:ef52:b0:17c:f072:95bc with SMTP id e18-20020a170902ef5200b0017cf07295bcmr2356069plx.28.1664562197903;
        Fri, 30 Sep 2022 11:23:17 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:56f2:482f:20c2:1d35? ([2620:15c:211:201:56f2:482f:20c2:1d35])
        by smtp.gmail.com with ESMTPSA id x64-20020a17090a38c600b00205d85cfb30sm5631068pjb.20.2022.09.30.11.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 11:23:17 -0700 (PDT)
Message-ID: <2f5a8742-b25d-d6b3-c6a4-1c119a94d569@acm.org>
Date:   Fri, 30 Sep 2022 11:23:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 01/16] ufs: core: Probe for ext_iid support
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
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <ff7cdcdef82f6c9d709e2b6ed5d91e255327b780.1663894792.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ff7cdcdef82f6c9d709e2b6ed5d91e255327b780.1663894792.git.quic_asutoshd@quicinc.com>
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
> +	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);

What value is reported when reading the REG_MCQCAP register on an UFSHCI 
3.0 controller? -1 or 0?

> +	hba->ext_iid_sup = (hba->mcq_capabilities & MASK_EXT_IID_SUPPORT) >>
> +		EXT_IID_CAP_SHIFT;

[ ... ]

> +	if (dev_info->wspecversion < 0x400)
> +		goto out;

Isn't this version check superfluous? Only UFSHCI 4.0 controllers should 
support the extended IID feature.

> +	ext_ufs_feature = get_unaligned_be32(desc_buf + DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);

The above change introduces a third instance of this code. Please 
introduce a helper function that does something like the following and 
replace the above line with a call to that helper function:

	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
		return 0;

	return get_unaligned_be32(desc_buf +
				 DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);

> +out:
> +	dev_info->b_ext_iid_en = !!ext_iid_en;

Please remove "!!". This conversion happens implicitly when assigning to 
a boolean variable.

Thanks,

Bart.
