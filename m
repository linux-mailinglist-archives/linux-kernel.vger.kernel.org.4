Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7666D74D5F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjGJMpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjGJMpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:45:42 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9559B;
        Mon, 10 Jul 2023 05:45:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B2B8C5C0166;
        Mon, 10 Jul 2023 08:45:33 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 10 Jul 2023 08:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688993133; x=1689079533; bh=Wr
        gvfSK/ZjUnMocbnypFGx2Xu2Tz3bZYi5KhzSIRavg=; b=HfW8C5wWvq2nAWizjJ
        E4WtfRQ4petWcoSQ6q0lIWyXzXpmAu28ZnV+iEWxSjyiGp3QT/ansazGclbI1WPh
        Su0zHiFw5m1xXNT37hK7v370U1VWB4SpIQrCR1U9EtSVMJIuIobaQBKg6QzWa8Vx
        oDe0CizDplLYcnZ9A3QMibFpjS5yZxiBGMf6LiZcpMC2aZ9MKU1CURIuL8WtalT4
        7kcAKuEEOzF0isQMeeMtzROFbi31vervfvhw82Oy2tqIDytrWIQls6FMR+A/G31u
        kARY4iT5PTCKBwZn3KdWefT740SJkyf/1kZPGOj26rK0e8IiiW2I8loSlyyvdHjE
        Ij0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688993133; x=1689079533; bh=WrgvfSK/ZjUnM
        ocbnypFGx2Xu2Tz3bZYi5KhzSIRavg=; b=XwySPgjShiTivcgcO87lJeu+tsCXi
        46y9i6y8bzcsRCaUaVkoFhuL4ghB2S3GmwEK+ALBPlUpo9XuCxoHutJF/avr2N0R
        QjcFzUWgK8SbagUmPHhI6585NY1lR1104mBpvV3p9HG8akg8bpRf3lgFkPJy+JtD
        oB+c2K6UItXlfhud0cnZXi0g7gAOxT3L4r2U/h4oJ5iQiyi2akD6pR7MgJTf4Pvj
        DERhrrGvwapHWW2rOL7KVwYTyNO39YH2VxwISU+4ZjbQuqjReIW5cGICQ46a7hHb
        v7nUQpbFgK8v0fjmSztcgAh71TQ1MUzyYYqmqoSRWclYBmwO1wvkDHq9g==
X-ME-Sender: <xms:bf2rZOmf60ZQDGJgw3s8P5MRfo7CShCcZZPAIuV5AKPOSwfkFjvNVw>
    <xme:bf2rZF2IwKTaJzFicKJVcjZ-sEZ_HztTfq61gt2xvXzlhgQ6G7UxUSV039NsCkbou
    fs5qPenfx6yLLyOUp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvdekgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:bf2rZMr1mXNHciHOBChPaW6Kq9Lz5-zJSwYwMIvseSyLPD_2DnIl6g>
    <xmx:bf2rZCmPfJL1nn0qaON3MrFyk0OVlEgZc-DMvaMTUu56DJMPW6CUMw>
    <xmx:bf2rZM2Otwu3AneCWbaQ71VydAQ8Ozmrj9Idq0VTY67Sb3hjP36Jdg>
    <xmx:bf2rZNLkOeVMZ5nvzl-PVhBKmJ7kMATU6iBPYONR472oQbo3nlvDdw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 395001700089; Mon, 10 Jul 2023 08:45:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <2ef84fb8-b5eb-4c9a-b8a1-0c5f33e7f572@app.fastmail.com>
In-Reply-To: <CAPDyKFoRtEXTGQkNzGza-sS_j1ajGmjtCTaoPB7PXVDE2bS0tQ@mail.gmail.com>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-4-ulf.hansson@linaro.org>
 <0c8938a9-7a26-bf97-51ee-0c271901ec21@linaro.org>
 <CAPDyKFrOye96GyHS0tiTQ02Ve5S6Crtk8=bMsRS9Ljj=h5-nWQ@mail.gmail.com>
 <1496b9c1-289a-c354-f0ae-e14fd4c9bcfa@linaro.org>
 <CAPDyKFr7Mqy5bisLcxcA_iEGWqL8SFt2mDDng7zYEaTD1vNisA@mail.gmail.com>
 <deyyt5r2wkxo7ily434gl3wudls2sbinkmnehssqshwnbzmlwf@lmqskj6zwfu2>
 <CAPDyKFoRtEXTGQkNzGza-sS_j1ajGmjtCTaoPB7PXVDE2bS0tQ@mail.gmail.com>
Date:   Mon, 10 Jul 2023 14:45:12 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>
Cc:     "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Olof Johansson" <olof@lixom.net>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Kevin Hilman" <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the genpd dir
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023, at 14:37, Ulf Hansson wrote:
> On Sun, 9 Jul 2023 at 04:21, Bjorn Andersson <andersson@kernel.org> wrote:
>> On Fri, Jul 07, 2023 at 05:27:39PM +0200, Ulf Hansson wrote:
>
> If I understand correctly, you are suggesting that each platform
> maintainer should merge the immutable branch with patch1 - and that I
> should send the patches (based on the immutable branch) to each of the
> platform maintainers to manage. Instead of one pull request with
> everything directly to Arnd, right?
>
> This still means that Arnd will have to resolve the conflicts as the
> pull requests arrive in his inbox.
>
> Although, I guess what you are looking for is less work for the soc/
> maintainers, which seems reasonable. Although, in that case, I might
> as well share an immutable branch with the complete series, rather
> than just patch1. That should help Arnd too, I think.
>
> Again, let's leave the call to Arnd on what to do.

I think it's much easier for me to pick up a single branch with
all of your patches. For platform maintainers, other changes can
go one of two ways:

- send a normal pull requests with changes against the same
  files, and have me take care of any conflicts where they
  arise. Since most of the changes are just simple file moves
  rather than changing file contents, 'git mergetool' handles
  these fine is most cases

- If there is a non-obvious merge, the entire genpd branch
  can be shared as an immutable branch, with patches for
  a particular platform rebased on top of that branch.

     Arnd
