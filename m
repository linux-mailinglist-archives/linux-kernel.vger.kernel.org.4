Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B14736FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjFTPL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjFTPL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:11:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08FDC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:11:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b539d2f969so27435375ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687273914; x=1689865914;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jC79vjT7xWBWYwpmn3ijy9z9IhPAYMHw/8W0EeFVGaw=;
        b=BzKmhpRkLYFk7XoNXWHZJydftqANKyk4OlRLd2vmhtSI5qkc2qvVFUGXgDPUGt40/v
         tfuTeiawSjGrfBiE0XQBOtdeZlS9xcjgyaQDyT8g+J/CxYuclr1PDmX1thDghbeL5LDJ
         y6PO4wKtguMr5md4Jmk1BawdpdYNOvOFnkve1WpGU+xWW0nRXpTseB59GOPBREBi7VSY
         q7+qykTE2aTbV6Dt/nTds1XrFA1OcQhcMoYWXnR8J+t1sdrONLe5A4ZzBAgXnCWKy7T3
         MU0VYFddnIThHCmwSDLY2QWtYksPnA4OCpzyf4PMSJQhbpRO5FH5E4+Zj6ajdetpXaWb
         6iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687273914; x=1689865914;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jC79vjT7xWBWYwpmn3ijy9z9IhPAYMHw/8W0EeFVGaw=;
        b=hs7082I2PESuw9uFRazpKI8YVCCYRp3ZGtLIeHuaQuFfl1akL83EiUto1jKkTaIUqp
         o64POvsTe54Gu2mIfNBRzagQm9TFTNUnimwjNyCwoHpZEaQ7hhuXo+3rZdTZBx23FBhq
         dhUunrEIVNNh+lywfLV/t2WsdJOle7UIdz9cR8kR1REfQ+KiFniCvRXcO0sNdHrfSOWR
         6QLnuEXIdZ5M7uHLPzsPjJ/eQE5gThBET0MGNktOXZkgGK4SbPY0Fg236f0VbpRY2VUk
         hHUvdiXmR+4+WfQTNG0RrTDz2QsLyxDdCkXxzbMrG8Ho08VDxQLK3ZtHR2N3LdVYUObR
         KKWg==
X-Gm-Message-State: AC+VfDzzDCnMhDFi+aWK/oBifhs4E2Ps5t0D/9fSwJRzZcZin/vosh8v
        2161i5XGAkcyILVeFD1jRFB0uQ==
X-Google-Smtp-Source: ACHHUZ7l/EoB0VO41Wjl+A0w3lizRN+7kVWzUoibQj5OSxIR3WVVskQEocT1A6TzjTPZFcHZewlj0w==
X-Received: by 2002:a17:902:d506:b0:1b6:6c32:59b3 with SMTP id b6-20020a170902d50600b001b66c3259b3mr6377963plg.19.1687273913969;
        Tue, 20 Jun 2023 08:11:53 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902c1d200b001a80ad9c599sm1727671plc.294.2023.06.20.08.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:11:53 -0700 (PDT)
Date:   Tue, 20 Jun 2023 08:11:53 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Jun 2023 08:11:12 PDT (-0700)
Subject:     Re: [PATCH] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
In-Reply-To: <20230525-palm-sponge-982d6591a791@wendy>
CC:     jiajie.ho@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Message-ID: <mhng-7f97aa16-4b17-4028-b750-3173451644a8@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 23:23:12 PDT (-0700), Conor Dooley wrote:
> On Thu, May 25, 2023 at 02:18:36PM +0800, Jia Jie Ho wrote:
>> Selects ARM_AMBA platform support for StarFive SoCs required by spi and
>> crypto dma engine.
>
> Thanks for sending this.
> @Palmer, this depends on another commit not to introduce a build
> breakage. I'll assign it to myself on patchwork and grab it when it is
> okay to take.
>
> Cheers,
> Conor.
>
>> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
>> ---
>>  arch/riscv/Kconfig.socs | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>> index 1cf69f958f10..381cd46e6373 100644
>> --- a/arch/riscv/Kconfig.socs
>> +++ b/arch/riscv/Kconfig.socs
>> @@ -29,6 +29,7 @@ config SOC_STARFIVE
>>  	bool "StarFive SoCs"
>>  	select PINCTRL
>>  	select RESET_CONTROLLER
>> +	select ARM_AMBA
>>  	help
>>  	  This enables support for StarFive SoC platform hardware.
>>  
>> -- 
>> 2.25.1
>> 

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!
