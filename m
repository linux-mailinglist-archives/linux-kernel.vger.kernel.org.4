Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D86738047
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjFUJoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjFUJoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:44:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDDC1704
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:44:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-988b75d8b28so399930066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687340670; x=1689932670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlQq0fREEwCbN+zg5nWq1emhTmdTchChleyqUPdFjVs=;
        b=RoI96apqYmjKlWTjKN9p6BcyJ5VA/4bq/RqDzYThEy0NTWAwP4iWQC/oU2Pz+jsrWF
         y/AWu2hB+BWqGcMKtXVmEDRQee9CFN9MW5CNkP154XjT82efc2LYyYZh8mG4UOow+sg7
         BY47AJvaDatxyD2z49YFys2s4fQdxOLXmsIOPMLjKnIyeVbBQ/2KHxFaicptBf6YpmXo
         BO/cLdVn0wOXZuAwdnfvYVdz+Z5oq0YTs9eSYX/7WOVjFM4oL3W7vBOjBtxXKbnFTueQ
         OWejhX/40rqyJm3/Cq4Rk47J4+OMZwG+8z65zQoq+84Ha6IBIFZlluyWcIj9VZDsLHdt
         D49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687340670; x=1689932670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlQq0fREEwCbN+zg5nWq1emhTmdTchChleyqUPdFjVs=;
        b=aQXEWUwY8Sr2W58nlu3vHxGhJbl7de4fm8S14Vn+Z+cZvtsV6ChzeIDJKXTC0CPRkE
         4i5aLCBFGkPzke1QXrvDbftyTpa3Nk44ABVk9uEGGAjKc9esPCORHtWMmgQ5Fkxpcx9x
         kNrFvGE/R8Nob8NJuzvZc/gIupq8wOB/ufwg601tGmcPbyTOpD7rTnxaMalywcVKJeVf
         kDZyPDX8uUzQzEvgIgVYlYyDlwwcQiBt1n1MGq/FyFzs2safR8aSRoRe85LDr6rDOdGo
         DdOb6i8MfTvGxzKLgGD52BWHMpuCNhVv4CSF64LtsD4yb4G5qmTdcT9HmiKsXcB0QNEj
         8bYw==
X-Gm-Message-State: AC+VfDxL59IJnh2oDfkokQGkOpRLmVOdcFScBG0tP782krnNKAdJjOf+
        JYNp+gwKFAYFM86lLhTliamZog==
X-Google-Smtp-Source: ACHHUZ4o1HsVmfldXZuoEWli3WLi9034GhMEw8CEYCXPxvttvyzAbQrtdKKRHkoZZ1vR3ZTq8DvX0g==
X-Received: by 2002:a17:907:3e0a:b0:982:9662:a679 with SMTP id hp10-20020a1709073e0a00b009829662a679mr14357488ejc.9.1687340670186;
        Wed, 21 Jun 2023 02:44:30 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id q25-20020a170906145900b0098503ba0db4sm2878692ejc.149.2023.06.21.02.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 02:44:29 -0700 (PDT)
Message-ID: <eccd35b4-369d-8344-d6e6-476df56c20bd@baylibre.com>
Date:   Wed, 21 Jun 2023 11:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] linux-firmware: update firmware for MT7922 WiFi
 device
Content-Language: en-US
To:     Deren Wu <Deren.Wu@mediatek.com>, jwboyer@kernel.org,
        dwmw2@infradead.org, ben@decadent.org.uk,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        linux-firmware <linux-firmware@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5d30a2ec441a1364a2548c007a94f6f3337b6eb0.1685603641.git.deren.wu@mediatek.com>
 <2af3edb8178b629af34afbce9c583556fb565081.1685603641.git.deren.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <2af3edb8178b629af34afbce9c583556fb565081.1685603641.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 09:36, Deren Wu wrote:
> Update binary firmware for MT7922 WiFi devices
> 
> File: mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin
> Version: 20230530123154a
> File: mediatek/WIFI_RAM_CODE_MT7922_1.bin
> Version: 20230530123236


Hi Deren,

Same here. Can you provide details (fix, improvement, new feature) for 
these updated binaries please ?

-- 
Regards,
Alexandre

