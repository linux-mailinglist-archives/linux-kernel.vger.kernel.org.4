Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030966F3509
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjEAR3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEAR3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:29:20 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE4AF;
        Mon,  1 May 2023 10:29:19 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ab032d9266so4825045ad.0;
        Mon, 01 May 2023 10:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962159; x=1685554159;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWsKDfZ9DhyKjlEN9i9uZZa656LlSQHxwvUUbjCDUoo=;
        b=j//qM7YOWE1lL1zlViiwict6aRSieY4voYe+aovPgxt8dutgTvYFn4gdl/Q7/DdKNq
         Ip3rt1MQ9OHmVX3aPvmg2u5uj77ENysS//6QHmMuop5Dzbl3T3/YF6WfTPaRX5BfhQaH
         T7IJMEQw30euAT92jg2PNWJzZpCKZSi/Wv55KSTUbTizAyr+AU/LqC5CD5bFj8zI8oBe
         qAM+1DQ//oRiEDG3ZxkPCEqmnvOvlbBX+I1hg6JVIVxK5OPhupoxaG3d7AuE8gn58XGb
         vXkekX8BF/9XsGvD+hA9B9KL7EeDvVIPq2l60zgrr+5inFkd8gwtpOscsHRO8o0UHxDa
         7tmA==
X-Gm-Message-State: AC+VfDzk4hTOn4Aqa4hOcajmOF8RPRvQzFZCWXcikrFQWaEPNSKiGDeh
        pSwjfS5SGCQC8IVqpjMdbn0=
X-Google-Smtp-Source: ACHHUZ7exqEKOU58Z3etuBG+Bq1RB/laict4/LvWmqHGfBFqATOlJp9iFQAiPQqbkML28YnLnb8F6w==
X-Received: by 2002:a17:903:1210:b0:1aa:cddd:57d8 with SMTP id l16-20020a170903121000b001aacddd57d8mr10863482plh.30.1682962158619;
        Mon, 01 May 2023 10:29:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:eba5:79b2:92dd:67e? ([2620:15c:211:201:eba5:79b2:92dd:67e])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b001aafe4f9b8esm1458414plb.180.2023.05.01.10.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 10:29:17 -0700 (PDT)
Message-ID: <f3cef43e-0afb-95b3-bd29-21afa2331a26@acm.org>
Date:   Mon, 1 May 2023 10:29:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] scsi: ufs: core: Change the module parameter macro of
 use_mcq_mode
Content-Language: en-US
To:     keosung.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1>
 <20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 02:44, Keoseong Park wrote:
> mcq_mode_ops uses only param_{set,get}_bool(). Therefore, convert
> module_param_cb() to module_param() and remove the mcq_mode_ops.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
