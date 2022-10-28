Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9300161196C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJ1RkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJ1Rj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9A922B0C;
        Fri, 28 Oct 2022 10:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E31D1629E7;
        Fri, 28 Oct 2022 17:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F741C433C1;
        Fri, 28 Oct 2022 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666978795;
        bh=ijO6aXAOytrnNWFvN6FIBPIF9fWaDeLYuPg+SmXzcW0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XlmX7AbLOlzcuDycIMTqQo5Msl/O1UrlY9QhSC6rGdeKF9JUjr3yrR9NpcHe2TYM+
         5suxjBt+Zv56j2cJU/oSN2Rahek8/rTW3NlgC9YBMu3vbyyg+IhXjKhjmvkhmwtAuP
         H+WDYNUQADpwXTt2AHYU66l28ZAbVfxwVvcfyurSOdWvYTYLSLAmOqWoKEaF0CGXQv
         MSBOUzEDFqrU4NM2XAp6iS6vNsOkEaPg2Nnllrq2Pk4hVjQk6CGstuMijgXCdnBLTZ
         qu/Law20CAgJeDQjTdRk1ob/7vgoAUmxchqimhuDnH231xMHziRaQRDrkzyPjqkUrp
         kGHDZ0Y2vmiBw==
Message-ID: <eeeb3895-4eed-ab2f-10e7-111a6275b8e7@kernel.org>
Date:   Fri, 28 Oct 2022 13:39:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 2/2] dt-bindings: Document common device controller
 bindings
Content-Language: en-US
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Rob Herring <robh@kernel.org>
Cc:     "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <cover.1666806317.git.oleksii_moisieiev@epam.com>
 <ab68324eea3c788a369260f5a1e5da843a960cde.1666806317.git.oleksii_moisieiev@epam.com>
 <166682078099.1353934.10574272333105424439.robh@kernel.org>
 <Y1omrFVw0FbC3YTc@EPUAKYIW015D>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <Y1omrFVw0FbC3YTc@EPUAKYIW015D>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 02:35, Oleksii Moisieiev wrote:
> On Wed, Oct 26, 2022 at 04:51:15PM -0500, Rob Herring wrote:
>> On Wed, 26 Oct 2022 17:51:27 +0000, Oleksii Moisieiev wrote:
>>> Introducing of the common device controller bindings for the controller
>>> provider and consumer devices. Those bindings are intended to allow
>>> divided system on chip into muliple domains, that can be used to
>>> configure hardware permissions.
>>>
>>> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
>>> ---
>>>  .../feature-domain-controller.yaml            | 80 +++++++++++++++++++
>>>  1 file changed, 80 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/feature-domains/feature-domain-controller.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/feature-domains/feature-domain-controller.example.dtb: foo@0: feature-domain-names: ['default', 'unbind'] is too long
>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/feature-domains/feature-domain-controller.yaml
>>
>> doc reference errors (make refcheckdocs):
>>
>>
>> See https://urldefense.com/v3/__https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ab68324eea3c788a369260f5a1e5da843a960cde.1666806317.git.oleksii_moisieiev@epam.com/__;!!GF_29dbcQIUBPA!y6dnIrQEa4gr2RDYPf2_Oc7JsKHJrAKtl69xg0Jlf-Qri5BP9kBzqIknprWXaikX5y2Yz_UWCW5yYv_9Hw$  [patchwork[.]ozlabs[.]org]
>>
>> This check can fail if there are any dependencies. The base for a patch
>> series is generally the most recent rc1.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit.
>>
> 
> Hello,
> 
> Thank you for the response. I would recheck and resubmit patch series if there
> will be no additional comments.
>

when resubmitting, Cc necessary maintainers as pointed out by
scripts/get_maintainer.pl. Or base your tree on something decent...

Best regards,
Krzysztof

