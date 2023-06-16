Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA73732F14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbjFPKsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345403AbjFPKsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:48:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461463C25;
        Fri, 16 Jun 2023 03:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3E3B63A1E;
        Fri, 16 Jun 2023 10:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF142C433C0;
        Fri, 16 Jun 2023 10:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911941;
        bh=NUODPlKnUcd/m1dN07t06atMah6KiygSU+gSQ+cz2nM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y5rLoHmkqqEGx3k2Lr3IQoSfQEbWjDyQt5y8k2tWr8ynramvXm8KNyF3cF7zy0CzC
         kp6sPMp0ZSrqQ8V78F9WGOsElsOvW7+FcidHUvvyTUFEg4AYxs8ng5ovtIdioHBzIe
         FoD+2U46+KEHFzSpBFry0rqWUxEj1DC/V1eFxNCEqWGQF44xSoqb0TlbTvOvKy4XD7
         4VNq1SfyBnjD61tEN4McwlF2VWPbMGqqIcSPqMr2HWTflrJRh3UXjKwLsAPM4iCV+7
         flP59CRY1R2QoEjxd4NiN5ZVypXa8HgMYZbIB7wolyelpsEFB4gdvdkjf4QwBkKK7+
         soiUouuagl3zg==
Message-ID: <8555c686-c663-767e-ce1c-a3b76fdafe05@kernel.org>
Date:   Fri, 16 Jun 2023 12:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/3=5d_dt-bindings=3a_can=3a_xilinx=5fcan?=
 =?UTF-8?B?OiBBZGQgRUNDIHByb3BlcnR5IOKAmHhsbngsaGFzLWVjY+KAmQ==?=
Content-Language: en-US
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
 <d12e3d8b-20e8-48bb-84d0-3fe7d3502c83@kernel.org>
 <PH8PR12MB6675D75114C7EE280235BE8CE158A@PH8PR12MB6675.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <PH8PR12MB6675D75114C7EE280235BE8CE158A@PH8PR12MB6675.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 12:13, Goud, Srinivas wrote:
>>>>> xlnx,has-ecc is optional property and added to Xilinx CAN Controller
>>>>> node if ECC block enabled in the HW.
>>>>>
>>>>> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
>>>>
>>>> Is there a way to introspect the IP core to check if this feature is compiled in?
>>> There is no way(IP registers) to indicate whether ECC feature is enabled or
>> not.
>>
>> Isn't this then deductible from compatible? Your binding claims it is only for
>> AXI CAN, so xlnx,axi-can-1.00.a, even though you did not restrict it in the
>> binding.
> Agree it is only for AXI CAN(xlnx,axi-can-1.00.a) but ECC feature is
> configurable option to the user.
> ECC is added as optional configuration(enable/disable) feature 
> to the existing AXI CAN.

Why boards would like not to have ECC? I understand that someone told
you "make it configurable in DTS", but that's not really a reason for
us. Why this is suitable for DTS?

Best regards,
Krzysztof

