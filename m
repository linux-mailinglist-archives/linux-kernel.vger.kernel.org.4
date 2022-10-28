Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844356109F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ1Fzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ1Fzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:55:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC02775FFC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:55:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y14so10530450ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHcjtBlF9AkvTQ187G+El3eWXgb0DB+tASWT0lUXslw=;
        b=APPhPPKpLEKKcqAjAIU8lScpz8AYZ3ghGbYomvNfHmYNs9YdI4LnOPVzQJd70DwRqv
         QuuxcEPLbqGQo4h7TbsxhbXer8SKQVr/AXJN5VtGqKTmMdWf3R7ewKM9Nyo9rpB7MXTE
         giH2VCjhSug33KY7sHF4EYCucXgLPy+FmetZkwTRcfPii6TUUtBNhiHS87CNQmk5Fdy+
         Q5qMr056HFbB+1cAH62ioMsRqU092xaOcpd+YMlQS/hZVgdqstMK4hvrEuLUXEkUDPx1
         5GwplW/0L/wYu67cQd8wD9yto/ljME60DVyT7BXgTU3hktCpkCaTvWeZwnrPW2s+1dcF
         NlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHcjtBlF9AkvTQ187G+El3eWXgb0DB+tASWT0lUXslw=;
        b=1IhbxlXVFdCGlWSaD0oK0DOJ/4Ua3mRRjbZX1rvBQvIT5eTJfYoHHTqGLBtMa+4sJd
         ZVePjtewyR8V2Sq/H/C2vjFUHggSZq+ZkhV3JJidqbMba2Sf0oMviNgc13GKKx9f0DHQ
         jQ55wucP34cpVHPZy71lOmOXSc83pC6YEJ5+BuXfDFsSjdivi2WI6nNMVcTjWT29yraF
         I8/FGVSIqRvngX4a4PbErBRdOa8WHixIFYYFnoAyXn+MpCtPNSCgxqA2RhSfoDzkg0dW
         7gn27Svd/1XaQa1En+vxxCj41FRcuKj8gNFb18YzpzZE+xwMZrVLnaCGsbhF1dL+Vec+
         rHmQ==
X-Gm-Message-State: ACrzQf0z+zXaWxGDCXn5Q3Q36PUGORz9yjWe+FX2zPhrkIKm333LSCUU
        e8qwuF1jfDs4CMboQHxsRNq6mhnYkZM=
X-Google-Smtp-Source: AMsMyM6ftI0oGaA8QDmtb2tUUW/FK1vUGwbu5918AdLHBLS5TzRNHnsreVduP+CuqTiJQYnvb4+D6Q==
X-Received: by 2002:a17:907:7e87:b0:791:a477:1109 with SMTP id qb7-20020a1709077e8700b00791a4771109mr42100956ejc.354.1666936537364;
        Thu, 27 Oct 2022 22:55:37 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:b816:5a2a:b0ef:26b2:1eb3? (p200300c78f2ab8165a2ab0ef26b21eb3.dip0.t-ipconnect.de. [2003:c7:8f2a:b816:5a2a:b0ef:26b2:1eb3])
        by smtp.gmail.com with ESMTPSA id v7-20020a17090606c700b00780f24b797dsm1698013ejb.108.2022.10.27.22.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 22:55:36 -0700 (PDT)
Message-ID: <0f50dd24-aaab-d7ad-858a-694f1d14dce5@gmail.com>
Date:   Fri, 28 Oct 2022 07:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 1/6] staging: vt6655: fix lines ending in a '('
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
 <6742e42999e05ddf09318a0a3bda9ce23b6ae562.1666849707.git.tanjubrunostar0@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <6742e42999e05ddf09318a0a3bda9ce23b6ae562.1666849707.git.tanjubrunostar0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 11:05, Tanjuate Brunostar wrote:
> fix serveral checkpatch errors related to lines ending with a '(' by
> refactoring the code lines

Patch series coverletter is missing or the wrong one was send.

[PATCH v6 1_6] staging_ vt6655_ fix lines ending in a '('-4646.txt
WARNING: 'serveral' may be misspelled - perhaps 'several'?
#7:
fix serveral checkpatch errors related to lines ending with a '(' by
     ^^^^^^^^
