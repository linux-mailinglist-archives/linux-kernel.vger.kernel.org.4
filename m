Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6A469DD08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjBUJjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjBUJjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:39:07 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDB3241C6;
        Tue, 21 Feb 2023 01:39:06 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17211366c6aso4047502fac.13;
        Tue, 21 Feb 2023 01:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYzG5ssaLA2O4RX+ksz66ZZSsXVKW2HZLIvI31k/qio=;
        b=IAEFnu7JMucY6HTgVO/Mo16xU6IEXaBtr59F7PlD+cw+lXksJcGgFRWpfMOPuMmNbf
         DuMb6Opy5YxCwbQe8rf507osk+iyyE7Gpmo4OzBAKpnLsvcUVT0iWWbhOqb7oJib0RHo
         /UxwqyPQCGau7a7H8A2WLsj94cd5s9QKFKmQrTAlMUOJSn1S2uRs7rvHXJqlhsx+U6JA
         +C+SDw7u0fUzQAdp37YUDnWxaJS/JepbAP/9l2EFpysmI/yPBAi31aqTqq1LPqpK6/9C
         O6bRE0mrkyXeZGzCzy6PHtQ49BqTv/EJ2qptIv6JoaxUmVnOmT8JTubvVyVKjWoOAh3W
         sbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYzG5ssaLA2O4RX+ksz66ZZSsXVKW2HZLIvI31k/qio=;
        b=ePHIRxmu9HGQtQnJk2MaAFNKsOYH3tjYbcJHeZzboFUJEP9mqgJbqT3yNad7IJwPv0
         zlPIN0K6cXusaff+IDhy0MWWaamt2+QvXamN9GVf2s5fl0AihBE5gKKi1F8wViGHB4o6
         0atQtdfDNLT52c2qYmR7+RlUfC8ZQ3g5Wc04LBbw9DapTDYTw5yuqTr1WVe795pKbXKj
         lyMknrHFnSsMeB8OaKrRd+dJENAA9AfghNPXEfan7yeUBfO3cWA9/r/Q1TM2rESXZaFY
         K2uPjSZn8hu1itkpXYh8ixCeT4zlE3gu/yV3c4tO3BJYt0LxkepF2fY3IoBaTcFl011Y
         9Oaw==
X-Gm-Message-State: AO0yUKXZG1GBGWgcCw9f6qv3dMlCpTPEe/hIpGXd43PY5za3BUiB1fQU
        Tdi3R4HdVDA761NFokCbOg2ZwwSgmLTScT4emF70Vcp17TU=
X-Google-Smtp-Source: AK7set/2DC3PaB9vJnX4CdCdeihpzX1Y/N0+fFoiXCMXoWMSjD85u4MM56c2lC74m3WDTL56wPjCTB3C0IAWOItIl4I=
X-Received: by 2002:a05:6870:b016:b0:171:f3aa:8da5 with SMTP id
 y22-20020a056870b01600b00171f3aa8da5mr383773oae.239.1676972343433; Tue, 21
 Feb 2023 01:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20230221092435.22069-1-arinc.unal@arinc9.com> <20230221092435.22069-2-arinc.unal@arinc9.com>
In-Reply-To: <20230221092435.22069-2-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Feb 2023 10:38:52 +0100
Message-ID: <CAMhs-H9qLw6uhjPnFWovQBMFe38y95Q_VvG8Bj9wovSR+1J_2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mips: ralink: make SOC_MT7621 select PINCTRL
To:     arinc9.unal@gmail.com
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ar=C4=B1n=C3=A7,

On Tue, Feb 21, 2023 at 10:24 AM <arinc9.unal@gmail.com> wrote:
>
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> Currently, out of every Ralink SoC, only the dt-binding of the MT7621 SoC
> uses pinctrl. Because of this, PINCTRL is not selected at all. Make
> SOC_MT7621 select PINCTRL.
>
> Remove PINCTRL_MT7621, enabling it for the MT7621 SoC will be handled und=
er
> the PINCTRL_MT7621 option.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  arch/mips/ralink/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
> index 06031796c87b..83e61e147b90 100644
> --- a/arch/mips/ralink/Kconfig
> +++ b/arch/mips/ralink/Kconfig
> @@ -54,7 +54,7 @@ choice
>                 select HAVE_PCI
>                 select PCI_DRIVERS_GENERIC
>                 select SOC_BUS
> -               select PINCTRL_MT7621
> +               select PINCTRL
>
>                 help
>                   The MT7621 system-on-a-chip includes an 880 MHz MIPS100=
4Kc
> --
> 2.37.2
>

Which git tree are you working against? CONFIG_SOC_MT7621 is not
selecting PINCTRL_MT7621 at all in v6.2 [0]. I think it should select
'PINCTRL_MT7621' and the 'select PINCTRL' stuff added inside the
PINCTRL_RALINK option in [1].

Am I missing something?

Thanks,
    Sergio Paracuellos

[0]: https://elixir.bootlin.com/linux/v6.2/source/arch/mips/ralink/Kconfig
[1]: https://elixir.bootlin.com/linux/v6.2/source/drivers/pinctrl/ralink/Kc=
onfig#L5
