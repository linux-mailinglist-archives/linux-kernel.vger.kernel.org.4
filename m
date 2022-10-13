Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C935FE136
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJMS3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiJMS2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:28:43 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D84BC472
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:24:15 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id z97so3762438ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7qwPUEZ1ZhfA+wANlCjEKHD1jlsyDHPilB/I6xGaZA=;
        b=OwfkBRBgr2PFFLhPYms8BwxXSG4Fc/fK8EqoqLMWxXrxwEZH0zChQpuSzaJVWYum/F
         EWYmiYq6Hh1IlFL04YmRQRLZ8SCSU3l9AlL5NDc5LzM9kvEGaYBXnhegk5/Q0E1OUZko
         MnphSpSgbFutzcpwWwyxMmJjA9d9m+d/zCpfxzmvEZzce+tVvPdGp7fcdyZq1dM33ry6
         Ur1QrDlMMv6P/i17YtvM+PtLl/wjMlPc5OmIsMoUpbnE/TiXYxrpIIpb9j8JBLWyXOVC
         ZpI6fmspp6+uOtN6tYPSkl3/Vt/ztk3Z8LpFlx43HtrhhTudENtKQjlBd8yE7z43pn6D
         4JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7qwPUEZ1ZhfA+wANlCjEKHD1jlsyDHPilB/I6xGaZA=;
        b=cow91v6ln6yrSnOFeF8jRbxpgVqOVZXp8+geaGmVnuHsV9/qu2y8R7D2DgoTHfnQM1
         K6CYV3l+3WylAdsdYxPhIRrKFG45356s3NmoxStAWvR4ms5yXPsPwhrBab3gy4YDrDX1
         Q7G7D1hgtLUiFmm/IlqVRsiSf23I+Tl2/izghuUozwVUlJ8QjmpEe0OezedTdX218ccH
         VWcWP0Fz9ToPlCp3TOXiDanVsxxHYPduSaLQg+QAK0LsQ4ZjWdZuNdegu64llZNwgZ/q
         8OskdiUapW3AN0SgNaLJd00fce32LLh8TwtaR9Ak2bibHG7RTEB3q6BhgpbAB4HJA8EH
         G2tg==
X-Gm-Message-State: ACrzQf1z8K2Ms+rXpPmxN+lTjXWyQPzlZYoQ0e9nr2xcJarUC6AZ02g5
        Fl+2jFm62UYCi+K9tnONv7s=
X-Google-Smtp-Source: AMsMyM4tW50WsdxGOymGeUSqnL5oRfzwxkZiFV1zFdsjDVrLwel/HsNrBGerF0BdB9iwstFH+FQueA==
X-Received: by 2002:a05:6402:5252:b0:45d:d1a:fe7d with SMTP id t18-20020a056402525200b0045d0d1afe7dmr815908edd.323.1665685058029;
        Thu, 13 Oct 2022 11:17:38 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id v25-20020aa7dbd9000000b00456c6b4b777sm222778edt.69.2022.10.13.11.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:17:37 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, wens@csie.org, samuel@sholland.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iommu/sun50i: Invalidate iova at map and unmap
Date:   Thu, 13 Oct 2022 20:17:36 +0200
Message-ID: <3161965.AJdgDx1Vlc@kista>
In-Reply-To: <20221013181221.3247429-6-jernej.skrabec@gmail.com>
References: <20221013181221.3247429-1-jernej.skrabec@gmail.com> <20221013181221.3247429-6-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 13. oktober 2022 ob 20:12:20 CEST je Jernej Skrabec napis=
al(a):
> Mapped and unmapped iova addresses needs to be invalidated immediately
> or otherwise they might or might not work when used by master device.
>=20
> This was discovered when running video decoder conformity test with
> Cedrus. Some videos were now and then decoded incorrectly and generated
> page faults.
>=20
> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Please ignore this patch. It's same as next one, with slightly different co=
mmit=20
message.


