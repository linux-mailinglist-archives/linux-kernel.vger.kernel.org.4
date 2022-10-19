Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15C56038DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 06:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJSE3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 00:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJSE3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 00:29:08 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E37054C8D;
        Tue, 18 Oct 2022 21:29:06 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29J4SmTR062851;
        Tue, 18 Oct 2022 23:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666153728;
        bh=eFh32FoTwp/oIkMmernvS0tQR2Uo417WxoSAXhgooHY=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=P+YwybHtKLIKE9jyUkUr5b8L3KcIcOQ2xqP93/67wwgjbE25J9gGN1L+9X9IJr5fD
         EmRHE0GUIa2gimOnEHA9ycV2D4tpdrlnp8wwWhoFl8fAPbdPpsEOdU4ZaxhG+4a2AP
         UQh/gK3WYagSoASPR1GM9cFYpOXb0HGgY0xybOJM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29J4SmQY116582
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Oct 2022 23:28:48 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 18
 Oct 2022 23:28:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 18 Oct 2022 23:28:48 -0500
Received: from [172.24.145.87] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29J4Shv6095798;
        Tue, 18 Oct 2022 23:28:44 -0500
Message-ID: <694b14c5-1d96-a305-99f0-c6be2248ea7b@ti.com>
Date:   Wed, 19 Oct 2022 09:58:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
CC:     <rogerq@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <lee@kernel.org>,
        <linux-phy@lists.infradead.org>, <dan.carpenter@oracle.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J721e
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
References: <20221018084333.149790-1-s-vadapalli@ti.com>
 <20221018084333.149790-2-s-vadapalli@ti.com>
 <166609952062.171721.12955273990805791032.robh@kernel.org>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <166609952062.171721.12955273990805791032.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 18/10/22 19:02, Rob Herring wrote:
> On Tue, 18 Oct 2022 14:13:31 +0530, Siddharth Vadapalli wrote:
>> TI's J721e SoC supports additional PHY modes like QSGMII and SGMII
>> that are not supported on earlier SoCs. Add a compatible for it.
>>
>> Extend ti,qsgmii-main-ports property to support selection of upto
>> two main ports at once across the two QSGMII interfaces.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 48 +++++++++++++++----
>>  1 file changed, 40 insertions(+), 8 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml:75:12: [error] syntax error: mapping values are not allowed here (syntax)

I will fix the errors in the v3 series and ensure that there are no
errors or warnings with dt_binding_check, using the updated dt-schema
and yamllint.

Regards,
Siddharth.
