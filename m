Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88266DB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbjAQK2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjAQK1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:27:44 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D87279A9;
        Tue, 17 Jan 2023 02:27:42 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30HAQsXv103287;
        Tue, 17 Jan 2023 04:26:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673951214;
        bh=HLR+mGL+Qj5K/UgXvir37XZAI7z3g+0nfN0Ej2ahbJU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Rh5hZ4g0uh5A8jXmMjycfiTYYjzSQhfMkIr6i2Ce4ZhOvL8rMUq6rlIJsD1kKZE86
         DcWJK+SeByxXW65XzxNxc7XsKAuXuBdLLpg0Txu2DUmjCBfQLHvZbPmYstw+QKmlLf
         rmXBqH19WuBZcRX3abXXxn72Ve78vvFtr+7zfbKo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30HAQsJs029663
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jan 2023 04:26:54 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 17
 Jan 2023 04:26:53 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 17 Jan 2023 04:26:53 -0600
Received: from [172.24.223.35] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30HAQj0K053861;
        Tue, 17 Jan 2023 04:26:45 -0600
Message-ID: <10ca38d8-df9a-33f1-3f66-8342580ef5a9@ti.com>
Date:   Tue, 17 Jan 2023 15:56:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/4] dt-bindings: Introduce dual-link panels &
 panel-vendors
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>, Nishanth Menon <nm@ti.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Mediatek List <linux-mediatek@lists.infradead.org>,
        Linux C-SKY Arch List <linux-csky@vger.kernel.org>,
        Linux RISC-V List <linux-riscv@lists.infradead.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Rahul T R <r-ravikumar@ti.com>
References: <20230103064615.5311-1-a-bhatia1@ti.com>
 <Y8UZQHvVT2VQcQ33@pendragon.ideasonboard.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <Y8UZQHvVT2VQcQ33@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for taking a look at this!

On 16-Jan-23 15:00, Laurent Pinchart wrote:
> Hi Aradhya,
> 
> On Tue, Jan 03, 2023 at 12:16:11PM +0530, Aradhya Bhatia wrote:
>> Hi all,
>>
>> Microtips Technology Solutions USA, and Lincoln Technology Solutions are
>> 2 display panel vendors, and the first 2 patches add their vendor
>> prefixes.
>>
>> The fourth patch, simply introduces the new compatible for the generic
>> dual-link panels in the panel-lvds driver. This new compatible is based
>> from a new DT binding added in the third patch explained below.
>>
>> The third patch introduces a dt-binding for generic dual-link LVDS
>> panels. These panels do not have any documented constraints, except for
>> their timing characteristics. Further, these panels have 2 pixel-sinks.
>> In a dual-link connection between an LVDS encoder and the panel, one
>> sink accepts the odd set of LVDS pixels and the other, the even set.
>>
>> A lot of this has been based from the Advantech,idk-2121wr dual-link
>> panel[1] and Maxime's patches for generic LVDS panels[2] (which are
>> single-link by default.) and the discussions that happened before they
>> were finally merged.
>>
>> Below are some notes and points that I want to bring forward.
>>
>>    - The advantech,idk-2121wr panel binding uses 2 boolean properties
>>      dual-link-odd/even-pixels, to signify which port sink is being used
>>      for which set of LVDS pixels. I too have added similar support and
>>      introduced constraints around those properties, so as to not break
>>      the ABI... but I believe there is a better way to achieve this.
>>
>>      A "pixel-type" enum property could be introduced in their stead,
>>      which can accept one of the 2 options <dual-lvds-odd-pixels> or
>>      <dual-lvds-even-pixels>.
>>
>>      This method, in my opinion, is more accurate and cleaner to
>>      implement in the bindings as well.
>>
>>      If this does sound a better I can push out a new revision where the
>>      driver supports both these methods (to not break the ABI) and the
>>      advantech,2121wr panel can remain as an exception.
> 
> It's usually best not to change an existing system if there are no good
> reasons, so I'd ask why you think a pixel-type property would be better
> (including when taking into account the fact that we would have to
> maintain the advantech,2121wtr driver separately) if you want to go that
> way. Otherwise, if we were developing this from scratch, I would have no
> real preference.
> 
Such a property would have been a more accurate representation of the
case here, voiding the need of a "oneOf:" clause, and simplifying the
overall binding implementation.

Furthermore, I saw this as a fair opportunity to introduce the new
property because there was only one other dual link panel which used the
original properties.
And, while the code delta shall be same in implementing the pixel-type
property irrespective of the number of existing dual-link panels that
support the original method, I believe with pixel-type, we can set a
fresh precedence for future scenarios (perhaps for "quad-link" LVDS, if
there ever will be one).

Having said that, this was merely a suggestion. If this does not seem to
be a strong enough reason to change the existing system, I can keep
using the original properties (as I have in the patches) and send a v2.

>>    - As an alternative to the previous point, if that method is not
>>      preferred for some reason, the advantech,2121wtr panel binding
>>      could then be merged in the panel-dual-lvds binding as part of
>>      future work.
>>
>>
>>    - Another tweak, I am looking forward to do as part of future work and
>>      would like all your comments is to introduce driver-based
>>      implementation of the panel timing parameters, like it is with
>>      "panel-simple". The driver can then support both the panel-timing
>>      sources (DT node or hard-coded driver structure) and the binding
>>      can remove this from the "required" section.
> 
> There's been a very long discussion in the past (multiple discussions
> actually) regarding whether timings should be set in DT or in drivers.
> There were multiple arguments supporting both sides, without (it seems)
> a clear winner. If you want driver-side timings for dual-link panels,
> I'd like to understand why you think that's better. If the reasons are
> the same as the ones expressed when we discussed simple panels, you
> should also look at whether or not any of the fears expressed on either
> side have materialized.

I went through the discussions that you mentioned above. For now, I will
stick to the status-quo that there is for LVDS panels. =)

> 
>> Thank you!
>>
>> [1]: https://patchwork.freedesktop.org/patch/357122/
>> [2]: https://patchwork.freedesktop.org/patch/471228/
>>
>> Aradhya Bhatia (4):
>>    dt-bindings: vendor-prefixes: Add microtips
>>    dt-bindings: vendor-prefixes: Add lincolntech
>>    dt-bindings: panel: Introduce dual-link LVDS panel
>>    drm: panel-lvds: Introduce dual-link panels
>>
>>   .../display/panel/panel-dual-lvds.yaml        | 157 ++++++++++++++++++
>>   .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
>>   MAINTAINERS                                   |   1 +
>>   drivers/gpu/drm/panel/panel-lvds.c            |   1 +
>>   4 files changed, 163 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml
> 

Regards
Aradhya
