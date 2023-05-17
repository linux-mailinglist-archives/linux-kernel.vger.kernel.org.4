Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE15A70615B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjEQHiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjEQHhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:37:55 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B2CE52
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:37:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64395e741fcso373355b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684309067; x=1686901067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7G2+GiqZTEnICnzzvagb14E08/JnnciwA1LRqGqYto=;
        b=ZSUm/FDaXcxzgMtxnP6YATO77IXyq33I/jfofsuyf8enOnq24T9h+CAIBDPsz2kySA
         J7qaZIBCnAhYD3EFzjBcizu9te4JqRi+AprJSeAp16uhhODAei1i7ut3oD3tjP0I1Tfn
         YuY2cg/a+pSvNLqyKjzG2QSfzML3MJWSXh2tYEShzCPHnS8fCV4pGlEocM+nQpYVN4Hz
         CKkASzrb+YTO0i9RV6PsCca6UxiOpXTOBpagaeOuZeJQ6PQ5G5pB++CODzvLaRIybhpX
         DktRY1olDixF+WDSZKZkcFxRGWPwonGu8NMpK8FJigeafUm1Wco0x+OZMyhrUhfA9GYd
         36fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309067; x=1686901067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7G2+GiqZTEnICnzzvagb14E08/JnnciwA1LRqGqYto=;
        b=jKu4Wa6LqfSmEzOQTjwwW5UWJUvp2n4nWUXMe/VTRqhXTNRAFdl2PBmZLsQYDA96+E
         iAn1W3ZekBiaH4Li0a9taXiETf7K+n7WDdo0eO3ekvvxtUSftcDlnIiSNKmRSgc7HfOS
         aIEwJCyEw9TFdZG8zJf+Y55W/EKQeltFP/IqC2WsdwawoA3EqzjmhBFoELv/YLIfKK++
         C14UTd3WrAKTk8RBp19B7zpUrR614wG6p8RtVqVVJ72HevbTi4aQf9QNbqo1Ufgts7wj
         JTMIrwjrkbKKka4TxY2cEZ2PZpcn74+LKs9wOX46WWAfuF3ZCg/LEmhLThmRJNpQ5xWr
         JSSA==
X-Gm-Message-State: AC+VfDy/raZOsr4rFmBvK3c7y5v8LqOloewi8eysphLkH0ISIDUJm2rd
        bp2mEKvh23nZdvxHq5CrK5doVQO9ero=
X-Google-Smtp-Source: ACHHUZ7uXnf2Pcr9J/EUDfhhMEUSGuw/KM22Lxow7nOEAFCHTidGVQenu0dqdTn/PJXfYht5nyuHGw==
X-Received: by 2002:a05:6a00:1396:b0:646:6cc3:4a52 with SMTP id t22-20020a056a00139600b006466cc34a52mr41429384pfg.3.1684309066722;
        Wed, 17 May 2023 00:37:46 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b00634a96493f7sm12177713pfn.128.2023.05.17.00.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:37:46 -0700 (PDT)
Message-ID: <4125c148-a4f4-edd2-3009-0283246f8a95@gmail.com>
Date:   Wed, 17 May 2023 14:37:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ntfs: Add myself as a reviewer
To:     Namjae Jeon <linkinjeon@kernel.org>, brauner@kernel.org
Cc:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20230517070739.6505-1-linkinjeon@kernel.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230517070739.6505-1-linkinjeon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 14:07, Namjae Jeon wrote:
> I'm volunteering to help review patches for current unmaintained
> ntfs filesytem.
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e2fd64c2ebdc..c2cecb2059d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14928,6 +14928,7 @@ F:	drivers/ntb/hw/intel/
>  
>  NTFS FILESYSTEM
>  M:	Anton Altaparmakov <anton@tuxera.com>
> +R:	Namjae Jeon <linkinjeon@kernel.org>
>  L:	linux-ntfs-dev@lists.sourceforge.net
>  S:	Supported
>  W:	http://www.tuxera.com/

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

Anyway, what about also adding linux-mm list so that akpm can
pick patches?

-- 
An old man doll... just what I always wanted! - Clara

