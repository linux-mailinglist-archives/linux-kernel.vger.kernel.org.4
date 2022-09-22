Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BE05E6E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIVVW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIVVWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:22:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9325410F72D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:22:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r7so17545354wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=js/5oTRugoQUYKiAkaMc0Wr4v083F951SM+zFeysBRc=;
        b=kOmpyQR0sC0aLPXqU/SaAlZvRiczPLKEvueA69by3IY5Iq3flK830ktzUfIgf4JQTE
         e9DziPS/vdUnv9DtWtr6PROybAMNwm+GP639aoDgYLNMEUpqIke+2n5J6sPXEghstq4E
         VGxzZCDn9V8W8zABUZ+Zm5PAu6AO3oBhXfQ/zjAueeR3MpN5W/TuDexdjNBR7jB3ohKi
         ysvcQy7IHRFS3ZKWztHLJ3RumbkqsL072exPD2C3ZrjlZGXkUjMeIrUlK4IUdqt/2elO
         /+ubFvnkyLhWNCQiy5aRuylFG4FiAwxs4HVzyT20DbJUwurfG1dougBZjdgaS4dwY6JB
         AnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=js/5oTRugoQUYKiAkaMc0Wr4v083F951SM+zFeysBRc=;
        b=Kkh7lEFhqGegXcoEVb34c1aZnfFDHtdGUkCRhr9KQAt4UtC5IMKeBNGgOSyek3+nta
         VhZ1JyX3vu6v7tFfm4FqyyuQeYzZvjutIUAEUKWXUOIp2hOrRsz/vWURMiJ9t2Lew/qp
         bAbX3j9iNOuSQuUo9oFSTXXgzAQxL+KXIXvCempQ2jcinoHCnRVO0s2Dz6W6b1nZXu0h
         oIJhj/zcIv8MI4sMpOM5UtEMmdSirByd1a8l1gK1P54hQzzU7yCwEHBblZFM95X7J2LO
         I+ySM3qFxNLsRfOCVY+SQaITlhhNhnQxC+JI76qgsS7xuVNzV0OhV0FXCx42Smj7/YvE
         J7tQ==
X-Gm-Message-State: ACrzQf353XpCbEgi2EwOZgYqWxLZHmuUICy74x2ctIOVNs2/kWpFvnnw
        sSXmC9g5HV1OrskXuXmldLdzqQ==
X-Google-Smtp-Source: AMsMyM7WdWinUK+JlpX9DEv0QsSlne/dIOCkLeNnQqueMPqOPMiLhB+SfIDWl6uCJmTendCxS37cdg==
X-Received: by 2002:adf:e4cc:0:b0:22a:d755:aaf7 with SMTP id v12-20020adfe4cc000000b0022ad755aaf7mr3231150wrm.692.1663881740992;
        Thu, 22 Sep 2022 14:22:20 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id r14-20020a0560001b8e00b0022afcc11f65sm5813935wru.47.2022.09.22.14.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 14:22:20 -0700 (PDT)
Message-ID: <1dca4a7f-f4d7-9fd7-69f0-5b0aec51bdef@linaro.org>
Date:   Thu, 22 Sep 2022 22:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220921115813.208ff789@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220921115813.208ff789@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/09/2022 10:58, Miquel Raynal wrote:
> 
> Srinivas, can you give us an update on what you think about this
> series (not a commitment, just how you feel it overall)?
> 
Overall this is going in right direction, there are few bindings related 
comments once those are sorted out it should be good to go.

 From NVMEM side am happy with this feature, which has been a long 
pending one.

We have few discussions on ONIE standard before, layouts would fit in 
nicely.


--srini

> Michael, is there a v3 in preparation? I'll try to write something on
> top of your v2 otherwise.
