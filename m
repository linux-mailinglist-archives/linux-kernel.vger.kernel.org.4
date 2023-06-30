Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C477743CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjF3Ndx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjF3Ndu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:33:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3AA1FD8;
        Fri, 30 Jun 2023 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688132027; x=1688736827; i=rwarsow@gmx.de;
 bh=1FjQkWzz5XQu54ji6OXeWW3bwJfR5MaMh6jwUOfKEhk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=WBlJ5+Y7aWITUSDesMOd79wMTTesXnsnAT3VNM8JbPXFpOj7e50A9oSbSLRCKlJHRzlZS3F
 wozatHRvEuZaKA4Vv0akbusfNXxHoABauEJrQT4pcmzrkGD+hhKP2eqt5SYvFcQ50dJxAbHgt
 FZmPjFRUiVOz8j49qSpjyaOROJq/D9C08XnEbxnUKENfitkEgFDPtCZYIQCydcfLMvjYgCrAT
 fUk9wCPcTcOyTwzDsi8wP10wxedXTXVP8ZiFmNWeotwSVlMc5/bnNZSsAMRqI2DYaAqcwVmXU
 zV5+k0yw5myY9HrDnfd+lzfoXqwKTJNAhKYgzN80tSox9znTh8kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.89]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzFr-1qX27f3kyP-00HuM3; Fri, 30
 Jun 2023 15:33:46 +0200
Message-ID: <a62494e7-726d-c22d-a623-42d51a05a745@gmx.de>
Date:   Fri, 30 Jun 2023 15:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 00/31] 6.4.1-rc3 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2KvIlMveVlpNfP9E8ttTQr7C2vv1rFadDhAzem1xB8YvMJNuLzE
 cW1L5JwOEW0oBb5Ei3fVKbl46S7g0b9W+MjcUz2zNUjjU1B8LS0T+MQ5YRhjr4F3VAFPqHn
 DuWLF4vrfw4SJ+uq17Tlb12SeDP96yWXSFJKUQhCZrB0Y1U7K7zSQk6J+0j18rD0RwyQmEV
 S1ybgrIWGDEFlRds6W32g==
UI-OutboundReport: notjunk:1;M01:P0:9ODoYGXH/iM=;UMZ1rogkiZo1hRni1CQK0PVMPHO
 +BxC3KjsJM08AQKMGL0w33HVqY/606K4+wxSsk09034+MecMyOP6rG+e2VBOIThn7D4Gwc0sl
 kADCXDqOfH0lPBiWhtpEWXW+He5ux8AjxyyZaTS/4FMcygEekb9hhuVefkTlCCgsKAexvt1+S
 nrgJQkHoSyQncZM2Ua6633AQpXZj3cQzpaUs9prV521Q+BFOJwXvI+lA+XdC054aOtkPsi1Y8
 q37mnA6LHi7DktZBqvOLgQfpDz8yAcflF1Af9BK41GHJt3FEM14o9qo1ksiV7Qd8Mg/1GtWw3
 enHkPBAX5PGoaj0QgrS0OLcwVYE2I35LCzEQ7UCvHHCA21+S0vZV8XOo1NU0Yfp6NUIF8Qq3p
 i0X1R3trwUNVbRwoBucRXeSJzzJYJz9pbNCurut8tMCn/JcqyZJpDGTkOvUx7NsfI+e1VN4jT
 C8DXBfLzS0FcOJxcO6KgsbAOAmQeBViCPGoi7HlRY6WrOiRiuuoDZ4G8jjGW4DvmE/t+uWHSq
 a8ceZfdFu5mPmAG3Fcli5dOzhCncbydPM6kbli86ugbYB+khstff1ZPYCWtHrZ7k9yjD+jtSf
 K5rOZUV95+SGzbLVtCkdOCHB1rRlcE02FI50trQU++UV/N8dygiNqOhUpTyqfshqm5yAbR6Ns
 3YgZUgJw+TjVtwdzinaujYyqzbM1rAxVyy9z2P5WSEAGE6ah3hIbS5si/AHF64j4GS5O6AH2c
 OklNoW6wCw2Hkqz1U85ghB379SbCuCRxCSEgkpeNyRfNdVlmFQoXitgYe7B5jAZuqHc70msjO
 HCAOoUskFtAb7CBMRNpLyhWMgIAjZplujQveOoCfZ0MYPLAnGZPUINJpko7DQ+Eqv42ua28fy
 lO0YwEms+4MYRMttQZxO+qXEPIPMzYMnNrCW+j8YDFlosZzoYt7+aEOe1MC8NNHJG5/pEhuK6
 ijmIZoqJb9JNCciMD9SixrlAn2o=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.1-rc3

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

