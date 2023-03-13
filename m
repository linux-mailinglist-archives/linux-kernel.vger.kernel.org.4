Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6526B78D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCMN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjCMN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:26:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7D6302A2;
        Mon, 13 Mar 2023 06:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6801AB810F3;
        Mon, 13 Mar 2023 13:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE259C433EF;
        Mon, 13 Mar 2023 13:26:20 +0000 (UTC)
Message-ID: <04465497-306b-6e37-9dca-45d194d9d926@xs4all.nl>
Date:   Mon, 13 Mar 2023 14:26:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: media: amphion: use hyphen in node name of
 vpu core
Content-Language: en-US
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-devicetree <devicetree@vger.kernel.org>
References: <20220411074855.25114-1-ming.qian@nxp.com>
 <7213be47-1746-b7c6-9807-21865adc190a@xs4all.nl>
In-Reply-To: <7213be47-1746-b7c6-9807-21865adc190a@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming,

I recommend reposting this patch if you still want it.

Regards,

	Hans

On 24/11/2022 09:48, Hans Verkuil wrote:
> Rob, can you Ack (or nack) this old patch? It looks like it was
> missed, most likely because the devicetree ML wasn't CCed.
> 
> Regards,
> 
> 	Hans
> 
> On 11/04/2022 09:48, Ming Qian wrote:
>> Hyphen is recommended in node name than underscore.
>> So change the node name from "vpu_core" to "vpu-core"
>>
>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>> ---
>>  Documentation/devicetree/bindings/media/amphion,vpu.yaml | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/amphion,vpu.yaml b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
>> index a9d80eaeeeb6..c0d83d755239 100644
>> --- a/Documentation/devicetree/bindings/media/amphion,vpu.yaml
>> +++ b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
>> @@ -47,7 +47,7 @@ patternProperties:
>>      $ref: ../mailbox/fsl,mu.yaml#
>>  
>>  
>> -  "^vpu_core@[0-9a-f]+$":
>> +  "^vpu-core@[0-9a-f]+$":
>>      description:
>>        Each core correspond a decoder or encoder, need to configure them
>>        separately. NXP i.MX8QM SoC has one decoder and two encoder, i.MX8QXP SoC
>> @@ -143,7 +143,7 @@ examples:
>>          power-domains = <&pd IMX_SC_R_VPU_MU_2>;
>>        };
>>  
>> -      vpu_core0: vpu_core@2d080000 {
>> +      vpu_core0: vpu-core@2d080000 {
>>          compatible = "nxp,imx8q-vpu-decoder";
>>          reg = <0x2d080000 0x10000>;
>>          power-domains = <&pd IMX_SC_R_VPU_DEC_0>;
>> @@ -154,7 +154,7 @@ examples:
>>          memory-region = <&decoder_boot>, <&decoder_rpc>;
>>        };
>>  
>> -      vpu_core1: vpu_core@2d090000 {
>> +      vpu_core1: vpu-core@2d090000 {
>>          compatible = "nxp,imx8q-vpu-encoder";
>>          reg = <0x2d090000 0x10000>;
>>          power-domains = <&pd IMX_SC_R_VPU_ENC_0>;
>> @@ -165,7 +165,7 @@ examples:
>>          memory-region = <&encoder1_boot>, <&encoder1_rpc>;
>>        };
>>  
>> -      vpu_core2: vpu_core@2d0a0000 {
>> +      vpu_core2: vpu-core@2d0a0000 {
>>          reg = <0x2d0a0000 0x10000>;
>>          compatible = "nxp,imx8q-vpu-encoder";
>>          power-domains = <&pd IMX_SC_R_VPU_ENC_1>;
> 

