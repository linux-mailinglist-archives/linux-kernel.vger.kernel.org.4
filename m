Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C19611326
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ1NlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiJ1Nk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:40:58 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22813332F;
        Fri, 28 Oct 2022 06:39:19 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id i12so4070943qvs.2;
        Fri, 28 Oct 2022 06:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJCtDRCnrR7E/hqR/zDPHN8HpV6xJf2P5wEq2KAgP2o=;
        b=Xyo4jqi+jwobzJFudsA3FBRKkujvS+KuEoIWjWA3xfDudOryqAFXWcZ2ZCwrINsGcZ
         IpOW+qjGmdQ7LH4eO0UZrOHIFef1ZbiNpCf/tngbucHAogciz79BkVIMAtxFfbWyYAh3
         HxKw0wW4B/3FXkf5ZjgZls38ssSmBXLPPDMShdmYnhgIPNW3Gn+9tAtOGwgkcr2cu51A
         Wp+nr0TdOCSpXs6e91pj7XSEuYyam5xJ49q+u9hu1XKLT707yTfyuz/sJuGoY4UAOMRn
         Vl3SmOFUWEepZ/MLGJS39/tIDsT1USDyHxJ1f1nWvw3Dcy1kmppp5t0SUtf9Rw3gejfX
         NTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJCtDRCnrR7E/hqR/zDPHN8HpV6xJf2P5wEq2KAgP2o=;
        b=7az7/Kz94lJPYgsLdYcoEZGUPg13w5/r2y4SzCfpFrMTOEolcmNee+rVAu7YMgQ+se
         bg8ume4nOTV4XwEqvxBFcHiz5Hr4nwJx4h9Y9chGdBhlOnxhPbJEtxMN4KRulfgo+ipb
         /tzLem+IuKZ7HFu1txOkpxk0qMKpPd7SBf5B2Rv5nBjW/LUAX1Fj447aaSX/hc7aKp1D
         IP7clqycR/4L5INpq62QIwCYD3xXMJEJxwWnY9d00CTBu1RaRzYmh/QA9UCM6+tO5nP8
         qvdXCj0jtnPzwV3bflAlzWPX9WK8oWn1ed9beAd2ILY3hYggfwnlhkgTZoeqMKflhkgQ
         p0YQ==
X-Gm-Message-State: ACrzQf02Sodu2ltj/PKgl2oOY9kpypaqvFw7hT/0s1zexZpaYgJiDde7
        ilcQ5JtggOGzvaja4ANEmMq4kASsm0JXGJAV
X-Google-Smtp-Source: AMsMyM7EzQzUXbFTI1GKbpACqvv/IawriqG7DlJJLQVtTEkFJDjjlubd7SqtztxbTryPdAv7ilPyxA==
X-Received: by 2002:a05:6a00:a21:b0:562:99d6:c30a with SMTP id p33-20020a056a000a2100b0056299d6c30amr52646476pfh.35.1666964347776;
        Fri, 28 Oct 2022 06:39:07 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00186c5e8b1d0sm3028820plp.149.2022.10.28.06.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:39:07 -0700 (PDT)
Message-ID: <df4e5274-5fd1-f1ba-d3d3-4e57a3694154@gmail.com>
Date:   Fri, 28 Oct 2022 20:39:03 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 06/15] Documentation: PG_MAGIC isn't a magic number
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <a7d633805909dab487bde9427a19a3b2e3502e9a.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <a7d633805909dab487bde9427a19a3b2e3502e9a.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
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
> It's part of the userspace I/O packet protocol
> 

The patch subject should have been "Documentation: remove PG_MAGIC".

Otherwise LGTM.

-- 
An old man doll... just what I always wanted! - Clara

