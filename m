Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A96C6DF887
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjDLObw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDLObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:31:48 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9494B83DE;
        Wed, 12 Apr 2023 07:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1681309878; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=P7EFm3Wq2/ysbV2EMeWmp81wrbnIWKNF96itF9fODPoX1Ji/EUnmxN60FdGyOkIjC+l8d22euS6a0IW7oeGqzveIl4RGCOTJ96WO1mXUQ7uGBYpO9jGsFchiNZXk5daHyMYBousYnjMdnEdwZkKXczeVNnYW/+9Gw4oRTtWvU1M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1681309878; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=3c7CGkWjnzNRHL7qhiYM9MX8ZN0XNedfJlqVhIQAlA8=; 
        b=GG69l+sMVB+ZMbOqIK1qp12g8Byj49xlNyaevj2FPiIIx6KW546KdIr5vQklTKfvwL9bEZIIY5OYQVMi49KVW0rA7K+zvi0DPopQpHSHF23xDLHLIDZ7PZo6G9Tao5Ap6plik98IGo8j89Zhpum64cHPKr+KNozxzSj4cQpEm9U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1681309878;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=3c7CGkWjnzNRHL7qhiYM9MX8ZN0XNedfJlqVhIQAlA8=;
        b=ZtEvAJKr+8NFnB/5n5uShBN2qHsvvFFzTSCeRXqIhscjxSRCSzZKcbd6nOP0bfnh
        yAjq/bYUwqakWqnxUuGNhTE01Nf/FKkq7ffP7PAAJN1qARTXkK+hpam1+96prkHP1Qb
        9lFntl424cEiToZPSUGq/m3SJTPkn/q6a0lFhUb0=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1681309875185877.4920617615047; Wed, 12 Apr 2023 07:31:15 -0700 (PDT)
Message-ID: <703ad8a8-f84e-6404-4cce-5386bfaa2bd7@arinc9.com>
Date:   Wed, 12 Apr 2023 17:31:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Aw: Re: Re: Re: [PATCH v3 0/5] arm: dts: mt7623: relocate gmacs,
 mt7530 switch, and add port@5
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
 <c3ab9a9b-3eb2-8fb0-d5d7-c0b7c684d3a7@arinc9.com>
 <trinity-dab715b9-3953-40da-bc25-c4c2a5e9b7c3-1676715866453@3c-app-gmx-bap53>
 <27a26da8-8297-5327-7493-54d8359b6970@arinc9.com>
 <trinity-dd260791-3637-4193-8f93-a9fcdb013dcb-1676722705920@3c-app-gmx-bap53>
 <2dc2fc39-b0d5-c872-36bf-fde851debe4b@arinc9.com>
 <A329B2DF-04B7-40FA-BBCE-1F1012A6DBBD@public-files.de>
 <fb96d8eb-2eb7-db19-1135-1a833294dd67@arinc9.com>
 <trinity-899c01a6-0fc5-4900-aea8-2b43802c8329-1676814734826@3c-app-gmx-bs35>
 <trinity-3f46d325-bc45-4ee7-ae86-c8db4467aa94-1681303779505@3c-app-gmx-bap50>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <trinity-3f46d325-bc45-4ee7-ae86-c8db4467aa94-1681303779505@3c-app-gmx-bap50>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.2023 15:49, Frank Wunderlich wrote:
> Hi,
> 
> retested series on bananpi r2 on 6.3-rc6 (after throughput is fixed for mt7623/trgmii too) with additional patches:
> 
> "net: dsa: implement preferred cpu port handling" by Vladimir Oltean to stay on gmac0 by default
> "net: dsa: mt7530: add support for changing DSA master" by Richard van Schagen
> 
> looks good so far, but i have not managed how to change dsa master from the preferred port (eth0) to the second one...
> any idea how the correct syntax is for iproute2?

https://www.kernel.org/doc/html/latest/networking/dsa/configuration.html#affinity-of-user-ports-to-cpu-ports

In short: ip link set lan0 type dsa conduit eth1

> 
> at least vladimirs patch should be included when applying this series

I'm currently cleaning up the DSA driver, I'll get to this at some point.

Arınç
