Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2212739D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjFVJdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjFVJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:33:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFB31BC5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:26:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3112c11fdc9so4927674f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687426011; x=1690018011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/aC8mCOVavwd5bkCHY05FoCaArXFgiYwfyDm/yPyuJs=;
        b=draD3nbDhpHj052iMV+axxX3WTJI5C9dqU2WTC5xp3fYwUUh2+Plh5RXbnezXZObOH
         0O/ZCEgacb3secdyRIKHhHfRYtpd8BjICuKSWK5//3bOaMreZMPvKODVhKgMdyegKVvm
         YozOFUUcUIxGteip9jfkdsSUujemEPwJHYGQBcz64adZzQRWz/Y7KMvWfzGRycX4yRq1
         z4W0F1NDACGfS2QnbKRMn0hsAkqPH1EHbcNdFYnk9bzPD6x5W5HKASnH3I9XObNHx91W
         NPr+CZTUYINR5wwhdA3oukobmvPImFewLK/pTfhSVSK9S7cP2GriBwKqA7OoZ1eSWqAS
         qZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687426011; x=1690018011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/aC8mCOVavwd5bkCHY05FoCaArXFgiYwfyDm/yPyuJs=;
        b=W431tK4weXX5Z5bCUv7uc34YK5hFWqm19dh4P7MrMx71UdKjTMUcuXM2IaspoVrabq
         tQIFBQIQv3nxL3jmKbbzqi88fRoZZBKyh4GbA3xJBOFboDXEd98roLIclq8PFGTc9zno
         Klwzf5ILHsE32eWBys7pnfCqFR4RxBRW/7JVSYbnXPU8Gh986plzQh1Tb8SSEvvaK+zF
         IZCqYyDIUTHsyyPVY8IvzEae475WKd80fcSPXe1/QcmX0ntKtUIICGSMueakYSLTbp7z
         lgx96Qcaj+i9XeJFhccP259JIk9T31iBuqYlJ6Y87Cp5EcuQJB/XXh6PQ64nXeIiWy7q
         pjtQ==
X-Gm-Message-State: AC+VfDzSsXCsTAAEHbIEP7hmcu80QXeAdUIwOS1HI6VVQLTfCIPQ7qjs
        eGPtMdL911YJyMBnhQy/ysAL0A==
X-Google-Smtp-Source: ACHHUZ4TX56WP8rsXkEdHgG92WgSIInFIdhK/0r9I6Yny2/T+tWmwnxJgeM4yFWmXcBLeyDL/ivuog==
X-Received: by 2002:adf:df89:0:b0:30f:cdbd:f990 with SMTP id z9-20020adfdf89000000b0030fcdbdf990mr12719312wrl.53.1687426010883;
        Thu, 22 Jun 2023 02:26:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d4441000000b00311d8c2561bsm6599907wrr.60.2023.06.22.02.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:26:50 -0700 (PDT)
Message-ID: <b7ffa43c-3dee-b0cf-2672-6b56fcbcd0e6@linaro.org>
Date:   Thu, 22 Jun 2023 11:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2]: Enable UBIFS support
Content-Language: en-US
To:     kah.jing.lee@intel.com, Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230622080435.471363-1-kah.jing.lee@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230622080435.471363-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 10:04, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> Hi,
> The patchset is to update the qspi mtd partition range for UBIFS on
> socfpga platform. The subsequent patch is enable the UBIFS in defconfig.
> 
> Alif Zakuan Yuslaimi (2):
>   arch: arm64: boot: dts: Updated QSPI Flash layout for UBIFS
>   arch: arm64: configs: Enable UBI and UBIFS

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Your patchset has also broken/missing threading. Read carefully
submitting patches and rest of documentation.

Best regards,
Krzysztof

