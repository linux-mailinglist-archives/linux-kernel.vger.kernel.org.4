Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4156BA170
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCNV26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCNV24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:28:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE001D937;
        Tue, 14 Mar 2023 14:28:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h8so18002273plf.10;
        Tue, 14 Mar 2023 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678829334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52SNEtO1jtD6XGiNa8SxQ6jhT5uzqz54L9FFreI3uMU=;
        b=eSjoZBauvdPyGp0SG3y76kEuxKv9+Mk/aYD/nZSyJe/xT+jPfeETe/vMkpMTsZRPl9
         gCP7A4Ou3EKb8bUQTQpO1GT+pX/lGNbRTfidcBJ2c6fH8ROz7rec4r4iHNuvFxjuS5su
         lDsTKCD/eLjCuuNHkrQ3QNQtFG11nBOvsmi0fZE4YU7iHsvi54n40Nt28S9gL2BI7Hzq
         buEf6fePKkjE0CKbiZTg3jH7ILnGXakhepDsNmAf/dZfJsQJWH0w/0ktNlxP5C6qGNb6
         8uSP1wPlHUmwnAbv3f6K6U+V4nJoprrS4x7hz3/uNcKsm+6+yxx6tX1nk8XLuSX73SPv
         XhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678829334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52SNEtO1jtD6XGiNa8SxQ6jhT5uzqz54L9FFreI3uMU=;
        b=BTlL6/twoRbcCaMIJ64u1G4IWq7dW+LxKp5egKtFTGv38DFo5VfFhLNcIKb4ilkpAH
         UV8rQY5Gph2HYGzFdQPYsuRhUHZhqD2FttoO7UYmZ1uWVW1zbjYAYveihhtVAGY+GFoU
         zN1exJFK/VOqzwenf9tA4GteZSupP41SVmIHlqeX1DFvpdtLccvaIXvYmTP3NOMnXqVs
         h2P03ceFDDPR56azggIqSx1xKYijICME2L3yLDI+pDzpinjvXamTpFN/StkYWRnmpS3q
         v3iyATvfWwiCB/rIbsVPycl32CnRsV9TJwxf0AYHaWTBFpkjjpuexyVn4C0WFbJMCIgL
         nxow==
X-Gm-Message-State: AO0yUKVZNVsCUXo6miUBOdHV2fLpFqxBZRR7J6bD387biRgA0A6etDed
        dSNzqZmKbf7kSOiy7oqktPY=
X-Google-Smtp-Source: AK7set8SakP4RMXD983ZSIKN8zu4/X+nsQUzlruNMe2xKQlo9ucPdb0fA1p5kP7nE3vrWOZH8wSebg==
X-Received: by 2002:a05:6a20:3d03:b0:d5:58df:fb80 with SMTP id y3-20020a056a203d0300b000d558dffb80mr4743698pzi.62.1678829333817;
        Tue, 14 Mar 2023 14:28:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q23-20020a62ae17000000b006254367756bsm2044684pff.108.2023.03.14.14.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 14:28:52 -0700 (PDT)
Message-ID: <d51b849d-d7b7-2171-0213-5106108b4677@gmail.com>
Date:   Tue, 14 Mar 2023 14:28:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 05/30] clk: bcm: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
 <20230312161512.2715500-6-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230312161512.2715500-6-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/23 09:14, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

