Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C9372BF5C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjFLKmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjFLKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:41:33 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3B6319DA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:25:53 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b1a3fa2cd2so47018731fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686565199; x=1689157199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LR3Gr3rH5sthOeyaX87Q0esSF88VmWVTqD2+1+ByAU=;
        b=XjnrK2b9X+P5TCdO310r8Kghu6QQ16pn0kCVVy41mXSlubzhYjw9/IMRzzfjHcBhJN
         q9prAxg0LJ9FSrV5UHC80EItzpCfr9R5GYA/ihU+zooBE9rZMr70cdwZZgeHldAAqVQN
         PRn7255T8AFyWME0SBuIsqgJUezND0HSM49ZYQcliPc51+bkNrVcM5V89dy8P8yPrJPi
         2hZSuuDg3Efsg6OqCaBRMB3hARfDU6BpUMz0N1fN3DEZ5yWZ6k0gGyVQbmI12hDNJMn5
         MyuROJt+NePrtDq/oWsDCvCqcplmmBwyItgjJLugHIuwoBN0nX4RbwmzEGLY8jPza+7l
         Hlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686565199; x=1689157199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LR3Gr3rH5sthOeyaX87Q0esSF88VmWVTqD2+1+ByAU=;
        b=DxyW1Nqp0y2PugyzGDc5yYHKgW09+GhkB3e5ebOyG2uD2nzoMGyyp0AI6Mbsfjws7t
         apr5VJmFF7k81MvjOd9mPNgnYqeQvvdRQRm1bgLkQQJIFR35Vh3Yl1qTsfV2RWgtVxga
         LcjboL3otB48LpxyeVvE1CFoNRGnUqwavPTCLGkCEnRWWud+jp92LKYvBnilRyb+2rq0
         wJDtM4pCFxQ1bN2BWyREAK3dhayqUhYlfwGD/FwBJj41KX4fwds8vbyvlZqqt7/fDaJg
         uUl/opF28YClizvwLOMrZJoobaTx5SanZNoTbcPaG6dhtjaw5dbBEpaWcxec0B4V54mm
         7yGg==
X-Gm-Message-State: AC+VfDx5o3E3y1iwmk79wi3VAwU/MJaEaGMwvLKiMsrrl2HhE14RjO5a
        L3nH25QYFxe6igjRMDTs9nQbew==
X-Google-Smtp-Source: ACHHUZ5g3d3/ktANczko05t2VH+3Q/oxm8IYN2AvfBJefgpvbwlceJyyCzKjZIiZN6b5n4bySqJxuA==
X-Received: by 2002:a2e:9059:0:b0:2ac:7137:5f13 with SMTP id n25-20020a2e9059000000b002ac71375f13mr2882100ljg.9.1686565198692;
        Mon, 12 Jun 2023 03:19:58 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id n7-20020adff087000000b0030ae5a0516csm12004938wro.17.2023.06.12.03.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 03:19:58 -0700 (PDT)
Message-ID: <53956869-19d8-7a38-aa60-db1273538912@linaro.org>
Date:   Mon, 12 Jun 2023 11:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 07/11] ASoC: q6dsp: q6apm-dai: Add open/free compress
 DAI callbacks
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
References: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
 <20230609145407.18774-8-srinivas.kandagatla@linaro.org>
 <0db2eb29-2145-4ab7-b29e-ef662a15b632@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <0db2eb29-2145-4ab7-b29e-ef662a15b632@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2023 18:29, Mark Brown wrote:
> On Fri, Jun 09, 2023 at 03:54:03PM +0100, Srinivas Kandagatla wrote:
>> Add q6apm open and free compress DAI callbacks to support compress
>> offload playback.
>> Include compress event handler callback also.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> 
> If you're sending the mail your signoff should really be last.
thats true, I will fix this in next spin.

-srini
