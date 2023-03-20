Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914A36C1F01
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCTSFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCTSFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:05:11 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A3110268;
        Mon, 20 Mar 2023 10:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679335067; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VNx4QWYCLV74z3Zba6mzNuV84BPhcZfC1VGce7T2tEeVW/OtIDxUKtaoxOQINQoU5Ir8kpBIZrR4wBXWo5QMgpDrxVjyWLqqDhbXTHxwphe4RHJIzoE7Fva66eTtCn5MPlLITCzOkp4xSZvpPF1sOEF1OEdO8eLiEj6OZP8Z5wA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679335067; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=2DI5mRRmeJks6i+blxmhayxvI3We+3JTiNb4Ey8Bp68=; 
        b=PPGFJHC7cmwRV1DOlopzVV7QNS2nHO4cmol7VwdSrlNlvVsBdQjdugFG3gNzPoG3Ai2cmfXIr7sH7J5yWocJ1RBaqBWtklpvJ8iHd3p/jX3W26BFAnUqApjezvRIll9ejnGVClPoMREaY4BaIEfVvMQblosuxFxxshYwivavPFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679335067;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=2DI5mRRmeJks6i+blxmhayxvI3We+3JTiNb4Ey8Bp68=;
        b=jM+gKd2b3IDauXZezQHzPctNJcFd+cDCN603B4qe0+sWpcyRCHMZwPaevHSDc+ae
        BkJMVjlQSQAnKLeGBISX22Q0rBAZLBAqP9QzSuyf/IKh9uyMJ/kPAypgOGok/Om2/Wa
        a14VoiWC2K5BNFuuQZTVLn469ZuOE/39tBSJnSLM=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679335065878288.9131534580729; Mon, 20 Mar 2023 10:57:45 -0700 (PDT)
Message-ID: <bdc82b4a-f1a9-0372-5a57-200a422b1b70@arinc9.com>
Date:   Mon, 20 Mar 2023 20:57:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
 <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
 <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com>
 <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.2023 20:36, Krzysztof Kozlowski wrote:
> On 20/03/2023 18:24, Sergio Paracuellos wrote:
>> Hi Krzysztof,
>>
>> On Mon, Mar 20, 2023 at 5:36 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 20/03/2023 17:18, Sergio Paracuellos wrote:
>>>> Adds device tree binding documentation for clocks and resets in the
>>>> Mediatek MIPS and Ralink SOCs. This covers RT2880, RT3050, RT3052, RT3350,
>>>> RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
>>>
>>> Use subject prefixes matching the subsystem (which you can get for
>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>>> your patch is touching).
>>>
>>> Subject: drop second/last, redundant "device tree binding
>>> documentation". The "dt-bindings" prefix is already stating that these
>>> are bindings.
>>
>> Sure, will do. Sorry for the inconvenience.
>>
>>> (BTW, that's the longest redundant component I ever saw)
>>
>> I thought it was better to just list compatible strings inside one
>> single file than adding the same binding in multiple files.
> 
> I don't understand how this is answers about redundant piece of subject.
> Amount of files are not related to repeating pieces of subject prefix.
> 
>>
>>>
>>>>
>>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>>> ---
>>>>   .../bindings/clock/mtmips-clock.yaml          | 68 +++++++++++++++++++
>>>>   1 file changed, 68 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/mtmips-clock.yaml b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>>>> new file mode 100644
>>>> index 000000000000..c92969ce231d
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>>>
>>> Filename matching compatible, so vendor prefix and device name (or
>>> family of names).
>>
>> I used mtmips here but list compatibles starting with ralink. As I
>> have said in the cover letter I am inspired by the last merged pinctrl
>> series for these SoCs.
>> See:
>> - https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a302b06185@arinc9.com/T/#t
> 
> 21 patches, so what exactly I should see (except that I was involved in
> that discussions)?
> 
> Plus nothing from this thread warrants here exception from naming style.
> 
> 
>>
>> Not all of compatible currently exist.
> 
> Then clearly state this.
> 
>> All of these are at the end the
>> way we can properly match compatible-data to write a proper driver.
>> The current ralink dtsi files which are in tree now
>> are totally incomplete and not documented so we are planning to align
> 
> Nothing like this was said in commit msg, so how can we know?
> 
>> all of this with openWRT used files and others soon. That's the reason
>> we are not touching
>> 'arch/mips/boot/dts' at all now. I don't think anybody is using any of
>> this but mt7621 which is properly completed and documented.
> 
> Anyway, none of this explains exception from naming convention - vendor,
> device or family name.

Would mediatek,mtmips-clock.yaml make sense?

Arınç
