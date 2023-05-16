Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C6B704D63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjEPMGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjEPMGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:06:45 -0400
X-Greylist: delayed 16930 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 05:06:42 PDT
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5A444AD;
        Tue, 16 May 2023 05:06:42 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:58f:0:640:3768:0])
        by forward502a.mail.yandex.net (Yandex) with ESMTP id 226C25EB96;
        Tue, 16 May 2023 15:06:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id b6aGXvFDdKo0-Qd5YAZVi;
        Tue, 16 May 2023 15:06:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1684238799;
        bh=/a6pvyDAWlMZ0z7v7y2vBNHYN4rbuFjpKaEnziP4leI=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=g5DXrY5seHHIRvbxU18DdWqOc5we2o1Y9nxHH41nZKWf8C5lfFVF/OERoFLIVWtp+
         jpVrB61ha4mlM1/4aWky+QYKvwXLHSAkat5ud5IOfqTRY9JLFOgwl5a4C88fUeVvYE
         EBB8uQsTaJoFSlSIRvq9VeLtDSGLwIDKLTzxOlEY=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <4950f67bf989a7f5eba462c44d6bdbffb34485d1.camel@maquefel.me>
Subject: Re: [PATCH 2/2] perf vendor events riscv: add T-HEAD C9xx JSON file
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Tue, 16 May 2023 18:06:39 +0300
In-Reply-To: <IA1PR20MB49539F3FBE068C7C811152B1BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <38eaec6b495786b048f78be08470f7c770793d7b.camel@maquefel.me>
         <IA1PR20MB49539F3FBE068C7C811152B1BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-16 at 17:45 +0800, Inochi Amaoto wrote:
> > Do c906 and c910 have same HPM events ?
> >=20
> > https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_=
rtl/pmu/rtl/aq_hpcp_top.v
> >=20
> > and
> >=20
> >=20
> > https://github.com/T-head-Semi/openc910/blob/main/C910_RTL_FACTORY/gen_=
rtl/pmu/rtl/ct_hpcp_top.v
> >=20
> > Look different to me - am i missing something ?
>=20
> Yes, they as different, but event ids are compatible. See [1] p.99
> and [2] p.73.
>=20
> It seems I forgot extra event index from C906. I will fix in the v2.
>=20
> [1]
> https://github.com/T-head-Semi/openc910/blob/main/doc/%E7%8E%84%E9%93%81C=
910%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf
> [2]
> https://github.com/T-head-Semi/openc906/blob/main/doc/%E7%8E%84%E9%93%81C=
906%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf

They are not the same - they are different in many ways. And c906 list
seems more complete to me.

I think you should drop wildcard (it shouldn't be used anyway) then and
name it c906.

"0x5b7-0x0-0x0,v1,t-head/c906,core" would match both c906 and c910.


>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

