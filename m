Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CF1601586
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJQRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiJQRih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:38:37 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC40072854;
        Mon, 17 Oct 2022 10:38:35 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m6so7098660qkm.4;
        Mon, 17 Oct 2022 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EuDinjXnRNJMh10ykEex11JG7grFmZlx9zMYOtc2Uk=;
        b=BuIuxBXrcg3PqxdCZ23OrmKAXTeEDOFbetfZUNHY8dUFxTOIaFjCZn9o6ARWXBL+O1
         6Z1uoBjbMX9dL6+CS6u8WPIQgrEd4fKVtxCt1u2qP5PkRmaQAdWPNhR3oJ2Bg9+8DMTS
         htcz2wM3iQJTKKvAEzYUo3N+vRRjg6SlbLZdzlYSUVEtAbA58wjg13+605sOV+L0A9Yv
         HDB/jEHK3I4RAlYKsI2efd3ge/AOAdpm4t4zWT5xw5skn8uuvBAKBVhQz2nHm45lQUFx
         N2qqN5udrs4ADbk2Bm1mH7qD2536qjCsq65BNEENbQ7WROAoTaU/AruQbnr8Pushkvj9
         oS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EuDinjXnRNJMh10ykEex11JG7grFmZlx9zMYOtc2Uk=;
        b=pspK8FGz+HKGVvecVapxlz6Jeo8I64iKQnu0elocGV0ZDBeUjl7JRKMVlffLT3/t/F
         uFarjfezi+BL1S9SGuaZMIqheq7kBJY3TDFUc2Ayo9bTrjzDNnrY7lbDWGli3UbDmKQ4
         me0hsWGkvC10CAopTbqoRZ1kRfXWlX745pTt1px7/7NikF/carQdWNDvNxvKs4yve3bh
         1TV89s7fC2+RyvHqxFGcL6ndPBbfwPJr8MOADx5B8hiz0BcXBtLw8FQ6fvcAmVJpQ/T+
         PMEWzBklhB5MGgTFrUBlbpVXK/QowsNxLmgxKbt9jkyaggNxAWuwrBSyV+adXCY3UVVZ
         qbNQ==
X-Gm-Message-State: ACrzQf2w8U3PI6VVvUXv2LrLvb4lcG8VRV75y31WmmepARFtj7Lc8bBS
        i2MwUCOTKUz5xh04CxmJftZZtbrgX4Q=
X-Google-Smtp-Source: AMsMyM6cfZij01FZn4saN9n2ujPUnz2PuwHcNg3pvT0WmCiQ22sL8HuxzDE6UJPByBnLqathBsp+rA==
X-Received: by 2002:a05:620a:4546:b0:6ee:bf43:a8f4 with SMTP id u6-20020a05620a454600b006eebf43a8f4mr8727794qkp.673.1666028314663;
        Mon, 17 Oct 2022 10:38:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bk18-20020a05620a1a1200b006ec771d8f89sm248271qkb.112.2022.10.17.10.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 10:38:33 -0700 (PDT)
Message-ID: <807d12c6-c467-d183-6ee6-675465033e86@gmail.com>
Date:   Mon, 17 Oct 2022 10:38:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for
 broadcom
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>, william.zhang@broadcom.com,
        anand.gore@broadcom.com, kursad.oney@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        rjui@broadcom.com, sbranden@broadcom.com, rafal@milecki.pl,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20221013214639.31074-1-palmer@rivosinc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221013214639.31074-1-palmer@rivosinc.com>
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

On 10/13/22 14:46, Palmer Dabbelt wrote:
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
> 
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.

Applied thanks, next time  please copy bcm-kernel-feedback-list such 
that patches land in our internal patchwork instance and they are easier 
to pick up.
-- 
Florian
