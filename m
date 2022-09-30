Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11AA5F07D6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiI3Jnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiI3Jnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:43:42 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B8140F27
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:43:41 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AE8373F695;
        Fri, 30 Sep 2022 11:43:39 +0200 (CEST)
Message-ID: <3e8b907d-413a-70be-d8bd-2ab8b53c3b9c@somainline.org>
Date:   Fri, 30 Sep 2022 11:43:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] slimbus: stream: handle unsupported bitrates for
 presence rate
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220930092006.85982-1-krzysztof.kozlowski@linaro.org>
 <c3aafcdf-9e24-9fbb-b022-d7d1cf04b7b9@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <c3aafcdf-9e24-9fbb-b022-d7d1cf04b7b9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.09.2022 11:42, Krzysztof Kozlowski wrote:
> On 30/09/2022 11:20, Krzysztof Kozlowski wrote:
>> Handle errors of getting presence rate for unsupported stream bitrate,
>> instead of sending -EINVAL in change content message.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/slimbus/stream.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
>> index f8eade1e0132..28fbecb3907d 100644
>> --- a/drivers/slimbus/stream.c
>> +++ b/drivers/slimbus/stream.c
>> @@ -204,7 +204,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
>>  {
>>  	struct slim_controller *ctrl = rt->dev->ctrl;
>>  	struct slim_port *port;
>> -	int num_ports, i, port_id;
>> +	int num_ports, i, port_id, prrate;
>>  
>>  	pr_err("%s:%d AAAA\n", __func__, __LINE__);
> 
> The context is from development tree. I'll rebase and send a v2.
I somehow didn't think it's out of the ordinary heh, my r-b still stands
for the changes.

Konrad
> 
> 
> Best regards,
> Krzysztof
> 
