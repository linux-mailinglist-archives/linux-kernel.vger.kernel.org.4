Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9E61FDDA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiKGSrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiKGSrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:47:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9617225E9C;
        Mon,  7 Nov 2022 10:47:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l11so19046880edb.4;
        Mon, 07 Nov 2022 10:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k9MmuI1MvMCM4kW5q5UZ7eFYSW9HVmxbOqfeTnNIVQ=;
        b=LRsYyTRaV4jafpX+zpnW8OS59zf+/7sj1d0JukdUCJqQLqq1taC5fxBB57pHK+n5Dv
         cimzGiZgMO2ABdiuEEB4EfE72tkL6TaQG1q67coXEvtWBW5KsZFZtN/x3jXDeNRQp7yK
         W7s+U6gyNo3qxYwo/1QxCRoW1NzkrKP+lrh3y6GvOixtF3ouonMArMCgVJ7Yymtg7GDA
         1oxMYGgkk04WQSJYD6wNci85CTuBX8i1i2Xw5lKMA92Lzg44v6z15+Bqm94eg51xEYU/
         DNA2BF9wWujsCUXArzAqNb8Y0CjvQhpFv2WLFsoykGR/4H+HGsZwgYHI6k6Fy0XvzpAr
         gFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4k9MmuI1MvMCM4kW5q5UZ7eFYSW9HVmxbOqfeTnNIVQ=;
        b=TUva2KTCeV5MGHsFGJR3Sg3H+lQLTxFScR6MZtQwmACshhceYLuwUByzKrsqg+fcur
         zRbA43Tvk88xi3CMnjrmS8a0NQaWKL3M90qz1uRId/S1/s2t+ykC38OiKZ9gdv3c+0XJ
         hqQ1ROGgQs5u4HACbMsuXa3cLiUljda+Ayte/SNlgUuWFsbz1WnXNpmlL4Nwva7t/ysz
         zb2kqPflQf1ZNcxmgswVPJfWwcc/ADKxwCjNCb0rlH2y18z/8UBxjKcaZMu3o5yHpcx7
         IY6XIeRkUV829IO9dReEppantvOTaOAEMuMjSqXJ5BxrNrVUXaupa3Xdcc40KTM324CO
         kWgw==
X-Gm-Message-State: ACrzQf3cmlSiLezbzCG24De8eh4h+EDs6raSyDlKpSiuUtX+kCRk1YAP
        lHQeBqpp1nVf7ZobBcXEcQOtGAcX0sHS/A==
X-Google-Smtp-Source: AMsMyM4nS36bVi8dvIU8Iq8ikvl6ojIMfWP3tkRXBU2SONRFQSJULPnsy557+rQe/FykE+cRNr7Gdg==
X-Received: by 2002:a05:6402:517c:b0:461:e7e7:c0b9 with SMTP id d28-20020a056402517c00b00461e7e7c0b9mr50272788ede.73.1667846819206;
        Mon, 07 Nov 2022 10:46:59 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7dcd7000000b00443d657d8a4sm4534499edu.61.2022.11.07.10.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:46:58 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v6 3/5] arm64: dts: allwinner: a100: Add LED controller node
Date:   Mon, 07 Nov 2022 19:46:57 +0100
Message-ID: <2128638.Mh6RI2rZIc@kista>
In-Reply-To: <20221107053247.1180-4-samuel@sholland.org>
References: <20221107053247.1180-1-samuel@sholland.org> <20221107053247.1180-4-samuel@sholland.org>
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

Dne ponedeljek, 07. november 2022 ob 06:32:44 CET je Samuel Holland 
napisal(a):
> Allwinner A100 contains an LED controller. Add it to the devicetree.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


