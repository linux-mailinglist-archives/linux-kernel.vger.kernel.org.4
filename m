Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CB86114F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJ1Oow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJ1Ooq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:44:46 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBF71B9C7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:44:35 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id hh9so3546683qtb.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1IE7Cwpt8efg3k5w+iPhQcam6OSGCnRt2G+xL2XabZo=;
        b=bfCOqhTa2afPTSavLhla0/5TlkeRvB4h7ALBCg9CbMKGxXSyFjEfz+MrOQQpT7ihEl
         5oeL/zRujCMCpdXe9Qhkh8dBm2gjivoyki0o1wCVFlzsn2Xnac1tXB7iADbDSiAfkSZM
         pOXfEsWhpzE4csSFFUOcHkIDX8RoFS34XYft1hfp5S6tkfUb0Hzj8PRCnOROkNQ5iQnZ
         DW8R/a8Q9halP2po+Q+So3WqYYrnJ6CZpeJJg/DeTx/vo9caAxupn2Ha4GDGN0yAMtsc
         d5hExeopxD8uS+z81kZJe3btsJjeBEEd/6oiyEZmm1dk7igYNWt75Q8I7IA6hX3Ako7P
         Rvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IE7Cwpt8efg3k5w+iPhQcam6OSGCnRt2G+xL2XabZo=;
        b=EL1kHM1izcKe/KXsTifPoBWzq7gsxs+CN1WLTrV6XzdBAwDbi4TpZdoH1I2Sh5Xh+J
         ZQr5n1qeMLqMpM4hh5TbqwcrUf88K6ECbrBxXFJoAWGjC8rPRh9aqF4d6zi1BhcTLalf
         B/q02ZaJNqBhZ4D7re8zZDDoPsfT2eMpmNFQPgU1NsbIdU2aC8pZFIPzUWorKkVb6syF
         5Xrxq7i4rSrmm069844b6+OB7jXt8dUI5LDp/C+1NN25INg+jTxMqBrj2kVhWlh/gvnD
         X9rD6gZQJJbV/kxSjG08jBZoPeX/QJ0OCMvWleExlSAZed1EWC+U5ryFjXhWDu2nOvor
         h/hA==
X-Gm-Message-State: ACrzQf0wrhkDjkEZD7ToNBs3JH+SlzWcxkfuW/fEfc1moTfkNktFkGjG
        FVR0zwcW1R6/PCGfN+DRa9g=
X-Google-Smtp-Source: AMsMyM7Xpi9cbFJBq2WIWU/XONEaw4C++x0EXwlLUygqpiSwgxb69pGmOqnFDpJkskwgaNvB8BL+rA==
X-Received: by 2002:ac8:5908:0:b0:39c:d7dd:14e9 with SMTP id 8-20020ac85908000000b0039cd7dd14e9mr46725632qty.623.1666968274291;
        Fri, 28 Oct 2022 07:44:34 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b006eea4b5abcesm3047110qkp.89.2022.10.28.07.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:44:33 -0700 (PDT)
Message-ID: <645ffd03-b49d-9e6e-7541-21c11eab0aef@gmail.com>
Date:   Fri, 28 Oct 2022 07:44:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 0/11] Introduce a unified API for SCMI Server testing
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221019204626.3813043-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 10/19/2022 1:46 PM, Cristian Marussi wrote:
> Hi all,
> 
> This series aims to introduce a new SCMI unified userspace interface meant
> to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
> from the perspective of the OSPM agent (non-secure world only ...)
> 
> It is proposed as a testing/development facility, it is NOT meant to be a
> feature to use in production, but only enabled in Kconfig for test
> deployments.
> 
> Currently an SCMI Compliance Suite like the one at [1] can only work by
> injecting SCMI messages at the SCMI transport layer using the mailbox test
> driver (CONFIG_MAILBOX_TEST) via its few debugfs entries and looking at
> the related replies from the SCMI backend Server.

I plan on giving this a try on our systems later today and will let you 
know the outcome. This is very useful for making sure the SCMI 
implementation is both correct and properly hardened.
-- 
Florian
