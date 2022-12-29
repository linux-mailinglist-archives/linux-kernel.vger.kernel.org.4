Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00356659025
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiL2SLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiL2SLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:11:14 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5D4B1C9;
        Thu, 29 Dec 2022 10:11:13 -0800 (PST)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0005.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::5])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 981DECB25B;
        Thu, 29 Dec 2022 18:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1672337472; bh=ylaqW3QriX4UFG2gLEv2+DmYHGXalLA07llE5x9zYTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nVuSop1x0HPR/WnzsSTq70LP78a7JG+zri9PBNH++4BdLNYruLLAcp/rTD7c7i+vV
         vw4+cJrvvd8oM+uMEqd+wBhIS9oomNhDTRDX4pLdpvN4rKulWjZPYu0CsT2wg40JWS
         GIUv6sJ/LN4Ph2xst3ULUHxvjIbgj6IbIBJEXBwg=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: dt-bindings: qcom,usb-vbus-regulator: change
 node name
Date:   Thu, 29 Dec 2022 19:11:10 +0100
Message-ID: <12119923.O9o76ZdvQC@g550jk>
In-Reply-To: <Y63U+7LnWhixrW6g@sirena.org.uk>
References: <20221031173933.936147-1-luca@z3ntu.xyz> <12119366.O9o76ZdvQC@g550jk>
 <Y63U+7LnWhixrW6g@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 29. Dezember 2022 18:57:15 CET Mark Brown wrote:
> On Wed, Dec 28, 2022 at 10:30:47PM +0100, Luca Weiss wrote:
> > On Montag, 31. Oktober 2022 18:39:32 CET Luca Weiss wrote:
> > > usb-vbus-regulator is a better generic node name than dcdc to change the
> > > example to match.
> > > 
> > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > 
> > Bump? Can this patch be picked up please?
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.

The patch was sent end of October, that is two months ago. I don't think two 
months of waiting is an unreasonable amount of time and is also more than "a 
couple of weeks"...

And as far as I am aware there's no open review comments, which is why I did 
send the email to ask what the status is so that it can go into 6.3 and I can 
remove it from my inbox.

Regards
Luca

> 
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.




