Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2776C1F74
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCTSVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjCTSUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:20:11 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9323B23F;
        Mon, 20 Mar 2023 11:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679335659; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=hr7AJp53V6fqL0E6c2EPDnnB8E+/xEg/7PrArQUOuc/HnFqHTRDkFUY2CEA78cqiuXeI5PDaEW9Xi6XXKUcYdw82MOlMy8iK/sqixIKZ8K1pI4mXmc7hs9u34eE7PyMyI60+iUMe0+hTYzV+TZItxuI5NZwFq77uVkKzTXC/kNI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679335659; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=wjxScLsbYnvFFmnITRMrmQqYNfvNZcrcBQFkGHy1K58=; 
        b=SRY3bB3aoHAaPLhGHdmnZf4LqBiQZdRyGHcORQdNe0mrFSuKhPyvyrDHui8ZgyJb28u9g2gMVQ/CI5IopntXcGcnVXAR81kJ+ZrMJuZ4K6r3ll8KTYUMRoBLkFDVHyQSr7leZYUZ8Upe5y7XNYvQqlrCZhpgyTPKkOp5qI9KMuA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679335659;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=wjxScLsbYnvFFmnITRMrmQqYNfvNZcrcBQFkGHy1K58=;
        b=HNaZ3yVErqBAPMmJk5PNHvWrhX24ENG/chaxq2h6Yg4/gzaBVQi0gqCP342iHkp/
        /pr3Qk4rVpxgJ2v40hWYXYpk6DqiLke6O2Mmc5JJmfW7N6HPa7iutBQUJapBX8uOSO+
        coxMGpiixRiKGyB7lA/ajft2c+NHYe8TNNp3IqVg=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679335657962195.85580421693794; Mon, 20 Mar 2023 11:07:37 -0700 (PDT)
Message-ID: <9cfd5bc1-64e9-5250-5a8d-18ac4c205584@arinc9.com>
Date:   Mon, 20 Mar 2023 21:07:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
 <5109c01b-48bd-2854-3f42-bf8ef8b4a821@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <5109c01b-48bd-2854-3f42-bf8ef8b4a821@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.2023 21:01, Krzysztof Kozlowski wrote:
> On 20/03/2023 17:18, Sergio Paracuellos wrote:
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - ralink,rt2880-sysc
>> +          - ralink,rt3050-sysc
>> +          - ralink,rt3052-sysc
>> +          - ralink,rt3352-sysc
>> +          - ralink,rt3883-sysc
>> +          - ralink,rt5350-sysc
>> +          - ralink,mt7620-sysc
>> +          - ralink,mt7620a-sysc
>> +          - ralink,mt7628-sysc
>> +          - ralink,mt7688-sysc
> 
> One more comment - this and maybe other compatibles - have wrong vendor
> prefix. This is mediatek, not ralink.

This platform was acquired from Ralink by MediaTek. I couldn't change 
some existing ralink compatible strings to mediatek as Rob explained on 
my pinctrl patch series that we don't do that. The compatible strings on 
this patch series here are new but I'd rather keep the compatible 
strings ralink to keep things consistent.

Arınç
