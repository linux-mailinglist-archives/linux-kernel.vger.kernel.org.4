Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA44D7171FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjE3Xu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjE3Xu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:50:56 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8F1B2;
        Tue, 30 May 2023 16:50:55 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b01dac1a82so28840415ad.2;
        Tue, 30 May 2023 16:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685490655; x=1688082655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i06h5BK+XtAu5jXCBUd3D2Pr9DE1D8oH6P1s8vIA0QM=;
        b=k20A6MygE0PsVMh/vnP3VhufVUN/vnRUEeJ0xkDCdij7HvhSWINjlPmdUKOnXMcukQ
         qr/HWjznLS7+0/gP5NUem5s6PPS/auHTOWezxyzCXaeikTOtczwqyevUd2LzjYfzK3Wb
         a2xfR9a8KFr/w/yLdRh9BGIRYTxDGHrehHW9iwClAVHHgv0BC4c+Ktzb0dDF1ei7N0p6
         ugtU7pQQehyDGrtUvEZVIsm5cXSb+eKF5JgNxFZ0zSi0Ltf9lpd0FV7JtEmUl27KBdlh
         sf+pymjjfsGT7Ho0UTq4txdy4mieUZk7ENTjXqvWx4+F6Zmq6mXyiSGAvFLZ4iu9dAqH
         nRxg==
X-Gm-Message-State: AC+VfDwdFekYoWgRTtIxCs3pjj2ZIOZ2EVGCV5G/QWjv/0CiPhVljwaO
        Lnb+j2UATbQrxGW6bvceGPY=
X-Google-Smtp-Source: ACHHUZ5q2rHhMeGb6KiH+LiODYM8ZJD5Z/27qCZSHx6XU038OIaBVsCApVD+YW5jC3EWzB+l3X8JCA==
X-Received: by 2002:a17:902:c40f:b0:1b0:286f:233a with SMTP id k15-20020a170902c40f00b001b0286f233amr3875945plk.61.1685490655006;
        Tue, 30 May 2023 16:50:55 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e80e00b001aae909cfbbsm10839276plg.119.2023.05.30.16.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 16:50:54 -0700 (PDT)
Message-ID: <ecd8d769-4143-550c-13b5-ae96e6a76ff6@acm.org>
Date:   Tue, 30 May 2023 16:50:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/1] scsi: ufs: core: Make UFS_MCQ_NUM_DEV_CMD_QUEUES a
 module parameter
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
References: <20230530023518.16965-1-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230530023518.16965-1-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 19:35, Po-Wen Kao wrote:
> A dedicated queue for dev commands is not mandatory, hence let
> UFS_MCQ_NUM_DEV_CMD_QUEUES become module parameter `dev_cmd_queues`
> to allow sharing first hw queue for dev commands.
> 
> When `dev_cmd_queues` is set to 0, the hwq 0 will be shared for I/O
> requests and dev commands. In the same hwq, commands are processed based
> on submission order hence might take longer to dispatch dev command
> under heavy traffic. For the host with dedicated hwq for dev commands
> can benefit in such scenario.

The UFS core has already too many kernel module parameters. I don't 
think that we need more kernel module parameters. Instead of adding a 
new kernel module parameter, I propose to never reserve a hardware queue 
for device commands. Reserving a hardware queue for device commands 
seems wasteful to me.

Thanks,

Bart.

