Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28935FC5A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJLMyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJLMyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB88C97F2;
        Wed, 12 Oct 2022 05:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 920846141C;
        Wed, 12 Oct 2022 12:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5AAC433D6;
        Wed, 12 Oct 2022 12:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665579251;
        bh=AIeGGSg/EfOPT/q/5pGppJEf2mu95V7y75CXy5HDoLY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eghw1zmWDlGQL6bVwaqS77HemFRMGuZ2H+EbyNO069FGb4Eb/0lVuGESOshgOGPAG
         93pqukcfVGNRVLX0KoGz7mPxXXG/KvxKXm8WfI7UXzQ7nnDW7yEUxQn/tdeCOb4YC8
         bfoX31FcNxkE/zyF137OmHghScvxw34m/oadhqN9aVRYYCBtuy+Yw3ghDNcMDLFnbF
         y0Uyr3wXOXIR0hTE3uhMMSRBeF52vzVBZI10O+5gA0fampASQ6cyQ+i/sXhBkJgYnZ
         dnoSevIC3y5P5plUORPRyFUdVEWxTNaW/JDRu47y2Qr9Z0NF/ee3/T1aUxIU5l6vFC
         YzmbMXV0pIetQ==
Message-ID: <2ee13936-4589-8711-2f20-a52f27047492@kernel.org>
Date:   Wed, 12 Oct 2022 08:54:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V14 1/7] dt-bindings: Added the yaml bindings for DCC
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
References: <cover.1664383851.git.quic_schowdhu@quicinc.com>
 <e320555b2075c94946ef3f9c78732dc84ba39449.1664383851.git.quic_schowdhu@quicinc.com>
 <4d0f7a01-1995-1b1e-40b9-125c3447b8c7@kernel.org>
 <78b42aab-164a-7fe6-fec5-77f52199c641@quicinc.com>
 <e028ad6a-9687-5089-4938-e982764b9c58@kernel.org>
 <a1a79910-c697-3660-ddf8-5f4f164c1b34@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <a1a79910-c697-3660-ddf8-5f4f164c1b34@quicinc.com>
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

On 12/10/2022 01:57, Souradeep Chowdhury wrote:
> 
> On 10/11/2022 6:50 PM, Krzysztof Kozlowski wrote:
>> On 30/09/2022 02:59, Souradeep Chowdhury wrote:
>>> Also the ./script/maintainers.pl gives the below output
>>>
>>> Souradeep Chowdhury<quic_schowdhu@quicinc.com>  (maintainer:DCC QTI
>>> DRIVER,in file)
>>> Andy Gross<agross@kernel.org>  (maintainer:ARM/QUALCOMM SUPPORT)
>>> Bjorn Andersson<andersson@kernel.org>  (maintainer:ARM/QUALCOMM SUPPORT)
>>> Konrad Dybcio<konrad.dybcio@somainline.org>  (reviewer:ARM/QUALCOMM SUPPORT)
>>> Rob Herring<robh+dt@kernel.org>  (maintainer:OPEN FIRMWARE AND FLATTENED
>>> DEVICE TREE BINDINGS)
>>> Krzysztof Kozlowski<krzysztof.kozlowski+dt@linaro.org>  (maintainer:OPEN
>>> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>>> linux-arm-msm@vger.kernel.org  (open list:DCC QTI DRIVER)
>>> devicetree@vger.kernel.org  (open list:OPEN FIRMWARE AND FLATTENED DEVICE
>>> TREE BINDINGS)
>>> linux-kernel@vger.kernel.org  (open list)
>>>
>>> Will send out the next version accordingly, let me know in case of any
>>> further concerns.
>> v15 and v16 was still not sent according to what you wrote above...
> 
> I have copied all of the above in the mailing list, also I have 
> implemented all the previous comments.

At least my address is not correct.

Best regards,
Krzysztof

