Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485EE5F44CD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJDNwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJDNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:52:00 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECA8175A3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:51:57 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id c2so1273002qvo.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=C1luhcQIdWeTFyljjKwh9u4O0/Z4ceTLk8DiwBDLN/E=;
        b=KKRsZsKcxSgT2NLqezYFAthVlqA7d1g+yzcqCgViHaLLoO1w2ABoTQwmeKSCkdW0g1
         /tiCDY/n3MyrT8MsACki5VUq9uHAmM3Or9D3cb8YhMJo8q3FdlLm6yyAUwOKeQ8sUutA
         OlzUHdKrSPgYXwui6EoPs4kjl7FPoL1hfvwC1GZ9r2VDg1JjTlqtNaflh/WTwVk4+9oo
         K1jFqMXNGvDOJYp+SNux4Pfkk4G/EnY7ujU7GO8NF76C9r2XwnpYet7wbCNbCVrkkGG5
         f8RswJCNFIG0wAo8m33D8iCDSNzLC1HQ8oEyl1+TFaIku27GrS/aIcvpVMeD5rJvY5jx
         +vPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=C1luhcQIdWeTFyljjKwh9u4O0/Z4ceTLk8DiwBDLN/E=;
        b=DLEQrfc5C3EV10VTU8ooSDvhay7qH9mu/PkKnhTIIzs2uIj+3ajkUwkJmW5Tfmu1KS
         j55ITKEmcTYrHPL9vlzxawGATWTpooWKjMbKN507m5XL9ld8XybZkeES64InL6UhmPxz
         N58/+lgpfpde+yGBQPaUXo2nh6rt4vfyv5ZpTEyaK+boQMQKbRzndkoDFZTn7Tf5wZsR
         sat+PyThhTXqgGVmLRPUpVTiDxnjGiBgKjj2+paGCLK78J/cal6Ov77nPxSb5fndPDzL
         T2mJcXLrsqgU41K0GejRdpQoKnl8pjbcSCKR+vCbhZVowtDTOUYqCiiwwbPN+xjle8zi
         /KoQ==
X-Gm-Message-State: ACrzQf0hh81U57YM1YnJjAER/tRgiehNZ5GJcD/GC/izn8HzIXRmW1mj
        sBWAPZQlCBpAjLPqKrOT6hc=
X-Google-Smtp-Source: AMsMyM6/k3TW7BEqP8gGTNXfrlEjXBamdkbCU0olDw+0wfUvYKJ8JLckyAfopDYAKWLMlr87q9hkhA==
X-Received: by 2002:a05:6214:c43:b0:4af:97c6:e31c with SMTP id r3-20020a0562140c4300b004af97c6e31cmr20157208qvj.103.1664891517091;
        Tue, 04 Oct 2022 06:51:57 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id s22-20020ac85296000000b00338ae1f5421sm11581469qtn.0.2022.10.04.06.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 06:51:56 -0700 (PDT)
Message-ID: <7bebb1cc-211a-dac4-3daa-ce005156f2f9@gmail.com>
Date:   Tue, 4 Oct 2022 06:51:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by
 nvme_fc_rcv_ls_req
Content-Language: en-US
To:     duoming@zju.edu.cn
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me
References: <20221002001909.20070-1-duoming@zju.edu.cn>
 <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
 <7bd9e071.1063f1.1839b89cefa.Coremail.duoming@zju.edu.cn>
 <2f36fa52-2dc3-21f3-b53c-d0a9186c3ceb@gmail.com>
 <8aeea62b-c947-6414-bca1-3bd3f427cd56@gmail.com>
 <118cdb2e.1067d5.183a2b07fa7.Coremail.duoming@zju.edu.cn>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <118cdb2e.1067d5.183a2b07fa7.Coremail.duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2022 4:10 AM, duoming@zju.edu.cn wrote:
>> looking further...   lpfc_poll_timeout() should only be used on an SLI-3
>> adapter.  The existing SLI-3 adapters don't support NVMe. So I'm a
>> little confused by this stack trace.
> I found this problem through a static analysis tool wroten by myself.
> I think the hacker may simulate the hardware to trigger this stack trace.
> So, I send the patch to correct the problem.
> 
>> Can you describe what the system config/software setup is and
>> specifically what lpfc adapter is being used (dmesg attachment logs are
>> sufficient, or lspci output).
> Best regards,
> Duoming Zhou
> 

ok - so the patch is to the tool ? as the code path doesn't actually occur ?

-- james
