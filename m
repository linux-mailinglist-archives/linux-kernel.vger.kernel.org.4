Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D413061A60E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKDXnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKDXnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:43:07 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767043E0BF;
        Fri,  4 Nov 2022 16:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Reply-To:Content-ID:Content-Description;
        bh=5DK/6BW6VHSBnMDPjjoCCOgcli3P8L2fcqJsVbJUKmA=; b=UomX6Hyz21CuclnkxkiWn7XglL
        3R4Xus8C3kDxBNlTjX9XhdeyllqlT8Xwe9T5YDcTfBMJDYpOJy+N7tqEd9Q4ZWo2QYJ9TseV5ZXLT
        vwXUwxvJBarja7iA0qRlVF4lvCa73dHjQK/S0s/g7SXfvuapbHhTpBAFxomRB7BULqGzZuGwJkW4A
        lEnrm7V7n56ahIbjj1yEFb4cTVaVgXdII6bLEhTPH7EV3tFyOMAiYHLJXeVpzHj+ISzcKCA9kURob
        Ssy+ugOO2H8Dbs6UpIOKbyEQ4GarI/+lEpS37+CviPEJ4uBtqRDMS+ehUKU9vy7ZYa5JI3hO/oMGe
        OTs3Qb2A==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1or6Ky-003dJB-0W; Fri, 04 Nov 2022 23:42:59 +0000
Message-ID: <a03089dd-6416-f933-6623-0e6c5f8460ec@debian.org>
Date:   Sat, 5 Nov 2022 00:42:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/1] arm64: allwinner: a64: enable Bluetooth on Pinebook
Content-Language: de-DE-frami
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
References: <20221007234553.12328-1-bage@debian.org>
 <20221007234553.12328-2-bage@debian.org>
From:   Bastian Germann <bage@debian.org>
In-Reply-To: <20221007234553.12328-2-bage@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Debian-User: bage
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.22 at 01:45 Bastian Germann wrote:
> Pinebook has an RTL8723CS WiFi + BT chip. BT is connected to UART1
> and uses PL5 as device wake GPIO and PL6 as host wake GPIO.
> The I2C controlling signals are connected to R_I2C bus.
> 
> Enable it in the device tree.

Hey,

Any chance you have a look at this patch? It has been a month and it was the third time the patch hit the list.
If there is something wrong with it I would appreciate a comment.

Thanks,
Bastian

