Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F913723633
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjFFEYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFFEYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:24:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B56187;
        Mon,  5 Jun 2023 21:24:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZy6v3ldmz4x3g;
        Tue,  6 Jun 2023 14:24:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686025483;
        bh=JR/J6iOGvofFQ79zUOMxU1TvmroSLFJQxCcxwNfgcBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hfT7vOaB8Gh9eXvW7nFcY1eBXRCQJXRQKIoCg8s3J4T82JjkvQLE1hOo3uoOc4zaO
         MBUe05J0ovZjXERuKMRV7Zpv0uqHz8jSCIRhxjzKKyN7NYp4MXdA3G4Y3CQMJ7to6f
         xFyulC/uXSYm6gc4rFjjKTCMwWLmsAdcRPMgDEGeLBaZ8759CwNL5yie9pYxlZopdX
         Xe7eEuQ2BHlm6cwGbEt/YIzyqv/XWxDMiHwHIf94KgEKdYNFaD1hJwfoexrI6s/y1H
         a3sp/vONmpoMn3BtPNJWWhH8aj1pz12ylBm2BpPPLPfJ1bS6Rl9bcngY8AevCAJDXC
         mdXU0JMQbhY/Q==
Date:   Tue, 6 Jun 2023 14:24:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>, irogers@google.com,
        suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, kjain@linux.ibm.com,
        renyu.zj@linux.alibaba.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, wangming01@loongson.cn,
        chenhuacai@kernel.org, sandipan.das@amd.com, 9erthalion6@gmail.com,
        seanjc@google.com, robh@kernel.org, tmricht@linux.ibm.com,
        tegongkang@gmail.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf test amd: Fix build failure with
 amd-ibs-via-core-pmu.c
Message-ID: <20230606142436.153750d9@canb.auug.org.au>
In-Reply-To: <ZH3w7TWRQZsPqhB2@kernel.org>
References: <CAP-5=fUPZ7+nAcxBp5sFBfxzkOH8kzWkLV0uziHqxYC0cDbbDw@mail.gmail.com>
        <20230603044650.286-1-ravi.bangoria@amd.com>
        <ZH3w7TWRQZsPqhB2@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aoAnzQewuA0W1vppZT1azH0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aoAnzQewuA0W1vppZT1azH0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Mon, 5 Jun 2023 11:27:57 -0300 Arnaldo Carvalho de Melo <acme@kernel.org=
> wrote:
>
> How are things like this resolved in linux-next?

Well, if it produces a conflict (or a build failure due to a semantic
conflict) I will fix it up (maybe using a separate patch such as this)
and report it so that the maintainers know that they need to let Linus
know about this when he merges their trees.

But since neither of those things has happened (it seems that an
allmodconfig build does not build the tests), I can still take this
patch and use it to fix up the tip tree merge (since that happens after
the perf tree merge) starting tomorrow and report it as above.  I will
then keep applying this patch to the merge until it is no longer needed.

Please send me the actual patch. (I am assuming that the patch applies
on top of a recent linux-next release?)

--=20
Cheers,
Stephen Rothwell

--Sig_/aoAnzQewuA0W1vppZT1azH0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR+tQQACgkQAVBC80lX
0GzQ8Qf/ZW/gJJZFgOOwSWU2eipr6GmHsFTkIhuD35t3ZI89Tb4IF30BT0nPctn/
WnZ05rwhdC6JkmTUfwWfOEfhUoQvXoGezQjtgwpZPRbUgyiU0NlSW1SKUFcXIaTJ
Q/1hBC2/sPGHII3JKcjBQMKw8haenmzuaAvdwTIyvVfDPUqQlxQzOUwgnxIDbcK8
eQL4nFwAIkhO2ZmKBjy1dh8bO9z9b80bJbFTwGeTMwlRotTkfNE0WYXsEFzKQkgF
OzrUacO20azqJcNn1pucBcHEueZhXbMQwB1lB74cwIrUKvoNeUy59fC63cwKEgVT
t8HnVqyrE2+WFoGNGfPyu9IWP/dh/A==
=E5lh
-----END PGP SIGNATURE-----

--Sig_/aoAnzQewuA0W1vppZT1azH0--
