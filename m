Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802FB64777D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLHUr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHUr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:47:57 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D3B248F1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:47:55 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id b9so2858860ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E4OG3gIKhP9b6oDormQTANR9G0dEFN+Gu8sz+bmNZls=;
        b=GyiIPRyNAXEMxHFiqbUS7k8gnM0YtqOMoPMgDyNNYNSHQtPAjSH2tTQIuIMoGXVZ/q
         AkmD7PaBDkmCMxCDM9DvV/npcLQDeqdXJngC1JOaRo6Fes25E0BMPD+ITfi90U/oMDyR
         yUJD2rxFPoivP9sl/U8lfxKp/RoDY61tRte15Tcd55RLatKTnlBq7DonsHWPrKwfNYml
         aevbu7+Fk3F5x0GfbI7xdV8VjZoQCAo0sitM6VjuLYliQeGCWwCOzsr4JQVYAuFlKUuV
         h0+UngCqLYRE63u7lRU269/sFPxiPQJXVutKO+kaZD5+/wzRlEFDOUEFkWa2KYvWBBD5
         RBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4OG3gIKhP9b6oDormQTANR9G0dEFN+Gu8sz+bmNZls=;
        b=vzI5TxZbRHoKuW9vKlrvKzcg5UGhG5/RX0DYMdt/CwivtGNrpTJ8X7e5igsp4cG2RE
         o20iE2YwUJkAlomfjvbGewb11iZ4zcDAZQE6BF1F5XH5Ato95dc64RYJJF5ajyinhLrn
         FuVmAssATIQXh3GEdOpLo3RJsAOYxidUNGJXMwrhqEcnMm9Bl0J0tL9aQ6bt8nlsdhW9
         lysppISIF4deNjbF17IqIbc3qhhbcDbIFyt0UBTlfmBAn7Fe/pfVGTb5GkLdm+W+zIBi
         byTUehqo/hVrsjJtSPV8gHlA0+7qyPRTgpHcT2qDf2nU2i281WqnPa+EtqXpYKH0FsZy
         idaQ==
X-Gm-Message-State: ANoB5pnP2X03IiS/3jbq7Cyh1/zghuBZjEDxqTAa9kelNl5orzQQdBlh
        HlsixZtU/HsTLzs8LdCjCg8=
X-Google-Smtp-Source: AA0mqf5cA+KnSgMkBK+xmYdjKkrs0kuJ0sFQ5TsNPXSWCkaSAiqFExKhsM0FjyEkeUa3C0cdsnc+rw==
X-Received: by 2002:a2e:9b51:0:b0:27a:2225:ed74 with SMTP id o17-20020a2e9b51000000b0027a2225ed74mr1132642ljj.30.1670532473725;
        Thu, 08 Dec 2022 12:47:53 -0800 (PST)
Received: from [172.22.204.227] (ppp85-140-58-71.pppoe.mtu-net.ru. [85.140.58.71])
        by smtp.gmail.com with ESMTPSA id bf12-20020a2eaa0c000000b0027a2e0b8766sm286433ljb.9.2022.12.08.12.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 12:47:53 -0800 (PST)
Message-ID: <692bb076-dc42-8caa-3c02-c160a006e0e5@gmail.com>
Date:   Thu, 8 Dec 2022 23:47:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mtd: parsers: scpart: fix __udivdi3 undefined on mips
Content-Language: en-US
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <8bf10097-519c-a3de-8a08-d0c5d7ddb2de@gmail.com>
Reply-To: 8bf10097-519c-a3de-8a08-d0c5d7ddb2de@gmail.com
In-Reply-To: <8bf10097-519c-a3de-8a08-d0c5d7ddb2de@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I'm sorry. I noticed that the patch below is broken. For some time now I can't send patches using git-send-mail since the gmail changed the authentication process and I have to use Thunderbird. The Thunderbird broke the line in the patch.  

I've already sent the PATCH v2.

Link:
https://lore.kernel.org/linux-mtd/805fe58e-690f-6a3f-5ebf-2f6f6e6e4599@gmail.com/

Have a nice day!

-- 
Best regards,
Mikhail

On 12/8/2022 9:59 PM, Mikhail Zhilkin wrote:

> This fixes the following compile error on mips architecture with clang
> version 16.0.0 reported by the 0-DAY CI Kernel Test Service:
>    ld.lld: error: undefined symbol: __udivdi3
>    referenced by scpart.c
>    mtd/parsers/scpart.o:(scpart_parse) in archive drivers/built-in.a
> 
> As a workaround this makes 'offs' a 32-bit type. This is enough, because
> the mtd containing partition table practically does not exceed 1 MB. We
> can revert this when the [Link] has been resolved.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1635
> Fixes: 9b78ef0c7997 ("mtd: parsers: add support for Sercomm partitions")
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
> ---
>  drivers/mtd/parsers/scpart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/parsers/scpart.c b/drivers/mtd/parsers/scpart.c
> index 02601bb33de4..6e5e11c37078 100644
> --- a/drivers/mtd/parsers/scpart.c
> +++ b/drivers/mtd/parsers/scpart.c
> @@ -50,7 +50,7 @@ static int scpart_scan_partmap(struct mtd_info
> *master, loff_t partmap_offs,
>  	int cnt = 0;
>  	int res = 0;
>  	int res2;
> -	loff_t offs;
> +	uint32_t offs;
>  	size_t retlen;
>  	struct sc_part_desc *pdesc = NULL;
>  	struct sc_part_desc *tmpdesc;

