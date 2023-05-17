Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E908706A47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjEQN5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjEQN5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:57:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1276188
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:57:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3078c092056so562474f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684331836; x=1686923836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKRMs4xBwcxe6pbrM4TISDziAjRrtGY3u+ik+E6ctaM=;
        b=Jrl3kxtJk/HLFSWty/jNmLRxKSgUJN0qDbaj9XxYlaqB38hMUgQp3PwnW3cKe85Tne
         5EDCUJFYCPLvAZgA5sMIJVmtiHobkoO7GM812sUXiZOqF9F5nmyR2pJ9Rmw9Qp5pzlEf
         iQ+hHQCCOpDzdITu1HpWEaBT6wIBD2fuIaQGpp8dtndCM2Ymcf7INpxu18JS6j2dI60p
         mKc/xttuSQPz7W6ry84ic3Mphr5AGPoAWyE4d45VjFef/8/qkgXUpDnu8GklUS3aCjsp
         gVQmPfUM9Ge1cT28KuhyjrntTgh2FjTKCH3/WewcIXkfHbbH1n0mTgudXhkHewwFSEja
         FIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684331836; x=1686923836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKRMs4xBwcxe6pbrM4TISDziAjRrtGY3u+ik+E6ctaM=;
        b=g0cVjwQapgbnX2/TGpbgTVXTuRrh60hWIfcGUVPv+OV2INB7TbdpcRP36yYkxm7cy/
         FbZ3xlW6mhUrk+9QbB3OMcvda6VkQp23epw2hjaN74T5l/hznwJYI2i/LmSr5ld7vxR1
         J7H0gOQKYx+gCQ2OR1RVfXzIb3XE0m89U6KtYXwemisVKxSNFR8Ky9HUVGCTaFdX1Jbu
         +Puxa0ePJChI5IFLea8chHF20r7fK8Reo0JCTLd7T9NlE1Wazq5iobwBPC0JYP2lELuz
         42JDFZTc9hiCIoGGbv7InLxGRTlHx7DhW1jzCQbhPTmcseMED4FApyxf6cfzCo8ENtGY
         D+sg==
X-Gm-Message-State: AC+VfDwHmoYjcO0t5Q5PdIdjoUOflAlXe6ZyV253TmUSMYZzessxtcSB
        Oi1Ypi7mvFqZ7W2YXvL1btfeu+6XJ3jsIdugd/o=
X-Google-Smtp-Source: ACHHUZ49RqRDuEpyHmdcdHEBROOkpHaQjVQTM1CuYDI9M7EujogAiu6ABXMnTGhKbQaA6p8Sza/JdQ==
X-Received: by 2002:adf:f490:0:b0:307:8691:1ea5 with SMTP id l16-20020adff490000000b0030786911ea5mr998841wro.26.1684331836430;
        Wed, 17 May 2023 06:57:16 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.230])
        by smtp.gmail.com with ESMTPSA id s5-20020adfdb05000000b00307a83ea722sm2867056wri.58.2023.05.17.06.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 06:57:15 -0700 (PDT)
Message-ID: <43e2069b-83fe-4fb1-ceb8-b55c3e30fbfd@linaro.org>
Date:   Wed, 17 May 2023 14:57:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] jffs2: mark __jffs2_dbg_superblock_counts() static
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230517132725.938292-1-arnd@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230517132725.938292-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 14:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function is only called locally and does not need to be
> global. Since there is no external prototype, gcc warns about
> the non-static definition:
> 
> fs/jffs2/debug.c:160:6: error: no previous prototype for '__jffs2_dbg_superblock_counts' [-Werror=missing-prototypes]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  fs/jffs2/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jffs2/debug.c b/fs/jffs2/debug.c
> index 9d26b1b9fc01..0925caab23c4 100644
> --- a/fs/jffs2/debug.c
> +++ b/fs/jffs2/debug.c
> @@ -157,7 +157,7 @@ __jffs2_dbg_prewrite_paranoia_check(struct jffs2_sb_info *c,
>  	kfree(buf);
>  }
>  
> -void __jffs2_dbg_superblock_counts(struct jffs2_sb_info *c)
> +static void __jffs2_dbg_superblock_counts(struct jffs2_sb_info *c)
>  {
>  	struct jffs2_eraseblock *jeb;
>  	uint32_t free = 0, dirty = 0, used = 0, wasted = 0,
