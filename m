Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCAA67DEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjA0ISm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjA0ISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:18:40 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4831538026;
        Fri, 27 Jan 2023 00:18:36 -0800 (PST)
Received: from [127.0.0.1] (144-178-202-138.static.ef-service.nl [144.178.202.138])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2A86CCD52C;
        Fri, 27 Jan 2023 08:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674807485; bh=scsgDr8Bc4H9mjfkHESouNbjZqJgzTX2xBO0EFeMwAA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References;
        b=q+kCCfHnPQWDPrOKoCSsb+f1u43YZoNE+XpXNS7pD9O62FvDxeLLiD0KtBqSkJn2Z
         S13s4FojPNyg9r3HVTwtiPYnIBQ+pWBIHUKn7h7MovolxStKznNSNvJGLr62BiGpeG
         zJ24Pt/NwvMBuR4uyYbCx4CHMvw0Edq0VFTpKADs=
Date:   Fri, 27 Jan 2023 09:18:03 +0100
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/3=5D_clk=3A_qcom=3A_smd=3A_A?= =?US-ASCII?Q?dd_XO_RPM_clocks_for_MSM8226/MSM8974?=
User-Agent: K-9 Mail for Android
In-Reply-To: <b24dbfb4-8b02-bb30-d859-a313a4aaa363@linaro.org>
References: <20230121192540.9177-1-rayyan@ansari.sh> <20230121192540.9177-2-rayyan@ansari.sh> <06d53a3fa48080d902476b71308e69bd.sboyd@kernel.org> <4c531c68-b74f-2f90-e8f6-98a4b0316cd4@ansari.sh> <a7058fb92642a1661995d7d3ca6411bd.sboyd@kernel.org> <b24dbfb4-8b02-bb30-d859-a313a4aaa363@linaro.org>
Message-ID: <E190B1BB-29C1-4E25-B658-7BDF4EF74197@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Checking clk_summary in debugfs it looks fine on msn8974pro-fairphone-fp2

Tested-by: Luca Weiss <luca@z3ntu=2Exyz>

Regards
Luca

Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg> schreef op 26 januari 2023 00=
:33:42 CET:
>
>
>On 26=2E01=2E2023 00:00, Stephen Boyd wrote:
>> Quoting Rayyan Ansari (2023-01-25 14:25:08)
>>> On 25/01/2023 20:58, Stephen Boyd wrote:
>>>> Quoting Rayyan Ansari (2023-01-21 11:25:38)
>>>>> Add the XO and XO_A clocks to the MSM8974 clock list, which is also
>>>>> used on MSM8226=2E
>>>>
>>>> Why was this missing for so long? Does this break suspend? Why are yo=
u
>>>> adding it now?
>>>
>>> I am adding it because of a recommendation from a maintainer on an old=
er=20
>>> patch version=2E
>>> See=20
>>> https://lore=2Ekernel=2Eorg/linux-arm-msm/20230119023337=2Eh6a7f56lizh=
v4tcy@builder=2Elan/#t
>>=20
>> So nobody has tested this on msm8974? Can you add this information to
>> the commit text?
>
>
>And can it be tested on msm8974?
>+ Luca
>
>^ could you, please?
>
>Konrad
