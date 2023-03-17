Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27C6BE010
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 05:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCQENp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 00:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCQENm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 00:13:42 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB275850;
        Thu, 16 Mar 2023 21:13:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32H4DOAI035305;
        Thu, 16 Mar 2023 23:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679026404;
        bh=rzBjLuA2vnESonRLg0uUEFMBnPEQcoqzzcZIcS76hqI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=g7+meP32+a0d80hU5jXxK3yvNqWpuuhXtpUV2aAKa7VdMuJoLgqrqLZaDiC01TFk5
         2NQ0vMqHniyX3viSmyhZe8E/lb9h4PQottTN6OfXEACN0tkLzQ34OLeSeQBs74q8xa
         Rx29omPAgl+YF/h6Y+xSd6mHt+M7creB71L4+wrU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32H4DOWr126883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Mar 2023 23:13:24 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Mar 2023 23:13:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Mar 2023 23:13:24 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32H4DLgx061170;
        Thu, 16 Mar 2023 23:13:21 -0500
Message-ID: <5835c3ba-7d69-e9d9-b6bb-9fd7637e85fa@ti.com>
Date:   Fri, 17 Mar 2023 09:43:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 0/2] arm64: dts: ti: k3-j721s2: Add support for ADC
 nodes
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     <nm@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230316095146.498999-1-b-kapoor@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230316095146.498999-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/23 15:21, Bhavya Kapoor wrote:
> J721s2 has two instances of 8 channel ADCs in MCU domain. Add support
> for both ADC nodes in dtsi file. Add pinmux information for both
> instances of ADC in board dts file.
> 
> Changelog v6->v7:
>  - Created 2 commits for k3-j721s2-mcu-wakeup.dtsi and
>  k3-j721s2-common-proc-board.dts instead of a single commit
> 
> Bhavya Kapoor (2):
>   arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support for ADC nodes
>   arm64: dts: ti: k3-j721s2-common-proc-board: Add pinmux information
>     for ADC
> 
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 44 +++++++++++++++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++
>  2 files changed, 84 insertions(+)
> 

LGTM

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


-- 
Regards
Vignesh
