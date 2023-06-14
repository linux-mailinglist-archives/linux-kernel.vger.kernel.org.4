Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFD972FC15
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbjFNLMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243858AbjFNLMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:12:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388ED2973;
        Wed, 14 Jun 2023 04:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7812E640B5;
        Wed, 14 Jun 2023 11:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29DDC433C8;
        Wed, 14 Jun 2023 11:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686741070;
        bh=KS9DVj9aYRog3BltgsnuuYsgIpVqdyC67ivJyO1Sh6c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l51wC1yNUHxP3dvGWOFensUejtxU3LH+sUgU1yL/ngqptnlvaJWh6u5xH4rryKae+
         tFJO2CbP4SQCKXlB/eh94Nk/jv52NKaCA9xx/K6xQnUaV8RHS06HDDzKOboSpNj5eG
         8+wdjqNINcBLgLwJu2xuMKxLoqo3AIvTA8l7UFtntwo+OAhTogBQx5009T9u6ps9nb
         A/21CqSW9HN/rUM30kdad6jsc2Ds4VcLouIoR9vx2e60XeU2w7HZ7itsIH/6fbuUUB
         fkacHEKZggSjjDSXZqnuuVCWOFCN2ENFo8uYJX9/067JysnpezrGLDkevAkX0RMTFh
         ZZqzfCxV/VypA==
Message-ID: <d12e3d8b-20e8-48bb-84d0-3fe7d3502c83@kernel.org>
Date:   Wed, 14 Jun 2023 13:11:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/3=5d_dt-bindings=3a_can=3a_xilinx=5fcan?=
 =?UTF-8?B?OiBBZGQgRUNDIHByb3BlcnR5IOKAmHhsbngsaGFzLWVjY+KAmQ==?=
To:     "Goud, Srinivas" <srinivas.goud@amd.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "gcnu.goud@gmail.com" <gcnu.goud@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <1686570177-2836108-2-git-send-email-srinivas.goud@amd.com>
 <20230613-outskirts-dove-e3e39b096647-mkl@pengutronix.de>
 <PH8PR12MB667577C4800ED8E82C36D57DE15AA@PH8PR12MB6675.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <PH8PR12MB667577C4800ED8E82C36D57DE15AA@PH8PR12MB6675.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 12:22, Goud, Srinivas wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>> Sent: Tuesday, June 13, 2023 1:23 PM
>> To: Goud, Srinivas <srinivas.goud@amd.com>
>> Cc: wg@grandegger.com; davem@davemloft.net; edumazet@google.com;
>> kuba@kernel.org; pabeni@redhat.com; gcnu.goud@gmail.com; git (AMD-
>> Xilinx) <git@amd.com>; michal.simek@xilinx.com; linux-can@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/3] dt-bindings: can: xilinx_can: Add ECC property
>> ‘xlnx,has-ecc’
>>
>> On 12.06.2023 17:12:55, Srinivas Goud wrote:
>>> ECC feature added to Tx and Rx FIFO’s for Xilinx CAN Controller.
>>> Part of this feature configuration and counter registers added in IP
>>> for 1bit/2bit ECC errors.
>>> Please find more details in PG096 v5.1 document.
>>>
>>> xlnx,has-ecc is optional property and added to Xilinx CAN Controller
>>> node if ECC block enabled in the HW.
>>>
>>> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
>>
>> Is there a way to introspect the IP core to check if this feature is compiled in?
> There is no way(IP registers) to indicate whether ECC feature is enabled or not.

Isn't this then deductible from compatible? Your binding claims it is
only for AXI CAN, so xlnx,axi-can-1.00.a, even though you did not
restrict it in the binding.

Best regards,
Krzysztof

