Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A02874781F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGDSEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGDSEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:04:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6454D10D5;
        Tue,  4 Jul 2023 11:04:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-676cc97ca74so1224530b3a.1;
        Tue, 04 Jul 2023 11:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688493889; x=1691085889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIen7ICtmmVRQh63iEY71+jYzIp8ye0ORPb8PBmm0ZI=;
        b=KgfIVauZnWMIjHCUPlA8nrhndq7q1DdgFaFUzysZds32PxKuKc2gBeMWXPuYd4D+mp
         YTi6bJW0C/OwLjm/QtgVKAN/krCgqIy1tHhKtkz6YwCeLOIJJ1TNFtJRrjpYUf81KFON
         i0FpXy1fux1+U17ZkLl4HvbhHcLqIPoJwWjrmu6S+Tiz1BHNt51SJOnXqSTga3AUJKGK
         DKyB71zWD+sh5wbR6HI7J1XA8Znl8XlAztypN0jOjDogBQe2DVceCjzmYHClQx9yv1J0
         oncpYA8UQn+cDFNukpA+E/o8atp1+ZzPWwvb3ncmU88orEEHxsN8AvzuAUh9/F2KqJJ/
         eqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688493889; x=1691085889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIen7ICtmmVRQh63iEY71+jYzIp8ye0ORPb8PBmm0ZI=;
        b=VGEMB6Ri8Kp2G9FZmK+RMHBIXgZC4ObX0HDWuETp0Aa9m8XknqIryqCCXWAMBVCFoU
         nb0T+h28xPIgv5vczFSWLN7yvAhdoJPT5mnhXcM3+cvgxTDX/noLRGSNPMKyiC8vmuEX
         CNaKechSq6p1ybUVgl+agA9x+Z548gXEFLvxeYrSYn+Bski9JFebfZis27o1Mg/zaZw2
         T0om3Kqn1S6SVxfXz8YPtdgE/uViAOXVeL2+/hUIoD2jxuBSVxFB8tKhmYB4RLn/REvi
         BOJYfZ6vA4kNYcjnjmI6+RRLnsYVE9dd6PkbRA2PkzL6OU+nYWuWj82P33wNKg+tFTwL
         +u2Q==
X-Gm-Message-State: AC+VfDwpPE34ImWstCi8pCuYeaqWAxTsn3rn4BNRD3arA/AMS+d2Ifa2
        34wiN8DriS3VC6/bmfquPCiHvTXRraxP9AkhSig=
X-Google-Smtp-Source: ACHHUZ6Gu9TsTPIro0wN6BGCu8VR92ajQIRX5b/yLlSDNB0Im0z3Ru/eHgTIMYnhtXZYvsxPBGhPpmdgKJzm+ichDKM=
X-Received: by 2002:a05:6a20:4413:b0:11b:3e33:d2ce with SMTP id
 ce19-20020a056a20441300b0011b3e33d2cemr21323216pzb.1.1688493888727; Tue, 04
 Jul 2023 11:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230704150240.2022020-1-hugo@hugovil.com> <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
 <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com> <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
 <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
 <20230704125541.f361cab8de3faacd830418ab@hugovil.com> <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
In-Reply-To: <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Jul 2023 15:04:37 -0300
Message-ID: <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Nate Drude <nate.d@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

On Tue, Jul 4, 2023 at 2:02=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:

> Ok, I tought pin 9 (ID) was an input, but it is in fact an output
> driven by the PTN5150 so the last sentence is incorrect.

Does USB OTG work if you keep interrupts =3D <11 IRQ_TYPE_LEVEL_LOW> ?
