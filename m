Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4581F6CCBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjC1VG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC1VG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:06:56 -0400
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EFBE2;
        Tue, 28 Mar 2023 14:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680037585; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=K3l+6cKlXTkJUHIja2qwDUU7cu+a8Rz+Gdw24HGBpKoIzOJ8vfmxi5gomdSRo3hB+ftJsTbY6mDeK9XzqG3ffCHE/07KCrn+FBaF08SbFGiC62IMJ+cJmBvf8cxCYobLT06itKX22R/XHnDvEa/JfKa6u6ajhSfLx5UjqXIkZZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1680037585; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=dtkb18ovKMaH43unnBPf7khKxODc/lZ7PabQ5gaNQy4=; 
        b=S9FSj28Nsi6/etwDQlZ5k9YJE4DWFkN43BNMr4YzGYq7DIBj+qaV9IPabOSM8EIK4Ap3BYCvnzhmfWqpMC3N54quSqk52tK6qQFWCSaCrtcAr1Ty2+k943NrNgcAc2kTnc1hqjgT6lVTklKVNh8dMorDvuUHmcj0LVpvzoIGkEo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1680037585;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=dtkb18ovKMaH43unnBPf7khKxODc/lZ7PabQ5gaNQy4=;
        b=PKmlQKkw4hyHAu+5NoHDphTDP0scndRBlGhQYcooVl0W1DLiU524odRu62YuKRAz
        hqFKtH3egX7y6vaU9CSe0+KQa5gjR2jmDe6d8GRT1q0tElvBczSJoj8QQapFc6XoaaQ
        UvmqYhmj6Lw55tHg5hFbk6BpIfeuX3133huAvmNM=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1680037584024831.8337484799076; Tue, 28 Mar 2023 14:06:24 -0700 (PDT)
Message-ID: <c12d50aa-7485-9ee4-3af1-8374de64eb07@arinc9.com>
Date:   Wed, 29 Mar 2023 00:06:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 01/21] pinctrl: ralink: reintroduce
 ralink,rt2880-pinmux compatible string
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
 <20230317213011.13656-2-arinc.unal@arinc9.com>
 <CAL_JsqLDRHs=TfcLsc0RJzF6rj84eXZooejmhx4hBDnpvCTk5A@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CAL_JsqLDRHs=TfcLsc0RJzF6rj84eXZooejmhx4hBDnpvCTk5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 23:59, Rob Herring wrote:
> On Fri, Mar 17, 2023 at 4:30 PM <arinc9.unal@gmail.com> wrote:
>>
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> There have been stable releases with the ralink,rt2880-pinmux compatible
>> string included. Having it removed breaks the ABI. Reintroduce it.
> 
> ralink,rt2880-pinmux now shows up as an undocumented compatible string
> in linux-next. Where's the binding for it?

This is exactly what I was talking about here:

https://lore.kernel.org/linux-devicetree/3fdc7db4-0df3-f922-3dbf-9f9250c271aa@arinc9.com/

Arınç
