Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB1C6C8C20
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjCYHOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjCYHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:14:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC0B5258;
        Sat, 25 Mar 2023 00:14:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so16065967ede.8;
        Sat, 25 Mar 2023 00:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679728441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWC7t13+yzJKdf33Wl8MOoOE6Dyz7GFsv5BEcRRUPMI=;
        b=mQ4V8zVELcJI0INzGZXWfTYFACbbMklaA+VtqoJG3vbnnpHMRW87/2lOemewUQBciR
         4k6wMnHHWDs778NuM/xZUl8oL1fDCF8uIwF/L2NvfRh+ENLan24DX1FEPpHDlaiDEAtC
         14H/00hJWH+OR5/9VtQCkOj+LXlZDAlWNsBnq5AAjtSyvyEv/Nm65eW7nWBfNDyNxu8n
         UaW76rPj4i09L4jJ/7dvxZ3AOCn9St/O8dCzzz9rMr9Fhsa9yv1PjebVOiO1/K9zztGW
         zsv0ar31+0IZEqiub/N6AoWzn/1oSSaSvmgCv+d17lTTztl2NAq+ErECuO7I9lCfd2nF
         xM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679728441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWC7t13+yzJKdf33Wl8MOoOE6Dyz7GFsv5BEcRRUPMI=;
        b=upzgeJaD+V8T9sYEQB3HIVZumr2wSD8cmLk8iVArlRMs/3WPivItVJumD2GJf/zTob
         VBKjgsc7OBHVB6ZX9GPG9SF3GMU9lhbLI3otNq2GGSEw59T4fyZjg/yoPLgYpEHH4hU/
         hIBiY4O1FD/krbSL4jQw6ER9f9Ed1kOnLhBTCfITdZOq79BTLjZ1bHpyyeW/vAI+MHN1
         fmMn+zj1jvItlK6jo255/7JYDglbJG+rkcKerZX/6fBHNIWzVEbeOnrz4/2BpX5ArmlH
         fQDWBuB6+5TSfEmdby3Y2cryNBr/XbZrxBogFp1w3Y0ICJetU/Y/IoVwNiMh4Rby2vvV
         2kUQ==
X-Gm-Message-State: AAQBX9d8RX2cRfsFTEKC/sN5bDetNEZxrJ8kKabEsoJCUR+BhNtIpVZM
        WViZ95kbahXoi140huj1QV+ZadHT360=
X-Google-Smtp-Source: AKy350Zd9FsNYacmYccxCQNonh7CGTsJFdHGVJxR8WVA7Wue84dPL3PQHv8WFWNAsq4rS3e0y2+qJQ==
X-Received: by 2002:a17:906:608f:b0:877:573d:e919 with SMTP id t15-20020a170906608f00b00877573de919mr5089636ejj.20.1679728441559;
        Sat, 25 Mar 2023 00:14:01 -0700 (PDT)
Received: from kista.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id q28-20020a50aa9c000000b004fb556e905fsm11811929edc.49.2023.03.25.00.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:14:01 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 7/9] media: sun6i-csi: capture: Implement enum_framesizes
Date:   Sat, 25 Mar 2023 08:13:59 +0100
Message-ID: <10243594.nUPlyArG6x@kista>
In-Reply-To: <20230324151228.2778112-8-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-8-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 24. marec 2023 ob 16:12:26 CET je Paul Kocialkowski napisal(a):
> Report available frame sizes as a continuous range between the
> hardware min/max limits.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Co-authored-by: Adam Pigg <adam@piggz.co.uk>
> Signed-off-by: Adam Pigg <adam@piggz.co.uk>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


