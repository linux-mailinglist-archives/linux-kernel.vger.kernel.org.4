Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCE87266FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjFGRQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjFGRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:16:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC231BF1;
        Wed,  7 Jun 2023 10:16:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5344d45bfb0so392530a12.1;
        Wed, 07 Jun 2023 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686158209; x=1688750209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/NZlXOYXqc88apQX7wCILgLxV86T50gknzurw4EXDE=;
        b=fybBTZJizPvbcpoFUu7tozGJLcqG2F+Rd2NSILxctipUlYsGhd9Nzznz4S9WSc8VIN
         AUNMSqvdjPgVOEn6hrAGEyxyYX3nBk8gUCg+rakBiI0wglGclmBd2Lvi2sjInZPD5sFF
         jrXVUEziuIm1lzdJh81YgyuufXApvoOHXwbiFrOZdcq6kLaD2I7Wr87+DGTJ1bN3I3kt
         EPa25QYVxADkB4jv3eRBi5FrHaPKx4Ay8VlGUBoyQCoCWJFgwT9GAYgR0tesZq2+zlbX
         4hXzv7hRvNNYCZgiqQOi/J6sB3iQHQFf+jL1qRcXZTilNXt6qF54oPmWsAy+xnGsS2vH
         iFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686158209; x=1688750209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/NZlXOYXqc88apQX7wCILgLxV86T50gknzurw4EXDE=;
        b=KwwE9xIuweFkgFkRgQLXH/IOrPS/8hEYjboZMoH5ez5YMlvvRPi20qeg9K2ezOneCE
         edjuz68NhD/rIvgoM3osis9CPFyNeeBZ0CUqdvxqR4TiO76iUR8seq9KgsHMt7lmxmad
         svOMtrcjAuzvTFQPXcRZzMnZ1qhSVJH11xnm8kKbIK70hMsckeTHCDTKM7oEkTMCAid3
         63Jk8rwaWtwAMRISmmjjxW0rvQJADj621blKJ5rbd5fhCW5vYQ4eZv8h12p4gBPV9ymK
         TY65rsGi766Noy6iTMu6owfjq4QRMiXgW5rk1G77P4tGUQvR1lwOorMi/4MnfGUgdIqq
         pEEA==
X-Gm-Message-State: AC+VfDyzMg1eOvlQZyTEkLclZSHUlD41cNHBoNHpf0q2etzCYM29sTvS
        uU3aSuoJPTLp3llZcKhkh24lEnl98euanM7qOXCIPd4DUQE=
X-Google-Smtp-Source: ACHHUZ7+OqQ/Ea3yCPmgSYsW0A47pePuHw/dSQd2Jw6mJ1KE/duK6IdPlUpsIfj0wVbN4I6SOKko6ZFViWJAREIhPOc=
X-Received: by 2002:a17:902:c942:b0:1a6:6bdb:b548 with SMTP id
 i2-20020a170902c94200b001a66bdbb548mr2773869pla.1.1686158209476; Wed, 07 Jun
 2023 10:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230607171159.2019417-1-tharvey@gateworks.com> <20230607171159.2019417-2-tharvey@gateworks.com>
In-Reply-To: <20230607171159.2019417-2-tharvey@gateworks.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 7 Jun 2023 14:16:38 -0300
Message-ID: <CAOMZO5ASwTJpH84SJX78k7MtZzwFc0bnbGqXsSFA6JFGq+0Emg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Add imx8mp-venice-gw73xx-2x
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Tim,

On Wed, Jun 7, 2023 at 2:12=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> w=
rote:

> +/* bluetooth HCI */
> +&uart3 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_uart3>, <&pinctrl_bten>;
> +       cts-gpios =3D <&gpio5 8 GPIO_ACTIVE_LOW>;
> +       rts-gpios =3D <&gpio5 9 GPIO_ACTIVE_LOW>;
> +       uart-has-rtscts;

'uart-has-rtscts' means: use native RTS and CTS lines, but you are
passing 'cts-gpios/rts-gpios',
which contradicts that.

I suggest you remove 'uart-has-rtscts'.
