Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D4E7241FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjFFMWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjFFMWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:22:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1F510C6;
        Tue,  6 Jun 2023 05:22:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2963448a12.2;
        Tue, 06 Jun 2023 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686054158; x=1688646158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGf+LbCEEUwIipAUYA9qn+braiGuNT98euBCIQ5hfhc=;
        b=k9QKN6t+LRIKLdmKvWAvdoBBWTSwlblr+4aD8PVoM/UlG9a+Krk9Ve1DuzW6NC6Fja
         g9cLCTKWAeCzBXLeqUU1qWBCrTTB2PZFPLTxE9rw+kT4uT1pSg70Um2gWVBeIWZgho8b
         Jg157O56uH2oPmWiWMThQbXbmmtDWskRCN5ycmrTcUEVbzCDb5yPxTdfDjYUUcYX9SRQ
         B9xMaRlm8gmfh7ntMoI0VCjfO8/0mNfeMDL4iB7V9uWzfxoMrrlwGuFj3LZe3YRKT2I2
         nhdMVk8tjhMPbmYOMs4OP7ADQGpaiSgWB9MPQ3whakOwc7du4va76pixiecpTkcti1LL
         AR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054158; x=1688646158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGf+LbCEEUwIipAUYA9qn+braiGuNT98euBCIQ5hfhc=;
        b=GNqE09B/KF8LUKa21YOuhaj5Fz5XfCT6tC6twT418fxdUiAu2lJsvoUAYJ3HCOT6ww
         g27w2dLmfh1eSiYtKAkIEEHb6v05vY3KJpIsm/QhptoetZkuwRNCqnpWEU6vBDoHYS9Y
         KtwcX47ArWXVL7HVdwBIYcJ2TWEncYmjvN7V5Wu9V0gFSed3DRwO/VEfdlisFH5KJ5yt
         DtLPW9P41QjIAyTdsncF7yerkRMIeFEcRmrFxarLsCqqkltlJQUC7VoLdOz/cbswaMvI
         QD+gUbewd4OBNxnvChQGWtDaSDJOK9fgIKDvhr0gZ+NBp+lPdLRagjbyRWBfB80AG0hp
         PTaQ==
X-Gm-Message-State: AC+VfDyn1JJUWULnqgGghQBZixt5llWR6AJMbdIbKV6dDSwHNXIQWA6r
        3LUm3QPgORiaetkiTty32HU=
X-Google-Smtp-Source: ACHHUZ4TEgNJum4i4f09/69xcEuwURT7A5wCvAl5WyIhH9srJwScdxZQcXuiRUD3ck10xges8meLPA==
X-Received: by 2002:a05:6a20:7f98:b0:10a:cbe6:69f0 with SMTP id d24-20020a056a207f9800b0010acbe669f0mr1104275pzj.10.1686054157668;
        Tue, 06 Jun 2023 05:22:37 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id c17-20020a62e811000000b00658670ebe7dsm4008696pfi.119.2023.06.06.05.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:22:37 -0700 (PDT)
Message-ID: <a26e0d90-091e-07c0-40d2-b81445103a25@gmail.com>
Date:   Tue, 6 Jun 2023 19:22:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] crypto: md4: Fix checkpatch issues
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Franziska Naepelt <franziska.naepelt@googlemail.com>,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        James Morris <jmorris@intercode.com.au>,
        Steve French <sfrench@samba.org>
References: <20230606112610.98149-1-franziska.naepelt@gmail.com>
 <ZH8jO0FO2QJ7eGBV@debian.me>
 <CAMj1kXHqn_Kff94s3zWZD5k5MvJQs-GGkFLC_tLJQLNDJgXHHA@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAMj1kXHqn_Kff94s3zWZD5k5MvJQs-GGkFLC_tLJQLNDJgXHHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 19:18, Ard Biesheuvel wrote:
> On Tue, 6 Jun 2023 at 14:15, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On Tue, Jun 06, 2023 at 01:26:10PM +0200, Franziska Naepelt wrote:
>>> The following checkpatch issues have been fixed:
>>> - WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
>>> - ERROR: space required after that ',' (ctx:VxV)
>>> - ERROR: space prohibited after that open square bracket '['
>>> - WARNING: space prohibited between function name and open parenthesis '('
>>> - ERROR: code indent should use tabs where possible
>>
>> Again, please split up into one patch per fixes, as a patch series.
>>
> 
> Apart from the SPDX conversion, I think it is fine to fix multiple
> different whitespace issues in the same file with one patch. Splitting
> that up is just busywork.
> 

Do you mean SPDX conversion in one patch and the rest in another? I think
so and confused...

-- 
An old man doll... just what I always wanted! - Clara

