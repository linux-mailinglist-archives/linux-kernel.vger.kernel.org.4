Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C206590C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 20:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiL2TMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 14:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiL2TMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 14:12:53 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E6AD2DE;
        Thu, 29 Dec 2022 11:12:49 -0800 (PST)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0005.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::5])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 17E4ACA889;
        Thu, 29 Dec 2022 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1672341167; bh=Iik8yy7q1EoLGhtZihsdRMr9LgVe2immk1/jOSNNRHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aG6Ri/RPvpPFQtT1WR2IAHlypKM92qYpNfUisPshQ6t8VVumCNR2jLd/10Khm0OdH
         Z2OzBLS8uV4lovIiC+70fRrKnNhbna4082AqnGg488525D3521yXEKNDzmHT/mcLXw
         fN6dciNdrfU/+L5zG6ilEtFZSbmnSdFbiWP+XtTA=
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
Date:   Thu, 29 Dec 2022 20:12:46 +0100
Message-ID: <5890061.lOV4Wx5bFT@g550jk>
In-Reply-To: <Y63fvNfPrnot+C6a@sirena.org.uk>
References: <20221031173933.936147-1-luca@z3ntu.xyz> <12119923.O9o76ZdvQC@g550jk>
 <Y63fvNfPrnot+C6a@sirena.org.uk>
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

On Donnerstag, 29. Dezember 2022 19:43:08 CET Mark Brown wrote:
> On Thu, Dec 29, 2022 at 07:11:10PM +0100, Luca Weiss wrote:
> > The patch was sent end of October, that is two months ago. I don't think
> > two months of waiting is an unreasonable amount of time and is also more
> > than "a couple of weeks"...
> > 
> > And as far as I am aware there's no open review comments, which is why I
> > did send the email to ask what the status is so that it can go into 6.3
> > and I can remove it from my inbox.
> 
> Please read the rest of the mail:
> > > directly if something has gone wrong you'll have to resend the patches
> > > anyway, so sending again is generally a better approach though there are
> > > some other maintainers who like them - if in doubt look at how patches
> > > for the subsystem are normally handled.
> 
> I can't do anything with your content free ping on patch 2 of
> some series...

I'll just resend, that should alleviate all problems.



