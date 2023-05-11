Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3046FEB15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbjEKFUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEKFUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:20:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC714213
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B602B618F2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F6FC433D2;
        Thu, 11 May 2023 05:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683782406;
        bh=FTIiBKAFL2DBhGmuNd5YDha3nOeMeeEPUsMzvvwTkns=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Bf2kwxM4phlrWRg/r1CkMCQDlPsdamEGJKd2jCkYnLrmCYjelecnIfCCiROrmvLfH
         5pREYWIA5SL1/5VRC+8sewFUFvndWE0VayP8xgjqJg9NOIiSxylI8g6LU624Cg+Wvq
         eCgE/DEtzNwXWGwV/AOy0ycZZDiZeqjS1o7sJfHygdnlpAVva0pW26csUq0fn+A3m7
         OgtVB7BoT1EWLx8y5P5qaTh+YWv+MewmaBP2zExhTJQlQjo96TsmvpFUjNvWDi2AgG
         urXMg2lyY4mjHI0ymB8HGvFD9Jkw3edus0u6tzi9voKJTvz0NEOZEfc0zyeswV0oI3
         UP3nCQY8F2RIg==
Date:   Thu, 11 May 2023 06:20:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yixun Lan <dlan@gentoo.org>, Yangtao Li <frank.li@vivo.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, Wei Fu <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 5/5] MAINTAINERS: add entry for T-HEAD RISC-V SoC
User-Agent: K-9 Mail for Android
In-Reply-To: <ZFw8u9uqaRvCEQCI@ofant>
References: <20230510204456.57202-1-frank.li@vivo.com> <20230510204456.57202-5-frank.li@vivo.com> <ZFw8u9uqaRvCEQCI@ofant>
Message-ID: <AA64B50D-DAA9-4329-B4BA-BAC20224C7A3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11 May 2023 01:54:19 IST, Yixun Lan <dlan@gentoo=2Eorg> wrote:
>Hi Yangtao:
>
>On 04:44 Thu 11 May     , Yangtao Li wrote:
>> From: Jisheng Zhang <jszhang@kernel=2Eorg>
>>=20
>> Jisheng:
>> I would like to temporarily maintain the T-HEAD RISC-V SoC support=2E
>>=20
>> Yangtao:
>> Wei and me would like to help support and maintain too=2E
>>=20
>> Cc: Icenowy Zheng <uwu@icenowy=2Eme>
>> Cc: Wei Fu <wefu@redhat=2Ecom>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel=2Eorg>
>> Signed-off-by: Yangtao Li <frank=2Eli@vivo=2Ecom>
>> ---
>> v2:
>> -add Yangtao and Wei
>>  MAINTAINERS | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7e0b87d5aa2e=2E=2E592769efd1d1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18155,6 +18155,14 @@ T:	git https://git=2Ekernel=2Eorg/pub/scm/linu=
x/kernel/git/conor/linux=2Egit/
>>  F:	Documentation/devicetree/bindings/riscv/
>>  F:	arch/riscv/boot/dts/
>> =20
>> +RISC-V T-HEAD SoC SUPPORT
>> +M:	Jisheng Zhang <jszhang@kernel=2Eorg>
>> +M:	Wei Fu <wefu@redhat=2Ecom>
>> +M:	Yangtao Li <frank=2Eli@vivo=2Ecom>
>> +L:	linux-riscv@lists=2Einfradead=2Eorg
>> +S:	Maintained
>> +F:	arch/riscv/boot/dts/thead/
>> +
>>  RNBD BLOCK DRIVERS
>>  M:	Md=2E Haris Iqbal <haris=2Eiqbal@ionos=2Ecom>
>>  M:	Jack Wang <jinpu=2Ewang@ionos=2Ecom>
>> --=20
>> 2=2E34=2E1
>>=20
>
>Don't get yourself wrong, no objection personally=2E=2E
>
>But as I saw, none of contributors has affinity with T-Head, so no idea h=
ow this will
>work well=2E=2E always better to take over maintainership after show enou=
gh commitment=2E=2E
>
>Anyway, raise your comments, and I'd more than happy to be proved I'm wro=
ng
>

They're more than welcome to be the maintainers IMO=2E
Being the vendor is no guarantee of commitment either!
Guo Ren, who does work for T-Head, was the one who suggested that
Wei Fu would be a good person to add here=2E
If they don't end up maintaining it, it'll fall back to me anyway & I'd pr=
efer
to give people a chance=2E

Thanks,
Conor=2E
