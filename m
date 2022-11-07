Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8028861FDE8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiKGSv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiKGSvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:51:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6531205E3;
        Mon,  7 Nov 2022 10:51:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v17so19069744edc.8;
        Mon, 07 Nov 2022 10:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akILfU+YT1llMINpbgikOikRS7jUP0JVY03LJFm+weA=;
        b=UpOC1qkRVlt2Ctk70uMr9xynYyB5jrRklLjfJko+I+KcGHvqHcQ1yo0F3eBiWboAkW
         gNLt9QKMIIQT+N+VyNllglFaA3hxZlLrHiPRTYikVdVz9fSJQqKsqiqrM8JwTxNxQVl5
         z826ksA/yfAJeio2QhgjWN4JZ6DOFL75dVjy/AzBY8WGZsm1JKxi0SgnHGC28TI2bNDz
         CcDTw3GV91ouK3j5Zwkfd1V8WQs/JEqGe8QZiUwA1CctCv52IhCOo7mYUTmjTRJZaO9u
         ZzHbNdchISMosbirY4oOG0ka5eD3te8crOTUoNdCbTsZmwGwEs26ZLZ2WNp7PIFbHRZk
         GpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akILfU+YT1llMINpbgikOikRS7jUP0JVY03LJFm+weA=;
        b=Yu59HKfGAnZBPYrFiNG/BmjoWkG/3Yh7IOZVQn7qc6ZnP6xx15mloNkoLTTckHOGQj
         +op5CWRg0hHWo698x1CUSviV2FWeoAnjI+HvuvJOlkhG0blAnklF7I9Bo7cMudGFBotW
         2Hjbm05NxT3lR6slhEQliYvqhjY+NpakcUtfx2IIYK8axfAS6ryMhSVK3dkyHee4pLkC
         69/Gp8SnWRNiBIB5enQ59o1spXRQ+F0iwbBZjmYzNgI38yZYudblIWzmFZEU96yXxnit
         E0O5g7rcqyC3emyyQTBosEaZDuvDPpdKI9NU1QBm3L8M2kaXvXsfyu/7T6EDJIQ/5jBz
         AnUA==
X-Gm-Message-State: ACrzQf34vcEgqmg5f9TaqrDLM2jT5zNIbqIfMX+1LAZUO1Sp20HrhYeL
        rH7qeTxQR3YbyZ4/qLRbzf0=
X-Google-Smtp-Source: AMsMyM73qc/snTrYZAxym8IQqfLO7pQi4KRuVMRzRznlZLQy7C6bYaqqhsqAcch/xVdo/YDzNQGplQ==
X-Received: by 2002:a50:ea81:0:b0:463:6cf1:71ed with SMTP id d1-20020a50ea81000000b004636cf171edmr41381150edo.116.1667847113184;
        Mon, 07 Nov 2022 10:51:53 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709064a1300b007ad9adabcd4sm3714675eju.213.2022.11.07.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:51:52 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v6 4/5] riscv: dts: allwinner: d1: Add LED controller node
Date:   Mon, 07 Nov 2022 19:51:51 +0100
Message-ID: <3642870.MHq7AAxBmi@kista>
In-Reply-To: <20221107053247.1180-5-samuel@sholland.org>
References: <20221107053247.1180-1-samuel@sholland.org> <20221107053247.1180-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 07. november 2022 ob 06:32:45 CET je Samuel Holland 
napisal(a):
> Allwinner D1 contains an LED controller. Add its devicetree node, as
> well as the pinmux used by the reference board design.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


