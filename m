Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85E56B5CD1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCKO03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCKO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:26:27 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A39C2310A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:26:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso1930834wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678544784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=me1EJEGXaS0DFRZHEAYC72z0W2KEACpXBRzTLuD/pqM=;
        b=bje2PGnirIumpFcmHIdEnssR5Ih4SfMCJX+snPXZ5XOcQ0J6ePcFUqOfwHbesaCJYd
         06bZW2BNtDBkzA1cXGaLFQB6t5Fc7Aj4IuknfnT562lQ3x3n0lIRpDUlGyFXtPOSJF+V
         V+8kpPFTKqDnQMFouOlzxVfHZFyXMJpMQei0Iz99bSU64wf0f0Fx9FDp1mWt8OPGMJyp
         4HNiyvYlvfQ2Sk87rqeXyFNSUup7mvbNStVx74gG1px536ilCm9ytfc/stxRZwxoVIuf
         64uBvSsQkhBTxgchaWaRMDpZ1ixD9tzUpuCfvcvXQTogcttF+XW1LgR/wwT/MUcoDqIZ
         yuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678544784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me1EJEGXaS0DFRZHEAYC72z0W2KEACpXBRzTLuD/pqM=;
        b=jy6DgpArldnxAJGvET9xltrxcGlIkGpRh88bFtRKzbv5C/6VqwVGrLqSZNC7z7Z4p4
         BG8LOAqc6NKl655Ff53IfVwSwzvWMabn+gM2ueGllZ1MAoY5hhJT4smrc1ctTjOR5vjs
         yAkGVMRpAyREdUGHAUxHgjSyr4mXcoEXgjjrHPx68M0iMHZ0YqfH4POvQNldAWDJfgHB
         4CE0cnyleI4SBXsv+BcbB3/2kLg4Vf+g2KQTKdja5QLdwD+tTdM+gD/ApiA0RntaLZKo
         d+H9ueRwhCaigaxy8WBVEozjiOMIzP8bBsIeTe6JdG9fujkdlJk0s8KcMhT+0hCgs11S
         LWvw==
X-Gm-Message-State: AO0yUKWNnao7qc+w4DGLVcM8M2NFDeKvBWiTdevquKZ7ubHyCnP6qYGK
        0HNU1z91bAN2gEEeKegum48=
X-Google-Smtp-Source: AK7set+Qh1IspVxGiRADjG20G93XsreuhL9Jl2qPNZj8A73Pq5+CfKKG+SMWT1Syv/ti3R41zOXDVQ==
X-Received: by 2002:a05:600c:35c4:b0:3e8:490b:e286 with SMTP id r4-20020a05600c35c400b003e8490be286mr5742615wmq.14.1678544784510;
        Sat, 11 Mar 2023 06:26:24 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b003dc434b39c7sm3644356wmo.0.2023.03.11.06.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 06:26:24 -0800 (PST)
Date:   Sat, 11 Mar 2023 17:26:20 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: greybus: Fix Alignment with parenthesis
Message-ID: <5f574998-3141-467c-8b45-291acd6fba8c@kili.mountain>
References: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303110958250.2802@hadrien>
 <71211670-60f9-11f4-1ee7-f94d4d9df4fb@gmail.com>
 <alpine.DEB.2.22.394.2303111354490.2802@hadrien>
 <61dab579-f10b-5538-8b61-ebe73ae5b4f1@gmail.com>
 <27dfe880-35f7-cbc1-cf8b-7bbd7f1c7301@gmail.com>
 <e0d7928e-854e-4d10-a90f-db87a7d60569@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d7928e-854e-4d10-a90f-db87a7d60569@kili.mountain>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 05:23:11PM +0300, Dan Carpenter wrote:
> People are giving you feedback to help you and not because they are
                                                                  ^^^
I meant "care" not "are".

> about that particular line of code.

regards,
dan carpenter

