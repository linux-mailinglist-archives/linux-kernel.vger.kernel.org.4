Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB6C655E4C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 22:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLYVJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 16:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYVJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 16:09:46 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ED8E66
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 13:09:45 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id f25so2069395uaa.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 13:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1DFvd/qB2iPwiRdxjvsshI/YDS4Nv+p2asGKuDLehw=;
        b=O+OC63vZk+RatR3SA4cquYSleIGxtKek3zCZ9h5PoWko4uxX+OsT1WQXdvT8++2dVS
         FdxaFTh59onahD/MjSEkn1FtRgSmUDy5tGxJtfqJnrugsCUwggdWOdCPLSPhl5cE+GzI
         SIgmk7rBUF9tdHX8iJ/lRADAnTzYvcMgqsglhoVpl7rh2QklWeHW5cwX8FiWToa0zpqC
         oHCYodNfigkkSaBp0AU1Q/qzizTBrMev4kQaovnyMIY95rfkss8Mac3RPg77uZxWyMUK
         CHQiSjg78WBpSEPCdglTFXR39IDIBaG1/zvt0SYrIqCmbsyo5PSVPJnwBVh2xWsC8B1y
         zuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1DFvd/qB2iPwiRdxjvsshI/YDS4Nv+p2asGKuDLehw=;
        b=NV3wRexfZLvsg/KXJ0vu4fR5JWZ2VT1IuAEk2gxV89A/1bVLP1M/YKssEwFBEa3WBs
         s9QIbpRu4m1etVOWsln73iAqQKhqVmFJwvy5ZUzqiwYfvB9PYiepQJiMlZIlv6bgl6Em
         C3JOfbxmEqfloqMp+anfMDjG+jviSnmW4NZjYnui6lih10edq5ywWqeDT2VIfjEVCsEV
         tNmDGpReT8h5KdIbI5ogFLI+0uEsJJIw5HGsVet3VEJFLigeFdbyHN+cHZqUAaDgjUFt
         xGZyRQlmVbG3kybs/SWG+94JWsVYJZXcSrAZPqz77Rso7sICbcInAAQA90DFWrPCBUEM
         ipqg==
X-Gm-Message-State: AFqh2koSKtp1MmmyEwc47ydIGBglh43mlt/+6SILVNoFa5hjtJbm2ini
        D7taZCxSRmxYmK9NeY5RXlKCUH9+jO2kpsKbS1U=
X-Google-Smtp-Source: AMrXdXtdYAPlRF4M3B4WUpEVAkaR7XdHKmwRa6xR9AImltxga+MOGIjHWYB7Xi4j/6b3VktWfKu0TAaqG0rQBYnsvDM=
X-Received: by 2002:ab0:784f:0:b0:4e5:ad78:8523 with SMTP id
 y15-20020ab0784f000000b004e5ad788523mr172406uaq.50.1672002584841; Sun, 25 Dec
 2022 13:09:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6122:134c:0:0:0:0 with HTTP; Sun, 25 Dec 2022 13:09:44
 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <nambiemagrang@gmail.com>
Date:   Sun, 25 Dec 2022 21:09:44 +0000
Message-ID: <CACrRiTEzeMyXKsbBDX452+tDK8H+C-MhCUKCrQxtL_0jS7HWvw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Good Day Dearest,

 I am Mrs. Thaj Xoa from Vietnam, I Have an important message I want
to tell you please reply back for more details.

Regards
Mrs. Thaj xoa
