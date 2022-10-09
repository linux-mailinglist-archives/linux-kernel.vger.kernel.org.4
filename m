Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9D5F88E7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJICdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJICdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:33:32 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED14367AE;
        Sat,  8 Oct 2022 19:33:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y4so1695461iof.3;
        Sat, 08 Oct 2022 19:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eKgMiGJ4xMxKYE+sQjNHKzDaMNVrm+oHUpyMXCSQTDs=;
        b=NYxjOsB+i0Q2ncUgRrwdIlyCeHGXDiDQMmC2QhU/GxeAdvqZz4Jqs83TVFyc/xxPHF
         xoxeAcjCNNk9cT36I2UsTNFh1MpzMgFw2RqsKQP1t9QKQfWaF0oQFKYuULT+bPNb1ULK
         olXhHsfMph/NoI5REHcWMZwWXYzwhSec67GlMSVFje4mN5bn1i/18t/EQl2LTQPy5372
         Dcs3UhVWPx01WuR08asoh6m4cksqAs92QVS7BkG9wHbGdNS9kcSRc31yPGsMdTjFkINi
         pyG1PqaxlVn2HM/r2L5klq1kOrBxlJvCN1+E29HNVzNNUff5699oF8Z/C7MNgI+vRbyN
         lmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKgMiGJ4xMxKYE+sQjNHKzDaMNVrm+oHUpyMXCSQTDs=;
        b=u5lO+knmXDvYyNdHFrFQhUCgmi0mrQY3naYW6H6lg/gKesn3SN7llBhxGXbABN2WdA
         qC8miME9oBHzoQhTakrbO1Qi5ybPSbzsG1eO+iWwZ3cnxxxAgfMaPaXbiEGAmhmfojBU
         u5KYxrtBPNT/ZXiE+D3VfUk5qYzJmhaneCBNIhR7ek2YVMjcM7GPz46qoZvAvk14ULLS
         TYPVuL0MaNTlC4xO8S3pFmOwO8fJtud/aWL++R+mJCVMZ8bp7AYnMlq4tI0bqYf7zBjo
         7ccjmK3ALlv2VhKoPYb9bmmvHpwAyZfRKSpuQu2YDeeC5vjNNzVq8vWciZVayphD3Ljg
         VvWA==
X-Gm-Message-State: ACrzQf0dP2vIxzN55AW2nsu6NYubxeFwtazdGbPWFKwlxMZYwAHFJOhj
        3CdRePqtNfUufFYrvy2Mw2M=
X-Google-Smtp-Source: AMsMyM5GzbjwHI/Y3eo0drTr+O2Tna+hX32qEn8v3GHuwVNW5h74J0HM80QYq2XPcO73lKQxp6N5LQ==
X-Received: by 2002:a05:6602:98:b0:6a2:1723:bee1 with SMTP id h24-20020a056602009800b006a21723bee1mr5195402iob.58.1665282810832;
        Sat, 08 Oct 2022 19:33:30 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4d87:cd00:9f51:32d7:1177:67d? ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id v14-20020a92ab0e000000b002faa9fe86bfsm2449714ilh.56.2022.10.08.19.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 19:33:30 -0700 (PDT)
Message-ID: <f488fa30-a307-96f6-fe85-271cdc48faa3@gmail.com>
Date:   Sat, 8 Oct 2022 21:33:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v6 1/2] power: supply: add Qualcomm PMI8998 SMB2 Charger
 driver
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20221008183753.249514-1-caleb.connolly@linaro.org>
 <20221008183753.249514-2-caleb.connolly@linaro.org>
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <20221008183753.249514-2-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/10/22 13:37, Caleb Connolly wrote:
> Add a driver for the SMB2 charger block found in the Qualcomm PMI8998
> and PM660.
> This driver adds initial support for detecting USB cables and managing
> basic battery charging.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

I can confirm that this driver works as expected on boot and when
suspended/resumed. Tested in my Xiaomi Poco F1 running postmarketOS.

Tested-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>

Regards
Joel Selvaraj
