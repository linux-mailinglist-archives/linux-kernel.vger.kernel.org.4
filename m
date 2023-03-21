Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A536C2F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCUKwL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 06:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjCUKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:51:46 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BD61F92B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:51:43 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so15831350pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679395903;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qswG2/ZBW7aTCsKI3gXz0TlSSCCucbrgwXXHtDYCg7M=;
        b=lH9oU9o+X9nT/Ae+rOFJk33jbvUlnEdIysaHi0q+MffFgoyJ0lknbkqOI9t0pEOxvt
         05AZUr+uvwgZPZgwLnNEdOK3oONDbBFXWVVBq/gY0EDpRmA5TFwGACn9np0D75zkPg8b
         q2maNVfo7cFKYMgfZMd9b61ZJj8S+8YrTBS4S9nhSsl0SUZ8/SmrUHNhJzC2Fl9Ufdmh
         jrfwp4tBMLcchXQWkcyFCU7qXQ9koqZ5/6/z1QBAqnBJS0ohoO4QBO4CXntY+Ty+VWcI
         N0+mZ0n6Gya1SK57JRQ0TqFTIAYNOwsVPEPA6fHj6GRG/uRJTEUACMUEjxQewDiLJeE7
         hGUw==
X-Gm-Message-State: AO0yUKW+BOHfqzl7gWZ2Ry3SUdpLoxJNMQSNLQWOU7zQ03iaCcFlFjyd
        Py9xgvGdiucsupYESOpBkiFtaQ==
X-Google-Smtp-Source: AK7set/9jppZ/8fvwHpwmrSJGSCQmBWnfdRTrTdLhtDmmxg2bsp/b1grQinpEEOPKC3NJrRBf73Yag==
X-Received: by 2002:a17:903:3092:b0:1a1:a706:5df3 with SMTP id u18-20020a170903309200b001a1a7065df3mr1614761plc.15.1679395903364;
        Tue, 21 Mar 2023 03:51:43 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902c38200b001960706141fsm8408525plg.149.2023.03.21.03.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:51:42 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v11 3/3] arm64: dts: mediatek: Initial mt8365-evk support
In-Reply-To: <20230309213501.794764-4-bero@baylibre.com>
References: <20230309213501.794764-1-bero@baylibre.com>
 <20230309213501.794764-4-bero@baylibre.com>
Date:   Tue, 21 Mar 2023 03:51:41 -0700
Message-ID: <7h8rfqwf5u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkränzer <bero@baylibre.com> writes:

> From: Fabien Parent <fparent@baylibre.com>
>
> This adds minimal support for the Mediatek 8365 SOC and the EVK reference
> board, allowing the board to boot to initramfs with serial port I/O.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> [bero@baylibre.com: Removed parts depending on drivers that aren't upstream yet, cleanups, add CPU cache layout, add systimer, fix GIC]
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> [aouledameur@baylibre.com: Fix systimer properties]
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Tested (again) and things are working well.  This is the last patch
remaining to be merged.  As soon as this lands in linux-next, I'll add
this board to my KernelCI lab.

Kevin
