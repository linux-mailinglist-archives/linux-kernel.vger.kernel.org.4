Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0C667CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbjALRkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbjALRjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:39:47 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571626C2A4;
        Thu, 12 Jan 2023 08:58:55 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 79BB0CC598;
        Thu, 12 Jan 2023 16:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1673542018; bh=YZ31VjxQ998swhidkgP8BiVfHd20jGadBRqpOMOLJDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SQFARVSqmS/CuDdOTzoZkQwh/4ZgdafNH+jLRa2Ts1j2Nbgd8k8dInb3Ss2slpbFx
         n7xx0jNpvt2WWfi+TZECHmbOIiIdoKTf5NGvBLBd/j7DhuG5mFNY2bnN26sOpUrrbg
         aXvrgOFRj/EA1QG49jP14y9mzX+E14sLDoGefoic=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing
 compatibles
Date:   Thu, 12 Jan 2023 17:46:57 +0100
Message-ID: <2662546.mvXUDI8C0e@g550jk>
In-Reply-To: <20230112031621.rphz4zu63ibul374@vireshk-i7>
References: <20221016090035.565350-1-luca@z3ntu.xyz> <4899603.LvFx2qVVIh@g550jk>
 <20230112031621.rphz4zu63ibul374@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 12. J=E4nner 2023 04:16:21 CET Viresh Kumar wrote:
> On 11-01-23, 20:48, Luca Weiss wrote:
> > Hi Viresh,
> >=20
> > gentle bump, I hope this patch could get applied in-time for the next
> > merge
> > window.
>=20
> I thought Bjorn applied this patch long back. But now that I look back
> at his email, he applied 2/5 and replied to 1/5, probably because
> there wasn't a cover-letter available :(
>=20
> Sorry for the confusion, applied now.

No worries, thanks for applying!


