Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD016E7F65
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjDSQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjDSQSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:18:05 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719E419A3;
        Wed, 19 Apr 2023 09:18:04 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B83CFC6E13;
        Wed, 19 Apr 2023 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681921082; bh=/fXev4EJCHlSFuLfMgc8DULhsUVCUngGI8FvP7ThQic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ul/NIajw6Y6NsmjLGNAPH+4mHN529xc6Dx6BcS9eyLgHpJwztqsxWUBI+UDfuWxkJ
         UXuFhFKG+2Qif/ylXoPtZ37gVCi0AYmy9jp6VVa1wANlgqsVYgAQ8Exh5ID1g9t/6i
         fAYb6HP7EuoIZZDSok0kfCk6h5Lic22qxf4BztWk=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: correct qfprom node reg
Date:   Wed, 19 Apr 2023 18:18:01 +0200
Message-ID: <4820647.31r3eYUQgx@z3ntu.xyz>
In-Reply-To: <383f6aa0-6150-22b5-425a-f9cf13bdbc50@linaro.org>
References: <20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3ntu.xyz>
 <5664419.DvuYhMxLoT@z3ntu.xyz>
 <383f6aa0-6150-22b5-425a-f9cf13bdbc50@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 19. April 2023 18:12:04 CEST Konrad Dybcio wrote:
> On 19.04.2023 18:00, Luca Weiss wrote:
> > Hi Konrad,
> >=20
> > On Montag, 30. J=E4nner 2023 21:37:29 CEST Luca Weiss wrote:
> >> On Montag, 30. J=E4nner 2023 19:42:51 CET Konrad Dybcio wrote:
> >>> On 30.01.2023 19:36, Luca Weiss wrote:
> >>>> On Montag, 30. J=E4nner 2023 19:30:04 CET Konrad Dybcio wrote:
> >>>>> On 30.01.2023 19:20, luca@z3ntu.xyz wrote:
> >>>>>> From: Craig Tatlor <ctatlor97@gmail.com>
> >>>>>>=20
> >>>>>> The qfprom actually starts at 0xfc4b8000 instead of 0xfc4bc000 as
> >>>>>> defined previously. Adjust the tsens offsets accordingly.
> >>>>>>=20
> >>>>>> [luca@z3ntu.xyz: extract to standalone patch]
> >>>>>>=20
> >>>>>> Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens =
and
> >>>>>> qfprom nodes") Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> >>>>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> >>>>>> ---
> >>>>>=20
> >>>>> Isn't this a raw vs ecc-corrected values problem?
> >>>>=20
> >>>> Not quite sure what you mean.
> >>>=20
> >>> The QFPROM is split into two parts: one where raw values
> >>> are stored, and the other one where ECC-corrected copies
> >>> of them reside. Usually it's at offset of 0x4000. We should
> >>> generally be using the ECC-corrected ones, because.. well..
> >>> they are ECC-corrected.. You may want to check if the
> >>> fuse you're adding reads the same value at +0x4000.
> >>=20
> >> Yeah that actually seems to work...
> >>=20
> >> But downstream's using this +0x4000 only for tsens it seems
> >>=20
> >>    <0xfc4bc000 0x1000> as "tsens_eeprom_physical"
> >>=20
> >> qcom,clock-krait-8974 is using this:
> >>     <0xfc4b80b0 0x08> as "efuse"
> >>=20
> >> Also seems HDMI driver is using a mix for HDCP stuff
> >>=20
> >>   drivers/video/msm/mdss/mdss_hdmi_util.h:
> >>     /* QFPROM Registers for HDMI/HDCP */
> >>     #define QFPROM_RAW_FEAT_CONFIG_ROW0_LSB  (0x000000F8)
> >>     #define QFPROM_RAW_FEAT_CONFIG_ROW0_MSB  (0x000000FC)
> >>     #define HDCP_KSV_LSB                     (0x000060D8)
> >>     #define HDCP_KSV_MSB                     (0x000060DC)
> >>=20
> >> Any clue why Qualcomm used it this way in downstream? I'd rather not
> >> deviate too much if not for a good reason...
> >=20
> > Any comments on the above?
>=20
> This thread got burried to deep in the mailbox!
>=20
> I see two reasons why they could be using the uncorrected region:
> - their generators are messed up in general
>=20
> - they may have had an early chip revision once where there were
>   problems with this and their generators were messed up to
>   accommodate for it and everybody forgot to fix that
>=20
> No other good explanations as far as I'm aware!

So, resolution is to use the offsets as declared in downstream, so take thi=
s=20
patch to have the full range available?

Regards
Luca



