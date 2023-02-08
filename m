Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5441668E7D8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjBHFqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBHFqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:46:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1899CDF1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 21:46:11 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso3235178pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 21:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGlOEIPzV+FTI/GF62gic89emIZoIYryIf9WL0MuhjI=;
        b=cQmLD187qGYvCE95MDfRyufr4leKm51MnluIeCu1mwvtokMHZKgE9e6RJ8OIsqQPMi
         ewo6oAXyGxCRbEjKCgm4EeLHmc7c1UiRoK0i3HL4F1a36+75ZRjyF8O3SOmfmpJ7ytt0
         dQg2rz8F2L7Ui9fsllAshRSkZVoeQVeI9aoXCVMh1Y1Q1Tvn2mv5tjOBLCXCS1Ny1+GA
         MvaRH6AvLYEw4coHFQ991tFAM6de03LOhkoEkeZZQ6Hoh7iD4gLL0JjaVYDwD6eoWIfU
         iplJ7Y7j89AMoh7SbAVtaUpa5WXzb2ilRqD6Ra8tHg7cjviJFyNZfbHaJff8klqkWaWv
         nDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGlOEIPzV+FTI/GF62gic89emIZoIYryIf9WL0MuhjI=;
        b=UHKPdoc6V68RnegJ9ozFXKYFp2zxCQgR+2Y8ZoQP7adLuB+SEjhTNSdVymjURjc41L
         DYehkzPCP3rYrjorysBdLqK7dpORnn1PCIXWxXYKaA90OhB5g6Giu/3W20rbLdKsYQH9
         rNrtuSTe3iZtapMoKK4R3BldBLYCCTfSd7HkUNSdL7r5lCpntVe/9t4RCyWBKBZZxqnk
         qivHpoTLNV0FAsEUTkKM8p2nEw+3lHfSJzNp97rk5CjExsKc6nWaYKidtwUGv6VR1G6H
         DIFrrycW+RRFvKxaKm/DHiW3yB58wvHXz1EwURs5p04YunzZhQKGTd8EpTCmEc2udcK2
         p1XA==
X-Gm-Message-State: AO0yUKWSYt8iN9wtbbW+bnGo6DJ2g/lxzWqJ/L9iIsiLfa/t9J0l06LI
        X33LJSpPjUoCuPyyjYRDGvm/0w==
X-Google-Smtp-Source: AK7set94skn6M5M9CT0xtS0+tEYXm95sJCOLMhuwaiyK3S9cl/nNQN5VoK2Af4LK20Th3wzFVP00fw==
X-Received: by 2002:a05:6a20:8403:b0:bb:b945:4865 with SMTP id c3-20020a056a20840300b000bbb9454865mr7962364pzd.8.1675835171325;
        Tue, 07 Feb 2023 21:46:11 -0800 (PST)
Received: from [10.16.128.218] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001898ee9f723sm5008429plb.2.2023.02.07.21.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 21:46:10 -0800 (PST)
Message-ID: <b86a549a-5c8e-55dc-d6f4-edc5ca75ac05@igel.co.jp>
Date:   Wed, 8 Feb 2023 14:46:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [EXT] Re: [RFC PATCH 4/4] PCI: endpoint: function: Add EP
 function driver to provide virtio net device
Content-Language: en-US
To:     Frank Li <frank.li@nxp.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <20230203100418.2981144-5-mie@igel.co.jp>
 <20230203052114-mutt-send-email-mst@kernel.org>
 <HE1PR0401MB23313FC60955EADE8A00133088D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjgVKccRcsARSkDF+boVkVi7h=AMHC+iWyOfp4dJ-_tQ@mail.gmail.com>
 <HE1PR0401MB2331D1335BFACBD23B7676EF88DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <HE1PR0401MB2331D1335BFACBD23B7676EF88DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/02/08 0:37, Frank Li wrote:
>>> but it may need update host side pci virtio driver.
>> Thanks, is it possible to use  MSI-X as well? The virtio spec
>> indicates to use legacy irq or
>> MSI-X only.
> I supposed yes. It is depend MSI controller type in EP side.
> But not like standard PCI MSI-X, it is platform MSI-X irq.
>
> If use GIC-its, it should support MSI-X.
>
> Thomas Gleixner is working on pre-device msi irq domain.
> https://lore.kernel.org/all/20221121135653.208611233@linutronix.de
>
> I hope Thomas can finish their work soon.
> so I can continue my patch upstream work.
> https://lore.kernel.org/imx/87wn7evql7.ffs@tglx/T/#u

Thank for sharing this those information. I'll see the details to embed.

>> Best,
>> Shunsuke.

Best,

Shunsuke.

