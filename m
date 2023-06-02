Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8740A71FE1B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjFBJmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjFBJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:42:01 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 02:41:46 PDT
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706821AB;
        Fri,  2 Jun 2023 02:41:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 358EAC0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
        t=1685695598; bh=IyHRJF/zre043k98ZDshtLNWhe8WKi2wLyzTArL8jtA=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=X1aWV4csjSO2RPP7ImF6gPm9floXV+c11hTO2RkkL5ZpwwzncQKcuUEf6rOTwZED2
         cK7P4r6MKAnwdXitp+dXJ/sPDFIv26m4F3ZKVirRTZp+8sdiPmromGeQj+zBKl1fbM
         RVevDZleSvrJ0PAeuaZZgJiXv5s6h3aMm/FPY06osUXdzXKLRDwySvnSvA8lxKyqi3
         nfIRxMTfyMpPqQE8/zJkFC/tXZa+KBdKHCconvupGk2vkv6otDPX0YncapaIEsP+Du
         WpfTChvxpL3Buro9euVycxE1eJTNTvEz26vg9vS23G+q82w8RwZMN5GgWGuQDPFbMZ
         4p+u/R32A8Vbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
        t=1685695598; bh=IyHRJF/zre043k98ZDshtLNWhe8WKi2wLyzTArL8jtA=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=wRROsHfNTT80YN/60jvIiKOv3gjfU+1kjKfFYX40vJy0dSOm+PNpuByNgxDVeGt0C
         PStAyU6eViXSd7KEXZKMc4hh5sUOFk62rMX2MKFy9uBrKLVmN8u9l/CV9wbydrm4eq
         hjULC5hamswiGAr8RiaI/oR+jk4ESS4sN+QWpDU6hCz0jTc4NKxrQSEsq2snqGH5I6
         6bbPA9A04v7GyUR0+03X2PKNGmtC9XYiyhXV+3x0JkwuHq1dYsUeBz9hVYK5tJJ4jC
         Oq9bTdW16BnTPQfa7cyIbkLAkrk2ju6u1dEy/IQ6/1urjMIR06cVxxTQBbR9m/oCfa
         NJy8vPex3zfKw==
Message-ID: <b9fc06dd-d9e4-58fc-6252-87590c416ce7@yadro.com>
Date:   Fri, 2 Jun 2023 11:46:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] dt-bindings: leds: Document Awinic AW2016 bindings
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux@yadro.com>,
        <linux-leds@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230524113910.196321-1-v.barinov@yadro.com>
 <20230524114056.196518-1-v.barinov@yadro.com>
 <168493088788.3462735.2834416618033227181.robh@kernel.org>
 <20230602080655.GN449117@google.com>
Content-Language: en-US
From:   Vladimir Barinov <v.barinov@yadro.com>
In-Reply-To: <20230602080655.GN449117@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 6/2/23 11:06, Lee Jones wrote:
> «Внимание! Данное письмо от внешнего адресата!»
>
> On Wed, 24 May 2023, Rob Herring wrote:
>
>> On Wed, 24 May 2023 14:40:56 +0300, Vladimir Barinov wrote:
>>> Add Awinic AW2026 binding documentation
>>>
>>> Signed-off-by: Vladimir Barinov <v.barinov@yadro.com>
>>> ---
>>>   .../bindings/leds/awinic,aw2026.yaml          | 92 +++++++++++++++++++
>>>   1 file changed, 92 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw2026.yaml
>>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Error: Documentation/devicetree/bindings/leds/awinic,aw2026.example.dts:52.3-53.1 syntax error
>> FATAL ERROR: Unable to parse input tree
>> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/leds/awinic,aw2026.example.dtb] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [Makefile:1512: dt_binding_check] Error 2
> Taking this set out of my review queue until this is rectified.

Thank you for paying attention for this commit.

I've already resent fixes in v2 version:

https://lore.kernel.org/all/20230525101341.2036563-1-v.barinov@yadro.com/

>
> --
> Lee Jones [李琼斯]


-- 
Regards
Vladimir

