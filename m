Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097487259E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjFGJRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbjFGJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:17:45 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8706EEA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:17:44 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6260e771419so1658066d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686129463; x=1688721463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tL/PpO32/XApPqfzUVTE3O6ft3MNge9AqUMgAVH97Go=;
        b=LA1NcZSM698iSn60uFcQpBnfpJtIf8HrfDX45R7PrTAbr/4cqrBSDZveCLn5zpjE+J
         vA0rFAeJDMZkfXW1kY/f86Q5xjAxnBSmf0exIC0lTVn3mpC+ZLjkP6iF9OF0TC4I7/gz
         Aw1IMePf/uSCDYvq/j/EeIYt1ZGKVBtHdqblBHAi8/FONeLu7GoiGW4WPPaIfjqIUAB4
         ccP4uVkGyd8Ak13o4sCeO1rbpzhdixbb0yohSbvAia8nb72kJG8lIlj//Y3zWq4TmT8c
         ebz/k+vohkq8mfIYeA9dOxeKrTORy2Qo68o9BSzfcMCf2xSrEkT3R2c3YoRczy3PpsbX
         vS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129463; x=1688721463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tL/PpO32/XApPqfzUVTE3O6ft3MNge9AqUMgAVH97Go=;
        b=Ls7fhpLUUN1BDgAGxhETk39nNo0a2iFr4P7lEI363SDGeQaPx8CI65hLjWKxvx4D/u
         NdDqJbt6S/CEWCatuj5vmYbYBgDxuzzKlW2Ue2255DPHXo0mScNFq/ctBD7kZ7kQ2vP7
         pXcvQPEAJzayNSoMPplXQkAfj8ubiR7X+6y7c3dVMWfZU2aOJiy4kC1BE72sqYGbm4iH
         hTx1z4HtveyaLMe9uqbNEFT5hPr1y2gJPAJJNloUzXgUzqcRe9IRh06UTTYAzKXdKfa5
         2GxZYKJXlSd1LMWxxe0RgfQYHpKqt+r4Xpl4etlvgr5EBR+Jef5CjRkm6HH54r5U0T9d
         nwUg==
X-Gm-Message-State: AC+VfDyySKnl9O4it2c1X1laGxTlGBS48M3PLOdgQGlg7ip1lCe6CGKm
        WwDdKLK8UWORRe+oIJ/Htlg2hAHlVp/7SluAq5pu2A==
X-Google-Smtp-Source: ACHHUZ63ODvAxF/CpyrKWinNPoD3cAv/NGbt5pcbkG/HkvXLOyFHWdTRETdhqtAFABETjRLAHdGW1Duy/f8pc/N3XXM=
X-Received: by 2002:a05:6214:2a84:b0:625:86ed:8aab with SMTP id
 jr4-20020a0562142a8400b0062586ed8aabmr2135830qvb.14.1686129463604; Wed, 07
 Jun 2023 02:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230602161246.1855448-1-amit.pundir@linaro.org>
 <CAD=FV=U9xwxC4+wDYFMSoLWaj8vaLH_jettZ=nxEZP+1tNk=oA@mail.gmail.com> <d0dfdfba-7a70-7d12-2c30-ad32b3f95bb8@linaro.org>
In-Reply-To: <d0dfdfba-7a70-7d12-2c30-ad32b3f95bb8@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 7 Jun 2023 14:47:07 +0530
Message-ID: <CAMi1Hd1Upo8zV4MPtdqHgEaMQ72yK0gZgf5Z4uOaqKqhw8Hndg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes up
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        regressions <regressions@lists.linux.dev>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 at 13:19, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/06/2023 01:34, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jun 2, 2023 at 9:12=E2=80=AFAM Amit Pundir <amit.pundir@linaro.=
org> wrote:
> >>
> >> Move lvs1 and lvs2 regulator nodes up in the rpmh-regulators
> >> list to workaround a boot regression uncovered by the upstream
> >> commit ad44ac082fdf ("regulator: qcom-rpmh: Revert "regulator:
> >> qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"").
> >>
> >> Without this fix DB845c fail to boot at times because one of the
> >> lvs1 or lvs2 regulators fail to turn ON in time.
> >>
> >> Link: https://lore.kernel.org/all/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGr=
LZsw5edb-NtRJRw@mail.gmail.com/
> >> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 24 +++++++++++----------=
-
> >>  1 file changed, 12 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/b=
oot/dts/qcom/sdm845-db845c.dts
> >> index e14fe9bbb386..df2fde9063dc 100644
> >> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> >> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> >> @@ -301,6 +301,18 @@ regulators-0 {
> >>                 vdd-l26-supply =3D <&vreg_s3a_1p35>;
> >>                 vin-lvs-1-2-supply =3D <&vreg_s4a_1p8>;
> >>
> >> +               vreg_lvs1a_1p8: lvs1 {
> >> +                       regulator-min-microvolt =3D <1800000>;
> >> +                       regulator-max-microvolt =3D <1800000>;
> >> +                       regulator-always-on;
> >> +               };
> >> +
> >> +               vreg_lvs2a_1p8: lvs2 {
> >> +                       regulator-min-microvolt =3D <1800000>;
> >> +                       regulator-max-microvolt =3D <1800000>;
> >> +                       regulator-always-on;
> >> +               };
> >> +
> >>                 vreg_s3a_1p35: smps3 {
> >>                         regulator-min-microvolt =3D <1352000>;
> >>                         regulator-max-microvolt =3D <1352000>;
> >> @@ -381,18 +393,6 @@ vreg_l26a_1p2: ldo26 {
> >>                         regulator-max-microvolt =3D <1200000>;
> >>                         regulator-initial-mode =3D <RPMH_REGULATOR_MOD=
E_HPM>;
> >>                 };
> >> -
> >> -               vreg_lvs1a_1p8: lvs1 {
> >> -                       regulator-min-microvolt =3D <1800000>;
> >> -                       regulator-max-microvolt =3D <1800000>;
> >> -                       regulator-always-on;
> >> -               };
> >> -
> >> -               vreg_lvs2a_1p8: lvs2 {
> >> -                       regulator-min-microvolt =3D <1800000>;
> >> -                       regulator-max-microvolt =3D <1800000>;
> >> -                       regulator-always-on;
> >> -               };
> >
> > This is a hack, but it at least feels less bad than reverting the
> > async probe patch. I'll leave it to Bjorn to decide if he's OK with
> > it. Personally, it feels like this would deserve a comment in the dts
> > to document that these regulators need to be listed first.
> >
> > Ideally, we could still work towards a root cause. I added a few more
> > ideas to help with root causing in reply to the original thread about
> > this.
> >
> > https://lore.kernel.org/r/CAD=3DFV=3DUKyjRNZG-ED2meUAR9aXdco+AbUTHiKixT=
zjCkaJbjTg@mail.gmail.com/
>
> We do not shape DTS based on given OS behavior. AOSP needs this, BSD
> needs that and Linux needs something else. Next time someone will move
> these regulators down because on his system probing is from end of list,
> not beginning and he has the same problem.
>
> No, really, are we going to reshuffle nodes because AOSP needs it?

Hi, other than the fact that I reproduced it on AOSP, there is nothing
AOSP specific in this patch. I'm sure there may be another
platforms/OS (which load kernel modules from a ramdisk) that may trip
on this bug. But I can try reproducing it on an OS of your choice if
it helps.

Regards,
Amit Pundir

>
> Best regards,
> Krzysztof
>
