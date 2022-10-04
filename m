Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D735F4ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJDV0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJDV0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:26:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8886B67E;
        Tue,  4 Oct 2022 14:26:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a2so11475510ejx.10;
        Tue, 04 Oct 2022 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FA4LJWdiwYUEQsx68E+G6s7HzhTzaIPGCaPF+TV8Qms=;
        b=nuTI2cTf7rh4rxtd35UMwIcE/tST/2WEsxB9L0/3zf4V/GhsDhy+71ShviDnFxnI0F
         IdxbIYeF60fY3/eBeGq8k5beQMKU2x700bPm9uvNS1SWrQCZGRHpvH3xAbeS+j7ZmOQN
         QfhWZRzl6XJA9RsuSIdx8JPWJapDkG7JcGX78iCpPGJh86Wx+XWkBA1/NToMxwbihq85
         l8PezBpz4hOPjn4vRTg4JEyd9PXuYqfoB2XxDPWUF/nXvHUknL2qEcw6APwEesqYMnua
         1MpELQd9B0FS2sUKhzfxNuSb+Zw/Y2oP56OFvF8YQjxq6/Edv0Lr4k8FQHek4EZwCKnm
         hmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FA4LJWdiwYUEQsx68E+G6s7HzhTzaIPGCaPF+TV8Qms=;
        b=XIiwr2kKNDIVKQuJYCRTa0ECeupd6JlVBFcp0ANuSC4BxGdzbMFLwHKe/1zGYE4J6M
         jHv0lxAJK6FjMlz2oUEj+Dd+LiRnw/E1GuWAll++Oa6DnZnT2AfAs6/fa5WzvG+eyNJo
         2Q6pRaK3FzvST2PE+XCx6rMof/TVTpE0Du6VSR5l3XexNfAG4dSjaW5pw+Af9JGScBMu
         4sQWfLMh0hKL55Q1r8pvwnN3VYta4QkbSno++r9v6cIdQqjvaZb6rpfohgEAnyfoyd3z
         THn3NESfCJbW08dQDAb/TkNm6x5/rFtB3naKYL/HlbI6xy/a2695xi8CpWVe7TSgWVp5
         c/9g==
X-Gm-Message-State: ACrzQf24/Ve0F+0V+9a+L/eUUX+c88wbGoqu5IwDS62td5SeQFbF//vZ
        FWC4paBObpYaSkStIntG/2I=
X-Google-Smtp-Source: AMsMyM7KRFs1FZFUalci1ZrB0YChDhtfJ/86PyDNo1/1sDBN2bRLxk1uomsFJUHvH4/Q3t3AQcXOTw==
X-Received: by 2002:a17:907:7ea1:b0:782:8016:f67b with SMTP id qb33-20020a1709077ea100b007828016f67bmr21314451ejc.188.1664918758749;
        Tue, 04 Oct 2022 14:25:58 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a06:125d:3a8d:82a2:428d? (p200300c78f3e6a06125d3a8d82a2428d.dip0.t-ipconnect.de. [2003:c7:8f3e:6a06:125d:3a8d:82a2:428d])
        by smtp.gmail.com with ESMTPSA id ky9-20020a170907778900b0073ddff7e432sm7729334ejc.14.2022.10.04.14.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 14:25:57 -0700 (PDT)
Message-ID: <73a3969a-d821-f3ee-78ce-df2fedefecdb@gmail.com>
Date:   Tue, 4 Oct 2022 23:25:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] media: atomisp: Fix spelling mistake "modee" -> "mode"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221004161336.155337-1-colin.i.king@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221004161336.155337-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 18:13, Colin Ian King wrote:
> There is a spelling mistake in a literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   .../media/atomisp/pci/css_2401_system/host/pixelgen_private.h   | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h b/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h
> index 1c7938d8ccb5..8f79424bedb2 100644
> --- a/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h
> +++ b/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h
> @@ -161,7 +161,7 @@ STORAGE_CLASS_PIXELGEN_C void pixelgen_ctrl_dump_state(
>   		     state->syng_stat_fcnt);
>   	ia_css_print("Pixel Generator ID %d syng stat done  0x%x\n", ID,
>   		     state->syng_stat_done);
> -	ia_css_print("Pixel Generator ID %d tpg modee  0x%x\n", ID, state->tpg_mode);
> +	ia_css_print("Pixel Generator ID %d tpg mode  0x%x\n", ID, state->tpg_mode);
>   	ia_css_print("Pixel Generator ID %d tpg hcnt mask  0x%x\n", ID,
>   		     state->tpg_hcnt_mask);
>   	ia_css_print("Pixel Generator ID %d tpg hcnt mask  0x%x\n", ID,


This is typically to pedantic for a patch.

You can fix same type of issues at one time. Do not make your patch to long.

Use checkpatch.

Bye Philipp


./scripts/checkpatch.pl --file 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h
CHECK: Lines should not end with a '('
#32: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:32:
+STORAGE_CLASS_PIXELGEN_C hrt_data pixelgen_ctrl_reg_load(

WARNING: please, no spaces at the start of a line
#33: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:33:
+    const pixelgen_ID_t ID,$

WARNING: please, no spaces at the start of a line
#34: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:34:
+    const hrt_address reg)$

CHECK: Lines should not end with a '('
#38: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:38:
+	return ia_css_device_load_uint32(PIXELGEN_CTRL_BASE[ID] + reg * sizeof(

CHECK: Lines should not end with a '('
#46: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:46:
+STORAGE_CLASS_PIXELGEN_C void pixelgen_ctrl_reg_store(

WARNING: please, no spaces at the start of a line
#47: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:47:
+    const pixelgen_ID_t ID,$

WARNING: please, no spaces at the start of a line
#48: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:48:
+    const hrt_address reg,$

WARNING: please, no spaces at the start of a line
#49: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:49:
+    const hrt_data value)$

CHECK: Lines should not end with a '('
#69: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:69:
+STORAGE_CLASS_PIXELGEN_C void pixelgen_ctrl_get_state(

WARNING: please, no spaces at the start of a line
#70: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:70:
+    const pixelgen_ID_t ID,$

WARNING: please, no spaces at the start of a line
#71: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:71:
+    pixelgen_ctrl_state_t *state)$

CHECK: Lines should not end with a '('
#133: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:133:
+STORAGE_CLASS_PIXELGEN_C void pixelgen_ctrl_dump_state(

WARNING: please, no spaces at the start of a line
#134: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:134:
+    const pixelgen_ID_t ID,$

WARNING: please, no spaces at the start of a line
#135: FILE: 
drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:135:
+    pixelgen_ctrl_state_t *state)$

total: 0 errors, 9 warnings, 5 checks, 184 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h has 
style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$
