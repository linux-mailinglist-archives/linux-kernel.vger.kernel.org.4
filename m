Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8B05FF861
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 06:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJOEGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 00:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJOEGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 00:06:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2595E68CDD;
        Fri, 14 Oct 2022 21:06:41 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r18so5931284pgr.12;
        Fri, 14 Oct 2022 21:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCEzpUM47vPP09CX43zJ3a0Bg5dTaQs9xpncOJIeo4g=;
        b=npVKUFJIIv7iIEM3AXCg3/9lW/iTdihpZBXHmi3ZoU6bhI8ItUv49uFU0TP1Vsz7S3
         JdZrCoHNQ1B5oKEsu3hAxowenRg/bmircRhikjpEB/EQgRcR2vh0fWWbzYm/qsDAy8Q3
         kLSnri4+1gdBO8FjGbf0nxuNuBkEXv3VERersWYQWUfSetLwGFQspWaxnWutkWAZKwE9
         gMLdAdIjqMJt0fB+QI1CmlV/k3WhuI2/5puU6vRMz0/egeIkXlHwIaAx0Ud2LqSwPj/v
         hNNHzennTWHmks2xnx0DJJ0uoKeTQTpgJWyHwSqYETYKzcLgVdskEGhemLz4mTXim9Qg
         3Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCEzpUM47vPP09CX43zJ3a0Bg5dTaQs9xpncOJIeo4g=;
        b=CokvkfxiJW4umADyyg/gwGhLXd6MEG1kbUjYSJ20N1ROweRubf3Js8fANp1LFiY+E/
         Sk5SH7eiDzVWUakMkdzQqWfpJu6t2cRosp0tObfLKPPbGdyeKDVkL+LArBxb7GWWOsHx
         j1O4UBhBVhHVpjKfN+oz+wX1+CvUjbnQvhp3LSmb61wJB3tsXlTY3fgG+5wA9vniKXRA
         aawrzVJBlHwkyoq3gE0M9/hDlNqd/EpcT35g2tAcv63uITK7DVpruB33DlTblTSfV5Gh
         NvTyuED5hbkyqurAFev8ztgvtLpDYJoy1JaF6a5ULCMfjQ9DEU/nb9jqk0WgKmS5votB
         M4lg==
X-Gm-Message-State: ACrzQf1/8buipH+8wjntsK7Lb/31yDj1AvQlQjSs7ekug0adDrMnYClG
        9iA4jRriTSoTn2cam7xF/oBki6JPfMQ=
X-Google-Smtp-Source: AMsMyM5b8AhQS/7jA+cbMioopBG/liguQofMui2bb+J5Bn/HNRQmYkrNVWdVDxDTSBktgow4niFHZw==
X-Received: by 2002:a63:6b09:0:b0:453:b1f8:bb3b with SMTP id g9-20020a636b09000000b00453b1f8bb3bmr1121328pgc.36.1665806800570;
        Fri, 14 Oct 2022 21:06:40 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902a70e00b0017c7376ac9csm2406979plq.206.2022.10.14.21.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 21:06:40 -0700 (PDT)
Message-ID: <48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com>
Date:   Sat, 15 Oct 2022 13:06:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     bilbao@vt.edu, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        miguel.ojeda.sandonis@gmail.com
References: <20221014142454.871196-2-carlos.bilbao@amd.com>
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221014142454.871196-2-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Minor nit on language code.

On Fri, 14 Oct 2022 09:24:53 -0500, Carlos Bilbao wrote:
> Start the process of translating kernel documentation to Spanish. Create
> sp_SP/ and include an index and a disclaimer, following the approach of
> prior translations. Add Carlos Bilbao as MAINTAINER of this translation
> effort.
IIUC, the language code for "Spanish (Spain)" should be "es-ES", as is
listed at e.g., http://www.lingoes.net/en/translator/langcode.htm.

The other translations use directory names found in the table, with
"-" replaced with "_".  It would be better to be consistent.

Just my two cents.

        Thanks, Akira

> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/translations/index.rst          |  1 +
>  .../translations/sp_SP/disclaimer-sp.rst      |  6 ++
>  Documentation/translations/sp_SP/index.rst    | 72 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  4 files changed, 84 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
>  create mode 100644 Documentation/translations/sp_SP/index.rst
> 
> diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
> index 1175a47d07f0..b826c34791c0 100644
> --- a/Documentation/translations/index.rst
> +++ b/Documentation/translations/index.rst
> @@ -12,6 +12,7 @@ Translations
>     it_IT/index
>     ko_KR/index
>     ja_JP/index
> +   sp_SP/index
>  
>  

