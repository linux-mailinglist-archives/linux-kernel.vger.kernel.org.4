Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7F971722D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjEaAAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjEaAAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:00:43 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382C2B2;
        Tue, 30 May 2023 17:00:42 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1b02085bf8dso27260545ad.0;
        Tue, 30 May 2023 17:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685491241; x=1688083241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6f9p6Ip33TWg0QRs0/JjpOq/znW7u5TyerI2zaL1Kw=;
        b=B4W43gFHBHavwjnuqrtQhqnJesPfypK+T8nIriN5rHc3gIab2RO7v2kDBFCd2IGao/
         mzOzoBhcSaLT7CFrqnzn9dK6nTAViLDfBHUPodqG77cymXOBWklFTcaMzCt+zRms7dcF
         hMiwursRA4sZu4WlM99XnoTWPl0KbCELIGBjZna8gh5ZoFC9no7GvOo0DvfXrZYbg9iF
         WF9qQ0o/4GsD/1iw22hv6hauytKff7ZnLV5pqQWNFv3LxGymfZSylYi+AnKX1nSUDBXx
         gmTF0J/rqWaFJQ9NzATaI9ZqlSmNKvjhoNpLjwJFrWo6ZUbFnKRpY1kB9+Mk6J0W2fXM
         NWuw==
X-Gm-Message-State: AC+VfDxRluKehzBrJ2RDFFzU9HkriKbMtiQoPL/QzmdWCFxmphpsHx/4
        xJKbvrmLkvyLyR68IqR2yZQ=
X-Google-Smtp-Source: ACHHUZ6KHbtIWEo8uC7vWZab/C/5aBiWhIjwNwa+qTpWZHhYAbQ+wZaWF65z/EBJMIeMAB/BO8nC8g==
X-Received: by 2002:a17:902:e993:b0:1ae:40ed:4b8 with SMTP id f19-20020a170902e99300b001ae40ed04b8mr3647056plb.22.1685491241359;
        Tue, 30 May 2023 17:00:41 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902db1100b001a65fa33e62sm10836138plx.154.2023.05.30.17.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 17:00:40 -0700 (PDT)
Message-ID: <3bb2386a-8cba-6ee2-6034-60af4d37c4db@acm.org>
Date:   Tue, 30 May 2023 17:00:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] scsi: ufs: core: Export symbols for MTK driver
 module
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
References: <20230530023227.16653-1-powen.kao@mediatek.com>
 <20230530023227.16653-3-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230530023227.16653-3-powen.kao@mediatek.com>
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

On 5/29/23 19:32, Po-Wen Kao wrote:
> Export
> - ufshcd_mcq_config_mac
> - ufshcd_mcq_make_queues_operational
> - ufshcd_mcq_read_cqis
> - ufshcd_mcq_poll_cqe_lock

Please use the regular style for patch descriptions and use full 
sentences instead of a bullet list.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
