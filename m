Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063087066E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjEQLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEQLio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:38:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AE1F5;
        Wed, 17 May 2023 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684323522; x=1715859522;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BWwbZfpcj80S+j5er87s3wXNxN+FvOIC3tzT92WETII=;
  b=lcUEZtMUGnhuyoANU/Yx8Ju3eOjWFrnVIrAfEYLGOHMOsAv0OmPy1DEJ
   DyRmUtHmhRzgBWdDr3SAZXjrqn1xo3bfr1ha3tGTJsCge34dF1A2aQq1N
   JHBriSGn2E/WrjXRpNfpDrmeqsGA4qGavwWmyH7wpk/t4inJbAldr0fir
   WvAYkYMp1+ITR7Ld38zAJR8KIfGjiwrb+rpCBNHEG4NFtC9oxbcFW588G
   0tyXgERyXiYLXVgLNy6wZy5/cno71XPrXAXVlzUO232cYagQgkcLpQzvT
   DirM17o5fp4x+4VfNqVIjxY5SpwZzRibM395qUrLa39qbcO+O5cDML6Pj
   A==;
X-IronPort-AV: E=Sophos;i="5.99,282,1677567600"; 
   d="scan'208";a="225737288"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 04:38:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 04:38:42 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 04:38:40 -0700
Message-ID: <7772a5981d9a3d46056a53997162d1d75d22a701.camel@microchip.com>
Subject: Re: [PATCH] arm64: dts: microchip: add missing cache properties
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 17 May 2023 13:38:39 +0200
In-Reply-To: <151169f7-dcdb-47f1-9616-67c3c388a233@linaro.org>
References: <20230421223155.115339-1-krzysztof.kozlowski@linaro.org>
         <151169f7-dcdb-47f1-9616-67c3c388a233@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

I would love to do that, but I am not familiar with the procedure, so maybe=
 you
could help me out?

This is my understanding of what I need to do:

Clone the upstream repo listed in MAINTAINERS:

git clone git@github.com:microchip-ung/linux-upstream.git
cd linux-upstream
git checkout sparx5-next

Fetch the latest mainline tag from upstream:

git fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
tag\
 v6.4-rc2 --no-tags

Rebase the current branch on top of that tag:

git rebase v6.4-rc2

Use b4 to fetch and apply the mail thread patch series:

b4 shazam -tsl 20230421223155.115339-1-krzysztof.kozlowski@linaro.org

Tag the current work for inclusion in the next kernel version with a decrip=
tion:

git tag -s sparx5-dt-6.5

Push work that to the public repo:

git push origin sparx5-dt-6.5

Create a pull request (to stdout) to be included in an email to the maintai=
ners:

git request-pull v6.4-rc2 origin sparx5-dt-6.5

Send this PR to the maintainers and CC co-maintainers.

Is this the correct procedure?
Who should I send the PR email to (is there a list somewhere)?
=20
BR
Steen

On Tue, 2023-05-16 at 18:30 +0200, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On 22/04/2023 00:31, Krzysztof Kozlowski wrote:
> > As all level 2 and level 3 caches are unified, add required
> > cache-unified and cache-level properties to fix warnings like:
> >=20
> > =C2=A0 sparx5_pcb125.dtb: l2-cache0: 'cache-level' is a required proper=
ty
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > ---
>=20
> Anyone from Microchip picking this up?
>=20
> Best regards,
> Krzysztof
>=20

