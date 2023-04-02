Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358AD6D3714
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjDBKOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjDBKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:14:13 -0400
Received: from sonic305-19.consmr.mail.ir2.yahoo.com (sonic305-19.consmr.mail.ir2.yahoo.com [77.238.177.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1767AAF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1680430449; bh=MlKU1KQZBbNUfKCkJVC00AEtTe5/ly1B1hYcwT2pTxU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZIwl1Tlb+z7ZHYX12MfN4nvU8MfZHGPgOQEYsnUEgfXPIMqpWPqpRbf4t+cXvUP0POc2tVVGo1wUKogEgH14eVUe1tT30Ph4fHt1CJHkeCkQLaqOCzYlwMSHgVQhHlSK9JIY4O5MWcVad2KDhQH6OAY1TevLg85e9A+4TIZMTv0VTHrRXeQsEROt4v9ROWyQpHPziJmq5D8/gYZDjRVf/bF4D1/czoNTMIj26L18ypcCqBJfIHQXQC/3aTlxtHSHBIMnjHlEWB9Yk/j7mLe9q/EqGSz0pbrvpgltlPZdtfHpGskD8E0GOgZlA214Hcv9wXhz5/yyHsrc5Fsz2pJ6hQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680430449; bh=WKxBGUwkvav4XwwsDQ8jEiGIfqiKV8aCJN0iQWw9EtX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=EOAtiw42dbc1Axaipl9t0dFOhp66sxDUUdAQB9eKir7ib15EabMLBIgplMGAWsOupRNoCb8NhiFteXEub+tTgrrZD7yOwsLfBOi4TLsM1ok+i6UmsRmtv5tAPt/39w/dSVkcEfy9ZO8fGo7zd3/c9ZbxG485c3oucDPBj8UlHldQqZU4/NPEDCW50Q8qGAlKiw+tSv5ew5N3stESpaeyYwuD8Y3SWpb3sIy3MfT67J0xD3RPhgBgvgF9qviTcOSkH3C8helGTFX7qzH6s4fBn2R4E6+tsOEvaEmMfmA95RJcy4D7hrjFEkXVgZ4ew9OS8lyzMb9+3XNGg/dfMNLt9A==
X-YMail-OSG: pKCN2.QVM1lWsIbiRCHioxo5Pt7Uiqocro1jUN32eE0whJktJlsy_E97Hg1qK5y
 LktsmgTmvIf_gwnnSds2GhBssKslKuQ7GLSZ6WmYL6FxJEZDd1yUNfFJnxd5IkpavjtdSISxYjSa
 NuTJTaDYBlOo7tc23bUXI1bwOG7dQjij33Xw3aiiSvAaq1PMx33VuwJq4oO57oKRPQ9OnjAo6rTt
 ZDCwXcJ9V1RPtIxo8wZUhXLpHkb_5M.07TSuXrAeMqmk5qb6DAF3LZsDozoiHlhE11hIBuRupL6p
 08mxd3NcM5bLBXtWrkeHKjyM4CcpIyQkOou6f0bktCuJ3oI_WIyk0pE4uis7pLHdhyOfTU_5Rca5
 XmkOkZ13SKVd_XWe4QZNSJcz8se6Ac74d3XxpGUmcg8EhISxpezGIN_fK55PVkx5XdQdYxoRUb4M
 KayQ8n3ZgXBA4Nkh84xHxsnUEbtATUCO7XpIhsyI8sXaF4hw60FL5iY5hLke5.IzvSfzUKTpTU2i
 srjLGrIKPoXAgg7YxoiG69OtghevXE4_v4jb39GOBbuhRi6j3i4zcK7ZC44Z7xv2ky_aLMf7a596
 JApA3WTdsGkwI4LUcIUqolqdzvctIpuJ.aB9eEBD1XCBy.dJfmvzO_89KHPI9V6pN4B6lBpqDjp5
 Nd7Aj8MckZh0GfjAh6jTGgxqMHa_AQw7vjHc9m7gP7oMFXMFxyPfG2NG8.qy2k7D3BTe9qThIAeZ
 uV7ehcZbSpC3fh1RqHI_NgiE4ybFPOpFPyOoSZVorYssS3L5HTYpmV.8Mzqahr3DesFkCiTu92Nb
 k4ZxmycbynZEIQqgieEkMyF0ILwSBkD1G_Xs9_zkOaVxemFtaN2nAGfHM47YofUGrgcyfJDpNtiJ
 o0mEStUz9xDKydDXcoHBM66eRJ2YvUPXbVFcy2k5.l.br48h1dnm4KNMHKMStWWCsZlNx6oqvJB2
 _Gd0ULYhf6B3mnxUyTCAMPsN7JcPHEjL.tyc2oqwjsIOTJVf7polvBD4TvrNljHZjgaYR59.eTFY
 EHXD7IGaELAgBvMlZDjmhMFHRGesf9GBt24k84r.2V_wuOXD4ykxQaeXIJxrK3eNmuynuoE_nzyi
 vWX.wFYL32rSml_yMvT8n6x2aRr4nMbMoJ30WH9.f7Z2tbH.f8HW_Y_89u_.kOwbsCMrZ2q5l224
 fskVmEXMRb22zBOmi4hKjHYY0yl.y2Cu3lR6HfE4z71KCFPGtNup7fc7WBB8tWNW307LSPsmqZ5i
 HpNvhmSZGFABKlvCI9PuJiY3kkJwtqykF_7z3tyE9LAQ4KLMEa8qp5Iwpht8zVW15h.C7ff1LQRW
 bpwdfChCl7qlqaGg0pA1hPkbj.xFIOd_rjLUo0GZLua3p1DHHQ7nNEqPm8.kZXnw3I8ER0D0YcHI
 MOuvwFA3j02mlkmQlqcpLPBqALyTdmLgM2BIjsC_MUoq7_4SXFiroJRlC_c.fa59xL3EyM1jlHrk
 kox2T_UD9WQIzUgnf0lPCrQZQPGm2B.ivyzcZqmNUyUH7YuyoyaYO3PojtydxCnFGLTDT9H_qpZH
 gAX.YJjhYVrGSwNT2v7HbxQf6iWyyDYcZqv2njuwEN.eaZ0RKSTKq1AkyCGoSCuSqs27Jjz3Nshp
 9v3a485Aq9dSTb8tHv3p98tDgrLFaY3MYn5Zv7wT6ckm2S7kNmnLqkjMc3KWihxMecVurZ9xjb5X
 tk63bWat0r4zymoOQ.dz5SECEJKaOEuXZgy4N.Ge7VVRnsmZx.5r0FnaUZVEn2PKP.7oNM.KDXxe
 ZqooRCUi5IPSMIux93FKsJntpzH2wlrnEL98.2u6UmXnJ4K.TR1RyoWCIYkmulFuMx6X2rEBO95k
 qZpN6kQ45Evaj5N0IJsL2eMUHUOURvoHmHbbCc4COIXPV.Wjpn18ZH7eMa._C_ttoucBDVbPt4D7
 6mMm83FqYRnjFa801Tz8twzZDzdgop1fbs2C4X6N74WAK_zwbkrsuugXpvhct9dATFTPk.S0vNtE
 v4l7kRi01V_.fXcWbBJqiTE9GIxW.kPqwDfOB432jlXYvrv1VMX0NGSWcJXdGUqX68QN5.Wpy2FM
 pU7f5mfQPIAVx7e5Eu0VUXIp4uxGGyFylYtgrBeVkIGuDUWlaiBhwNbZ1BSc2QzXwuxTEmKv9ZA1
 OQounl1OQUci_5z9M_C93cAKpmmv.pZA5TFBWVBTGlMWER2Ob2JJzsM5J77QN2_wzurgQLhzNA3Z
 x.6KQA9iQCqBsJ.g1d8qDduj9QLk5rd_9W4mcjaBoLp_IzkbSkH5su4B7VhH1vuaR0A6c9NjLwxA
 g5v4o_udN0Dx5poxprB0M_3lTk4xjtg--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 8aea96a8-b4b3-4593-8ccf-70c01945595a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Sun, 2 Apr 2023 10:14:09 +0000
Received: by hermes--production-ir2-74cd8fc864-29g5c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1444fd286b9b770797e8ff9df080e96e;
          Sun, 02 Apr 2023 10:14:04 +0000 (UTC)
Message-ID: <688277f8-c6e4-6e9b-2f56-01a63103e61d@rocketmail.com>
Date:   Sun, 2 Apr 2023 12:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/10] power: supply: rt5033_charger: Make use of high
 impedance mode
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1677620677.git.jahau@rocketmail.com>
 <6b474e64f752ca6802dfb0bfc5571eb1adad8449.1677620677.git.jahau@rocketmail.com>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <6b474e64f752ca6802dfb0bfc5571eb1adad8449.1677620677.git.jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 28.02.23 23:32, Jakob Hauser wrote:
> Enable high impedance mode to reduce power consumption. However, it needs to be
> disabled in case of charging or OTG mode.
> 
> Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>   drivers/power/supply/rt5033_charger.c | 47 ++++++++++++++++++++++++++-
>   1 file changed, 46 insertions(+), 1 deletion(-)

...

Raymond (in copy) did some tests on the flash LEDs, which are also 
managed by the rt5033 chip. There is no driver for leds-rt5033 yet but 
Raymond got the rt5033 LEDs running via the similar driver leds-sgm3140.

However, to get the flash LEDs working, he had to disable the high 
impedance mode of rt5033.

I implemented the use of high impedance mode by this patch to improve 
power saving. It's kind of a sleep mode. Although it's not clear how 
much power it does save, it's generally worth trying to improve power 
saving on mobile devices as far as possible.

As it now turns out that the use of high impedance mode might complicate 
the handling of the flash LEDs, I would drop this patch in the next 
version v2 of the patchset. Let's skip this power saving attempt for 
now. It still can be added at a later date as an improvement.

Kind regards,
Jakob
