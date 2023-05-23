Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB58570E4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbjEWSnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbjEWSnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:43:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40FF91;
        Tue, 23 May 2023 11:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684867422; i=rwarsow@gmx.de;
        bh=92V7MM843tenXsql5RGiJHqh5TuZ4uMkeis0sdCYmTA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=oaofGjW9T5Yd9ktlVVpSnR8lOgEuVmmnnIsRJEXyJEmZrRrkhoi4t/k4FhoXBx1BI
         PflhEUTX7gF2xFuMzVA9C1DgohAy+3kykFdTf9UyHaG2He/ipeFe7s2NpMAeRK/5R8
         UxYEeU6WF+m87wxh3zV2ftD/saw5wp8qh8cu7lo8Yp7PONcWfmxsYYK4JTX628hBgr
         aYRAd1hsc8mF08L0p3ckSKnwgWlTGDjdTgUcm9gFYmJw8O0Sq5LIvwxXk745vUF7Ib
         3O6WBm6d719RMjBN4MIDsT+3GlfD2b5SCBdj7tZRwDTGYm4Z3Utwf7UlvyPvE8VlWS
         UaeEWjVHbxBUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.139]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs0X-1qWF6S3nGb-00mqFI; Tue, 23
 May 2023 20:43:41 +0200
Message-ID: <51f15112-1a79-a2b4-aee1-7f4becee1f2e@gmx.de>
Date:   Tue, 23 May 2023 20:43:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 000/363] 6.3.4-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:a1X2Z52ZmkoKbW8DCfgsMbJl7dw2SY/5hxGHUkR9FsjTZpUo6Pf
 xrU/hIKIqb1kK0Hoy+kEr0Rbbq8SGL1OHK+88lyyPhUmbbItnayWuekgeJOCFK4g/UBgNNC
 PUpPP2bKFqXltvGub7YHYZ1iO1QpOrmhiIbCkH1H6sDC4BbcmJ99hymkFSQVGnxEaMkIg8n
 CEE5pOaXFAYsT9a+qjyrw==
UI-OutboundReport: notjunk:1;M01:P0:dWcSf7M9Wcg=;wafeN5QY/0YPxYUhtaSPk+EincV
 vO+G9c8MhtNqwnaKs5Vjz22TsTMBk942p4htXCyUxmDo8KptiGa5aWm0aVyy99GK8Dku7a9Pu
 DA/cDxW6Gh10mcmiOjz5ds77mPL27QIMk4ToqEaiDHFMSF2sHZgpP1o//CQ0pHz9Nromntdw+
 JjkbWsaEiXnvQCGyEVIbnS+hJH2ANn0NLSkPQ7sIr9kaW0voWARACfWgD/LFro812/oIaowTb
 eoIosZ63G4Qy04Km51nt+prlPRzdlyOlmNa5HBbvrEuHJA5o6pJp5S/qxu3ISjInESqpDXq4B
 8+cqdpuPeKp0at/A1Xz/W3rEvD0SVYsfFsvYxXkHJLh5flnmoqfgZBXDaX9h7nVRq+eeFaqDI
 f/zDBK/SYH/RYF9AY2CV6l52UastG2yIKDV4GyeX5zMl8GUn3cDFXBIrULpZaQLvT/jPpJiZF
 NRDGISdNcJaWUh4rWi/Z4xavvoS7qsbkFxcqegWYpq37wyaDeX83OavXwgGjmnjQyik8vOXzk
 GuTgKSgiXe2XWSFn0ErBhqFjRwd+YroGji5vBul+FfgUbQW5Gh4ReINDtnf5HsauRGlG1b/Gm
 GILMiYp1wQ3sLGPlY+GF1igwoimz6DVLnGxZoL+a/QVQ0eLo7dFSnr7L2zRWXIHybLUOBbHzX
 wdFtWlQWokAeG0d3gauSv97Ni9EQXA3meYXHEDoL1JOry61uOl9ZtxCNs/ir2geJUlz4oSRd+
 TTS3/+ze+b1waB6ayE8rn/Q08pe8g5q/YyMqP6QZRvrfk/LqdFLCJFs9rFMt2DDDf44cQ08LW
 W3sH9pwKx3yK17KTMZoGpj90aWBgaICxl8gxv1PyC8nDhpD0nA/+IxVi2kQUTx8HeCakQzXcG
 jt711IJwyXPMiHkRZH8gRQqMeMFC5GoyFicekPl1dxNGaqGfmtZdqJLhkDjIHlTV8InUL0BOO
 1nF1ixrQD/PL86gdkR9MMQZHaHs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.3.4-rc2

compiles, boots and runs here on x86_64
(Intel Rocket Lake)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

