Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA816739E12
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjFVKLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjFVKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:11:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BBE122;
        Thu, 22 Jun 2023 03:11:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b45a71c9caso93918951fa.3;
        Thu, 22 Jun 2023 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687428668; x=1690020668;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97S+NTwimgEvGUhJ6O5phnPpyUEei+BRZkc+BeXQtHA=;
        b=nXT4s9CJAjSVTTwqKkemUlcmpRMEOnLyJrHdlBI8DLExVONrkO949cszb+Cv4oVSq/
         mZXE7oj02OUI1gOdz9yawksKNDe9/H02OwzCTOSeWCU19kr5b+NYS1YJKBWQGZKKHQE+
         01/jrFfE0J8Dw9PjE8L+NmZrQSblRVAmuXal02BpXGOIBV2zN8TjgedlDv9klXew8Dar
         UnX/zQeVo42QHOYx3AAju3RuQd7hfFtfUH0Aek/L795jvyDwgiEaYaFSh+FJp+nlFQOv
         ot7WWTBMUtU4q9zQOpEsIc+19toqMjL1zIj7TyjnMOQyG432rNSjsNs3sWk6saFisj5x
         koaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687428668; x=1690020668;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97S+NTwimgEvGUhJ6O5phnPpyUEei+BRZkc+BeXQtHA=;
        b=Ld22uWlFqxu9ziZodWG53h0zOLXD08pnf9JIi3ZKn+u+YWpyq9qp40XwvoWJxbmKhw
         aiunc0cNWa5R/ffbP86YkSNK0mKDJ0QLRsdYlexR728RLjcOsROgp7a7xipAuMyCZ8Wo
         /QFeZkN3t5HauHLvWCRNOPUgdvLCOFsyfwsvJGFMTgXhto1IjfgOaL2OwszZHPhmmGly
         LRt2sDUs0PN0zddOR0BocaNEbjWF5/PpbESfxDWSjTURzH0HzaqtW0QwYsUfb098SITe
         eNGLXMXOIzH/CFzoQHZ8oUPQH8po8PMn7M4NCgXZDCxLuEcia8QfSLCxj4sqT37ZNX9O
         qWPQ==
X-Gm-Message-State: AC+VfDzHTe5ooXYi5hG6UpUD0UuyLQsNZs4/nDaD6boUwSP7tx/ecmTp
        MlbR5EGT0KheEyCvXp6W9+2xhv4kiHg=
X-Google-Smtp-Source: ACHHUZ6oLiaK6ztZDvKBOxxd3Tp3oTDhzkgMh3kCc/zwAvSyND4XfxTh7iEyIT8kQGdwxAHtZCzbag==
X-Received: by 2002:a2e:3513:0:b0:2b4:83c3:d285 with SMTP id z19-20020a2e3513000000b002b483c3d285mr6207420ljz.38.1687428667400;
        Thu, 22 Jun 2023 03:11:07 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.74.98])
        by smtp.gmail.com with ESMTPSA id h9-20020a2e9009000000b002b326e7e76csm1225863ljg.64.2023.06.22.03.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 03:11:06 -0700 (PDT)
Subject: Re: [PATCH 04/39] drm: renesas: shmobile: Fix ARGB32 overlay format
 typo
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1687423204.git.geert+renesas@glider.be>
 <7cc1dea4833e6fb9b30aa35f801f14338578dfb1.1687423204.git.geert+renesas@glider.be>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <e13b3952-0446-67fb-e654-9890cc858faa@gmail.com>
Date:   Thu, 22 Jun 2023 13:11:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7cc1dea4833e6fb9b30aa35f801f14338578dfb1.1687423204.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 6/22/23 12:21 PM, Geert Uytterhoeven wrote:

> When configurating

   Configuring? My spellchecker trips. :-)

> a CHn Source Image Format Register (LDBBSIFR), one
> should use the corresponding LDBBSIFR_RPKF_* definition for overlay
> planes, not the DDFR_PKF_* definition for the primary plane.
> 
> Fortunately both definitions resolve to the same value, so this bug did
> not cause any harm.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

MBR, Sergey
