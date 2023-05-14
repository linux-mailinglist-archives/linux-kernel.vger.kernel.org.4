Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBD4701F9F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 23:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjENVBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 17:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjENVBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 17:01:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067DE10D9
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1684098099; i=hfdevel@gmx.net;
        bh=JLpbwCKl/yHzTYYr9JyJyKY1h8yVM4J1x+alUlH1beM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ODpyOExqhqoZCc2/Jevl7zpR94kQzq1xsoQYuTlmQ97eB23RJNHFSk6hi8h4xmhtb
         1lmxRBftQdHnbcIweimorVf5nVh4DlPiWIZGmn/i0ZEig6Z/UJoFERuVQ3AKxC9xP0
         0YHv3pOwvVWeikzjzQieNGTCcu17sw3PjJ/wo2ZiSuGReiT3rJ07lv258eVgSty7z5
         cBgxuPJi5MqvtT9WA+mVXZ76Vw02cYbT5eHgXqJgHjo6hhyC1BJ5DyAFNWCr2mE0sI
         ZWlzCyK8OrydUgj1cQMW24LOdZ1frdBtptgtn27VdgBSXuXLpgKk1WkKrKTwYcgm5Z
         /SBv5NbnMTS4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.115] ([93.236.68.89]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmfi-1pac7V2xZK-00THLA; Sun, 14
 May 2023 23:01:39 +0200
Message-ID: <2558ba71-4f51-e186-b51b-554a72f19e19@gmx.net>
Date:   Sun, 14 May 2023 23:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ARM: dts: meson8: correct uart_B and uart_C clock
 references
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        neil.armstrong@linaro.org
References: <20230514201909.506090-1-martin.blumenstingl@googlemail.com>
From:   Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20230514201909.506090-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MV78Ss+OjvEaNrHx16nfBXIHCLTC7Ys8s2TdTwCjE3dTlJe83ZE
 6jHFq8nXsjDmdK3p0KVViOwM6/QONvZuG7JUMbAWuMbNEwLI3EAvA/3dkLYZenlfjTIusBp
 sf6FfrKBzB5g4w9TYrA43j/JyScals/3QM0MZCbRQASD4eqqeJ7/EMjymNnXS2pMgfSIqs2
 3kHJabv1Np3bIHT9RrM4g==
UI-OutboundReport: notjunk:1;M01:P0:ZcaPssHlN6I=;pHTHtw55Yrs3yMe+N+sXIPn0TYK
 LysSkXpCPKlM0tDe6Gga8PIbNilx7IoZYiy4zKtf4jsLeAnxicfHdUFiWS5rtgqMeOlkR2t5J
 nuht1biPbUbr9AGmXUZuxFhcNWEk42tNmWpNJj+Bbudj+wMaNwDnRDNiQnkHfSIgXh3AQK4n0
 cWWIRnkNdTUoW5xmC5Vl7fqZF1AodLW8lJSBSfykt7v3nxpT+hRmwFx8+HkP/ZakLI/6cxmxU
 RMGJWpLToBzjxH8mFm39XeYks/2c87cEDPZ09P2/kireCkMt1Yh3YRQ/x6TwgT41gBl/UAdrj
 ZS8YZ8y1RWC1xyDs1ujRnFhHWd8aAl32ZfApgoGqDGTRg95w/4/nIQ/jxZxFcHeIfrLH6IXk5
 8XxvERp/xqgYz14OF9LxmKjOPhN8dSUCSNtyNyeU8T8Zf8mXQ9AYgBC85bV3P6QN3nzSMh1Y+
 uk5OojvkZswvzJTXKFfFJccwMB101LdIrreJBb83xashZ0DoAFs21YHE+7Z0e29qWxkB7+9Jo
 61QsXWW5nXyfcd4Az0Fi+9KlY6BZyzRq6R00TRRszUXCcoUE1hLB3f2L5RotQnCZ7mztleMJp
 FsawMK3MP+zWljJVOfVpeR2srb93koNRSEoHdmH9ohyOlXQAtGQ84Gyh+IO5vHP189NwzDYZK
 xqEydU2w817wi0ycu9Bc/wUlXZIohLXhrmgBdfyxlgQAnZl1MKW9VSIxhoWWNGkEREpTPmC98
 EcrPD4agfOF4bn3MnJlU+tZLmoBCLzHswi/3Q0YKtECn1a9FJJku/aZ+xcA2tNq265bAkgxUE
 gQ+3td5PBa4YFzTfy3b0lp8PEnEdhDx1u7TbSsGECOjOUSQLNT1aJt5KdzPv80ZDnBMP/6Gmj
 +XtzYQz1luuvdIiYWjUzvRXXTf2b4cGKaFb3dkMGYsdlzGmqqwDFDlePCo2UlYqNGC/yRfPTC
 N35bSA==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.2023 22.19, Martin Blumenstingl wrote:
> On Meson8 uart_B and uart_C do not work, because they are relying on
> incorrect clocks. Change the references of pclk to the correct CLKID
> (UART1 for uart_B and UART2 for uart_C), to allow use of the two uarts.
>
> This was originally reported by Hans-Frieder Vogt for Meson8b [0], but
> the same bug is also present in meson8.dtsi
>
> [0] https://lore.kernel.org/linux-amlogic/trinity-bf20bcb9-790b-4ab9-99e=
3-0831ef8257f4-1680878185420@3c-app-gmx-bap55/
>
> Fixes: 57007bfb5469 ("ARM: dts: meson8: Fix the UART device-tree schema =
validation")
> Reported-by: Hans-Frieder Vogt <hfdevel@gmx.net> # for meson8b.dtsi
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Changes since v1:
> - move the link to the original report for Meson8b to the description
>
>
>   arch/arm/boot/dts/meson8.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dt=
si
> index 4f22ab451aae..1054297fa69f 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -769,13 +769,13 @@ &uart_A {
>
>   &uart_B {
>   	compatible =3D "amlogic,meson8-uart";
> -	clocks =3D <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
> +	clocks =3D <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
Shouldn't the second clock reference for uart_B rather be CLKID_UART1,
similar to meson8b?
Sorry, didn't spot this earlier.
>   	clock-names =3D "xtal", "pclk", "baud";
>   };
>
>   &uart_C {
>   	compatible =3D "amlogic,meson8-uart";
> -	clocks =3D <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
> +	clocks =3D <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
>   	clock-names =3D "xtal", "pclk", "baud";
>   };
>

