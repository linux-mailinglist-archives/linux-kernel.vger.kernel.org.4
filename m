Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82FF5BB087
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIPPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIPPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:51:25 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4BAF54
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:51:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663343477; bh=o7/sJH9KC43rAMSSCMF6yPESCQKJUXZTt09gwNOkTQY=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=PTr3TThy0zNQpy4g0N5g88DBy+9CYDUyhzW1nw2JYD6oDUCHB6Ri/UgBATuzhq/N6
         otpDt6RmUQIymf3jnnmqcTExDeuVS/bsGRPCdASWhn8kdo7OM+wJXTGwo2GKfowrks
         jKWUvDuvqJOfBg9dZum27M1PuHazfwJeM8M87Mb0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] get_maintainer: Extend matched name characters in
 maintainers_in_file()
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220916084712.84411-1-j@jannau.net>
Date:   Fri, 16 Sep 2022 17:51:16 +0200
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0ADED23-788E-4A17-AA50-12C837839CAD@cutebit.org>
References: <20220916084712.84411-1-j@jannau.net>
To:     Janne Grunau <j@jannau.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 16. 9. 2022, at 10:47, Janne Grunau <j@jannau.net> wrote:
>=20
> Extend the regexp matching name characters to cover Unicode blocks =
Latin
> Extended-A and Extended-B.
> Fixes 'scripts/get_maintainer.pl -f' for
> 'Documentation/devicetree/bindings/clock/apple,nco.yaml'.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

Applauded-and-tested-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>

On behalf of those not wanting to mangle our names to appease software,
let me thank you.

> This still excludes Greek and Cyrilic characters which should be
> expected in names as well. I tried to use '\p{L}' to match all Unicode
> letters but couldn't get it to work. Feel free understand this as bug
> report with an incomplete fix.
>=20
> best regards,
> Janne

