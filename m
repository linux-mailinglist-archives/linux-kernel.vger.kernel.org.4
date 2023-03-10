Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9C06B3EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCJMQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCJMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:16:47 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6B3F8E6A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:16:45 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id r27so6303724lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678450604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHKLAp7Jc2+KfUJDyt1Qw5kE7c8IF/JbAk1d9mBkGBo=;
        b=tUIeDfbAHkOtyKcaJDW2W727Bn4SuJJdRW0k7tU3jT0EiwV0LQqbmOkrZyS35PzdPV
         5hbDunOvUkcnFJHO6AYF7Fm7vnsDP1LLub3ZMqVAokK0pzBj1iqt3OR44ESEEwHoOOwq
         c6qoZ1WB+xnlkJmMJmZUrNlotaMMTmZHXWQU+aGaZhZyl/blx4Z/6j8HX59PMHfLgqzH
         ofoF4iynm5i4IQUPF/mPmCyUufm1L6puyemneMJy0Okf1/voCaX88CoBvIC0SpuB82WX
         OntBBsIAVRJZc74MoBeiUf2/YCfCr9QGp/Ou1hwWaS59mJCMNR24hRRyFe38mPIJlqo9
         gnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678450604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHKLAp7Jc2+KfUJDyt1Qw5kE7c8IF/JbAk1d9mBkGBo=;
        b=G/TypHgDLxvpz48dL3z/9RsXKiRZqPwofsyBINdpG8r20fipPagQVNAIRlSahZJXSp
         SK3nz/OEeCCyDMyWb/09OmtsDax1w7oiOggbhTecHen6LpR7R537EQc+VKdxSNVfQ4d0
         aHQmjn7CDooG8XHFJBRPAWALT06oj4o0Xp0sHpQhW1h0WOxYN7KO2nYN2xZ6SrqKTnq2
         De6NaGol/4PWZwUKs8NIlTn8P0XhIJfhC/LBHXxN7MPbDqQMFY4+WzbDN3VEu+bG4EgL
         W266WNeU3d6mEeVW6tnfUcw9v6X5iuS3oH0KPOELK0LSCE5FcRS8IOA7og1S4Kn6s4Bh
         fFeg==
X-Gm-Message-State: AO0yUKUF6J9MtmwA7TTS5h6ZMkROFxjOZdrMvmlbPoq+7h1iFXU4V6oV
        1Kj25hv7mFyiebCn5MXiez7OLA==
X-Google-Smtp-Source: AK7set+ztOwX9GCaJ+2a+//vED4TpcxEahgis2gwcXYlHekIEepQTV95RUpl3HNmkXO0n0x3my+Q3w==
X-Received: by 2002:ac2:55af:0:b0:4df:5cc0:8ad1 with SMTP id y15-20020ac255af000000b004df5cc08ad1mr6960146lfg.28.1678450604169;
        Fri, 10 Mar 2023 04:16:44 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b27-20020a056512025b00b004cb3a55feacsm226907lfo.100.2023.03.10.04.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 04:16:43 -0800 (PST)
Message-ID: <0328b17b-2956-9cf6-f90c-63210b01e61f@linaro.org>
Date:   Fri, 10 Mar 2023 14:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/1] remoteproc: qcom: pas: Coredump elf class to elf64
Content-Language: en-GB
To:     Sibi Sankar <quic_sibis@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <20230309001035.24024-1-quic_gokukris@quicinc.com>
 <affcec97-6cc2-aa0a-103d-efa8ad3b68bf@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <affcec97-6cc2-aa0a-103d-efa8ad3b68bf@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 06:04, Sibi Sankar wrote:
> Hey Gokul,
> 
> Thanks for the patch.
> 
> On 3/9/23 05:40, Gokul krishna Krishnakumar wrote:
>> This change adds a new initialization param which modifies the elf
>> class accordingly. Some of the subsystem dump analysis tools need
>> the elf class to be elf64.
>>
> 
> https://lore.kernel.org/lkml/8dea333d-544d-7c07-d560-a1a9c3a38ddc@quicinc.com/
> 
> This patch was already sent upstream a while back ^^. IIRC the firmware
> certainly aren't 64 bit elfs and dump analysis tools don't really care 
> as long the coredump contains section headers.

I think that if we want to change the coredump ELF class, we should 
match the class of the loaded firmware file. Same applies to the ELF 
machine (EM_NONE).

-- 
With best wishes
Dmitry

