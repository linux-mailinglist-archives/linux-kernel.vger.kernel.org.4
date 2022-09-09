Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8D5B3180
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiIIIPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiIIIP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:15:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621AA3D75
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:15:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m15so1395711lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=G9dF6A4OKGqKPWBJ/rsRlHvwJYl0XtUPK+SRDQT8YPc=;
        b=LF17xs37jw3OQrFl05WuIzpxwcuS4Yf3J7JQfuPYJV2DVTh/thJ3UMao+7qmXL4qyr
         3jZPxosS/lqwUykQdDSZBlWmyW0PYQVI571dwZ3GXRFmhPxo2G/fCLKnSlXjBuXvLrU5
         WES2FH+Jhn/hprX5Ruxs1tYdcxiLbcyBAXMzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=G9dF6A4OKGqKPWBJ/rsRlHvwJYl0XtUPK+SRDQT8YPc=;
        b=MBU/JdGmA7DCkoqZvasOw2En9fjmeqkA46xoMGo7E6JR/PiYScMqVay/E+3cT3APmI
         k4N+NN2AVIP5zMZ5apeQvVcBrzWNgNjW1dObeTzv8yR6nI9N4DsgPG+Ze4gKFngEnZCo
         6rKMfP6o9ZKjc6SlRDxOY3DxPknTszJ+kngPvfwWPAE8fmHPkZ/3WzX+ZsvY9WGuPAKQ
         tNjWkQwJd5Y641oBwo3Lk0X1Q9B4ymHR3w1h5tR3NbVTPi5pVWVbrRS2e97Az3v23gWS
         ypCYoPJDxQpae9ha2tkkKeWJ+TUIxsl4IKN9PiVQ68Q1tbHhUkCHq+HD1hXoNxqX/egr
         5Chg==
X-Gm-Message-State: ACgBeo3J4g0cL0Efe4jLbNk2ixha5mMHy0psWP/sRP0HlC+UcLC8zbLV
        rvJ0QR/OKNFyYBsHr5pEiHrrfzMOVJgOp1vS
X-Google-Smtp-Source: AA6agR78Go+tnxdAfSDFi/lV2IDV0LZRhTJAeNsURPRHLWJ8IT6wFwVvPB3ulOqU8ARXBHAiPLZC0w==
X-Received: by 2002:a05:6512:3501:b0:496:d15:e614 with SMTP id h1-20020a056512350100b004960d15e614mr4343150lfs.194.1662711324507;
        Fri, 09 Sep 2022 01:15:24 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x12-20020a19f60c000000b004946e72711bsm183381lfe.76.2022.09.09.01.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 01:15:23 -0700 (PDT)
Message-ID: <174dd607-25b6-26c0-e6e7-1634c5b01dbc@rasmusvillemoes.dk>
Date:   Fri, 9 Sep 2022 10:15:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/6] rtc: isl12022: cleanups and hwmon support
Content-Language: en-US
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 12.01, Rasmus Villemoes wrote:
> This series does a few cleanups of the isl12022 driver,
> 
> - removes use of deprecated function
> - removes some  redundant code
> - switches to regmap API instead of private helpers
> 
> and finally hooks up the temperatur sensor to hwmon.

ping. Any comments before I respin 6/6 to address Guenter's request?

Rasmus
