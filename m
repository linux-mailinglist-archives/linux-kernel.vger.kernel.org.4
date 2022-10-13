Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D52D5FD66B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJMIqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJMIqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:46:45 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8897F15FD96;
        Thu, 13 Oct 2022 01:46:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29D8kR7U037725;
        Thu, 13 Oct 2022 03:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665650787;
        bh=ZqAvK0Bo9tuPdjUmWHMjOdEYetr/nCxAujiZNOn+ZdA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=gpzRAdshxB8Jq1SvJX2TQUrWu8Ddg+vfb8VR3uyY3ayKQGtQkSw72IYeD3r2S5KwZ
         u5Dw+QG0zOfFIr7hPL0Tp0oj4VKEVwsgfGFUh6qbcRYeVvGStVwNhbJ9GcAyT/qbDt
         mP3KacX4qOtP51MKXEB0EOkPyHTKbxvO4mGtjVic=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29D8kRdh036671
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Oct 2022 03:46:27 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 13
 Oct 2022 03:46:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 13 Oct 2022 03:46:27 -0500
Received: from [10.24.69.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29D8kL0a002875;
        Thu, 13 Oct 2022 03:46:22 -0500
Message-ID: <531c3974-d4db-c2eb-62b6-0e74eee5f0c4@ti.com>
Date:   Thu, 13 Oct 2022 14:16:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/5] dt-bindings: remoteproc: Add PRU
 consumer bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, MD Danish Anwar <danishanwar@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <srk@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, <nm@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, <vigneshr@ti.com>
References: <20221012114429.2341215-1-danishanwar@ti.com>
 <20221012114429.2341215-2-danishanwar@ti.com>
 <166558063092.1936865.1773120279875751081.robh@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
In-Reply-To: <166558063092.1936865.1773120279875751081.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 12/10/22 18:49, Rob Herring wrote:
> On Wed, 12 Oct 2022 17:14:25 +0530, MD Danish Anwar wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> Add a YAML binding document for PRU consumers. The binding includes
>> all the common properties that can be used by different PRU consumer
>> or application nodes and supported by the PRU remoteproc driver.
>> These are used to configure the PRU hardware for specific user
>> applications.
>>
>> The application nodes themselves should define their own bindings.
>>
>> Co-developed-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../bindings/remoteproc/ti,pru-consumer.yaml  | 132 ++++++++++++++++++
>>  1 file changed, 132 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.example.dtb:0:0: /example-0/icssg2-eth: failed to match any schema with compatible: ['ti,am654-icssg-prueth']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 

This error is coming as this dt-schema has 'ti,am654-icssg-prueth' as
compatible in the example section, which is introduced in [1] patch series.
Including the full example section in this dt schema binding is causing this error.

In v5 [2] of this series, only the 'ti,prus', 'firmware-name' and
'ti,pruss-gp-mux-sel' properties were included in the example section. Mathieu
had asked to include full example in the dt binding document.

So I added full example section. But in full example I included compatible
property as well which is not introduced in this series thus creating dt check
binding error.

I will remove the example section from here and add it to dt-schema binding of
icssg-prueth.

[1] https://lore.kernel.org/all/20220531095108.21757-2-p-mohan@ti.com/
[2] https://lore.kernel.org/all/20220607045650.4999-2-p-mohan@ti.com/

> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
