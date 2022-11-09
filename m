Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87736623541
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiKIVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiKIVAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:00:00 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143774C24A;
        Wed,  9 Nov 2022 12:57:20 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id c2so18209166plz.11;
        Wed, 09 Nov 2022 12:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uD0GBYBsoiz/gWYARSVIf2ZmCuLIn6//Vw6TLDyyaDk=;
        b=Vhftjzmfu0SwLsWMSWiAsWr7oVd9GDkoEvhUSY+LdAbvxs7rWAL+3Y29c3egfF9cti
         qmmleqrPaV8fyvfGhbZpR1I3IaoYMH/j8HRQcJz71LtkQOTZgVtYDs+BmbAeF4uqDMXz
         g7yG0skx2FTge0wbhYaS5MMFezv+E11qS/K6faJsQ3j+K5T9mBfOy8Ak2NyHIvXScSlM
         TO6wOvQIgWrfwfir8zw7IXYDeJHVFyEOSn4SjD8lx0d5jRmCitoAtbKuW3eBpQeVHkha
         KcSTDpyuigKJep2oLawcVOG4kHM5azQVrkPb9G3wUahUxrnItBIWzONjdik8yKBPlf7l
         y0DQ==
X-Gm-Message-State: ACrzQf2ovskXeqTz6rBtmvHIPxkuebuccBbSnSCZr/j0KcJj74Cnc4rL
        ++3Ls5726I7fkJvVK102E/c=
X-Google-Smtp-Source: AMsMyM6p5H47cPIfuFBoHxSrzEpBlvA/rTkDEywkBb3sGm2Kl+Ps8iLYUi4EJ4PlEY27+/wEAy0czg==
X-Received: by 2002:a17:90a:db09:b0:212:ec36:4d04 with SMTP id g9-20020a17090adb0900b00212ec364d04mr1243701pjv.158.1668027417839;
        Wed, 09 Nov 2022 12:56:57 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:68b6:5dae:a00c:c3b? ([2620:15c:211:201:68b6:5dae:a00c:c3b])
        by smtp.gmail.com with ESMTPSA id q32-20020a17090a4fa300b0020ad86f4c54sm1682505pjh.16.2022.11.09.12.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 12:56:57 -0800 (PST)
Message-ID: <310d25c7-1a7b-2770-8f47-9ad21ef12ffd@acm.org>
Date:   Wed, 9 Nov 2022 12:56:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 02/16] ufs: core: Probe for ext_iid support
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1668022680.git.quic_asutoshd@quicinc.com>
 <94a483673c3c7e03d8897fffd6e6145027979517.1668022680.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <94a483673c3c7e03d8897fffd6e6145027979517.1668022680.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 11:41, Asutosh Das wrote:
> Task Tag is limited to 8 bits and this restricts the number
> of active IOs to 255.
> In Multi-circular queue mode, this may not be enough.
> The specification provides EXT_IID which can be used to increase
> the number of IOs if the UFS device and UFSHC support it.
> This patch adds support to probe for ext_iid support in
> ufs device and UFSHC.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
