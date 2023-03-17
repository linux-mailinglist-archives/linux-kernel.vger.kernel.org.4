Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4758C6BF2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCQUoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjCQUoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:44:16 -0400
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F60AF1D;
        Fri, 17 Mar 2023 13:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679085824; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Y582FsUn/rvAl46zKQ+vg4iZzkvmjmgeLYIeb6p6N+RCtmnykIySNbxgvrY3+keXPRSCUvjQUT9gnZu36OP3HktHEexvoRisyL318F1H6GZbOF/Pr+6Cr+r6WBMwl6FPkuU2QPQTXppwxx74rO1530KPDA52+5ZQklU5zH0gO1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679085824; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=JO6TDZk1gNuJY9zhmyYqZtSQKRJFrNsjLtQ8d66Q7jI=; 
        b=astSoG+O232junYv52KbuDV3+OERfLYkkFL3VzhfERG4UhxYbBhgG/gBVNXhyKEsZ/i6RpRh1pAfSr7auQ9y9y0JJkucK+boniqrR1cfuUSoHficKFaagGLXBIxic20Aw1n+qZO/s0iHDVe0ts/zBsETtk57BOl0apylvZCD16E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679085824;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=JO6TDZk1gNuJY9zhmyYqZtSQKRJFrNsjLtQ8d66Q7jI=;
        b=DkOoJ1RNcWXF0uQERlD1A2iMK2YQxgwdrzUfevcgasCEU6QgVAXqk29bIC6dT94v
        p6woSXG3i/DgvBxuEQADeby3gGhRk2PtPwWw9RXN3JDD+euf+I9Tydgz82LHI9dL6Ya
        Uagm474kthEqGGrrCh8hUtXYHwi5h9yx7kkeLWOk=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679085823481812.3752234065518; Fri, 17 Mar 2023 13:43:43 -0700 (PDT)
Message-ID: <d7cc6264-48e1-4aab-ef6a-a106ffaee87e@arinc9.com>
Date:   Fri, 17 Mar 2023 23:43:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 09/21] dt-bindings: pinctrl: ralink: {mt7620,mt7621}:
 rename to mediatek
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-10-arinc.unal@arinc9.com>
 <20230317185810.GA2619692-robh@kernel.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230317185810.GA2619692-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.2023 21:58, Rob Herring wrote:
> On Mon, Mar 13, 2023 at 11:59:09PM +0300, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Rename schemas of pin controllers for MediaTek MT7620 and MT7621 SoCs to be
>> on par with other pin controllers for MediaTek SoCs.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>
>> I'm not changing the compatible string. I asked if it's accepted to do this
>> whilst keeping the compatible string but haven't received a response.
> 
> It's fine with me though I'd somewhat rather keep the filename matching
> the compatible. Either way:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

I prefer to do this so I'm going to keep it as is. Thanks for being OK 
with either way.

Arınç
