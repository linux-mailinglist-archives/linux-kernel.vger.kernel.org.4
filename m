Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A84733F36
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346134AbjFQHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFQHby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:31:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30696B5;
        Sat, 17 Jun 2023 00:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9FCD60A5F;
        Sat, 17 Jun 2023 07:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F064EC433C0;
        Sat, 17 Jun 2023 07:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686987112;
        bh=t6X3NymgEfIejj+0mMRY1uM4fmwiGJB8jfh4BMssApY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e0GqLsY3JOWZfKQ/nbgTdCQz9AI6cC+BlFWeiC4XA6tMh8Mn42BzAhWrUmxXjZOHO
         SglD5dIy5xect3cUl3phIcbhfkYHM9blsGT7hTUVSQHPNhGySDJseNW5aIzNr3Tyh8
         FAAKeI3QZzFkV+Nas5t5pAFSeKHgaZJwuKgU60GGIE6XqNTqOJa3r49a44CH13uZXU
         V9743IhyurtGs102+jA6HZxxXx1wUuLNEvtUnWEDKH9ISmzWby4uORXy4KNMSqqlYk
         R8W4TfpnEmV/TS/vNASSGhXZIg2I3VEgK8GWmjZFIU17+VmmdBiDG1NQ9Z69tBlhy+
         YxTLDk7VytS1Q==
Message-ID: <4b66f578-b6c5-5d3e-98e2-d034fabb366c@kernel.org>
Date:   Sat, 17 Jun 2023 09:31:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/3=5d_dt-bindings=3a_can=3a_xilinx=5fcan?=
 =?UTF-8?B?OiBBZGQgRUNDIHByb3BlcnR5IOKAmHhsbngsaGFzLWVjY+KAmQ==?=
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
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
 <8555c686-c663-767e-ce1c-a3b76fdafe05@kernel.org>
 <ef7e8e53-4e7b-8384-6518-68657474db24@amd.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ef7e8e53-4e7b-8384-6518-68657474db24@amd.com>
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

On 16/06/2023 12:44, Michal Simek wrote:
> 
> 
> On 6/16/23 12:38, Krzysztof Kozlowski wrote:
>> On 16/06/2023 12:13, Goud, Srinivas wrote:
>>>>>>> xlnx,has-ecc is optional property and added to Xilinx CAN Controller
>>>>>>> node if ECC block enabled in the HW.
>>>>>>>
>>>>>>> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
>>>>>>
>>>>>> Is there a way to introspect the IP core to check if this feature is compiled in?
>>>>> There is no way(IP registers) to indicate whether ECC feature is enabled or
>>>> not.
>>>>
>>>> Isn't this then deductible from compatible? Your binding claims it is only for
>>>> AXI CAN, so xlnx,axi-can-1.00.a, even though you did not restrict it in the
>>>> binding.
>>> Agree it is only for AXI CAN(xlnx,axi-can-1.00.a) but ECC feature is
>>> configurable option to the user.
>>> ECC is added as optional configuration(enable/disable) feature
>>> to the existing AXI CAN.
>>
>> Why boards would like not to have ECC? I understand that someone told
>> you "make it configurable in DTS", but that's not really a reason for
>> us. Why this is suitable for DTS?
> 
> Let me jump to this. This is core for programmable logic where HW designers of 
> this IP added couple of feature which can be enabled or disable based on 
> customer need. It means it is not SW option if ECC is enable but it is HW choice 
> if ECC is present in the HW or not.
> Selection if ECC should be used is up to every customer to decide.
> We are not able to get information why customers choosing ECC enabled/disabled 
> but I can imagine that with ECC disable less fpga resources are used.

Thanks for the explanation. Apologies for being picky, but you are in
minority when adding such properties with true hardware meaning. Most of
the submissions of such properties add them to control the bits in register.

Best regards,
Krzysztof

