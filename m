Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB8A6CA9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjC0QFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjC0QFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:05:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD801BF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:05:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn12so38347460edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679933109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xWYiS3llu2HpwOSTJeOhknc09GbN4E66RoEIS5/sjs=;
        b=N0lhdKu1Wt1wakJ4GZ5rAE32F86Cwg+uPgtKI8cdDYcQDSOkdI5RqyoenNHspPDbZ1
         NgB6kd/48VFxqqB1/LxR55cRlGZb9KSZFaLqKeBLNE2rv801ii31R0AfpFriWlTJAfJk
         VmzurPJBhLPDddZnCNjJUn1Fc/rjbXCTUw5YL9S56uKbWTHQKMyRB8rIL+jyvKD2sScz
         73RupSe+hfofNOQJiXDWKXdsty7kiMJWrGcc98ERQzv75WJaJw650M0oNKPyHw8JyVjn
         VcSJgSlxCdLx+RnKbBLJl4v8NyWH/nVEVjlWK7IwuCSq3yiAl7lF3sgEW99m+Zuk+YhH
         Qqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679933109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xWYiS3llu2HpwOSTJeOhknc09GbN4E66RoEIS5/sjs=;
        b=zZ2pGTZnQ039cm/ayPkK7G89dAqks02b14d4QMQuMOZStLt/fOMNWrZGDlxr6Fp1PH
         krFvBSiEGpyhdybUUfKv0i8oZVjq5HzE3niCxg6gHH+epMDdn1JjwbveUzg4ZH+SIcTJ
         fym28HUC2wi+KSqlUZhqlnPpS56xeNxYLf3jnXxP7yVrkw3xtNL/WfvUiR5e9VpJhM7I
         6eJ0Z9cAb88m9uTt3QX8xUGzf0ItRQOu8h2qu7v0jnw/SU8fPAQ98/4vOotCNKf+pdoC
         XOq1Jo5lu9FVvtjc1xK6q/wAQUaRCxWo9zydMqx2E3yePMutwYld6rqaV2AK9cijVVio
         T0Eg==
X-Gm-Message-State: AAQBX9dCGDm4QztB6gnC/TtxsqWwud68v9xsmxHMdHtKF39ONFLYyOwC
        /ypxDAkZvUz7TAdLGuBw89dCMDA0W4/n51nwMTA=
X-Google-Smtp-Source: AKy350ZnoR9P3I9BdnZ/TMQKT/EOkIrQZ1OTR5vigOyQRanxSzAkd1f0gLI52BjTe6OdWnPHmIABVQ==
X-Received: by 2002:a50:ec89:0:b0:4fa:4b1c:5ea3 with SMTP id e9-20020a50ec89000000b004fa4b1c5ea3mr12716995edr.23.1679933109297;
        Mon, 27 Mar 2023 09:05:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:581e:789c:7616:5ee? ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id k24-20020a50ce58000000b004fc9e462743sm14685826edj.91.2023.03.27.09.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 09:05:08 -0700 (PDT)
Message-ID: <efa9a89e-ead7-8604-5d7a-07c728485eee@linaro.org>
Date:   Mon, 27 Mar 2023 18:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] depends on ARCH_STM32 instead of MACH_STM32MP157
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230324155105.826063-1-christophe.kerello@foss.st.com>
 <20230324170320.5087c223@xps-13>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230324170320.5087c223@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 17:03, Miquel Raynal wrote:
> Hi Christophe,
> 
> christophe.kerello@foss.st.com wrote on Fri, 24 Mar 2023 16:51:03 +0100:
> 
>> To be able to compile the driver on all STM32MP SOCs, we move the
>> "depends on" on ARCH_STM32.
>>
>> Christophe Kerello (2):
>>   memory: stm32-fmc2-ebi: depends on ARCH_STM32 instead of
>>     MACH_STM32MP157
>>   mtd: rawnand: stm32_fmc2: depends on ARCH_STM32 instead of
>>     MACH_STM32MP157
> 
> I don't see issue with taking these two patches in independent trees so
> if nobody disagrees I will take the second one through the mtd tree and
> let Krzysztof take the first one through mem-ctrl.

Sure, np.

Best regards,
Krzysztof

