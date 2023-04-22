Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E46EBA0B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 17:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDVPmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 11:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDVPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 11:42:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1851B1;
        Sat, 22 Apr 2023 08:42:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-246fa478d45so2765716a91.3;
        Sat, 22 Apr 2023 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682178135; x=1684770135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVQxYKKislOfR8ZYxXmr+9aUravTx+cCIGJ45Hvdwug=;
        b=kzRug9+Tn2TJDGedKHq0d0CoA69nMh58ZwBNCSJckG3XcAvmRQWS49yobLUnHZd2Yu
         IjkvWXWo7K2rQ8/HXc+WHPFAXbuwOR+Up3g7iVrBkvBXl7K0G+orhNidjG3715FEOjuw
         70cojn3cR8Vz29I59NZakznDwpBOeBvRbsTf8N8/y2iNQVSYeE6NjFDra8GOtR+cfHaL
         rfCwoO4HrmeaSBUlIm9xbqz4N3LGFdGOjE5nvmtqnKwXikF8Ui6KDWRcNg2na9+FGKA/
         x0Kwo9TLMY0sGY9yxqYLoK7ImpT6cgmeWoqkue6VHPp0IkzmGeL7d3/sHqLlui0xFWIC
         cdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682178135; x=1684770135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVQxYKKislOfR8ZYxXmr+9aUravTx+cCIGJ45Hvdwug=;
        b=FCZ5rvlRySo7a/WKWAe6pa8f1FaAeYNeyRcY2fWhtnH1sziafPXvJkKeJrOmAUi4Db
         FoHr2a5zRH36rxPzmzmkfyegybpYbWO2+9np1TH9OKhjHd0v1rZY+j6fzscREI6f1LWC
         oOCoZbpm8GuaNMPCps1Qppq0ieMioszzW/ZXbivQdY104WspKehJ+W6Z49R7IRy/iwga
         XnLnStQYfEeoVSfRcCgQ1fMUhpXw+btSOQZ667gQzO8EkMU1BYVnGYzLMFSPl/MyI6kp
         b3wwsYVf0yG2yRmtjx8rxsJ3dnl1lK8t0hWqteH3wDg4V1nxNSUTPOr1X7LszliS+zV3
         Ux9Q==
X-Gm-Message-State: AAQBX9e9tdbSSfYdtj3/Ma3G4SYtYKX44ttSk8x8Fy6Ya5n6bQsBNAGU
        CtlbzqKWB4cwPiJuchDzjcaO/wdNr3o/paWYNlc=
X-Google-Smtp-Source: AKy350YcNTd1IJRZb+33FolxDKuyDPWLDnjQIJs2yR0FXe6LQ2bkFXxQm41e5R1Hh2Oi1yTd7XP/Lt963dVdW48ZFfE=
X-Received: by 2002:a17:90a:9113:b0:247:4200:7432 with SMTP id
 k19-20020a17090a911300b0024742007432mr8202873pjo.40.1682178135605; Sat, 22
 Apr 2023 08:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230419181309.338354-1-cristian.ciocaltea@collabora.com>
 <CAEwRq=o71XMoj6_QU-mKrrrBqz80=C0g4fMwejv7fN-vAop89w@mail.gmail.com> <80d23bb9-b55a-57c5-4aa1-d29a919b04ae@collabora.com>
In-Reply-To: <80d23bb9-b55a-57c5-4aa1-d29a919b04ae@collabora.com>
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Sat, 22 Apr 2023 15:42:04 +0000
Message-ID: <CAEwRq=rzz2gdj5rc4_hYb1dZX3ztMa6ZGOeoqM1CU4uLvWZ7Qg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Enable rk3588 timer support
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
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

Hi,

On Sat, Apr 22, 2023 at 3:15=E2=80=AFPM Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> Thanks for taking the time to test this!

You did the work, I try to help...

BTW, I'll test the PWM fan patch (ported to QP64 board) iff I can find
a fan with the same connector...

Regards

--=20
Vincent Legoll
