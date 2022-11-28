Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F6B63AB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiK1Ots (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiK1Otq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:49:46 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35C82709
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:49:44 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id b73so13586214yba.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kUyFaq6hU2wuVKo6b7K203M1NFz6Mru7sP6h4b9W0lE=;
        b=K3qilqb9qv0kJMdpbvK+6gS0jgNBmkoVD183PER+BnRh5STjVwtjE1fhtmGiBDgS55
         cIy1scO+eFYQP8oNxc5ccrCnlzAwncuDR88YGjx9q4LUPXaLvQqjS0CaiEP+/RZKO+2a
         sxm9NIqGAksFPmFxVRU6d6/BqHU5ljqdzeJJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUyFaq6hU2wuVKo6b7K203M1NFz6Mru7sP6h4b9W0lE=;
        b=4NAOF0qAvDgzFJYJiEgVXhMCk6qQPqD4M7ZdB7E2MgavjlwUERJeVxvAJwJwv0l4JS
         ebEx2dWvj0sTYa4U8cxBuczjt6sLiS2IVBUXEoe4q94An9AX1wumVzwipWimGt0AR8ym
         Qs7zwMwii7zYkcMzDj1fOM10AsLNQeeL0ng5qFC7ej6p2MmfIq4QiZdMOkB4Jn+Qfbi6
         m5HDL1eVEMQWF2VIxtOkFetUi8cwuFqOhS5lsjwBkWHwDIUyfGjUG/MwgFx/3ldLsySR
         kxu3qTQgwwEPm9xVEjj6CCXYNGD/Uw3zETbWGviqtiVSuT6XfoGddyCDLgxs3YxftQEp
         bdmg==
X-Gm-Message-State: ANoB5pmCG8/VwBGYnZ77uv5/vx8dR4iyvDh69I8sVpiJuUQe1vWbxOX+
        VG6rlXYRsILBRnoUgXKr4ZtqtSj78pJFHPZarVR9tg==
X-Google-Smtp-Source: AA0mqf4JghXFRWp7xro+atPdczlzTf2r9GCLDA8K4XaiH0Ph6N0uXVagg93Axl+93wuEHGhGfjeqOazQThm+QngeTH8=
X-Received: by 2002:a25:bac8:0:b0:6d8:186:aac8 with SMTP id
 a8-20020a25bac8000000b006d80186aac8mr46583095ybk.23.1669646983894; Mon, 28
 Nov 2022 06:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20221128103227.23171-1-arun.ramadoss@microchip.com> <20221128103227.23171-2-arun.ramadoss@microchip.com>
In-Reply-To: <20221128103227.23171-2-arun.ramadoss@microchip.com>
From:   Pavan Chebbi <pavan.chebbi@broadcom.com>
Date:   Mon, 28 Nov 2022 20:19:33 +0530
Message-ID: <CALs4sv19Efi0oKVqRqRFtF2SCr6Phejh4RFvuRN1UCkdvcKJeg@mail.gmail.com>
Subject: Re: [Patch net-next v1 01/12] net: dsa: microchip: ptp: add the posix
 clock support
To:     Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
        Tristram.Ha@microchip.com, richardcochran@gmail.com,
        ceggers@arri.de
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006625eb05ee88fba0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006625eb05ee88fba0
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 28, 2022 at 4:03 PM Arun Ramadoss
<arun.ramadoss@microchip.com> wrote:

> diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
> new file mode 100644
> index 000000000000..e578a0006ecf
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Microchip KSZ PTP register definitions
> + * Copyright (C) 2022 Microchip Technology Inc.
> + */
> +
> +#ifndef __KSZ_PTP_REGS_H
> +#define __KSZ_PTP_REGS_H
> +
> +/* 5 - PTP Clock */
> +#define REG_PTP_CLK_CTRL               0x0500
> +
> +#define PTP_STEP_ADJ                   BIT(6)
> +#define PTP_STEP_DIR                   BIT(5)
> +#define PTP_READ_TIME                  BIT(4)
> +#define PTP_LOAD_TIME                  BIT(3)

PTP_WRITE_TIME sounds more intuitive than PTP_LOAD_TIME?
Also I see that all the #defines are introduced in this patch, some of
which are used later. It is a good idea to introduce the #defines in
the same patches where they are being used for the first time.
I will be looking at the entire series but am responding to this now.

> +#define PTP_CLK_ADJ_ENABLE             BIT(2)
> +#define PTP_CLK_ENABLE                 BIT(1)
> +#define PTP_CLK_RESET                  BIT(0)
> +
> +#define REG_PTP_RTC_SUB_NANOSEC__2     0x0502
> +
> +#define PTP_RTC_SUB_NANOSEC_M          0x0007
> +#define PTP_RTC_0NS                    0x00
> +
> +#define REG_PTP_RTC_NANOSEC            0x0504
> +#define REG_PTP_RTC_NANOSEC_H          0x0504
> +#define REG_PTP_RTC_NANOSEC_L          0x0506
> +
> +#define REG_PTP_RTC_SEC                        0x0508
> +#define REG_PTP_RTC_SEC_H              0x0508
> +#define REG_PTP_RTC_SEC_L              0x050A
> +
> +#define REG_PTP_SUBNANOSEC_RATE                0x050C
> +#define REG_PTP_SUBNANOSEC_RATE_H      0x050C
> +#define PTP_SUBNANOSEC_M               0x3FFFFFFF
> +
> +#define PTP_RATE_DIR                   BIT(31)
> +#define PTP_TMP_RATE_ENABLE            BIT(30)
> +
> +#define REG_PTP_SUBNANOSEC_RATE_L      0x050E
> +
> +#define REG_PTP_RATE_DURATION          0x0510
> +#define REG_PTP_RATE_DURATION_H                0x0510
> +#define REG_PTP_RATE_DURATION_L                0x0512
> +
> +#define REG_PTP_MSG_CONF1              0x0514
> +
> +#define PTP_802_1AS                    BIT(7)
> +#define PTP_ENABLE                     BIT(6)
> +#define PTP_ETH_ENABLE                 BIT(5)
> +#define PTP_IPV4_UDP_ENABLE            BIT(4)
> +#define PTP_IPV6_UDP_ENABLE            BIT(3)
> +#define PTP_TC_P2P                     BIT(2)
> +#define PTP_MASTER                     BIT(1)
> +#define PTP_1STEP                      BIT(0)
> +
> +#endif
> --
> 2.36.1
>

--0000000000006625eb05ee88fba0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICMynhcQDY+aoPs+Lw9dwHoowVhppMna
w9TrZQGtabOTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMTEy
ODE0NDk0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCUs1WktrMSjsdx6/hMjbOP+BQBa6Nj1uJs8bAh1MilKQ7VkFT1
HLhD1LrwHHDd6S8H1QVgXNRRBpAM5Taw5NeJLaer1NO/u4t4Y3PRAWDz9qNRUanbhDdYwg1hGrqY
XHKwVRB5HgyKfe/rOO73lYlArojcxc4aIlMt0PI4xJsqsceWYredfC/O5GT+6bXUgPB8sVbAQDx2
DLdmBLH5ipiulbUnaaxN0ngzgUDO6/wFzxSeCPgv0Mdb83Dg2VsZETtyoJ51lWA0dXjdKeSICJs3
nZNXVMGN/peRuooEHznbYzjKf6RVZzWUVUE6DM4pYa61tw9BmE0uH/QHvtJCtPIH
--0000000000006625eb05ee88fba0--
