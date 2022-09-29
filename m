Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B595E5EFD9A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiI2TGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiI2TGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:06:12 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EE54DB19;
        Thu, 29 Sep 2022 12:06:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CE9625C00DC;
        Thu, 29 Sep 2022 15:06:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 29 Sep 2022 15:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wfchandler.org;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664478368; x=
        1664564768; bh=5iKGShl7bHTQjRCpR3Rp6BaSwCatu+rb0Y5UgnU1eOI=; b=b
        jrvUMZDt1YwJthfV0Qdg1pP8nZ4FmTK4O2Kgie1W59wAZQUOwbnInXX6+yDOV4Wi
        320UZAirBa3MqnVZ2aE6Cb02FuoVzav5HWwTjLISFdgS40eKjTjc3Sh8n+0BgaNN
        oHTucHpyqZd8tjiYo79F+uUZiMXZM1xLELwLc1VstcU03zdUNydkMNd768X7F/F9
        ZbBcSnVnb4zgeJFM5lbLDu56wCzeZjirQZlTa4fFfMwk1CCGPU9lOfinGWV6/ftZ
        fj0EpExYXPSN23eF+hvGiQEJulQX4h4ARbKPntyxJ3/Syz8vrRb4rygpv6M1OimM
        Nlmjowi7XwG0uUKgu0hqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664478368; x=
        1664564768; bh=5iKGShl7bHTQjRCpR3Rp6BaSwCatu+rb0Y5UgnU1eOI=; b=g
        CE1erlxOgz9e/8NSesIGMjsGGtZKUSnx1P+eMftneMNUoN1Qy/4wFNdxptmx1A2e
        3eCegl44ve78g7uqOtsr8qyd7VnuNPK521x6Ns1cgNZp9AKfqqNyx1/UBoQVZ3xT
        pnXXMAYzzyjflS/hw5GQWjAstMl/fSLYe2hTsrOkUXYgd7BRoavZ1WAWHkIrfpfV
        yLB2gU/No/AjG68I2RHg8wTaLevQmiiCeWWBbCf6SsyoZGzby+I32TjQfP2boxJY
        azykm7zKS2k0ivVqTvT5bKXvZT946ygpBd0jSAgvQgBrEps5m2NXcmxNMYakSaTo
        KkR+Ee9CKCs17F5HlxNcw==
X-ME-Sender: <xms:oOw1Y-_M43lu3v59LAVn-Wvuma4teIASMQM-RlC3gmF2FQXplHtGZA>
    <xme:oOw1Y-sXZwaKiCo5umh65GeMXM9Z0iejVscfWSmo1Res8gOETRc7A3TKr066i7Doj
    LrJ8SyhvsJGBsaW2-E>
X-ME-Received: <xmr:oOw1Y0CpZic9AF2PCVMafAs6lODMC7cEJESnp3ZGAQ-pGvpIdOUOqReLBY3ksrtT8GA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehtddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffoffkjghfgggtgfesthhqmhdtredttdenucfhrhhomhephghi
    lhhlucevhhgrnhgulhgvrhcuoeiffhgtseiffhgthhgrnhgulhgvrhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfeuvdduudfftdfgkedtffehkeeuhefhtdehtdfgkefhveehkeej
    geeuhfeugffhnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiffhgtseiffhgthhgrnhgulhgv
    rhdrohhrgh
X-ME-Proxy: <xmx:oOw1Y2f8qM7kPlpQN_wIgtP96-ECrohv5jFIjEyCoFTYeamATejhvQ>
    <xmx:oOw1YzPG7w0Ly2ZZ-n3OYR6jlX42W6cy7WBstYjwcGM4I81e5_HUEQ>
    <xmx:oOw1YwnSE81F-dSFv7RneP7Yh9y8_aS5hCcw9MW8IK9QSg5244LXdQ>
    <xmx:oOw1Y8hhEreVNdy2h1gPCDVLahul77WLeWU42taDNO9CbOK97Am6xA>
Feedback-ID: ica594744:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Sep 2022 15:06:07 -0400 (EDT)
From:   Will Chandler <wfc@wfchandler.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix empty version number when building outside of a git repo
Date:   Thu, 29 Sep 2022 15:06:06 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <B89DF3DD-B07E-427F-8D4B-1F8251345A4C@wfchandler.org>
In-Reply-To: <2a4a15a4-55cd-f98b-4b14-474f24e2c308@huawei.com>
References: <20220927195228.47304-1-wfc@wfchandler.org>
 <c5181877-2998-b952-abe6-26d733ae2aeb@huawei.com>
 <87A1F5B6-3F60-4988-8BA6-A993E5789C80@wfchandler.org>
 <2a4a15a4-55cd-f98b-4b14-474f24e2c308@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Sep 2022, at 6:09, John Garry wrote:

> Hmmm... maybe someone would want to customise PERF-VERSION-FILE for the=
ir own distro. Not sure. But then fiddling with PERF-VERSION-FILE might b=
reak the parsing so...I guess not.

Yeah, seems like a bad idea. Doing a quick search, Void Linux does seem t=
o be
trying to set a custom version string in their build script[0], but I don=
't
think passing PERF_VERSION as an argument to make has worked since 2013 w=
ith
3cecaa200227 ("perf tools: Do not include PERF-VERSION-FILE to Makefile, =
2013-01-16").

[0] https://github.com/void-linux/void-packages/blob/fdb3515c33f2bb997392=
ea6992e6bbb82c4376c5/srcpkgs/linux-tools/template#L56

> BTW, is there any other method of building the perf code not considered=
? So far I know:
> a. in git tree
> b. perf-tar-src-pkg
> c. tarball

Those are all that come to mind for me as well.

Let me know if you'd like me to re-roll the patch using the pre-7572733b8=
499
approach.
