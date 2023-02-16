Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FDD698B62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 05:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjBPERJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 23:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBPERC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 23:17:02 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 082E734035
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 20:17:02 -0800 (PST)
Received: from [192.168.87.25] (unknown [50.35.78.176])
        by linux.microsoft.com (Postfix) with ESMTPSA id 240CA20B9C3D;
        Wed, 15 Feb 2023 20:17:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 240CA20B9C3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676521021;
        bh=VmsDF5gDLO0hK+EBXyDyJfasU051a0MIEUc0wQei5PA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=qblMqRUk/t0G8EmLsEeHJRQ3EbsYm/2M9u9QOGyyhpNRJFj0S+UgH5sth+0NIEiWH
         s/GHuGPYnCe2/EiI2SnvXgkQjadEPJcywRIcTqHchiR2v7YSG7DgVw4a/xlSrjqd36
         3bsg1CWzAZAQxHGsUps1VyDKTONOB+9NpLC9NEhA=
Message-ID: <a62fb259-3ad3-b75e-c59e-2ce937bf799a@linux.microsoft.com>
Date:   Wed, 15 Feb 2023 20:17:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
 i2C driver
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
 <b0f55494-3a17-4d87-7b8f-5b078503cb53@linaro.org>
 <SEZPR06MB52690A1D06F3CFEAAF1FDBDEF2A39@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Language: en-US
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
In-Reply-To: <SEZPR06MB52690A1D06F3CFEAAF1FDBDEF2A39@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

On 2/14/2023 9:43 PM, Ryan Chen wrote:
> It is not duplicated, as my description in cover " This series add AST2600 i2c new register set driver"
> So, this will be different driver compatible.
> The original compatible is
>        - aspeed,ast2400-i2c-bus
>        - aspeed,ast2500-i2c-bus
>        - aspeed,ast2600-i2c-bus
> So the new register set compatible is "- aspeed,ast2600-i2c", remove "bus".

Is it possible to keep existing driver drivers/i2c/busses/i2c-aspeed.c
for ast2400/ast2500, while move ast2600 support to new driver
altogether, say i2c-ast2600.c along with new register mode? By default
new driver can support legacy mode with same compatible "aspeed,ast2600-
i2c-bus", additionally driven by dt props, switch to new mode.

Regards,
Dhananjay
