Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD6F69702F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjBNV4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBNV4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:56:09 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145B305CA;
        Tue, 14 Feb 2023 13:56:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676411735; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Ca/TggrF2spbW8pMsdJvQthh73Cj9ui7TX9h4Ts4FoBXxMiH6Hts2WOnpoMstcylavAvDL1tu9lR9zJhB9Ovp9gw9HoTW6/ods2PbtaHuKDagLg4Qq3F5QpyO3kHgkbVcw/2Nz6lvy1Awx/gN3wq2ZwnaDp6hiYQLBsXs2M6Tr4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676411735; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vySWJ6MN7022l7oLRpZ2ZjFOTGdUlfBsedw6emUG1O4=; 
        b=Zwqm7OmXoHxtZvgHa2/pUq1iRirvi9dcfAVHbkMliZfcGRmeBB8zIzju6AKZDpu7KyoIK+AhZRtz5Ufk1V3icIwlTT2wEKeh7Am3pBP5WhLBPyHsOkR1sccH7j1TNbW6jaLhHjus6/43LhFm+7RUoX5OZwrbylMGziC92LuvMb0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676411735;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=vySWJ6MN7022l7oLRpZ2ZjFOTGdUlfBsedw6emUG1O4=;
        b=Di5jnN9soUnGjJdR/O7p+IrPvwh+BCFYmxAd+xdPOhAwkkYELy8sjacA87Z450a2
        P5OB9yDUlso9h1rdQzX/jrL98upH6zSvN/R57MPEepNi1ber+l9HthibJ3jpEYutJNe
        v44UgNwL7o5qW5XWT0ziksNDISF72+b3UbqcmqGU=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676411732227685.6659792892178; Tue, 14 Feb 2023 13:55:32 -0800 (PST)
Message-ID: <551f3ca9-d919-0eef-844b-8925c94ee236@arinc9.com>
Date:   Wed, 15 Feb 2023 00:55:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] arm: dts: mt7623: disable home key on Bananapi BPI-R2
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        arinc9.unal@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
References: <20230212121354.44590-1-arinc.unal@arinc9.com>
 <C18B89E3-7B54-47B4-98B3-B2D74AB29A54@public-files.de>
 <fbc7cb4e-0424-f9c7-aa99-d8d9f7674175@gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <fbc7cb4e-0424-f9c7-aa99-d8d9f7674175@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2023 21:09, Matthias Brugger wrote:
> 
> 
> On 12/02/2023 13:33, Frank Wunderlich wrote:
>> Am 12. Februar 2023 13:13:54 MEZ schrieb arinc9.unal@gmail.com:
>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>
>>> There's no home key on Bananapi BPI-R2. Disable it.
>>
>>>
>>> +&mt6323keys {
>>> +    home {
>>> +        status = "disabled";
>>> +    };
>>> +};
>>>
>>
>> Acked-by: Frank Wunderlich <frank-w@public-files.de>
>> regards Frank
> 
> 
> Applied, thanks!

Efkaristo poli! (I'm learning Greek, I'm trying to practice wherever I 
can ;))

I'd like to remind my v3 patch series for the mt7623 DTs.

Arınç
