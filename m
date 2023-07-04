Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A8774795E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGDVDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGDVDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:03:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74310CB;
        Tue,  4 Jul 2023 14:03:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-263315da33cso1021345a91.0;
        Tue, 04 Jul 2023 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688504585; x=1691096585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/cTL862NXgXQKBS79CUrLFFpaTPI21CGdAr7foC2LM=;
        b=lBZsFiQdIVwB6+F2lViydVF01AONClmuY8f+9+R+pAzop4u180aH1XmBrKP5AZ2Rpo
         iU70i/xM7KdlHpE49VLCJUZkXmTf731lIjevh7RfgJezWCm/ef0uQ3fqijImtZMIKt/G
         JvLFD74fGCmafnvWLyJVL2BIK6+B7+C1BXZ6oJOP9v6HrH/o/gce+SWlSijsW8BWW+S7
         NCuRDxJ4x3SX9Uoi+rTVhd4zQR5SsFMI4sMxELo0iJoWZ2fTCgQGVNSyu4RzxckfL/XY
         yd8jWlE2GeMEP8bPAlIPyfwtw4ygRJJlyNbmxqDJwNpM7K+hb/+bxoDXQoOKnZ6GY4cz
         RNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688504585; x=1691096585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/cTL862NXgXQKBS79CUrLFFpaTPI21CGdAr7foC2LM=;
        b=LlaeBeGdnr40YvY2HFhPbouXcEy2Qm6Qmix6LDqV5cBCAtADXUesbewV9A4khQ8h5j
         ulK8hmRGjEx0F1URyeMiusx2vA5s79FZvHEeT4kMSxpCCkTdP9XsEYrGeFCJC+8gq+V9
         Lr9ElK3u5dHOqrvsF+idFpcL/H9JBVBHev3uqgTJdzAJoTmFMQOG+nKxlye/CEqe1V82
         T6DWQuUU5EOaQUoCQ6f+6YHgeeaqFJEy1YWESvQy33xct3hQija0hCzcVsvzJOJmQY+9
         AUelSMG2icOK+Y0GPEgK2auL+5eUTKrxjaeHRFFWo+WbWhN4PymoLsApCCU3eNc4ZiMD
         jKTA==
X-Gm-Message-State: AC+VfDz18Jbl0MDVzbsjlFNCQI5e5TQ0c/9/gxa4tpfE+wSH6rZuh0CN
        PUuA54fUuLsgLEhKsA4L2L2q8ms/D/0U8caDfME=
X-Google-Smtp-Source: ACHHUZ6dZ5d/8aGkkANJvpKRCk8cDPMPFTOFXBpdZAlL7o1KEqDfh2qr2S07Ar96W3zyrP6zs46GDxCjq4+cOcckZOw=
X-Received: by 2002:a05:6a20:4413:b0:11b:3e33:d2ce with SMTP id
 ce19-20020a056a20441300b0011b3e33d2cemr21920702pzb.1.1688504585247; Tue, 04
 Jul 2023 14:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230704150240.2022020-1-hugo@hugovil.com> <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
 <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com> <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
 <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
 <20230704125541.f361cab8de3faacd830418ab@hugovil.com> <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
 <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com> <20230704164140.824f6890dae5c87fc92531b4@hugovil.com>
In-Reply-To: <20230704164140.824f6890dae5c87fc92531b4@hugovil.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Jul 2023 18:02:53 -0300
Message-ID: <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
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

On Tue, Jul 4, 2023 at 5:41=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:

> Hi Fabio,
> with interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>, USB OTG doesn't work.

PTN5150 datasheet says:

"Any changes in the attach/detach events or Rp current source changes
will trigger INTB pin to go LOW."

What about:  interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>; ?

Also, please add a pullup to the GPIO1_11 pad.

Does it work?
