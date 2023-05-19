Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477D270948B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjESKN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjESKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:13:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C297134
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:13:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-510d8d7f8eeso4908599a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684491197; x=1687083197;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVdHyVEBkD1LhOEev7a/Do4pDVl++X0ERDIZ2zx9RbU=;
        b=p6kqZICOEEaQoD/heIGGVBqfIBu4+MRpLi+U5R6hLH3o7j4HYwZHdfMFqe4xm5VVOZ
         m+HyeVP7MFtTZcaXCjpSA5b4IDUnKhBeAq8tIO46Vp/lgo/4jOnbEFFxGj2yc5ynI6+F
         TTm6QG1oPFf04M2Gir8Nvjd7ejwPj4VkfJILwE+smALFlcBYALklVIeHvJ/4SnBWlHQ+
         Kz0kZJH0RB6o9jcHgLMTuzwGIITeMpPIVIxomW8qyR09EhBJXP2hBVErPp1AD+hQ4rv7
         Yso12Y3AkBHm0+p3x7nP+w9RPYwjNB+Q71PqcTre1mOMJiYCGg4N7y+hkCadeThB3EyI
         y/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684491197; x=1687083197;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVdHyVEBkD1LhOEev7a/Do4pDVl++X0ERDIZ2zx9RbU=;
        b=VngptQ+g4fm2hNTdX3UoyyjTil958JOqyml/1nSoXZseBUj+XKSt7K3/in8teTrthx
         CeE69QhSuNXM52KdNG4tFBaI4pl3IjJQ3yBld2DlXB7b97r0PyKmmayy50WGI2RhHJBb
         Lyx2U/GwxbsbGTrFS1p/sGTbv1dal3hVfQaB5rnVWx5vOn9QThcdUL6/Lh5WVZeKKPH3
         7qgtZTlixB8ozTGMve5lKfIru+pZnoCFSGcPk+etg/hV7gUU+QRBg+1YT+3O+v+PkR6k
         yjvfNCeohyGmh+TcbNVKDqGla4h1PfoO+NSbjsj9O9TvFv8Dt2mkS5UQxVz1RdM958B2
         KrVg==
X-Gm-Message-State: AC+VfDygw8xh26yKJNhJC2eDKuizxx+7qutAxMmwA3rfREIXXmz1AFJs
        u6Wv4Q2msobc4PWaqxWI7mBKeluEa0Vce5R1C/8=
X-Google-Smtp-Source: ACHHUZ67k7p2+Hbu5dbMuK1yegRrf60hzjh7w0A4QE1rrsaoPb+IFbSjWwraoX0YSblJwbDBGkagZ1OeZ3mFkPnJvc8=
X-Received: by 2002:a17:907:26ca:b0:969:bac4:8e22 with SMTP id
 bp10-20020a17090726ca00b00969bac48e22mr1085758ejc.26.1684491197102; Fri, 19
 May 2023 03:13:17 -0700 (PDT)
MIME-Version: 1.0
Sender: hhkjrjf701@gmail.com
Received: by 2002:a98:8ad9:0:b0:1ca:9374:fdb6 with HTTP; Fri, 19 May 2023
 03:13:16 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Fri, 19 May 2023 12:13:16 +0200
X-Google-Sender-Auth: fI9Tks2i0CLHTNHI8CnJ3Ooe0so
Message-ID: <CAJn1gpPZR5M-XNfgdwgRP2tOadupXK1Q-SOcoNPJWgpEoRXKZg@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearly Beloved In Christ,

Please forgive me for stressing you with my predicaments as I directly
believe that you will be honest to fulfill my final wish before i die.

I am Mrs.Sophia Erick, and i was Diagnosed with Cancer about 2 years
ago, before i go for a surgery i have to do this by helping the
Orphanages home, Motherless babies home, less privileged and disable
citizens and widows around the world,

So If you are interested to fulfill my final wish by using the sum of
$ 11,000,000.00,  to help them as I mentioned, kindly get back to me
for more information on how the fund will be transferred to your
account.

Sincerely Mrs. Sophia Erick.
