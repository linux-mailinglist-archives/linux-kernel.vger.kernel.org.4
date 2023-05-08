Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3716FB276
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjEHOU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjEHOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:20:26 -0400
X-Greylist: delayed 1522 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 May 2023 07:20:24 PDT
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30200E40;
        Mon,  8 May 2023 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=McnVi0pRU1tHz403LrXGQdHX++EZ969HmPkiZtI1nZQ=; b=iCFl8+pi3CqMBWYuONMPMg+nM0
        /0WFwKK25rsqOXlJ9hewIV8/L97WhwUxZQP1SfzQ9enn0EOVHR0jMhrTm5VHB1+qiW0DEH0SD8W9o
        xLwLAEVloGkR2mjNYfLJeyeWVZh0iSlO1JhQM6Y/8t3a99MzAlGmoczVwK852u4u1dx9AyfS/7z3Z
        7f02wUnQEKhrpKz3kE84mX6ddLUfFBtT7Cq1uH8ZSidTBc3of4UJd3utkAaDIwCn0uoVw81sL42uH
        /rts8XKsfiLgwzaYg+Vf56fYRSORevj25apxLWkofJPCp1+/ywCfom6jQiSSIPM4U6fxVzbnA0N53
        R/znwrcw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pw1KI-00BxYA-U3; Mon, 08 May 2023 16:54:54 +0300
Message-ID: <5dabe391-2ec8-4483-ead8-582cd10a0ff1@kapsi.fi>
Date:   Mon, 8 May 2023 16:54:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs
Content-Language: en-US
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stefan Kristiansson <stefank@nvidia.com>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
 <20230508122048.99953-5-pdeschrijver@nvidia.com>
 <20230508133325.xllmriwydkczk6lh@krzk-bin>
 <MW3PR12MB43461CD5FEAE22462283AE7CB1719@MW3PR12MB4346.namprd12.prod.outlook.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <MW3PR12MB43461CD5FEAE22462283AE7CB1719@MW3PR12MB4346.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 16:52, Peter De Schrijver wrote:
> No idea what the second error is about. Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml does not have a oneOf conditional?
> 
> Peter.

The oneOf conditional would be from the core schema. Also, no top posting.

Cheers,
Mikko

> 
> ________________________________________
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: 08 May 2023 16:33
> To: Peter De Schrijver
> Cc: thierry.reding@gmail.com; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; linux-kernel@vger.kernel.org; robh+dt@kernel.org; Jonathan Hunter; linux-tegra@vger.kernel.org; devicetree@vger.kernel.org; Stefan Kristiansson
> Subject: Re: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs
> 
> On Mon, 08 May 2023 15:20:52 +0300, Peter De Schrijver wrote:
>> Add bindings for DRAM MRQ GSC support.
>>
>> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
>> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> ---
>>   .../firmware/nvidia,tegra186-bpmp.yaml        | 69 ++++++++++++++++++-
>>   .../nvidia,tegra264-bpmp-shmem.yaml           | 40 +++++++++++
>>   2 files changed, 106 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml:10:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml: 'oneOf' conditional failed, one must be fixed:
>          'unevaluatedProperties' is a required property
>          'additionalProperties' is a required property
>          hint: Either unevaluatedProperties or additionalProperties must be present
>          from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.example.dts:110.31-116.11: ERROR (duplicate_label): /example-1/hsp@3c00000: Duplicate label 'hsp_top0' on /example-1/hsp@3c00000 and /example-0/hsp@3c00000
> ERROR: Input tree has errors, aborting (use -f to force output)
> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.example.dtb] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1512: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
> MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml
> 
> See https://patchwork.ozlabs.org/patch/1778345
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
> --
> nvpublic

