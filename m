Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA85EAE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiIZRcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiIZRc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:32:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9A81822CC;
        Mon, 26 Sep 2022 09:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D388B80B72;
        Mon, 26 Sep 2022 16:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C7AC433C1;
        Mon, 26 Sep 2022 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664210989;
        bh=1c5Fiy+fkune816aVwNMAtlbMdamxliwtVQD1QR541I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q9wmOkOry7vvnnNujle0YG1Rqjsp4YNyE5klrWU5Uzak/F3L3zILU7QNdYPI5EiY3
         gS+HAvGjMbhz5pQKwdFl++v9tXzRLsRKQuwP6RovFqGd0y1CVb42nyWNkunNKzYun9
         LVemAzvPiRsOHkTIVdxjO8FA2Q5vLru3UoQCzEMpHElgVxkj9ZbNjIcjpWxRJ4Rirw
         8r7q4HWU18SR9IvFK1RiZ2t8G4hQzumviTEvH+ZnmjR603YGfG6J2oW/N2ijrBEQV0
         i4VXf92cX08/fEYowYiOa6YwgjosypWGkDF7zKTu7U5Z5y3z9iQZZQM8YACmlSYMGo
         Bof2Vd1ICeeng==
Message-ID: <d8706eb0-6e1c-22ae-a88b-ea183e6bcede@kernel.org>
Date:   Mon, 26 Sep 2022 11:49:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv3 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220926140932.820050-1-dinguyen@kernel.org>
 <f4d29a38-c195-43f7-4837-43a6176a0a58@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <f4d29a38-c195-43f7-4837-43a6176a0a58@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/22 10:35, Krzysztof Kozlowski wrote:
> On 26/09/2022 16:09, Dinh Nguyen wrote:
>> +allOf:
>> +  - $ref: "synopsys-dw-mshc-common.yaml#"
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const:
>> +              - altr,socfpga-dw-mshc
>> +    then:
>> +      required:
>> +        - altr,sysmgr-syscon
> 
> else:
>    properties:
>      altr,sysmgr-syscon: false
> and then you will probably see the warnings leading to error in syntax
> (const is not an array)...
> 

Hmm, okay. I ran dt_binding_check and did not see the warning. I'll 
check it again.

Dinh
