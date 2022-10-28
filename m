Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D59611390
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJ1Nuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJ1NuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:50:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2153EA46;
        Fri, 28 Oct 2022 06:48:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h2so4890076pgp.4;
        Fri, 28 Oct 2022 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wE36S4Q5QWhpFdF46oNzWKHxmiuCfLnpzqCU+eFD2+c=;
        b=cG4Pku9rZ0VITcSQVmtP7BMBPYsHVd6SmHjm3wGArrpOIxcqYGgw6eG5tPmqJncahT
         3tGUiHNeRrmqc3kkMULrXFwFVoLLr5sMimq5SOnfFWY8nb82uRynQE0NtjHRqW1sAmFW
         nM7pwNFyM/Hoiw7FMr8vKM2wTBRoHb9vz/cvDRpSF89H6h9z0bwi249J5Cpb60wRLkcn
         F2E5lNpaLs0AtN+49DEjknt7U/baVHM/NGwoVn5gUEkU7+wYcBAMZZx9ATPS1hINIEd2
         oGb+1SImBElSIllLMNm3Q1UBc3RQv181o+8OfmQkAxC8xqTBoQJ0pAjsUfl+Knn7L4cB
         GRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wE36S4Q5QWhpFdF46oNzWKHxmiuCfLnpzqCU+eFD2+c=;
        b=q601H8A4aNXca1vUUV8aYd3b630qbdOV2OmlX1kjfdhwCXTGZVzQulEy+JQ+to2MCg
         iLxLyCEK7DgRDuf2V6hYtB+u5D0X1ySuvw52bzYd2q9ZLL13Jy8Vn9u9WU+HIx35V2Z5
         F7sQTT++zNzdpH0cDZkYh3SZiCMIuEpEczXIYYdHmGvqcostZneLJtkof7QPV7J58KvO
         290yk87sNLQ6PzykwrMe0Owl/e3Ljl7QUaYl+nLpRyKbmF9kN8kjax9xNZPpkQNls+RH
         /cUScGmvK6IgDjHgooFLppJtAcuMxv8v0h5rFwQZpBO/u+5bAO89sV/dSBExDE9/aX+h
         imug==
X-Gm-Message-State: ACrzQf2pJciQLZHq5REMVA4G2CZzBaT4nDJ/xuXe6eyx/vjWFu12hsE0
        H+QDJWLjHWryx2ghZXeqXrc=
X-Google-Smtp-Source: AMsMyM7Ocqtk9aKZ7TyJ4UhBbCZ4/O7u2PI6jmlN6yYJC+D8ujXagdwRZF10yINmvJfWzQPXIWYr0g==
X-Received: by 2002:a05:6a00:1acd:b0:56b:8181:d78d with SMTP id f13-20020a056a001acd00b0056b8181d78dmr33676499pfv.50.1666964936887;
        Fri, 28 Oct 2022 06:48:56 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902bb8500b00186a8beec78sm3096216pls.52.2022.10.28.06.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:48:56 -0700 (PDT)
Message-ID: <ca4ed45b-8183-07e0-1ebc-796241b27e18@gmail.com>
Date:   Fri, 28 Oct 2022 20:48:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 10/15] scsi: acorn: remove QUEUE_MAGIC_{FREE,USED}
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Russell King <linux@armlinux.org.uk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <f1330d4027e3d7e85d2a5cd7c5f43fed866b9ef9.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <f1330d4027e3d7e85d2a5cd7c5f43fed866b9ef9.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 05:43, наб wrote:
> We have largely moved away from this approach,
> and we have better debugging instrumentation nowadays: kill it
> 

Same reply as [1].

[1]: https://lore.kernel.org/linux-doc/80c998ec-435f-158c-9b45-4e6844f7861b@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara

