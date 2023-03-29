Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19046CD079
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjC2DIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjC2DIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:08:18 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A930E9;
        Tue, 28 Mar 2023 20:08:16 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so17200615pjt.2;
        Tue, 28 Mar 2023 20:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680059295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4LgpIpQnXfACsVW0Sr0WyWPrrO9CvQ3IEdJzoWk7M4=;
        b=VMFUpEUS9GsCI/lCf6a+nLzVzmutT4RHN/z+dJKu7cRL9M4gmzQtDofk286qk8sHMc
         IHsrf2WHkp+a3srrhJRvP1cewL3Igo5gTOfWoofqjn6GlxG39bwHZ+thoUMV6wHvqb6U
         RUDrdCAjQTVjn705OQN3oXlOywGt/2n7VCnrM2tkkJnyXiiPvYN4L1Izyu4jGZ0ubD42
         huXYl4BdG0TGVu5mHRaRkFqvSQStBa3Nq//xrdS2FhVQibXMgjLJamzbm36UQ2MtnXKk
         bQpcS23buS8JEqgm8EjZHIIWs853sGpNkIVhjrgi9MAW4z33L9zKrtuh6MTB5apo5HWS
         3OgQ==
X-Gm-Message-State: AO0yUKUNdsFJ7zb7A6W19y2VpGqxEI+7si1ox67drQpWpjrNZLBTPqYu
        UxK4NLoKu1N1YLEPamlZGQs=
X-Google-Smtp-Source: AK7set/Q12xf+jqguzPY9SwUlBFl3T2v1sDCZ9j6DZ2UAHKLcyqvrkIjxH4SQUNUFMYvcvNSrqJ+eA==
X-Received: by 2002:a05:6a20:2056:b0:db:bc99:1f4f with SMTP id x22-20020a056a20205600b000dbbc991f4fmr13341518pzx.32.1680059295427;
        Tue, 28 Mar 2023 20:08:15 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x23-20020a62fb17000000b0062d35807d3asm6295202pfm.28.2023.03.28.20.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 20:08:15 -0700 (PDT)
Message-ID: <6f1cf671-d8d3-b958-54b7-5f65db8731b5@acm.org>
Date:   Tue, 28 Mar 2023 20:08:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] scsi: ufs: ufs-mediatek: Add
 UFSHCD_QUIRK_MCQ_BROKEN_INTR quirk
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        alice.chao@mediatek.com, naomi.chu@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        eddie.huang@mediatek.com, mason.zhang@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
References: <20230328103801.11198-1-powen.kao@mediatek.com>
 <20230328103801.11198-2-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230328103801.11198-2-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 03:37, Po-Wen Kao wrote:
> Set UFSHCD_QUIRK_MCQ_BROKEN_INTR for mtk driver

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
