Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558F76DD7D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjDKKXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjDKKXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:23:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77231103
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:23:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-246772b0887so266441a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681208585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byWc1PE6Mr5vjZlhn/A+Tmf4sT9JymgBqL3WiNfAGUE=;
        b=wipKEWC+NFBLOJJbhpgSUVjFSUafgXjLjbN0VovJGlmQZ+sPip1LZhfPCSwaxGbpIR
         5y27wyjQfXgMafJmN3l5LDEzDDBkPoUVaxhAbrrGr8G2vwZGeOn98XLURlvcXvPZ4qM3
         cDhgVsBy41b3PXMKtOPHJGRydsHI7KJ7WoeMGPCr092QrYPTrssz8GhbTBNHpaRlGe9D
         XGUkXayvF0UATBS9tmA4mp/8dmAPz2/eVQgRdwbS8sOMm2hRAE/uYrsZANbuDfI9LxDE
         +O7ClneN7UBboTX8SQvDEJArTt8kuqZcAHadhkx828LR64SCA060juUMoaIP9xqma0rv
         RMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681208585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byWc1PE6Mr5vjZlhn/A+Tmf4sT9JymgBqL3WiNfAGUE=;
        b=wegNI6yN2G3qq/mjUn5B81RbPgmxe6sFoupnHfEgEC+RXOaKegv3QAS+wePZSPJQyY
         wDoLxg836iWM3EsKQfijW1c/U51ACkpsz6e7LerlTIL+IqpDnAvFxT5szeWPSqWo9F+7
         n1cjJVrEOMy9lJWHMX4RyqVYM7vucyklXBU/PdToZ8enUH2Ua13uzzedaKgTIHgPGZeC
         k7u3nQUvgY5r0ECdqMikjx/m2aaecikov/qk6582GWboNVWPBbctv0WlKRgHaDUhUBur
         Y/l9orpxohX50P4yFUaVHN2JRyWwlRi7JlXUwztdQf7knw4yPx1CYHVqEm7hR6HGPXUQ
         l0qg==
X-Gm-Message-State: AAQBX9dwSK342ABFVF4QpmMLqL5cN7r5418EjFVKYQxHmADE8OE3q4w6
        mXYxKeqhcycvI25Q0zEiMP1m8g==
X-Google-Smtp-Source: AKy350aRDcPsPp5oCo47lPcOVa42ieYrNa6u+2XtkMrMTyVaJJj188fuLSxe3T+oyEHpmhAG498e7Q==
X-Received: by 2002:aa7:9dce:0:b0:628:1274:4d60 with SMTP id g14-20020aa79dce000000b0062812744d60mr14844325pfq.21.1681208584884;
        Tue, 11 Apr 2023 03:23:04 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78dc8000000b0062dba4e4706sm9487628pfr.191.2023.04.11.03.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 03:23:04 -0700 (PDT)
Message-ID: <54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp>
Date:   Tue, 11 Apr 2023 19:22:59 +0900
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
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

I'm working on it. I'll submit the next version.

>
> Best regards
> Frank Li


Best regards,

Shunsuke

