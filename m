Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C336D71F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 03:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbjDEBWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 21:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbjDEBWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:22:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD83E2720
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 18:22:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l7so32408288pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 18:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1680657727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMZrmMwRVjfayGfEKZ5/Wh+uf7NTWdPEZjK/ywMGWbw=;
        b=lnRyzmMUBzt+VBlN5/kcDBg8RroinuDrfbciKMwqQwLIuaHTHlEBACCxutv53kRs7O
         0piT5yMXkTblwA/V126tw4KL6d48qex0ewc7RX3hPtyi9o2vTfWuIWCffSFX0z9veXw5
         2lGvowhgkxo3OaOyjZSS9sOG24Les0MeYsQrM0YX1PFFx9Tp48ShY+oYbhSqTsDAaih9
         VctYuChx8qvwghczBGyKMXQJ3D8Sc776C0ntWEhTQvx+9xUY3CNiWdfZChayMDUGrTVb
         OFA0gamskvvneAMDWv7T1aEkpvjh3hxw45CJRjMjU1hiuZD09JC3Yk9A6XuInOPBm1an
         +c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680657727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMZrmMwRVjfayGfEKZ5/Wh+uf7NTWdPEZjK/ywMGWbw=;
        b=bx+sM0i5Aq+RLFkQW+aEDgDab6WcjSAl7NThukTRM3emuS8Ub3XTF/4fryzbsHXUGB
         x3evs9k1/7nYmXnmZHrxP1DNdTQtUj5NnS+nWU+GMlnVtAoRU5QSHC55LPD92WKDwaab
         pqsLzjD8mqaQau3KEIsIvB4eNhImO0rwQF/2tYQ87CJLDBwOTFZGouMmu/nEBKTmvhBw
         KBQ4sp7X5qMSZDmXhAKrLdDjLvCh/kA/427Jm3iAEYxOsztqp1ojLV+Ht9lu53fkndF0
         9RH02PsQTiVKkcimZIKpvqZUEfSZ5xzEpn++Mu6gmgQzRzuTQ6kh4Wrphy2mLHUsZsPB
         9j5g==
X-Gm-Message-State: AAQBX9d+gUSgNmrq+c2DZs2U0iodwkMluqexB+sjmn7mOqp/1k8Q9Lgt
        ME7H2ZEP6kgnsfdcDuRcMvhWNA==
X-Google-Smtp-Source: AKy350YFg5M4Wfdwi60nxK/2w+Z902ux2yIkzfxHjSBUhr16zkDivckeO7pjVqcGWM0F3n4oJT8JHA==
X-Received: by 2002:a05:6a20:1bc6:b0:bf:4563:e647 with SMTP id cv6-20020a056a201bc600b000bf4563e647mr3276440pzb.40.1680657727161;
        Tue, 04 Apr 2023 18:22:07 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id r26-20020a62e41a000000b006281273f1f5sm9340798pfh.8.2023.04.04.18.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 18:22:06 -0700 (PDT)
Message-ID: <ad0217de-3db8-e3f9-3824-62b36dc7d2ee@igel.co.jp>
Date:   Wed, 5 Apr 2023 10:22:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
Content-Language: en-US
To:     Frank Li <frank.li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <HE1PR0401MB2331EAFF5684D60EC565433688D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjDDEK0NB=BWh00-HGU-p+sC=8TyP-oPdccnZxKxZt9w@mail.gmail.com>
 <HE1PR0401MB2331A8D5C791C34D9C39A62688DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <796eb893-f7e2-846c-e75f-9a5774089b8e@igel.co.jp>
 <AM6PR04MB483881DFA2C35F02011FE74D88899@AM6PR04MB4838.eurprd04.prod.outlook.com>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <AM6PR04MB483881DFA2C35F02011FE74D88899@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/03/30 1:46, Frank Li wrote:
>> On 2023/02/08 1:02, Frank Li wrote:
> Did you have chance to improve this?

Yes. I'm working on it.I'd like to submit new one in this week.

> Best regards
> Frank Li

Best,

Shunsuke,

